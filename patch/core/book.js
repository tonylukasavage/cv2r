
const { core, utils: { log, randomInt, textToBytes }} = require('../../lib');

module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;
		const clues = [];
		global.spoiler.forEach(spoil =>{
			let [ item, actor, location ] = spoil;

			// remove location descriptors
			location = location.replace(/-.*/, '');

			// remove parenthesized text from location
			location = location.replace(/\(.*/, '');

			// scrap "Mansion" qualifier
			location = location.replace(/Mansion.*/, '');

			// get rid of any extra whitespace
			location = location.trim();

			// normalize whip and crystal text
			if (item.includes('whip')) {
				item = 'a whip';
			} else if (item.includes('crystal')) {
				item = 'a crystal';
			}

			// set clue text based on actor type
			if (actor === 'Death') {
				clues.push('Death guards\n' + item);
			} else if (actor === 'Camilla') {
				clues.push('Camilla\ndefends\n' + item);
			} else if (actor === 'merchant') {
				clues.push('A merchant\nsells\n' + item + '\nin ' + location);
			} else if (actor === 'sacred flame') {
				clues.push(item + '\nis hidden\non Dabi\'s Path');
			} else if (actor === 'orb') {
				clues.push(location + ' hides\n' + item);
			} else if (actor === 'crystal dude') {
				clues.push('someone is\ngiving away\n' + item + '\nin ' + location);
			}
		});

		log('Book Clues');
		log('----------');
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.filter(a => a.fixture && a.name === 'book').forEach(a => {
				const index = randomInt(rng, 0, clues.length - 1);
				const maxlength = a.text.length;

				// make sure new text does not exceed the text it is replacing
				while (clues[index].length > maxlength) {
					clues[index] = clues[index].slice(0, maxlength - 1);
				}
				log(`[${a.text.length}] ` + a.text.replace(/\n/g, ' '));
				log(`[${clues[index].length}] ` + clues[index].replace(/\n/g, ' '));
				log('---');

				const textBytes = textToBytes(clues[index]);
				pm.add(textBytes, a.textPointer);

				// delete so we don't give the same clue twice
				clues.splice(index, 1);
			});
		});
	}
};
