const items = require('../../core/itemizer/items');
const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'req-drac',
	name: 'Random Dracula Requirements',
	description: 'Normally all dracula parts, red crystal, and magic cross are required to break the wall before Dracula\'s mansion. With this patch you\'ll need to hunt down some clues to find out what you\'ll need to enter Dracula\'s mansion.',
	patch: function(pm) {
		const reqs = items.filter(i => ![ 'garlic', 'laurels', 'oak stake' ].includes(i.name));
		console.log(reqs);
		// modSubroutine(pm.name, path.join(__dirname, 'req-drac.asm'), bank[1], {
		// 	invoke: {
		// 		romLoc: 0x49B2
		// 	}
		// });
	}
};