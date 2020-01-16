const path = require('path');
const { bank, patchManager, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		const hasDiamondWarp = patchManager.optional.patches.includes('diamond-warp');
		modSubroutine(pm.name, path.join(__dirname, 'sram.asm'), bank[8], {
			invoke: {
				romLoc: 0x1C02B,
				padding: 2
			},
			values: {
				diamondWarp: hasDiamondWarp ? '\nLDA #$01\nSTA $6006\nLDA #$00\n' : ''
			}
		});
	}
};
