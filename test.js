const test = require('ava');
const path = require('path');
const { promisify } = require('util');

const exec = promisify(require('child_process').exec);
 
function randomString() {
	return Math
		.random()
		.toString(36)
		.substring(2, 15) + Math.random().toString(36)
		.substring(2, 15);
}

for (let i = 0; i < 1000; i++) {
	const seed = randomString();
	const filename = path.join(__dirname, 'tmp', `cv2-test-${seed}`);
	const bin = process.platform === 'win32' ? 'node .\\bin\\cv2r' : './bin/cv2r';
	const cmd = `${bin} --seed ${seed} --output "${filename}" cv2.nes`;
	test(cmd, async t => {
		await exec(cmd);
		t.pass();
	});
}
