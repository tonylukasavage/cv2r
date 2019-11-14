const path = require('path');
const { bank, core, utils: { modSubroutine } } = require('../../../lib');

const LAURELS = 'laurels';
const RING = 'ring';

module.exports = {
	pre: true,
	id: 'ring-marsh-immunity',
	name: 'Ring Marsh Immunity',
	description: 'When Simon has Dracula\'s ring equipped, he takes no damage from marshes',
	patch: function(pm) {
		// change game logic so that all LAURELS are now [ LAURELS, RING ]
		core.forEach(loc => {
			if (!loc.actors || !loc.actors.length) { return; }
			loc.actors.filter(a => (a.requirements || []).includes(LAURELS)).forEach(a => {
				const index = a.requirements.indexOf(LAURELS);
				a.requirements[index] = [ LAURELS, RING ];
			});
		});

		modSubroutine(pm.name, path.join(__dirname, 'ring-marsh-immunity.asm'), bank[3], {
			invoke: {
				jump: true,
				romLoc: 0xC08A
			}
		});
	}
};