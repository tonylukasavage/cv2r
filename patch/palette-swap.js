module.exports = {
	name: 'Palette Swap',
	description: 'Change palette stuff',
	flags: '-x, --palette-swap',
	explicit: true,
	patch: [
		// Title Screen 
		{ offset: 0x01CAC9, value: "0F 28 03 1C 0F 28 20 1C" },
		{ offset: 0x01CA8F, value: "0F 28 03 20 0F 00 0C 10 0F 28 03 1C 0F 28 1B 1C" },

		//Towns

		//Jova
		{ offset: 0x011EB2, value: "0F 07 17 07 0F 00 23 10 0F 00 10 38 0F 11 20 15" },
		//Veros
		{ offset: 0x011EC3, value: "0F 07 31 07 0F 1B 2B 10 0F 00 10 37 0F 11 20 15" },
		//Aljiba
		{ offset: 0x011ED4, value: "0F 07 37 07 0F 14 21 10 0F 00 10 2B 0F 11 20 15" },
		//Alba
		{ offset: 0x011EE5, value: "0F 07 35 07 0F 03 13 10 0F 00 10 37 0F 11 20 15" },
		//Ondol
		{ offset: 0x011EF6, value: "0F 07 37 07 0F 05 15 10 0F 00 10 37 0F 11 20 15" },
		//Doina
		{ offset: 0x011F07, value: "0F 11 20 11 0F 06 16 10 0F 00 10 0C 0F 11 20 15" },
		//Last town
		{ offset: 0x011F18, value: "0F 16 20 16 0F 04 14 20 0F 00 10 0F 0F 11 20 15" },
		//Room
		{ offset: 0x011EA1, value: "0F 1C 21 1C 0F 09 1B 33 0F 00 20 21 0F 11 20 15" },
		//Night towns
		{ offset: 0x011E90, value: "0F 0C 1C 03 0F 0C 1C 1C 0F 0C 11 0F 0F 01 31 05" },

		//Mansions

		//Berkley
		{ offset: 0x011F6E, value: "0F 15 10 15 0F 01 11 00 0F 07 09 37 0F 11 20 15" },
		//Rover
		{ offset: 0x011F88, value: "0F 1B 10 1B 0F 04 14 00 0F 07 09 37 0F 11 20 15" },
		//Brahms
		{ offset: 0x011FA2, value: "0F 1C 10 1C 0F 00 10 00 0F 07 09 37 0F 11 20 15" },
		//Laruba
		{ offset: 0x011F54, value: "0F 00 10 00 0F 0A 1A 00 0F 07 09 37 0F 11 20 15" },
		//Bodley
		{ offset: 0x011FBC, value: "0F 14 24 14 0F 05 15 10 0F 07 09 37 0F 11 20 15" },
		//Dracula's Castle
		{ offset: 0x012160, value: "0F 04 21 04 0F 21 21 22 0F 05 15 1C 0F 01 20 05" },

		// Map screens

		//Belasco Marsh & Woods
		{ offset: 0x011FD6, value: "0F 07 17 07 0F 25 1A 15 0F 37 1C 14 0F 16 20 06" },
		//Skeleton bridge
		{ offset: 0x011FE7, value: "0F 07 10 07 0F 25 1C 15 0F 21 00 1C 0F 11 20 15" },
		//Cave
		{ offset: 0x01201A, value: "0F 1C 21 1C 0F 2C 14 13 0F 05 15 05 0F 01 20 15" },
		//Boat screen
		{ offset: 0x01CB03, value: "0F 07 17 07 0F 25 1A 15 0F 27 20 11 0F 11 20 15" },
		//After boat
		{ offset: 0x012091, value: "0F 07 17 07 0F 25 1A 15 0F 27 20 11 0F 11 20 15" },
		//Blob screen
		{ offset: 0x01205E, value: "0F 07 10 07 0F 15 1B 05 0F 27 20 1C 0F 11 20 15" },
		//After Ondol
		{ offset: 0x0120F0, value: "0F 07 38 07 0F 25 1A 05 0F 27 20 0C 0F 11 20 15" },
		//Graveyard
		{ offset: 0x01204D, value: "0F 11 10 11 0F 15 1B 05 0F 04 20 1B 0F 11 20 15" },
		//Swamp of DOOM
		{ offset: 0x012080, value: "0F 11 10 11 0F 15 1B 05 0F 04 20 1B 0F 16 20 06" },
		//Firedude screen
		{ offset: 0x0120A2, value: "0F 11 3B 11 0F 15 1B 05 0F 04 20 05 0F 11 20 15" },
		//Flame whip cave thing
		{ offset: 0x0120C4, value: "0F 11 21 11 0F 2C 14 13 0F 05 15 05 0F 01 20 15" },
		//Crystal screen before Bodley
		{ offset: 0x01CB14, value: "0F 05 15 05 0F 2C 14 13 0F 04 3C 05 0F 01 20 15" },
		//Mummy screen
		{ offset: 0x012101, value: "0F 11 2C 11 0F 15 1B 05 0F 04 20 1B 0F 11 20 15" },
		//Lizard swamp screen
		{ offset: 0x011FF8, value: "0F 11 2C 11 0F 15 18 05 0F 14 0B 04 0F 16 20 06" },
		//Mummy graveyard
		{ offset: 0x012123, value: "0F 04 14 04 0F 15 20 05 0F 15 20 0C 0F 11 20 15" },
		//Dead end (completely black palette, cruel joke in case anyone ever goes there)
		{ offset: 0x01202B, value: "0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F 0F" },

		//Endings
		
		//Best Ending
		{ offset: 0x0127F9, value: "0F 00 20 10 0F 16 26 10 0F 07 05 1A 0F 04 38 10" },


		// Sprites

		//Simon
		{ offset: 0x01CABE, value: "0F 06 27 37 0F 27 37 27" },
		//Zombies
		{ offset: 0x01CB6C, value: "0F 01 31 0F 0F" },
		//Skeleton
		{ offset: 0x01CB3A, value: "0F 11 20 0F" },
		//Death
		{ offset: 0x011FB8, value: "11" },
		//Carmilla
		{ offset: 0x011F6A, value: "15" },
		//Dracula
		{ offset: 0x012176, value: "16 20 05" },
	]
};
