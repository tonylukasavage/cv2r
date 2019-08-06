module.exports = {
	name: 'Night Party!',
	description: 'enable NPCs and door entry at night',
	flags: '-n, --night-party',
	patch: [
		{ offset: 0x4167, bytes: [ 0xA9, 0x00 ] },
		{ offset: 0xC7B8, bytes: [ 0xC9, 0x00 ] },
		{ offset: 0xC7BC, bytes: [ 0xC9, 0x24 ] }
	]
};