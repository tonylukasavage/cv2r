const path = require('path');
const { bank, memory, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		memory.isChecked = modSubroutine(pm.name, path.join(__dirname, 'isChecked.asm'), bank[3]);
	}
};
