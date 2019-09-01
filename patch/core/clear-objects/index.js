const path = require('path');
const { bank, memory, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	patch: function(pm) {
		memory.clearObjects = modSubroutine(pm.name, path.join(__dirname, 'clearObjects.asm'), bank[9]);
	}
};
