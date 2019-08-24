const bank = require('../../bank');
const mem = require('../../memory-loc');
const path = require('path');
const { modSubroutine } = require('../../utils');

module.exports = {
	patch: function(pm) {
		mem.isChecked = modSubroutine(pm.name, path.join(__dirname, 'isChecked.asm'), bank[3]);
	}
};