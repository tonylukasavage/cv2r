const _ = require('lodash');
const camelcase = require('camelcase');
const { cyan, green, yellow } = require('chalk');
const core = require('../lib/core');
const fs = require('fs').promises;
const mkdirp = require('mkdirp');
const pm = require('./patch-manager');
const path = require('path');
const { isGameFlag, log, printHeader, randomString, textToBytes } = require('./utils');
const seedrandom = require('seedrandom');

module.exports = async function create(opts = {}) {
	const seed = opts.seed || randomString();
	const rng = opts.rng = seedrandom(seed);
	const outputName = opts.output || `output/cv2r-${opts.version()}-${seed}`;
	const output = opts.output = {
		rom: `${outputName}.nes`,
		patch: `${outputName}.patch.json`,
		spoiler: `${outputName}.spoiler-log.csv`
	};

	if (!opts.json) {
		mkdirp.sync(path.dirname(path.resolve(output.rom)));
	}

	// set up patch manager based on command line args/options
	pm.init(opts);

	// execute all patches in order	
	for (const ord of pm.order) {
		const group = pm[ord];
		const { name, patches } = group;
		if (patches.length) { 
			printHeader(`${name === 'difficulty' ? opts.difficulty + ' ' : ''}${name} patches`);
		}
		for (const patchName of patches) {
			const dir = name === 'palette' ? 'palette' : 'patch';
			const { patch } = require(`./${dir}/${patchName}`);
			log(`* ${patchName}`);
			if (_.isFunction(patch)) {
				await patch(group, opts);
			} else if (_.isArray(patch)) {
				patch.forEach(p => {
					if (_.isString(p.bytes)) {
						p.bytes = p.bytes.split(/\s+/).map(b => parseInt(b, 16));
					}
					group.add(p.bytes, p.offset);
				});
			} else {
				const msg = !patch ? '"patch" property must be defined' : '"patch" property must be function or array';
				throw new Error(`invalid patch "${patchName}": ${msg}`);
			}
		}
		log('');
	}

	// write out the modified rom and patch
	if (opts.json) {
		console.log(JSON.stringify({
			patch: pm.export(),
			spoiler: global.spoiler
		}));
	} else {
		await fs.writeFile(output.patch, JSON.stringify(pm.export()));
		await fs.writeFile(opts.output.spoiler, 
      global.spoiler.map(s => `"${s[0]}","${s[1]}","${s[2]}"`).join('\n'));
		if (opts.rom) {	
			await fs.writeFile(output.rom, pm.patch(await fs.readFile(opts.rom)));
		}
	}

	// return the output filename
	return output;
}
