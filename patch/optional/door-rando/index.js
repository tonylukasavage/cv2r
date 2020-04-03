const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'door-rando',
	name: 'Door Rando',
	description: 'All town and mansion doors are randomized',
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'town-door-enter.asm'), bank[3], {
			invoke: {
				romLoc: 0xC81F
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'mansion-exit.asm'), bank[7], {
			invoke: {
				romLoc: 0x1D0F9
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'town-door-enter-pos.asm'), bank[7], {
			invoke: {
				romLoc: 0x1E77B,
				padding: 1
			}
		});
	}
};