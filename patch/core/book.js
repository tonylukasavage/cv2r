
const { core, utils: { log, randomInt, textToBytes }} = require('../../lib');
const VOWELS = [ 'a', 'e', 'i', 'o', 'u' ];
const MULTI = [ 'garlic', 'laurels' ];

function article(word) {
	return VOWELS.includes(word.toLowerCase().charAt(0)) ? 'an' : 'a';
}

function multi(item) {
	return MULTI.includes(item) ? 'free' : 'a free';
}

module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;
		const clues = [];
		global.spoiler.forEach(spoil =>{
			let [ item, actor, location ] = spoil;

			// don't leave clues for jova
			if (location.includes('Jova')) { return; }

			// remove location descriptors
			location = location.replace(/-.*/, '');

			// remove parenthesized text from location
			location = location.replace(/\(.*/, '');


			// remove some text qualifiers to make messages shorter
			location = location.replace(/ ?(?:mansion|graveyard|woods)/i, '');
			location = location.replace(/camilla cemetery/i, 'cemetery');

			location = location.trim();

			// normalize whip and crystal text
			if (item.includes('whip') || item.includes('morning star')) {
				item = 'whip';
			} else if (item.includes('crystal')) {
				item = 'crystal';
			}
			// set clue text based on actor type
			if (actor === 'Death') {
				clues.push('Death guards\n' + item);
			} else if (actor === 'Camilla') {
				clues.push('Camilla\ndefends\n' + item);
			} else if (actor === 'merchant') {
				// ignore basic merchants to make clues more relevant
				// clues.push(item + '\nfor sale in\n' + location);
			} else if (actor === 'sacred flame') {
				clues.push(item + '\nis hidden\non Dabi\'s Path');
			} else if (actor === 'orb') {
				clues.push(item + '\nsealed in\n' + location + ' orb');
			} else if (actor === 'crystal dude') {
				clues.push(location + `\nhas ${multi(item)}\n` + item);
			} else if (actor === 'secret merchant') {
				if (location.includes('Storigoi')) {
					clues.push(`graveyard\nduck has ${article(item)}\n` + item);
				} else {
					clues.push(`garlic needed\nto get ${article(item)}\n` + item);
				}
			}
		});

		log('Book Clues');
		log('----------');
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.filter(a => a.fixture && a.name === 'book').forEach(a => {
				const index = randomInt(rng, 0, clues.length - 1);
				const maxlength = a.text.length;
				clues[index] = clues[index].trim();

				// make sure new text does not exceed the text it is replacing
				if (clues[index].length > maxlength) {
					if (clues[index].length > maxlength) {
						clues[index] = clues[index].slice(0, maxlength - 1);
					}
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
