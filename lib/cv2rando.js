const _ = require('lodash');
const camelcase = require('camelcase');
const { cyan, green, yellow } = require('chalk');
const core = require('../lib/core');
const fs = require('fs').promises;
const mkdirp = require('mkdirp');
const pm = require('./patch-manager');
const path = require('path');
const { isGameFlag, log, randomString, textToBytes } = require('./utils');
const seedrandom = require('seedrandom');

module.exports = async function create(rom, opts = {}) {
	const seed = opts.seed || randomString();
	const rng = opts.rng = seedrandom(seed);
	const output = opts.output || `roms/cv2-rando-${opts.version()}-${seed}.nes`;
	const outputPatch = output.replace(new RegExp(path.extname(output) + '$'), '.patch.json');
	const romBuffer = await fs.readFile(rom);

	// apply all patches
	const manifest = require('./patch/patches.json');
	const groups = [ 'core', 'options' ];
	for (const group of groups) {
		for (const patchName of manifest[group]) {
			const { patch } = require(`./patch/${patchName}`);
			log(`Applying ${yellow(patchName)} patch...`);
			if (_.isFunction(patch)) {
				await patch(pm[group], opts);
			} else if (_.isArray(patch)) {
				patch.forEach(p => {
					pm[group].add(p.bytes, p.offset);
				});
			} else {
				const msg = !patch ? '"patch" property must be defined' : '"patch" property must be function or array';
				throw new Error(`invalid patch "${patchName}": ${msg}`);
			}
		}
	}

	// write all indexed and modified core data to rom buffer
	const flags = opts.options.filter(o => isGameFlag(o) && opts[camelcase(o.long)]);
	console.log(`Flags: [${ flags.map(f => cyan(f.long.replace(/^--/, ' '))) } ]`);
	console.log(`Applying flags to ${green('core')} data...`);

	// process all post patches
	opts.options.filter(o => /^\[PATCH(?:-X)?\]/.test(o.description)).map(o => o.long.replace(/^--/, '')).forEach(p => {
		const { name, patch } = require(`../patch/${p}`);

		// did we enable this patch?
		if (!opts[camelcase(p)]) { return; }
		console.log(`Applying ${yellow(name)} patch...`);

		// process the patch data
		patch.forEach(data => {
			// parse the hex string into an array of hex integers
			const bytes = data.value.split(/\s+/).map(b => parseInt(b, 16));
			pm.core.add(bytes, data.offset);
		});
	});

	// write out the modified rom
	mkdirp.sync(path.dirname(path.resolve(output)));

	await fs.writeFile(outputPatch, pm.export());
	if (!opts.patch) {	
		await fs.writeFile(output, pm.patch(romBuffer));
	}

	// return the output filename
	return output;
}
