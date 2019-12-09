const fs = require('fs');
const test = require('ava');
const path = require('path');
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

let useRom;
test.before(async () => {
	try {
		await access('cv2.nes', fs.constants.F_OK);
		useRom = true;
	} catch (err) {
		useRom = false;
	}
});

for (let i = 0; i < 1000; i++) {
	const seed = randomString();
	const filename = path.join(__dirname, 'tmp', `cv2-test-${seed}`);
	const bin = process.platform === 'win32' ? 'node --no-warnings .\\bin\\cv2r' : 'node --no-warnings ./bin/cv2r';
	const cmd = useRom ? `${bin} --seed ${seed} --output "${filename}" cv2.nes` : `${bin} --seed ${seed} --json`;

	test('cv2r --seed ' + seed, async t => {
		await exec(cmd);
		t.pass();
	});
}
