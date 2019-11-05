const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'ring-marsh-immunity',
	name: 'Ring Marsh Immunity',
	description: 'When Simon has Dracula\'s ring equipped, he takes no damage from marshes',
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'ring-marsh-immunity.asm'), bank[3], {
			invoke: {
				romLoc: 0xC088,
				padding: 2
			}
		});
	}
};