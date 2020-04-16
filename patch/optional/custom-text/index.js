const tp = require('./text-pointers');
const { prepText, romToRam } = require('./helpers');
const { bank, core, utils: { modText } } = require('../../../lib');

module.exports = {
	pre: true,
	id: 'custom-text',
	name: 'Custom Text',
	description: 'custom text',
	patch: async function(pm) {
		// initialize original text pointer listing
		const pointers = await tp.init();

		// initialize new text pointer table
		// const tableBytes = new Array(tp.pointers.length * 2);
		// tableBytes.fill(0xFF, 0, tableBytes.length);

		// write new text table
		const pointerMod = modText(pm.name, prepText('Remember when JC had the world record?'), bank[3]);

		// update text pointers for all actors
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }
				if (actor.id !== 0xB5) { return; }
				const pointerIndex = pointers.findIndex(p => p === romToRam(actor.textPointer));
				pm.add([pointerMod.ram & 0xFF], 0xCB92 + (pointerIndex * 2));
				pm.add([pointerMod.ram >>> 8], 0xCB92 + (pointerIndex * 2) + 1);

				// console.log(`[${(0xCB92 + (pointerIndex * 2)).toString(16)}] ${(pointerMod.ram >>> 8).toString(16)}${(pointerMod.ram & 0xFF).toString(16).padStart(2, '0')}`);
			});
		});

	}
};