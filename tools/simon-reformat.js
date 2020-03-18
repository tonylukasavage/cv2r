const fs = require('fs').promises;
const path = require('path');
const vm = require('vm');

(async function() {
	try {
		const rootDir = './patch/simon';
		const patches = await fs.readdir(rootDir);
		for (let patchName of patches) {
			// only process simon JS patches
			if (!/\.js$/.test(patchName)) { continue; }

			// initialize the patch for export
			const patchFile = path.join('./patch/simon', patchName);
			const context = { module: { exports: {} } };
			vm.createContext(context);
			vm.runInContext(await fs.readFile(patchFile, 'utf8'), context);

			// create JSON patch structure
			const mod = context.module.exports;
			const { id } = mod;
			mod.spriteMaker = true;
			const patchJson = JSON.stringify(mod, null, '\t');
			const patchDir = path.join(rootDir, id);
			const patchJsonFile = path.join(patchDir, 'index.json');
			await fs.mkdir(patchDir);
			await fs.writeFile(patchJsonFile, patchJson);
			await fs.copyFile(
				'../cv2r.com/web/public/img/simon/' + id + '.png',
				path.join(patchDir, id + '.png')
			);

			console.log(`patch created at ${patchDir}`);
		}
	} catch (err) {
		console.error(err.stack);
		process.exit(1);
	}
})();