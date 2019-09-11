module.exports = {
	patch: [
		// Stop flower animation to prevent bad tiles from appearing on non-graveyard screens
		{ offset: 0x6AE5, bytes: [ 0xBE ] }
	]
};
