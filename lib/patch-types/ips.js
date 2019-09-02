const _ = require('lodash');
const { cyan, green } = require('chalk');
const fs = require('fs').promises;
const path = require('path');
const { constants: { PATCH_TEMPLATE } } = require('..');

const IPS_HEADER = Buffer.from([ 0x50, 0x41, 0x54, 0x43, 0x48 ]);
const IPS_FOOTER = Buffer.from([ 0x45, 0x4F, 0x46 ]);
const IPS_FOOTER_DATA = IPS_FOOTER.readUIntBE(0, 3);

module.exports = async function(name, files, opts) {
	const [ ipsFile ] = files;
	const ipsBuffer = await validateIps(ipsFile);
	let offset = 5;
	const patches = [];

	function readBytes(len) {  
		if (offset + len > ipsBuffer.length) {
			throw new Error('IPS file exceeded, no EOF found');
		}
		const data = ipsBuffer.readUIntBE(offset, len);
		offset += len;
		return data;
	}

	// eslint-disable-next-line
	while (true) {
		const addr = readBytes(3);
		if (addr === IPS_FOOTER_DATA) { break; }
		const len = readBytes(2);

		if (len) {
			const dataBuffer = ipsBuffer.slice(offset, offset + len);
			offset += len;
			patches.push({ offset: addr, bytes: [ ...dataBuffer ] });
		} else {
			const repeat = readBytes(2);
			const byte = readBytes(1);
			const bytes = [];
			for (let i = 0; i < repeat; i++) {
				bytes[i] = byte;
			}
			patches.push({ offset: addr, bytes });
		}
	}

	// write collected patches to module format in designated location
	const { id, output } = opts;
	opts.patch = JSON.stringify(patches, null, '\t')
		.replace(/\n/g, '\n\t')
		.replace(/"(bytes|offset)"/g, '$1');
	const rendered = _.template(PATCH_TEMPLATE)(opts).trim();
	const filename = path.join(output, `${id}.js`);
	await fs.writeFile(filename, rendered);

	console.log(`Patch ${green(name)} written to ${cyan(filename)}`);
};

async function validateIps(file) {
	const ipsBuffer = await fs.readFile(file);
	if (ipsBuffer.slice(0, IPS_HEADER.length).compare(IPS_HEADER) !== 0) {
		throw new Error('invalid IPS header');
	}

	if (ipsBuffer.slice(ipsBuffer.length - 6, ipsBuffer.length - 3).compare(IPS_FOOTER) === 0
		&& ipsBuffer.slice(ipsBuffer.length - 3, ipsBuffer.length).compare(IPS_FOOTER) !== 0) {
		throw new Error('extended format IPS truncation is not supported');
	}
	if (ipsBuffer.slice(ipsBuffer.length - 3, ipsBuffer.length).compare(IPS_FOOTER) !== 0) {
		throw new Error('invalid IPS footer');
	}
	return ipsBuffer;
}