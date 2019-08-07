const patches = {
	core: [
		'sram',
		'clear-objects',
		'title-screen',
		'room-palette-fix',
		'fast-day-night',
		'fast-text',
		'night-party',
		'game-state-checks',
		'enemizer',
		'itemizer'
	],
	difficulty: {
		easy: [
			'double-hearts',
			'hearts-patch',
			'penalty-reduction'
		],
		standard: [
			'enemy-hp',
			'hearts-patch',
			'penalty-reduction',
			'price-rando'
		],
		hard: [
			'enemy-hp',
			'price-rando'
		]
	}
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

const order = [ 'core', 'difficulty', 'palette' ];

class PatchManager {
	constructor() {
		this.order = order;
		order.forEach(o => this[o] = new PatchGroup(o));
	}

	init(opts) {
		this.core.patches = patches.core;
		this.difficulty.patches = patches.difficulty[opts.difficulty];
		if (opts.palette) {
			this.palette.patches.push(opts.palette);
		}
	}

	getDifficulties() {
		return Object.keys(patches.difficulty);
	}

	export() {
		return JSON.stringify(order.reduce((a,c) => a.concat(this[c]), []));
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
