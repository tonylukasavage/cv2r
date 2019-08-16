module.exports = {
	name: 'Fast Day-Night Cycle',
	description: 'Get rid of the day-night cycle dialog boxes for a faster transition.',
	flags: '-f, --fast-day-night',
	patch: [
		{ offset: 0x01D7E8, bytes: [ 0x08 ] },
		{ offset: 0x01CF2C, bytes: [ 0x00 ] }
	]
};
