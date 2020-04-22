const RAM_ROM_DIFF = exports.RAM_ROM_DIFF = 0x4010;
const MAX_CHARS_PER_LINE = exports.MAX_CHARS_PER_LINE = 12;
const MAX_LINES = exports.MAX_LINES = 5;
const MAX_MERCHANT_LINES = exports.MAX_MERCHANT_LINES = 2;

exports.ramToRom = function(val) {
	return val + RAM_ROM_DIFF;
};

exports.romToRam = function(val) {
	return val - RAM_ROM_DIFF;
};

exports.prepText = function(text, actorName) {
	const words = text.split(/[\s\r\n\t]+/);
	let lines = [[]];

	while (words.length > 0) {
		const line = lines[lines.length - 1];
		const lineLength = line.reduce((a,c) => a + c.length + 1, 0);
		if (lineLength + words[0].length > MAX_CHARS_PER_LINE) {
			if (lineLength === 0 || words[0].length > 12) {
				const word = words.shift();
				line.push(word.slice(0, 12 - lineLength - (lineLength > 0 ? 1 : 0)));
				lines.push([]);
				words.unshift(word.slice(12 - lineLength - (lineLength > 0 ? 1 : 0)));
			} else {
				lines.push([words.shift()]);
			}
		} else {
			line.push(words.shift());
		}
	}

	lines = lines.filter(l => l[0] !== '');
	if (lines.length > MAX_LINES || (actorName === 'merchant' && lines.length > MAX_MERCHANT_LINES)) {
		throw new Error(`text is too long: "${text}"`);
	}

	return lines.reduce((a,c) => a + c.join(' ') + '\n', '').trimEnd();
};