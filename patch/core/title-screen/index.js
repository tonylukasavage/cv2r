const path = require('path');

const ICONS = [
	0x4D, // fangs
	0x4E, // rib
	0x4F, // heart
	0x50, // eyeball
	0x51, // nail
	0x52, // ring
	0x54, // dagger
	0x55, // silver knife
	0x57, // holy water
	0x58, // laurels
	0x59, // oak stake
	0x5A, // cross
	0x5B, // whip
	0x5C, // silk bag
	0x5E, // red crystal
	0x5F, // white crystal
	0x61, // heart
	0x69, // sacred flame
	0x6D, // garlic
	0x6E, // blue crystal
	0x6F, // golden knife
	0x70 // diamond
];

module.exports = {
	patch: function(patchGroup, opts) {
		const { version } = require('../../../package.json');
		const {
			bank,
			utils: { modBytes, modSubroutine, randomInt, TEXT_MAP_TITLE, textToBytes }
		} = require('../../../lib');
		const { rng } = opts;

		// convert text string to bytes and add the patch
		const titlePrint = (text, rom) => patchGroup.add(textToBytes(text, TEXT_MAP_TITLE), rom);

		// attempt to provide equal left/right padding on a title string
		const titlePad = (text, size) => {
			let padFront = text.length % 2;
			while (text.length < size) {
				text = `${padFront ? ' ' : ''}${text}${padFront ? '' : ' '}`;
				padFront = !padFront;
			}
			return text;
		};

		// It's important that the exact number of characters in the following strings are used.
		titlePrint('  randomizer  ', 0x01041E);
		titlePrint(titlePad(`v${version}`, 13), 0x010169);
		titlePrint('                        ', 0x010179);
		titlePrint('           ', 0x010194);
		titlePrint('  by bloodsweatandcode  ', 0x0101A2);

		// prevent selecting "password"
		titlePrint('        ', 0x13A2D);
		patchGroup.add([ 0xA9, 0x00 ], 0x1C39B);

		// update game start cursor
		patchGroup.add([ 0x6F ], 0x316D);
		patchGroup.add([ 0x88 ], 0x1C3CF);

		// add seed icons to game start screen
		const oam = [];
		const x = 0x48;
		for (let i = 0; i < 5; i++) {
			// y, tile id, attributes, x
			oam.push(0x98, ICONS[randomInt(rng, 0, ICONS.length - 1)], 0x00, x + (i * 0x1A));
		}
		const oamLoc = modBytes(patchGroup.name, oam, bank[0]);
		modSubroutine(patchGroup.name, path.join(__dirname, 'asm', 'seed-icons.asm'), bank[0], {
			invoke: {
				romLoc: 0x1C37C
			},
			values : {
				oamLoc: oamLoc.ram.toString(16)
			}
		});

		// update palette for seed icons
		patchGroup.add([ 0x0F, 0x12, 0x30, 0x16 ], 0x1CA9F);
	}
};