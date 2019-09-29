const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'death.asm'), bank[0], {
			invoke: {
				romLoc: 0x1C2A1
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'kills.asm'), bank[1], {
			invoke: {
				romLoc: 0x4937
			}
		});
	}
};
