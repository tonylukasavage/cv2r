const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'disable-qk',
	name: 'Disable Quick Kill',
	description: 'Disable the vanilla CV2 bug where the last frame of a subweapon does 185 damage, most often used to quick kill Death and Dracula.',
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'disable-qk.asm'), bank[1], {
			invoke: {
				romLoc: 0x49B2
			}
		});
	}
};