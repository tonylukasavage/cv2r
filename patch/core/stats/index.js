const path = require('path');
const { bank, memory, utils: { modData, modSubroutine } } = require('../../../lib');

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

		const bcdTableLow = modData(pm.name, path.join(__dirname, 'data', 'bcd-table-low.txt'), bank[4]);
		const bcdTableHigh = modData(pm.name, path.join(__dirname, 'data', 'bcd-table-high.txt'), bank[4]);
		memory.bcd16 = modSubroutine(pm.name, path.join(__dirname, 'asm', 'bcd16.asm'), bank[4], {
			values: {
				bcdTableLow: bcdTableLow.ram.toString(16),
				bcdTableHigh: bcdTableHigh.ram.toString(16)
			}
		});

		const statNames = modData(pm.name, path.join(__dirname, 'data', 'stat-names.txt'), bank[4]);
		modSubroutine(pm.name, path.join(__dirname, 'asm', 'stats.asm'), bank[4], {
			invoke: {
				romLoc: 0x122CC,
				padding: 2
			},
			values: {
				statNames: statNames.ram.toString(16),
				bcd16: memory.bcd16.ram.toString(16)
			}
		});

		// Stop at final ending screen. Normally the value 0x0E is loaded at this
		// point to cycle back to main screen, but the intent is to remain on the
		// stats screen indefinitely and force a reset to leave it.
		pm.add([ 0x0A ], 0x122DE);


	}
};
