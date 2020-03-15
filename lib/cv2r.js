const _ = require('lodash');
const bank = require('./bank');
const fs = require('fs').promises;
const mkdirp = require('mkdirp');
const pm = require('./patch-manager');
const path = require('path');
const { log, printHeader, randomString } = require('./utils');
const seedrandom = require('seedrandom');

module.exports = async function create(opts = {}) {
	const seed = opts.seed || randomString();
	opts.seed = seed;
	opts.rng = seedrandom(seed);
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
	await pm.init(opts);

	// execute all patches in order
	const order = pm.order.slice(0);
	let isPre = true;
	order.unshift('optional');

	for (const ord of order) {
		const group = pm[ord];
		let { name, patches } = group;

		if (ord === 'optional') {
			patches = patches.filter(p => isPre === !!require(`../patch/${name}/${p}`).pre);
			isPre = false;
		}

		if (patches.length) {
			printHeader(`${name === 'optional' && opts.difficulty ?
				opts.difficulty + ' ' : ''}${name} patches`);
		}

		for (const patchName of patches) {
			const reqPath = pm.isPatchFile(patchName) ? patchName : `../patch/${name}/${patchName}`;
			const patch = require(reqPath).patch;

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

	// write out remaining bank space
	bank.forEach((b, index) => {
		if (!b.rom) {
			log({ bank: index, remaining: 'unused' });
		} else {
			log({ bank: index, remaining: b.rom.end - (b.rom.start + b.offset) });
		}
	});

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
			await fs.writeFile(output.rom, pm.generateRom(await fs.readFile(opts.rom)));
		}
	}

	// return the output filename
	return output;
};
