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

module.exports = async function create(opts = {}) {
	const seed = opts.seed || randomString();
	const rng = opts.rng = seedrandom(seed);
	const manifest = require('../cv2rando.manifest.js');
	const outputName = opts.output || `output/cv2r-${opts.version()}-${seed}`;
	const output = opts.output = {
		rom: `${outputName}.nes`,
		patch: `${outputName}.patch.json`,
		spoiler: `${outputName}.spoiler-log.csv`
	};
	mkdirp.sync(path.dirname(path.resolve(output.rom)));

	const groups = [ 
		{ 
			name: 'core',
			patches: manifest.patch.core
		}, 
		{
			name: 'options',
			patches: manifest.difficulty[opts.difficulty]
		}
	];
	for (const { name, patches } of groups) {
		for (const patchName of patches) {
			const { patch } = require(`./patch/${patchName}`);
			log(`Applying ${yellow(patchName)} patch...`);
			if (_.isFunction(patch)) {
				await patch(pm[name], opts);
			} else if (_.isArray(patch)) {
				patch.forEach(p => {
					if (_.isString(p.bytes)) {
						p.bytes = p.bytes.split(/\s+/).map(b => parseInt(b, 16));
					}
					pm[name].add(p.bytes, p.offset);
				});
			} else {
				const msg = !patch ? '"patch" property must be defined' : '"patch" property must be function or array';
				throw new Error(`invalid patch "${patchName}": ${msg}`);
			}
		}
	}

	// write out the modified rom and patch
	await fs.writeFile(output.patch, pm.export());
	if (!opts.patch) {	
		await fs.writeFile(output.rom, pm.patch(await fs.readFile(opts.rom)));
	}

	// return the output filename
	return output;
}
