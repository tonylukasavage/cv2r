const path = require('path');
const { bank, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'penalty-reduction',
	name: 'Penalty Reduction',
	description: 'Keep half your hearts after game over',
	patch: function (pm) {
		const result = modSubroutine(pm.name, path.join(__dirname, 'pr.asm'), bank[3]);

		modSubroutine(pm.name, path.join(__dirname, 'pr-bank-switch.asm'), bank[7], {
			invoke: {
				romLoc: 0x01C42B,
				padding: 1
			},
			values: {
				pr: result.ram.toString(16)
			}
		});
	}
};