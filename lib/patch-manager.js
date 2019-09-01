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
		'clear-objects',
		'is-checked',
		'title-screen',
		'room-palette-fix',
		'fast-day-night',
		'fast-text',
		'night-party',
		'boss-drop',
		'game-state-checks',
		'enemizer',
		'itemizer'
	]
};

class PatchGroup extends Array {
	constructor(name) {
		super();
		this.name = name;
		this.patches = [];
	}

	add(byteArray, offset) {
		this.push({ [offset+'']: byteArray });
	}
}

const order = [ 'core', 'optional', 'palette' ];

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
			const allPatches = await this.getPatches().map(p => p.id);
			const patches = opts.patch.split(',').map(p => p.trim());
			patches.forEach(patch => {
				if (!allPatches.includes(patch)) {
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
		default:
			throw new Error(`invalid getPatches() type "${type}", must be "patch" or "palette"`);
		}

		for (let patch of fs.readdirSync(patchDir)) {
			const modPath = path.join(patchDir, patch);
			patches.push(require(modPath));
		}
		return patches;
	}

	export() {
		return order.reduce((a,c) => a.concat(this[c]), []);
	}

	patch(romBuffer) {
		order.forEach(o => {
			this[o].forEach(entry => {
				Object.keys(entry).forEach(offset => {
					Buffer.from(entry[offset]).copy(romBuffer, offset);
				});
			});
		});
		return romBuffer;
	}
}

module.exports = new PatchManager();
