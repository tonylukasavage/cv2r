module.exports = {
	name: 'Night Party!',
	description: 'enable NPCs and door entry at night',
	flags: '-n, --night-party',
	patch: [
		{ offset: 0x4167, value: "A9 00" },
		{ offset: 0xC7B8, value: "C9 00" },
		{ offset: 0xC7BC, value: "C9 24" }
	]
};