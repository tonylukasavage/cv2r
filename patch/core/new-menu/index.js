const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'new-menu',
	name: 'New Start Menu',
	description: 'An improved START menu, providing some additional stats like current number of lives and xp until the next level',
	patch: function (pm) {
		// show whip icon for lives
		pm.add([0x5B], 0x1F6CD);

		// write lives to menu
		modSubroutine(pm.name, path.join(__dirname, 'menu.asm'), bank[0], {
			invoke: {
				romLoc: 0x1F115,
				padding: 2
			}
		});
	}
};