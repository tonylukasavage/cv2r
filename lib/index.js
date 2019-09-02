const path = require('path');

module.exports = {
	assemble: require('./6502assembler'),
	bank: require('./bank'),
	core: require('./core'),
	difficulty: require('../config/difficulty.json'),
	memory: require('./memory-loc'),
	object: require('./object'),
	patchManager: require('./patch-manager'),
	utils: require('./utils'),
	version: require('../package.json').version,
	dir: {
		patch: path.join(__dirname, '..', 'patch', 'optional'),
		palette: path.join(__dirname, '..', 'patch', 'palette')
	},
	constants: require('../config/constants')
};
