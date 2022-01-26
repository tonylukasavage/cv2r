const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'fangs',
	name: 'Dracula\'s Fangs',
	description: 'Adds Dracula\'s Fangs as a collectable item. Instantly gives you 5 lives. After every continue you will also start with 5 lives.',
	patch: function (pm) {
		modSubroutine(pm.name, path.join(__dirname, 'fangs.asm'), bank[8], {
			invoke: {
				romLoc: 0x1F1A4,
				padding: 2
			}
		});
		modSubroutine(pm.name, path.join(__dirname, 'continue.asm'), bank[8], {
			invoke: {
				romLoc: 0x1C320,
				padding: 1
			}
		});
	}
};