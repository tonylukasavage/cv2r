const camelcase = require('camelcase');
const { cyan, green, yellow } = require('chalk');
const core = require('../lib/core');
const enemizer = require('../lib/enemizer');
const fs = require('fs').promises;
const itemizer = require('../lib/itemizer');
const mkdirp = require('mkdirp');
const path = require('path');
const { isGameFlag, TEXT_MAP_TITLE, randomString, textToBytes } = require('./utils');
const seedrandom = require('seedrandom');
const { version } = require('../package.json');

module.exports = async function create(rom, opts = {}) {
	const seed = opts.seed || randomString();
	const rng = seedrandom(seed);
	const output = opts.output || `tmp/cv2-rando-${opts.version()}-${seed}.nes`;

	// read the source rom
	const romBuffer = await fs.readFile(rom);

	// Modify the title screen. It's important that the exact number of characters
	// in the following strings are used.
	const titlePrint = (text, rom) => Buffer.from(textToBytes(text, TEXT_MAP_TITLE)).copy(romBuffer, rom);
	const titlePad = (text, size) => {
		let padFront = text.length % 2;
		console.log(!!padFront);
		while (text.length < size) {
			text = `${padFront ? ' ' : ''}${text}${padFront ? '' : ' '}`;
			padFront = !padFront;
		}
		return text;
	};
	titlePrint('  randomizer  ', 0x01041E);
	titlePrint(titlePad(`v${version}`, 13), 0x010169);
	titlePrint('                        ', 0x010179);
	titlePrint(' made by   ', 0x010194);
	titlePrint('   bloodsweatandcode    ', 0x0101A2);

	// randomize enemies
	if (opts.enemizer) { await enemizer(romBuffer, rng, opts); }

	// randomize items
	if (opts.itemizer) { await itemizer(romBuffer, rng, opts); }

	// write all indexed and modified core data to rom buffer
	const flags = opts.options.filter(o => isGameFlag(o) && opts[camelcase(o.long)]);
	console.log(`Flags: [${ flags.map(f => cyan(f.long.replace(/^--/, ' '))) } ]`);
	console.log(`Applying flags to ${green('core')} data...`);
	
	core.forEach(loc => {
		// update all actors (npcs, enemies, books, etc...)
		Array.isArray(loc.actors) && loc.actors.forEach(a => {
			let buf = Buffer.from([ a.x, a.y, a.id, a.data ]);
			buf.copy(romBuffer, a.pointer);

			// update text, if necessary
			if (a.text && a.textPointer) {
				const textArray = Array.isArray(a.text) ? a.text.slice(0) : [ a.text ];
				const textPointerArray = Array.isArray(a.textPointer) ? a.textPointer.slice(0) : [ a.textPointer ];
				for (let i = 0; i < textArray.length; i++) {
					buf = Buffer.from(textToBytes(textArray[i]));
					buf.copy(romBuffer, textPointerArray[i]);
				}
			}
		});

		// update pattern tables for all locations
		if (loc.pattern && loc.pattern.value != null && loc.pattern.pointer) {
			romBuffer.writeUInt8(loc.pattern.value, loc.pattern.pointer);
		}
	});

	// process all post patches
	opts.options.filter(o => /^\[PATCH\]/.test(o.description)).map(o => o.long.replace(/^--/, '')).forEach(p => {
		const { name, patch } = require(`../patch/${p}`);

		// did we enable this patch?
		if (!opts[camelcase(p)]) { return; }
		console.log(`Applying ${yellow(name)} patch...`);

		// process the patch data
		patch.forEach(data => {
			// parse the hex string into an array of hex integers
			const bytes = data.value.split(/\s+/).map(b => parseInt(b, 16));

			// convert the hex integers into a data buffer
			const buf = Buffer.from(bytes);

			// copy the patch bytes to the given offset within the rom buffer
			buf.copy(romBuffer, data.offset);
		});
	});

	// write out the modified rom
	mkdirp.sync(path.dirname(path.resolve(output)));
	await fs.writeFile(output, romBuffer);

	// return the output filename
	return output;
}
