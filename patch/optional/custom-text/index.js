const path = require('path');
const tp = require('./text-pointers');
const { romToRam } = require('./helpers');
const { bank, core, utils: { modSubroutine } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'custom-text',
	name: 'Custom Text',
	description: 'custom text',
	patch: async function(pm) {
		// initialize original text pointer listing
		const pointers = await tp.init();

		// initialize new text pointer table
		const tableBytes = new Array(tp.pointers.length * 2);
		tableBytes.fill(0xFF, 0, tableBytes.length);

		// update text pointers for all actors
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }
				const pointerIndex = pointers.findIndex(p => p === romToRam(actor.textPointer));
				console.log(pointerIndex);

				// actor.textOffset = (actor.textPointer - 0xCB92) / 2;
				// console.log(actor.textOffset     );
			});
		});

	}
};