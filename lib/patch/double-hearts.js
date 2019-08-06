module.exports = {
	name: 'Double Hearts',
	description: 'double the value of each heart',
	flags: '-d, --double-hearts',
	explicit: true,
	patch: [
		{ offset: 0x474F, bytes: [ 0x04 ] },
		{ offset: 0x475C, bytes: [ 0x08 ] },
		{ offset: 0x4769, bytes: [ 0x0C ] }
	]
};