module.exports = {
	name: 'Fast Day-Night Cycle',
	description: 'get rid of the day-night cycle dialog boxes',
	flags: '-f, --fast-day-night',
	patch: [
		{ offset: 0x01D7E8, bytes: [ 0x08 ] },
		{ offset: 0x01CF2C, bytes: [ 0x00 ] }
	]
};
