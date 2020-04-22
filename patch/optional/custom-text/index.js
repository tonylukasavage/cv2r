const _ = require('lodash');
const fs = require('fs').promises;
const path = require('path');
const { prepText, romToRam } = require('./helpers');
const { bank, core, memory, utils: { itemArticles, modSubroutine, modText, randomInt } } = require('../../../lib');

const BASE_ADDR_ROM = 0xCB92; // 0x8B82 RAM
const sharedItemTypes = [
	'garlicAljiba',
	'laurelsAljiba',
	'garlicAlba',
	'laurelsAlba',
	'laurelsOndol',
	'laurelsDoina',
	'oakRing',
	'oakRib',
	'oakHeart',
	'oakEye',
	'oakNail'
];

module.exports = {
	id: 'custom-text',
	name: 'Custom Text',
	description: 'All the dialog is now a little more fun in CV2R',
	patch: async function(pm, { rng }) {
		// load original text pointers
		const textPointers = [];
		let tpData = await fs.readFile(path.join(__dirname, 'data', 'text-pointers.raw'), 'utf8');
		while (tpData.length > 0) {
			const lowByte = tpData.slice(0, 2);
			const highByte = tpData.slice(2, 4);
			const pointer = parseInt('0x' + highByte + lowByte, 16);
			textPointers.push(pointer);
			tpData = tpData.slice(4);
		}

		// load new text
		const newText = {};
		const newTextFiles = (await fs.readdir(path.join(__dirname, 'data'))).filter(f => path.extname(f) === '.txt');
		for (let f of newTextFiles) {
			const file = path.join(__dirname, 'data', f);
			const name = f.replace(/\.txt$/, '');
			const data = await fs.readFile(file, 'utf8');
			newText[name] = data.split('\n').map(l => l.trim()).filter(l => l);
		}

		// update text pointers for all actors
		const actorMap = {
			'Camilla': 'camilla',
			'Death': 'death',
			'orb': 'orb',
			'sacred flame': 'flame',
			'crystal dude': 'dude',
			'man': 'npc',
			'old lady': 'npc',
			'woman': 'npc',
			'shepherd': 'npc',
			'merchant': 'merchant',
			'secret merchant': 'garlic'
			// 'book': 'book', // books are handled by book patch (clues)
			// 'sign': 'sign',
			// 'priest': 'priest' // all priests share same single text
		};

		const textValues = {};
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }
				const textKey = actorMap[actor.name];
				if (!textKey) { return; }
				const index = randomInt(rng, 0, newText[textKey].length - 1);
				const rawText = newText[textKey][index];
				const item = actor.itemName;
				const text = _.template(rawText)(itemArticles(item));
				const mod = modText(pm.name, prepText(text), bank[3]);
				newText[textKey].splice(index, 1);

				if (sharedItemTypes.includes(actor.itemType)) {
					textValues[actor.itemType] = `
LDA #$${(mod.ram & 0xFF).toString(16)}
STA *$00
LDA #$${(mod.ram >>> 8).toString(16)}
STA *$01
`;
				} else {
					const pointerIndex = textPointers.findIndex(p => p === romToRam(actor.textPointer));
					pm.add([mod.ram & 0xFF], BASE_ADDR_ROM + (pointerIndex * 2));
					pm.add([mod.ram >>> 8], BASE_ADDR_ROM + (pointerIndex * 2) + 1);
				}
			});
		});

		const refuseText = modText(pm.name, 'nice try\nsimon', bank[3]);
		modSubroutine(pm.name, path.join(__dirname, '..', '..', 'core', 'itemizer', 'asm', 'textUnshare.asm'), bank[3], {
			exitOffset: 17,
			values: Object.assign({
				isChecked: memory.isChecked.ram.toString(16),
				refuseLowByte: (refuseText.ram & 0xFF).toString(16),
				refuseHighByte: (refuseText.ram >>> 8).toString(16),
			}, textValues),
			invoke: {
				romLoc: 0x1EEC6,
				padding: 1
			}
		});

	}
};