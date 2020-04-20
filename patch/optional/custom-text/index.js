const _ = require('lodash');
const fs = require('fs').promises;
const path = require('path');
const { prepText, romToRam } = require('./helpers');
const { bank, core, utils: { modText, randomInt, textToBytes } } = require('../../../lib');

const BASE_ADDR_ROM = 0xCB92; // 0x8B82 RAM

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

		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }

				// grab random text from new text listing, write it to the rom, then remove it from the pool
				const textKey = actorMap[actor.name];
				if (!textKey) { return; }
				const index = randomInt(rng, 0, newText[textKey].length - 1);
				const text = newText[textKey][index];
				const mod = modText(pm.name, prepText(text), bank[3]);
				newText[textKey].splice(index, 1);

				// update actor's text pointer to reference our new text
				const pointerIndex = textPointers.findIndex(p => p === romToRam(actor.textPointer));
				pm.add([mod.ram & 0xFF], BASE_ADDR_ROM + (pointerIndex * 2));
				pm.add([mod.ram >>> 8], BASE_ADDR_ROM + (pointerIndex * 2) + 1);
			});
		});

	}
};