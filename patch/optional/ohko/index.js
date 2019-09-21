const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	id: 'ohko',
	name: 'OHKO',
	description: 'Enemies kill Simon in one hit!',
	patch: function(pm) {
		modSubroutine(pm.name, path.join(__dirname, 'ohko.asm'), bank[9], {
			invoke: {
				romLoc: 0x1D366
			}
		});
	}
};