const { red } = require('chalk');
const fs = require('fs');

const [ name, rom, offset ] = process.argv.slice(2);
if (!name) {
	console.error(red('must provide a name'));
	process.exit(1);
}
if (!rom) {
	console.error(red('must provide a rom'));
	process.exit(1);
}
if (!offset) {
	console.error(red('must provide an offset'));
	process.exit(1);
}
if (!/^0x/.test(offset)) {
	console.error(red('offset must be hex format ("0x1234", not "1234")'));
	process.exit(1);
}

const data = fs.readFileSync(rom);
const offsetInt = parseInt(offset, 16);
const buf = data.slice(offsetInt, offsetInt + 0x1000);
const dest = `./sprite/${name}.table`;
fs.writeFileSync(dest, buf);

console.log(`Sprite table $${offsetInt.toString(16)}-$${(offsetInt + 0xFFF).toString(16).toUpperCase()} written to ${dest}`);