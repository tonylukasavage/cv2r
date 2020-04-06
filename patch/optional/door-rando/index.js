const _ = require('lodash');
const assemble = require('../../../lib/6502assembler');
const fs = require('fs');
const path = require('path');
const { bank, memory, utils: { modSubroutine } } = require('../../../lib');
// town is 10 bytes
// mansion is 11 bytes

module.exports = {
	pre: true,
	id: 'door-rando',
	name: 'Door Rando',
	description: 'All town and mansion doors are randomized',
	patch: function(pm) {
		memory.doorEntryPos = modSubroutine(pm.name, path.join(__dirname, 'door-entry-pos.asm'), bank[3]);

		// override town and and mansion door positioning code to use mine on bank 3 
		const codeRaw = fs.readFileSync(path.join(__dirname, 'bank-switch.asm'));
		const code = _.template(codeRaw)({ doorEntryPos: memory.doorEntryPos.ram.toString(16) });
		const bytes = assemble(code);
		pm.add(bytes, 0x1E77B); // + 1
		pm.add(bytes, 0x1E7DF); // + 2

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

	}
};