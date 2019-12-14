const core = require('../../lib/core');
const fs = require('fs');
const logic = require('../../config/logic');
const test = require('ava');
const path = require('path');
const vm = require('vm');
const { promisify } = require('util');

const exec = promisify(require('child_process').exec);
const access = promisify(fs.access);

function randomString() {
	return Math
		.random()
		.toString(36)
		.substring(2, 15) + Math.random().toString(36)
		.substring(2, 15);
}

function logicByLocationAndType(location, name, logicType) {
	for (let i = 0; i < core.length; i++) {
		const loc = core[i];
		if (loc.name !== location) { continue; }
		return loc.actors.find(a => a.name === name).requirements[logicType];
	}
}

let useRom;
test.before(async () => {
	try {
		await access('cv2.nes', fs.constants.F_OK);
		useRom = true;
	} catch (err) {
		useRom = false;
	}
});

logic.forEach(lt => {
	for (let i = 0; i < 1000; i++) {
		const logic = lt;
		const seed = randomString();
		const filename = path.join(__dirname, 'tmp', `cv2-test-${seed}`);
		const bin = process.platform === 'win32' ? 'node --no-warnings .\\bin\\cv2r' : 'node --no-warnings ./bin/cv2r';
		const cmd = useRom ? `${bin} --seed ${seed} --output "${filename}" --logic ${logic} cv2.nes` : `${bin} --seed ${seed} --logic ${logic} --json`;

		test(cmd, async t => {
			const gotItems = [];
			const { stdout} = await exec(cmd);
			const crystals = [ 'white crystal', 'blue crystal', 'red crystal' ];
			const { spoiler } = JSON.parse(stdout);
			const spoilerLength = spoiler.length - 1;
			let found;
			let crystalCount = 0;

			spoiler.forEach(s => s.push(logicByLocationAndType(s[2], s[1], logic)));
			do {
				found = false;
				const setVal = v => !!gotItems.includes(v);
				const sandbox = {
					HOLY_WATER: setVal('holy water'),
					WHITE_CRYSTAL: setVal('white crystal'),
					BLUE_CRYSTAL: setVal('blue crystal'),
					RED_CRYSTAL: setVal('red crystal'),
					OAK_STAKE: setVal('oak stake'),
					HEART: setVal('heart'),
					LAURELS: setVal('laurels'),
					GARLIC: setVal('garlic'),
					NAIL: setVal('nail')
				};
				for (let i = 1; i < spoiler.length; i++) {
					const script = new vm.Script(spoiler[i][3]);
					if (!spoiler[i][3] || script.runInNewContext(sandbox)) {
						const item = spoiler[i][0];
						found = true;
						if (item.includes('crystal')) {
							gotItems.push(crystals[crystalCount++]);
						} else {
							gotItems.push(item);
						}
						spoiler.splice(i, 1);
						i--;
					}
				}
			} while (found);

			t.is(gotItems.length, spoilerLength);
			t.pass();
		});
	}
});
