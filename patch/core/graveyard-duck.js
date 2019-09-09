const {
	constants: { SPRITE_TABLE_OFFSET },
	core
} = require('../../lib');

const DUCK = '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1E 3D 7E 7F 7F 87 F3 87 1E 23 41 7E 54 F8 FC FC 7F 7F 5F 2F 13 1F 22 3F 78 40 60 30 1C 1F 3F 3F 00 00 80 40 C0 E0 D8 FF 00 00 80 C0 40 60 38 07 FD FE FA E4 F8 A0 20 E0 03 0E 06 1C 58 E0 E0 E0 1E 3D 7E 7F 7F 87 F3 87 1E 23 41 7E 54 F8 FC FC 7F 7F 5F 2F 13 7C 45 3D 78 40 60 30 1C 7C 7D 3D 00 00 80 40 C0 E0 D8 FF 00 00 80 C0 40 60 38 07 FD FE FA E4 F8 90 30 E0 03 0E 06 1C 58 F0 F0 E0';

module.exports = {
	id: 'graveyard-duck',
	name: 'Graveyard Duck',
	description: '',
	patch: function(pm) {
		const graveyard = core.find(loc => loc.objset === 3 && loc.area === 1 && loc.submap === 0);
		const spriteTable = graveyard.pattern.value & 0x0F;
		const src = SPRITE_TABLE_OFFSET + (spriteTable * 0x1000);

		// copy storigoi graveyard randomized sprite table to empty rom space
		pm.copy(src, 0x38010, 0x1000);

		// add duck to copied table
		pm.add(DUCK.split(' ').map(b => parseInt('0x' + b, 16)), 0x386F0);

		// change pattern table entry for storigoi graveyard to point to new table
		pm.add([ 0x18 ], graveyard.pattern.pointer);

		// update palette for the duck
		pm.add([ 0x0F, 0x38, 0x27, 0x0F ], 0x120E2);
	}
};