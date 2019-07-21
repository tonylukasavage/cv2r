module.exports = {
	name: '100% Heart drops',
	description: 'Every enemy will drop a heart',
	flags: '-h, --hearts-patch',
	patch: [
		{ offset: 0x42B9, value: "B0" }
	]
};
