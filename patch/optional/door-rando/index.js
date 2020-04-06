const _ = require('lodash');
const assemble = require('../../../lib/6502assembler');
const fs = require('fs');
const path = require('path');
const { bank, memory, utils: { modSubroutine } } = require('../../../lib');

const NOP = 0xEA;

function pad(bytes, len) {
	const ret = bytes.slice(0);
	while (ret.length < len) {
		ret.push(NOP);
	}
	return ret;
}

module.exports = {
	pre: true,
	id: 'door-rando',
	name: 'Door Rando',
	description: 'All town and mansion doors are randomized',
	patch: function(pm) {
		memory.doorEntryPos = modSubroutine(pm.name, path.join(__dirname, 'door-entry-pos.asm'), bank[3]);
		memory.bankSwitch232 = modSubroutine(pm.name, path.join(__dirname, 'bank-switch.asm'), bank[8], {
			values: {
				doorEntryPos: memory.doorEntryPos.ram.toString(16)
			}
		});

		// override town and and mansion door positioning code to use mine on bank 3
		// const codeRaw = fs.readFileSync(path.join(__dirname, 'bank-switch.asm'));
		// const code = _.template(codeRaw)({ doorEntryPos: memory.doorEntryPos.ram.toString(16) });
		// const bytes = assemble(code);
		const code = `JSR $${memory.bankSwitch232.ram.toString(16)}`;
		const bytes = assemble(code);
		pm.add(pad(bytes, 10), 0x1E77B);
		pm.add(pad(bytes, 11), 0x1E7DF);

		modSubroutine(pm.name, path.join(__dirname, 'town-door-enter.asm'), bank[3], {
			invoke: {
				romLoc: 0xC81F
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'mansion-door-enter.asm'), bank[3], {
			invoke: {
				romLoc: 0xC7FC,
				padding: 2
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'mansion-exit.asm'), bank[7], {
			invoke: {
				romLoc: 0x1D0F9
			}
		});

		modSubroutine(pm.name, path.join(__dirname, 'town-exit.asm'), bank[9], {
			invoke: {
				romLoc: 0x1D069,
				padding: 1
			}
		});

	}
};