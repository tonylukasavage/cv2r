module.exports = {
	name: 'Fast Text',
	description: 'Dialog boxes load text fast',
	patch: [
		{ offset: 0x1EEAE, bytes: [ 0x00 ] }
	]
};
