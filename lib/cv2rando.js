const assemble = require('./6502assembler');
const camelcase = require('camelcase');
const { green, yellow } = require('chalk');
const core = require('../data/core');
const enemizer = require('../lib/enemizer');
const fs = require('fs').promises;
const mkdirp = require('mkdirp');
const path = require('path');
const { randomString } = require('./utils');

const PATTERN_ASM = path.join(__dirname, '..', 'data', 'pattern.asm');

module.exports = async function create(rom, opts = {}) {
	const seed = opts.seed || randomString();
	const output = opts.output || `tmp/cv2-rando-${seed}.nes`;

	// read the source rom
	const romBuffer = await fs.readFile(rom);

	//enemizer();

	// write all indexed and modified core data to rom buffer
	console.log(`Writing ${green('core')} data to ROM buffer...`);
	core.forEach(loc => {
		// update all actors (npcs, enemies, books, etc...)
		Array.isArray(loc.actors) && loc.actors.forEach(a => {
			const buf = Buffer.from([ a.x, a.y, a.typeId, a.data ]);
			buf.copy(romBuffer, a.pointer);
		});

		// update pattern tables for all locations
		if (loc.pattern && loc.pattern.value != null && loc.pattern.pointer) {
			romBuffer.writeUInt8(loc.pattern.value, loc.pattern.pointer);
		}
	});

	// create pattern table mappings for all screens
	let buf = Buffer.from([ 0x20, 0x50, 0xB8 ]); //, 0x68, 0xA8, 0x28 ]);
	buf.copy(romBuffer, 0x1CCDF);

	// write code for mapping pattern table ids to each screen
	buf = Buffer.from(assemble(await fs.readFile(PATTERN_ASM, 'utf8')));
	buf.copy(romBuffer, 0x7860);

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
