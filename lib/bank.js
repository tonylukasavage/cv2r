module.exports = [
	// bank 0
	{
		name: 'bank 0',
		ram: {
			start: 0xB848,
			end: 0xBFCF
		},
		rom: {
			start: 0x3858,
			end: 0x3FDF
		},
		offset: 0
	},

	// bank 1
	{
		name: 'bank 1',
		ram: {
			start: 0xB8CC,
			end: 0xBFCF
		},
		rom: {
			start: 0x78DC,
			end: 0x7FDF
		},
		offset: 0
	},

	// bank 2
	{
		name: 'bank 2',
		ram: {
			start: 0xBEE3,
			end: 0xBFCE
		},
		rom: {
			start: 0xBEF3,
			end: 0xBFDE
		},
		offset: 0
	},

	// bank 3
	{
		name: 'bank 3',
		ram: {
			start: 0x9CF6,
			end: 0xBFCF
		},
		rom: {
			start: 0xDD06,
			end: 0xFFDF
		},
		offset: 0
	},

	// bank 4
	{
		name: 'bank 4',
		ram: {
			start: 0xBAE4,
			end: 0xBFF8
		},
		rom: {
			start: 0x13AF4,
			end: 0x14008
		},
		offset: 0
	},

	// bank 5
	{
		name: 'bank 5',
	},

	// bank 6
	{
		name: 'bank 6',
	},

	// bank 7
	{
		name: 'bank 7 (1)',
		ram: {
			start: 0xFEE2,
			end: 0xFFCE
		},
		rom: {
			start: 0x1FEF2,
			end: 0x1FFDE
		},
		offset: 0
	},

	// a few more bytes on bank 7, indexed at 8
	{
		name: 'bank 7 (2)',
		ram: {
			start: 0xFBD2,
			end: 0xFBFE
		},
		rom: {
			start: 0x1FBE2,
			end: 0x1FC0E
		},
		offset: 0
	}
];