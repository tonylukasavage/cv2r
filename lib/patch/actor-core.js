const core = require('../core');
const { textToBytes } = require('../utils');

module.exports = {
	patch: function(pm, opts) {
		core.forEach(loc => {
			// update all actors (npcs, enemies, books, etc...)
			Array.isArray(loc.actors) && loc.actors.forEach(a => {
				// update actor positioning and data, which can be an identifier or hp
				pm.add([ a.x, a.y, a.id, a.data ], a.pointer);

				// update text, if necessary
				if (a.text && a.textPointer) {
					const textArray = Array.isArray(a.text) ? a.text.slice(0) : [ a.text ];
					const textPointerArray = Array.isArray(a.textPointer) ? a.textPointer.slice(0) : [ a.textPointer ];
					for (let i = 0; i < textArray.length; i++) {
						pm.add(textToBytes(textArray[i]), textPointerArray[i]);
					}
				}
			});
		});
	}
};