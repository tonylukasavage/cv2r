const textPointers = require('./data/text-pointers');
const { prepText, romToRam } = require('./helpers');
const { bank, core, utils: { modText } } = require('../../../lib');

const BASE_ADDR_ROM = 0xCB92; // 0x8B82 RAM

module.exports = {
	pre: true,
	id: 'custom-text',
	name: 'Custom Text',
	description: 'custom text',
	patch: async function(pm) {
		// write new text table
		const pointerMod = modText(pm.name, prepText('Remember when JC had the world record?'), bank[3]);

		// update text pointers for all actors
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }
				if (actor.id !== 0xB5) { return; }
				const pointerIndex = textPointers.findIndex(p => p === romToRam(actor.textPointer));
				pm.add([pointerMod.ram & 0xFF], BASE_ADDR_ROM + (pointerIndex * 2));
				pm.add([pointerMod.ram >>> 8], BASE_ADDR_ROM + (pointerIndex * 2) + 1);

				// console.log(`[${(0xCB92 + (pointerIndex * 2)).toString(16)}] ${(pointerMod.ram >>> 8).toString(16)}${(pointerMod.ram & 0xFF).toString(16).padStart(2, '0')}`);
			});
		});

	}
};