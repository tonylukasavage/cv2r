const fs = require('fs').promises;
const path = require('path');

exports.BASE_ADDR_RAM = 0x8B82;
exports.BASE_ADDR_ROM = 0xCB92;
exports.pointers = [];

exports.init = async function init() {
	exports.pointers = [];
	let data = await fs.readFile(path.join(__dirname, 'text-pointers-raw.txt'), 'utf8');
	while (data.length > 0) {
		const lowByte = data.slice(0, 2);
		const highByte = data.slice(2, 4);
		const pointer = parseInt('0x' + highByte + lowByte, 16);
		exports.pointers.push(pointer);
		data = data.slice(4);
	}
	return exports.pointers;
};