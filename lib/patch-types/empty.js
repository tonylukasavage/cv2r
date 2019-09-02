const _ = require('lodash');
const { cyan, green } = require('chalk');
const fs = require('fs').promises;
const path = require('path');
const { constants: { PATCH_TEMPLATE } } = require('..');

module.exports = async function(name, files, opts) {
	const { id, output } = opts;
	opts.patch = '[]';
	const rendered = _.template(PATCH_TEMPLATE)(opts).trim();
	const filename = path.join(output, `${id}.js`);
	await fs.writeFile(filename, rendered);

	console.log(`Patch ${green(name)} written to ${cyan(filename)}`);
};