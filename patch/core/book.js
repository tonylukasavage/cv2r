
const { core, utils: { randomInt, textToBytes }} = require('../../lib');

module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;
		const clues = [];
		global.spoiler.forEach(a =>{
			let holds = a[0];
			let where = a[2];
			where = where.replace(/-.*/, '');
			where = where.replace(/\(.*/, '');
			where = where.replace(/Mansion.*/, '');
			where = where.replace(/ $/, '');

			if (holds.match('whip')) {
				holds = 'a whip';
			}
			if (holds.match('crystal')) {
				holds = 'a crystal';
			}

			if (a[1] === 'Death') {
				clues.push('Death guards\n' + holds);
			}
			if (a[1] === 'Camilla') {
				clues.push('Camilla holds\n' + holds);
			}
			if (a[1] === 'merchant') {
				clues.push('A merchant\nsells\n' + holds + '\nin ' + where);
			}
			if (a[1] === 'sacred flame') {
				clues.push(holds + '\nis hidden\non Dabi\'s Path');
			}
			if (a[1] === 'orb') {
				clues.push(where + ' hides\n' + holds);
			}
			if (a[1] == 'crystal dude') {
				clues.push('someone is\ngiving away\n' + holds + '\nin ' + where);
			}

		});

		core.forEach(loc => {
			if (!loc.actors) { return; }
			loc.actors.forEach(a => {
				if (!a.fixture) { return; }
				if (a.name === 'book') {
					const index = randomInt(rng, 0, clues.length - 1);
					const maxlength = a.text.length;
					while (clues[index].length > maxlength) {
						clues[index] = clues[index].slice(0, -1);
					}

					const textBytes = textToBytes(clues[index]);
					pm.add(textBytes, a.textPointer);

					// delete so we don't give the same clue twice
					clues.splice(index, 1);
				}
			});
		});
	}
};
