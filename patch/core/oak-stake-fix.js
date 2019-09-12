module.exports = {
	patch: [
		// Use knife sprite for oak stake since it's on every sprite table
		{ offset: 0x1DE46, bytes: [ 0xAD ] }
	]
};
