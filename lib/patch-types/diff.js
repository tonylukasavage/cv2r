const _ = require('lodash');
const fs = require('fs').promises;
const path = require('path');
const { green, cyan } = require('chalk');
const {
	constants: { PATCH_TEMPLATE },
	utils: { validateRom }
} = require('..');

module.exports = async function(name, files, opts) {
	const [ baseRom, hackRom ] = files;
	if (!baseRom) { throw new Error('must provide a base rom'); }
	if (!hackRom) { throw new Error('must provide a hacked rom to diff with base rom'); }
	validateRom(baseRom);
	validateRom(hackRom);
	const baseBytes = await fs.readFile(baseRom);
	const hackBytes = await fs.readFile(hackRom);

	// Cycle through each rom, byte by byte, creating a diff between the two
	let patch;
	const patches = [];
	for (let i = 0; i < baseBytes.length; i++) {
		if (patch) {
			if (baseBytes[i] === hackBytes[i]) {
				patch = null;
			} else {
				patch.bytes.push(hackBytes[i]);
			}
		} else {
			if (baseBytes[i] !== hackBytes[i]) {
				patch = { offset: i, bytes: [] };
				patches.push(patch);
				patch.bytes.push(hackBytes[i]);
			} else {
				patch = null;
			}
		}
	}

	// write collected patches to module format in designated location
	const { id, output } = opts;
	opts.patch = JSON.stringify(patches, null, '\t')
		.replace(/\n/g, '\n\t')
		.replace(/"(bytes|offset)"/g, '$1');
	const rendered = _.template(PATCH_TEMPLATE)(opts).trim();
	const filename = path.join(output, `${id}.js`);
	await fs.writeFile(filename, rendered);

	console.log(`Patch ${green(name)} with id ${green(id)} written to ${cyan(filename)}`);
};