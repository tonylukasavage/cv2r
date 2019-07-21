const { textToBytes } = require('../lib/utils');
const teststring = textToBytes("test");

module.exports = {
	name: 'Title screen',
	description: 'Change text on title screen',
	flags: '-c, --title-screen',
	patch: [
		{ offset: 0x01041E, value: "C1 C1 12 01 0E 04 0F 0D 09 1A 05 12 C1 C1" },
		{ offset: 0x01041E, value: ""+teststring }
	]
};
