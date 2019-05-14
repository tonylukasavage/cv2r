module.exports = {
	name: 'Fast Day-Night Cycle',
	description: 'get rid of the day-night cycle dialog boxes',
	flags: '-f, --fast-day-night',
	patch: [
		{ offset: 0x01D7E8, value: '08' }
	]
};