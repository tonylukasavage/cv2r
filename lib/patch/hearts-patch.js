module.exports = {
	name: '100% Heart drops',
	description: 'A heart drops on every single enemy kill',
	flags: '-h, --hearts-patch',
	patch: [
		{ offset: 0x42B9, bytes: [ 0xB0 ] }
	]
};
