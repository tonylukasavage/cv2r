const difficulty = require('../config/difficulty.json');
const fs = require('fs');
const path = require('path');

const diffs = {};
Object.keys(difficulty).forEach(key => {
	diffs[key] = difficulty[key].patches.slice(0);
});

const patches = {
	core: [
		'sram',
		'stats',
		'clear-objects',
		'is-checked',
		'title-screen',
		'endings',
		'room-palette-fix',
		'flower-fix',
		'oak-stake-fix',
		'fast-day-night',
		'fast-text',
		'night-party',
		'boss-drop',
		'game-state-checks',
		'enemizer',
		'graveyard-duck',
		'itemizer',
		'book'
	]
};

class PatchGroup extends Array {
	constructor(name) {
		super();
		this.name = name;
		this.patches = [];
	}

	// { '0x1234', [ 6, 7, 8, 9, 0xA ] }
	add(byteArray, offset) {
		this.push({ [offset + '']: byteArray });
	}

	// { '0x1234': [ 'copy', 65, 0x8765 ] }
	copy(srcOffset, dstOffset, length) {
		this.push({ [srcOffset + '']: [ 'copy', length, dstOffset ] });
	}
}

const order = [ 'core', 'optional', 'palette', 'simon' ];

class PatchManager {
	constructor() {
		this.order = order;
		order.forEach(o => this[o] = new PatchGroup(o));
	}

	async init(opts) {
		this.core.patches = patches.core;

		if (opts.difficulty) {
			this.optional.patches = diffs[opts.difficulty];
		} else if (opts.patch) {
			const allPatches = (await this.getPatches()).map(p => p.id);
			const patches = opts.patch.split(',').map(p => p.trim());
			patches.forEach(patch => {
				if (!allPatches.includes(patch) && !this.isPatchFile(patch)) {
					throw new Error(`invalid patch "${patch}"`);
				}
			});
			this.optional.patches = patches;
		} else {
			throw new Error('must specify difficulty or patch list');
		}

		if (!opts.palette) {
			throw new Error('no palette selected');
		}
		this.palette.patches.push(opts.palette);

		if (!opts.simon) {
			throw new Error('no simon sprite selected');
		}
		this.simon.patches.push(opts.simon);
	}

	getDifficulties() {
		return Object.keys(diffs);
	}

	getPatches(type = 'patch') {
		const patches = [];

		let patchDir;
		switch (type) {
		case 'patch':
			patchDir = path.join(__dirname, '..', 'patch', 'optional');
			break;
		case 'palette':
			patchDir = path.join(__dirname, '..', 'patch', 'palette');
			break;
		case 'simon':
			patchDir = path.join(__dirname, '..', 'patch', 'simon');
			break;
		default:
			throw new Error(`invalid getPatches() type "${type}", must be "patch", "palette", or "simon"`);
		}

		for (let patch of fs.readdirSync(patchDir)) {
			const modPath = path.join(patchDir, patch);
			patches.push(require(modPath));
		}
		return patches;
	}

	getPatchMethods() {
		const files = fs.readdirSync(path.join(__dirname, 'patch-types'));
		return files.map(f => f.replace(/\.js$/, ''));
	}

	export() {
		return order.reduce((a,c) => a.concat(this[c]), []);
	}

	generateRom(romBuffer) {
		order.forEach(o => {
			this[o].forEach(entry => {
				Object.keys(entry).forEach(offset => {
					const bytes = entry[offset];
					if (bytes[0] === 'copy') {
						const [ len, dstOffset ] = bytes.slice(1);
						romBuffer.slice(offset, parseInt(offset) + len).copy(romBuffer, dstOffset);
					} else {
						Buffer.from(bytes).copy(romBuffer, offset);
					}
				});
			});
		});
		return romBuffer;
	}

	async generatePatch(name, files, opts = {}) {
		try {
			let { desc = '', id, method = 'diff', output, type = 'optional' } = opts;
			if (!output) {
				if (!order.includes(type)) {
					throw new Error(`Invalid patch type "${type}", must be: ${order.join(', ')}`);
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

			// make sure we have a valid patch creation method
			const patchFuncs = this.getPatchMethods();
			const patchFuncList = patchFuncs.join(', ');
			if (!method) { throw new Error(`must provide --m,method for patching, options include: ${patchFuncList}`); }
			if (!patchFuncs.includes(method)) {
				throw new Error(`invalid method ${method}, must be: ${patchFuncList}`);
			}

			// get patch data and compose all info gathered into a patch in js module format
			const pfOpts = { desc, id, name, output };
			const patchFunc = require(`./patch-types/${method}`);
			await patchFunc(name, files, pfOpts);

		} catch (err) {
			console.error(err);
			process.exit(1);
		}
	}

	isPatchFile(filename) {
		if (!filename) { return false; }
		try {
			if (/\.js$/.test(filename)) {
				return true;
			} else if (/\.json$/.test(filename)) {
				JSON.parse(fs.readFileSync(filename, 'utf8'));
				return true;
			} else {
				return false;
			}
		} catch (err) {
			return false;
		}
	}
}

module.exports = new PatchManager();
