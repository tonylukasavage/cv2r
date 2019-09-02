const _ = require('lodash');
const fs = require('fs').promises;
const path = require('path');
const { constants: { PATCH_TEMPLATE } } = require('..');

module.exports = async function(files, opts) {
	const { id, output } = opts;
	opts.patch = '[]';
	const rendered = _.template(PATCH_TEMPLATE)(opts).trim();
	await fs.writeFile(path.join(output, `${id}.js`), rendered);
};