const fs = require('fs').promises;
const path = require('path');
const { prepText, romToRam } = require('./helpers');
const { bank, core, utils: { modText } } = require('../../../lib');

const BASE_ADDR_ROM = 0xCB92; // 0x8B82 RAM

module.exports = {
	id: 'custom-text',
	name: 'Custom Text',
	description: 'All the dialog is now a little more fun in CV2R',
	patch: async function(pm) {
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
			newText[name] = data.split('\n').map(l => l.trim()).filter(l => l).map(l => ({ rawText: l }));
		}

		// write new text table
		// Object.keys(newText).forEach(key => {
		// 	const textArray = newText[key];
		// 	textArray.forEach(textObj => {
		// 		textObj.mod = modText(pm.name, prepText(textObj.text), bank[3]);
		// 	});
		// });
		// console.log(JSON.stringify(newText, null, 2));

		const pointerMod = modText(pm.name, prepText('Remember when JC had the world record?'), bank[3]);

		// update text pointers for all actors
		const actorMap = {
			'Camilla': 'camilla',
			'Death': 'death',
			'orb': 'orb'
		};

		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(actor => {
				if (!actor.textPointer) { return; }
				if (actor.name === 'orb') {

				} else if (actor.name === 'Camilla') {

				} else if (actor.name === 'Death') {

				} else if (actor.name === 'sacred flame') {

				} else if (actor.name === 'crystal dude') {

				} else if (['man', 'old lady', 'woman', 'sheperd'].includes(actor.name)) {

				} else if (actor.name === 'merchant') {

				} else if (actor.name === 'secret merchant') {

				}

				if (actor.id !== 0xB5) { return; }
				const pointerIndex = textPointers.findIndex(p => p === romToRam(actor.textPointer));
				pm.add([pointerMod.ram & 0xFF], BASE_ADDR_ROM + (pointerIndex * 2));
				pm.add([pointerMod.ram >>> 8], BASE_ADDR_ROM + (pointerIndex * 2) + 1);

				// console.log(`[${(0xCB92 + (pointerIndex * 2)).toString(16)}] ${(pointerMod.ram >>> 8).toString(16)}${(pointerMod.ram & 0xFF).toString(16).padStart(2, '0')}`);
			});
		});

	}
};