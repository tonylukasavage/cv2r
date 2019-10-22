module.exports = {
	patch: [
		// camilla drop sprite
		{ offset: 0x2ABE0, bytes: 'C8 E4 E4 C4 8C 1F FE 00 F0 F8 F8 F8 F0 E0 00 00' },
		{ offset: 0x2A7F0, bytes: '01 03 01 01 03 0F 1F 3F 00 01 00 00 00 03 0F 1F' },
		{ offset: 0x2A800, bytes: '3F 7F 7F 3F 3F 18 0F 00 1F 3F 3F 1F 1F 0F 00 00' },
		{ offset: 0x2ABD0, bytes: 'C0 F8 FC FE FC F0 E0 D0 00 C0 F8 7C 00 00 80 E0' },

		// death drop sprite
		// { offset: 0x29590, bytes: '01 03 01 01 03 0F 1F 3F 00 01 00 00 00 03 0F 1F 3F 7F 7F 3F 3F 18 0F 00 1F 3F 3F 1F 1F 0F 00 00 C0 F8 FC FE FC F0 E0 D0 00 C0 F8 7C 00 00 80 E0 C8 E4 E4 C4 8C 1F FE 00 F0 F8 F8 F8 F0 E0 00 00' }
	]
};
