const fs = require('fs').promises;

(async function main() {
	try {
		const [,,baseRom,hackRom] = process.argv;
		const baseBytes = await fs.readFile(baseRom);
		const hackBytes = await fs.readFile(hackRom);
		if (baseBytes.length !== hackBytes.length) {
			throw new Error(`roms be same length, base rom has ${baseBytes.length}, hacked rom has ${hackBytes.length}`);
		}

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

		console.log(patches);
	} catch (err) {
		console.error(err);
		process.exit(1);
	}
})();
