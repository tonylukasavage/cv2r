const core = require('../../data/core');

module.exports = {
	name: 'Enemizer',
	description: 'Randomize enemies',
	flags: '-e, --enemizer',
	patch: function(romBuffer) {
		core[0].actors[0].data = 0;
		core[0].actors[0].typeId = 0xAE;
	}
};