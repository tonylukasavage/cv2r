module.exports = {
	id: 'ghost-town',
	name: 'Memories of a Ghost Town',
	description: 'Burb\'s FDS any\% inspired palette',
	patch: [
		// Title Screen
		{ offset: 0x01CAC9, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		{ offset: 0x01CA8F, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },

		// Towns

		// Jova
		{ offset: 0x011EB2, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Veros
		{ offset: 0x011EC3, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Aljiba
		{ offset: 0x011ED4, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Alba
		{ offset: 0x011EE5, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Ondol
		{ offset: 0x011EF6, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Doina
		{ offset: 0x011F07, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Last town
		{ offset: 0x011F18, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Room
		{ offset: 0x011EA1, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Night towns
		{ offset: 0x011E90, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },

		// Church offset
		{ offset: 0x011F29, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },

		// Mansions

		// Berkley
		{ offset: 0x011F6E, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Rover
		{ offset: 0x011F88, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Brahms
		{ offset: 0x011FA2, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Laruba
		{ offset: 0x011F54, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Bodley
		{ offset: 0x011FBC, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Dracula's Castle
		{ offset: 0x012160, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },

		// Map screens

		// Belasco Marsh & Woods
		{ offset: 0x011FD6, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Skeleton bridge
		{ offset: 0x011FE7, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Cave
		{ offset: 0x01201A, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Boat screen
		{ offset: 0x01CB03, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// After boat
		{ offset: 0x012091, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Blob screen
		{ offset: 0x01205E, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// After Ondol
		{ offset: 0x0120F0, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Graveyard
		{ offset: 0x01204D, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Swamp of DOOM
		{ offset: 0x012080, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Firedude screen
		{ offset: 0x0120A2, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Flame whip cave thing
		{ offset: 0x0120C4, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Crystal screen before Bodley
		{ offset: 0x01CB14, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Mummy screen
		{ offset: 0x012101, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Lizard swamp screen
		{ offset: 0x011FF8, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Mummy graveyard
		{ offset: 0x012123, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },
		// Dead end
		{ offset: 0x01202B, bytes: '0F 20 20 20 0F 20 20 20 0F 20 20 20 0F 20 20 20' },

		// Endings

		// Best Ending
		//{ offset: 0x0127F9, bytes: '0F 00 20 10 0F 16 26 10 0F 07 05 1A 0F 04 38 10' },


		// Sprites

		// Simon
		//{ offset: 0x01CABE, bytes: '0F 0A 1A 2A 0F 0A 2A 0A' },
		// Zombies
		//{ offset: 0x01CB6C, bytes: '0F 01 31 0F 0F' },
		// Skeleton
		//{ offset: 0x01CB3A, bytes: '0F 11 20 0F' },
		// Death
		//{ offset: 0x011FB8, bytes: '11' },
		// Carmilla
		//{ offset: 0x011F6A, bytes: '1A 2A' },
		// Dracula
		//{ offset: 0x012176, bytes: '1A 20 0F' }
	]
};
