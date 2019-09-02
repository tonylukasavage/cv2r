const _ = require('lodash');
const fs = require('fs').promises;
const path = require('path');
const { patchManager: pm, utils: { validateRom } } = require('../lib');

const template = `
module.exports = {
	id: '<%= id %>',
	name: '<%= name %>',
	description: '<%= description %>',
	patch: <%= patch %>
};
`;

const patchFuncs = {
	diff: async function(args, opts) {
		const [ baseRom, hackRom ] = args;
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
		const rendered = _.template(template)(opts).trim();
		fs.writeFile(path.join(output, `${id}.js`), rendered);
	},
	empty: function(args, opts) {
		return;
	},
	ips: function(args, opts) {
		return;
	}
}
const patchFuncList = Object.keys(patchFuncs).join(', ');

module.exports = async function diff(name, opts = {}) {
	try {
		let { description = '', id, method = 'diff', output, type = 'optional' } = opts;
		if (!output) {
			if (!pm.order.includes(type)) {
				throw new Error(`Invalid patch type "${type}", must be: ${pm.order.join(', ')}`);
			}
			output = path.join(__dirname, '..', 'patch', type);
		}

		// validate name and necessary options
		if (!name) { throw new Error('must provide a name for the patch'); }
		if (!id) { 
			id = name.toLowerCase().replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, ''); 
		}
		if (!/[a-z0-9-]+/.test(id)) {
			throw new Error(`invalid id ${id}, must contain only lowercase letters, numbers, or dashes (-)`);
		}
		if (!method) { throw new Error(`must provide --m,method for patching, options include: ${patchFuncList}`); }
		if (!Object.keys(patchFuncs).includes(method)) {
			throw new Error(`invalid method ${method}, must be: ${patchFuncList}`);
		}

		// get patch fata amd compose all info gathered into a patch in js module format
		const pfOpts = { description, id, name, output };
		await patchFuncs[method](opts.args, pfOpts);

	} catch (err) {
		console.error(err);
		process.exit(1);
	}
};
