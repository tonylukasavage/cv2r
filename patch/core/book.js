
const { core, utils: { log, randomInt, textToBytes }} = require('../../lib');
const VOWELS = [ 'a', 'e', 'i', 'o', 'u' ];
const MULTI = [ 'garlic', 'laurels' ];

function article(word) {
	if (MULTI.includes(word)){
		return 'some';
	}
	return VOWELS.includes(word.toLowerCase().charAt(0)) ? 'an' : 'a';
}

function multi(item) {
	return MULTI.includes(item) ? 'free' : 'a free';
}

// make sure we fit in the box. 14 characters will hit the edge, 5 lines will fit without hitting, 6th will overflow.
function wordWrap(str, maxWidth=13) {
	let newLineStr = "\n";
	let startingString = str;
	let done = false;
	let res = '';
	let lines = 1;
	while (str.length > maxWidth) {
		let found = false;
		lines+=1;
		// Inserts new line at first whitespace of the line
		for (i = maxWidth - 1; i >= 0; i--) {
			if (testWhite(str.charAt(i))) {
				res = res + str.slice(0, i).trim() + newLineStr;
				str = str.slice(i + 1);
				found = true;
				break;
			}
		}
		// Inserts new line at maxWidth position, the word is too long to wrap
		if (!found) {
			res += str.slice(0, maxWidth) + newLineStr;
			str = str.slice(maxWidth);
		}

	}
	if (lines > 5){
		// too many lines! redo linebreaking without word breaking to fit on fewer lines (hopefully)
		str = startingString;
		res = '';

		while (str.length > maxWidth) {
			res += str.slice(0, maxWidth).trim() + newLineStr;
			str = str.slice(maxWidth);
		}
		// this is the best we can do, if we still don't fit there's just too much text
	}

	return res + str;
}

function testWhite(x) {
	var white = new RegExp(/^\s$/);
	return white.test(x.charAt(0));
};


module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;
		const clues = [];
		function shuffleArray(array) {
			for (let i = array.length - 1; i > 0; i--) {
				let j = randomInt(rng, 0, i);
				[array[i], array[j]] = [array[j], array[i]];
			}
		}

		global.spoiler.forEach(spoil =>{
			let [ item, actor, location ] = spoil;

			// don't leave clues for jova
			if (location.includes('Jova')) { return; }

			// remove location descriptors
			location = location.replace(/-.*/, '');

			// remove parenthesized text from location
			location = location.replace(/\(.*/, '');

			// remove some text qualifiers to make messages shorter
			location = location.replace(/ ?mansion/i, '');
			location = location.trim();

			// normalize whip and crystal text
			if (item.includes('whip') || item.includes('morning star')) {
				item = 'whip';
			} else if (item.includes('crystal')) {
				item = 'crystal';
			}
			// set clue text based on actor type
			if (actor === 'Death') {
				clues.push(`Death guards ${article(item)} ` + item);
			} else if (actor === 'Camilla') {
				clues.push(`Camilla defends ${article(item)} ` + item);
			} else if (actor === 'merchant') {
				clues.push(`${article(item)} ` +item + ' for sale in ' + location);
			} else if (actor === 'sacred flame') {
				clues.push(`${article(item)} ` +item + ' hidden on Dabi\'s Path');
			} else if (actor === 'orb') {
				clues.push(`${article(item)} ` +item + ' sealed in ' + location + '\'s orb');
			} else if (actor === 'crystal dude') {
				clues.push(`${multi(item)} ` + item + " in "+location);
			} else if (actor === 'secret merchant') {
				if (location.includes('Storigoi')) {
					clues.push(`graveyard duck has ${article(item)} ` + item);
				} else {
					clues.push(`garlic needed to get ${article(item)} ` + item);
				}
			} else {
				//we didn't match any actor?! what's going on here
				return;

			}
			// do this here so shortest checking is correct, wordWrap potentially adds a few chars
			clues[clues.length-1]=wordWrap(clues[clues.length-1]);
		});
		let i = 0;
		let shortest=100;
		while (i<clues.length){
			if (clues[i].length < shortest){
				shortest=clues[i].length;
			}
			i++;
		}
		shuffleArray(clues);
		log('Book Clues');
		log('----------');
		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.filter(a => a.fixture && a.name === 'book').forEach(a => {
				let index = 0;
				const maxlength = a.text.length;
				if (maxlength < shortest){
					// we shorter than the shortest clue, this probably should never happen, we'll truncate later. set this so we'll match the shortest clue
					maxlength=shortest;
				}
				while (clues[index] != null && clues[index].length > maxlength){
					log('skipping a clue for lack of space in book');
					index+=1;
				}

				if (maxlength === shortest) {
					// set this back and then we'll truncate
					maxlength = a.text.length;
				}

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
