const { textToHexString } = require('../lib/utils');

module.exports = {
	name: 'Title screen',
	description: 'Change text on title screen',
	flags: '-c, --title-screen',
	patch: [
		{ offset: 0x01041E, value: textToHexString('BSAC RULES!!!') }
	]
};
