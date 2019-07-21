const { textToHexString } = require('../lib/utils');
const { version } = require('../package.json');

module.exports = {
	name: 'Title screen',
	description: 'Change text on title screen',
	flags: '-c, --title-screen',
	patch: [
		//First row, 14 characters
		{ offset: 0x01041E, value: textToHexString("  randomizer  ") },
		//Second row, 13 characters
		{ offset: 0x010169, value: textToHexString("   v" + version + "    ") },
		//Third row, 24 characters
		{ offset: 0x010179, value: textToHexString("                        ") },
		//Fourth row, 11 characters
		{ offset: 0x010194, value: textToHexString(" made by   ") },
		//Fifth row, 24 characters
		{ offset: 0x0101A2, value: textToHexString("   bloodsweatandcode    ") },
		//{ offset: 0x01041E, value: textToHexString("version " + version) + ' C1' }
	]
};
