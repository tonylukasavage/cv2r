module.exports = {
	id: 'double-hearts',
	name: 'Double Hearts',
	description: 'Doubles the value of every heart dropped',
	patch: [
		{ offset: 0x474F, bytes: [ 0x04 ] },
		{ offset: 0x475C, bytes: [ 0x08 ] },
		{ offset: 0x4769, bytes: [ 0x0C ] }
	]
};
