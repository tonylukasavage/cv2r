const camelcase = require('camelcase');
const { yellow } = require('chalk');
const fs = require('fs').promises;
const mkdirp = require('mkdirp');
const path = require('path');
const { randomString } = require('./utils');

module.exports = async function create(rom, opts = {}) {
	const seed = opts.seed || randomString();
	const output = opts.output || `tmp/cv2-rando-${seed}.nes`;

	// read the source rom
	const romBuffer = await fs.readFile(rom);

	// apply patches
	let patchCount = 0;
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
			patchCount++;
		});
	});

	// executePatch([
	// 	{ offset: 0x60D9, value: '47' }
	// ]);

	// randomize enemies
	

	// write out the modified rom
	if (patchCount) {
		mkdirp.sync(path.dirname(path.resolve(output)));
		await fs.writeFile(output, romBuffer);

		// return the output filename
		return output;
	} else {
		throw new Error('no patches specified');
	}
}
