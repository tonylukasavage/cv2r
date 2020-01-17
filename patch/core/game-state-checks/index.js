const path = require('path');
const { bank, memory, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		// subroutine to handle jovah warp and inventory quest item deselect code
		memory.gameStateChecks = modSubroutine(pm.name, path.join(__dirname, 'gameStateChecks.asm'), bank[2]);
		memory.warpPositioning = modSubroutine(pm.name, path.join(__dirname, 'warpPositioning.asm'), bank[3]);

		// bank switch and JSR on bank 7 to invoke the game state checks on bank 2, where
		// there's more free space
		modSubroutine(pm.name, path.join(__dirname, 'gameStateChecksWrapper.asm'), bank[7], {
			invoke: {
				romLoc: 0x1C09A
			},
			values: {
				gameStateChecks: memory.gameStateChecks.ram.toString(16)
			}
		});

		// update simon positioning+flags and camera positioning on jovah warp
		modSubroutine(pm.name, path.join(__dirname, 'jovahWarpPositioning.asm'), bank[8], {
			invoke: {
				romLoc: 0x1CFF8,
				padding: 1
			},
			values: {
				warpPositioning: memory.warpPositioning.ram.toString(16)
			}
		});

		// special handling for jovah warp on ferry
		modSubroutine(pm.name, path.join(__dirname, 'jovahWarpFerryCheck.asm'), bank[8], {
			invoke: {
				romLoc: 0x1CF4C,
				padding: 1
			},
			values: {
				clearObjects: memory.clearObjects.ram.toString(16)
			}
		});
	}
};
