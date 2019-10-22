const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'drac-downgrade',
	name: 'Dracula Fight Downgrade',
	description: 'Once Dracula\'s summoning blaze lights, Simon is given a thorn whip and has his level set to level 2.',
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'drac-downgrade.asm'), bank[1], {
			invoke: {
				romLoc: 0x74C3
			}
		});
	}
};