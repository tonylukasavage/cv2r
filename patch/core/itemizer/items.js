const path = require('path');
const { assemble, bank, utils: { randomInt, modSubroutine } } = require('../../../lib');

let items = module.exports = [];

function getWhips() {
	return [
		// { name: 'leather whip', value: 0x00, icon: 0x5B },
		{ name: 'thorn whip', type: 'whip', value: 0x01, icon: 0x5B, bankCode: [] },
		{ name: 'chain whip', type: 'whip', value: 0x02, icon: 0x5B, bankCode: [] },
		{ name: 'morning star', type: 'whip', value: 0x03, icon: 0x5B, bankCode: [] },
		{ name: 'flame whip', type: 'whip', value: 0x04, icon: 0x5B, bankCode: [] }
	];
}

function getWeapons() {
	return [
		{ name: 'dagger', type: 'weapon', value: 0x01, icon: 0x54, price: 50 },
		{ name: 'silver knife', type: 'weapon', value: 0x02, icon: 0x55, price: 50 },
		{ name: 'golden knife', type: 'weapon', value: 0x04, icon: 0x6F, price: 125 },
		{ name: 'holy water', type: 'weapon', value: 0x08, icon: 0x57, price: 50 },
		{ name: 'diamond', type: 'weapon', value: 0x10, icon: 0x70, price: 50 },
		{ name: 'sacred flame', type: 'weapon', value: 0x20, icon: 0x69, price: 75 },
		{ name: 'oak stake', type: 'weapon', value: 0x40, icon: 0x59, price: 50, count: 5 }
	];
}

function getInventory() {
	return [
		{ name: 'rib', type: 'inventory', value: 0x01, icon: 0x4E, dracPart: true },
		{ name: 'heart', type: 'inventory', value: 0x02, icon: 0x4F, dracPart: true },
		{ name: 'eyeball', type: 'inventory', value: 0x04, icon: 0x50, dracPart: true },
		{ name: 'nail', type: 'inventory', value: 0x08, icon: 0x51, dracPart: true },
		{ name: 'ring', type: 'inventory', value: 0x10, icon: 0x52, dracPart: true },
		{ name: 'white crystal', type: 'inventory', value: 0x20, icon: 0x5E, crystal: true, bankCode: [] },
		{ name: 'blue crystal', type: 'inventory', value: 0x40, icon: 0x6E, crystal: true, bankCode: [] },
		{ name: 'red crystal', type: 'inventory', value: 0x60, icon: 0x5F, crystal: true, bankCode: [] }
	];
}

function getCarry() {
	return [
		{ name: 'silk bag', type: 'carry', value: 0x01, icon: 0x5C, price: 100 },
		{ name: 'magic cross', type: 'carry', value: 0x02, icon: 0x5A, price: 100 },
		{ name: 'laurels', type: 'carry', value: 0x04, icon: 0x58, price: 50, count: 5, bankCode: [] },
		{ name: 'garlic', type: 'carry', value: 0x08, icon: 0x6D, price: 50, count: 2, bankCode: [] }
	];
}

items.allItems = function() {
	return [ ...getWhips(), ...getWeapons(), ...getInventory(), ...getCarry() ];
};

items.initItems = function initItems(pm, rng) {
	const bankIndexes = [ 1, 3 ];

	// "value" property refers to the value set at 0x0434 (RAM) when you own a whip
	const whips = getWhips();
	bankIndexes.forEach(bankIndex => {
		const file = path.join(__dirname, 'asm', 'whip.asm');
		const loc = modSubroutine(pm.name, file, bank[bankIndex]);
		whips.forEach(whip => {
			whip.bankCode[bankIndex] = `
JSR $${loc.ram.toString(16)}
`;
		});
	});
	whips.forEach(w => {
		w.whip = true;
		w.memory = 0x434;
		w.text = 'How \'bout\na whip?';
		w.price = randomInt(rng, 100, 150);
	});

	// "value" property refers to the value added to 0x004A (RAM) when you own a weapon
	const weapons = getWeapons();
	weapons.forEach(w => {
		w.weapon = true;
		w.memory = 0x4A;
		w.code = `
LDA *$${w.memory.toString(16)}
ORA #$${w.value.toString(16)}
STA *$${w.memory.toString(16)}
	`,
		w.codeBytes = assemble(w.code);

		w.text = w.name;
	});

	// "value" property refers to the value added to 0x0091 (RAM) when you own an item
	const inventory = getInventory();
	bankIndexes.forEach(bankIndex => {
		const file = path.join(__dirname, 'asm', 'crystal.asm');
		const loc = modSubroutine(pm.name, file, bank[bankIndex]);
		inventory.filter(i => i.crystal).forEach(crystal => {
			crystal.bankCode[bankIndex] = `
JSR $${loc.ram.toString(16)}
`;
			crystal.text = 'want a\ncrystal?';
		});
	});

	inventory.forEach(i => {
		i.price = i.crystal ? randomInt(rng, 50, 100) : 100;
		i.memory = 0x91;
		if (i.dracPart) {
			i.code = `
LDA *$${i.memory.toString(16)}
ORA #$${i.value.toString(16)}
STA *$${i.memory.toString(16)}
`;
			i.codeBytes = assemble(i.code);
			i.text = i.name;
		}
	});

	// "value" property refers to the value added to 0x0092 (RAM) when you own an item
	const carry = getCarry();

	// TODO: can this be optimized for garlic and laurels to share?
	// write subroutines to handle garlic and laurels since they require more logic
	// than the other items in the game and would unnecessarily chew up rom space
	const carryValues = [
		{ memory: '4C', value: 0x04 },
		{ memory: '4D', value: 0x08 }
	];
	bankIndexes.forEach(bankIndex => {
		carryValues.forEach(values => {
			const file = path.join(__dirname, 'asm', 'carry.asm');
			const loc = modSubroutine(pm.name, file, bank[bankIndex], { values });
			const item = carry.find(c => c.value === values.value);
			item.bankCode[bankIndex] = `
JSR $${loc.ram.toString(16)}
`;
		});
	});

	// back to normal item handling, but only generating code for silk bag and cross
	carry.forEach(c => {
		c.memory = 0x92;
		if (c.value < 0x04) {
			c.code = `
LDA *$${c.memory.toString(16)}
ORA #${c.value.toString(16)}
STA *$${c.memory.toString(16)}
	`;
			c.codeBytes = assemble(c.code);
		}
		c.text = c.name;
	});

	// add all processed items to the exported array
	items.push(...whips, ...weapons, ...inventory, ...carry);
};
