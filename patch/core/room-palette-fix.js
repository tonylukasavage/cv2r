module.exports = {
	patch: [
		// Fix Ondol laurel room night time palette pointer
		{ offset: 0x80D0, bytes: [ 0xB6 ] },

		// Fix Alba garlic room night time palette pointer
		{ offset: 0x1FA58, bytes: [ 0x15 ] }

		// This fixes the laurel merchant room, but also changes the night time palette
		// for Alba. It's daylight out and the zombies are orange! I'm not going to
		// put it in place, and the garlic merchant room will still get the night time
		// palette, but everything, including the dialog, is still clear. If I can
		// figure out a way to separate the two later, then I'll re-enable this.
		// { offset: 0x1FA5A, bytes: [ 0x15, 0x2E ] }
	]
};
