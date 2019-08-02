class Patch extends Array {
	constructor(name) {
		super();
		this.name = name;
	}

	add(byteArray, offset) {
		this.push({ [offset+'']: byteArray });
	}
}

class PatchManager {
	constructor() {
		this.core = new Patch('core');
		this.options = new Patch('options');
	}

	export() {
		return JSON.stringify(this.core.concat(this.options));
	}

	patch(romBuffer) {
		const patches = [ this.core, this.options ];
		patches.forEach(patch => {
			this.core.forEach(entry => {
				Object.keys(entry).forEach(offset => {
					Buffer.from(entry[offset]).copy(romBuffer, offset);
				});
			});
		});
		return romBuffer;
	}
}

module.exports = new PatchManager();
