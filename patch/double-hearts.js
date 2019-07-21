module.exports = {
	name: 'Double Hearts',
	description: 'double the value of each heart',
	flags: '-d, --double-hearts',
	explicit: true,
	patch: [
		{ offset: 0x474F, value: "04" },
		{ offset: 0x475C, value: "08" },
		{ offset: 0x4769, value: "0C" }
	]
};