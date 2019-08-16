module.exports = {
	name: 'Night Party!',
	description: 'NPCs still roam the town at night. You can also enter doors and interact with people inside them at night.',
	flags: '-n, --night-party',
	patch: [
		{ offset: 0x4167, bytes: [ 0xA9, 0x00 ] },
		{ offset: 0xC7B8, bytes: [ 0xC9, 0x00 ] },
		{ offset: 0xC7BC, bytes: [ 0xC9, 0x24 ] }
	]
};