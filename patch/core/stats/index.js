const path = require('path');
const { bank, utils: { modData, modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'asm', 'death.asm'), bank[0], {
			invoke: {
				romLoc: 0x1C2A1
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'asm', 'kills.asm'), bank[1], {
			invoke: {
				romLoc: 0x4937
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'asm', 'hearts.asm'), bank[1], {
			invoke: {
				romLoc: 0x4772
			}
		});

		const mod = modData(pm.name, path.join(__dirname, 'data', 'stat-names.txt'), bank[4]);
		modSubroutine(pm.name, path.join(__dirname, 'asm', 'stats.asm'), bank[4], {
			invoke: {
				romLoc: 0x122CC,
				padding: 2
			},
			values: {
				statNames: mod.ram.toString(16)
			}
		});

		// Stop at final ending screen. Normally the value 0x0E is loaded at this
		// point to cycle back to main screen, but the intent is to remain on the
		// stats screen indefinitely and force a reset to leave it.
		pm.add([ 0x0A ], 0x122DE);


	}
};
