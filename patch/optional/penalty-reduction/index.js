const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'penalty-reduction',
	name: 'Penalty Reduction',
	description: 'Keep half your hearts after game over',
	patch: function (pm) {
		modSubroutine(pm.name, path.join(__dirname, 'pr.asm'), bank[8], {
			invoke: {
				romLoc: 0x01C42B,
				padding: 1
			}
		});
	}
};