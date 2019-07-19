module.exports = {
	name: 'Fast Text',
	description: 'Dialog boxes load text fast',
	flags: '-t, --fast-text',
	patch: [
		{ offset: 0x1EEAE, value: "00" }
	]
};