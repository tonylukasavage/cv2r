const assemble = require('../6502assembler');

// "value" property refers to the value set at 0x0434 (RAM) when you own a whip
const whips = [
  //{ name: 'leather whip', value: 0x00, icon: 0x5B },
  { name: 'thorn whip', value: 0x01, icon: 0x5B, price: 100 },
  { name: 'chain whip', value: 0x02, icon: 0x5B, price: 150 },
  { name: 'morning star', value: 0x03, icon: 0x5B, price: 200 },
  { name: 'flame whip', value: 0x04, icon: 0x5B, price: 226 }
];
whips.forEach(w => {
  w.whip = true;
  w.memory = 0x434;
  w.code = `
LDA #$${w.value.toString(16)}
STA $${w.memory.toString(16)}
`,
  w.codeBytes = assemble(w.code);

  w.text = w.name;
});

// "value" property refers to the value added to 0x004A (RAM) when you own a weapon
const weapons = [
  { name: 'dagger', value: 0x01, icon: 0x54, price: 50 },
  { name: 'silver knife', value: 0x02, icon: 0x55, price: 100 },
  { name: 'golden knife', value: 0x04, icon: 0x6F, price: 150 },
  { name: 'holy water', value: 0x08, icon: 0x57, price: 50 },
  { name: 'diamond', value: 0x10, icon: 0x70, price: 50 },
  { name: 'sacred flame', value: 0x20, icon: 0x69, price: 100 },
  { name: 'oak stake', value: 0x40, icon: 0x59, price: 50, count: 5 }
];
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
const inventory = [
  { name: 'rib', value: 0x01, icon: 0x4E, dracPart: true },
  { name: 'heart', value: 0x02, icon: 0x4F, dracPart: true },
  { name: 'eyeball', value: 0x04, icon: 0x50, dracPart: true },
  { name: 'nail', value: 0x08, icon: 0x51, dracPart: true },
  { name: 'ring', value: 0x10, icon: 0x52, dracPart: true },
  { name: 'white crystal', value: 0x20, icon: 0x5E, crystal: true },
  { name: 'blue crystal', value: 0x40, icon: 0x6E, crystal: true },
  { name: 'red crystal', value: 0x60, icon: 0x5F, crystal: true }
];
inventory.forEach(i => {
  i.price = 116;
  i.memory = 0x91;
  if (i.dracPart) {
    i.code = `
LDA *$${i.memory.toString(16)}
ORA #$${i.value.toString(16)}
STA *$${i.memory.toString(16)}
`;
  } else {
    i.code = `
LDA *$${i.memory.toString(16)}
AND #$1F
ORA #$${i.value.toString(16)}
STA *$${i.memory.toString(16)}
`;
  }
  i.codeBytes = assemble(i.code);

  i.text = i.name;
});

// "value" property refers to the value added to 0x0092 (RAM) when you own an item
const carry = [
  { name: 'silk bag', value: 0x01, icon: 0x5C, price: 100 },
  { name: 'magic cross', value: 0x02, icon: 0x5A, price: 100 },
  { name: 'laurels', value: 0x04, icon: 0x58, price: 50, count: 5 },     // number of laurels at 0x004C
  { name: 'garlic', value: 0x08, icon: 0x6D, price: 50, count: 2 }       // number of garlic at 0x004D
];
carry.forEach(c => {
  c.memory = 0x92;
  c.code = `
LDA *$${c.memory.toString(16)}
ORA #${c.value.toString(16)}
STA *$${c.memory.toString(16)}
`;
  if ([ 'laurels', 'garlic' ].includes(c.name)) {
    const itemLoc = c.name === 'laurels' ? 0x4c : 0x4D;
    c.code += `
AND #$1
BEQ NO_SILK_BAG
LDA #$8
BNE THE_CODE
NO_SILK_BAG LDA #$4
THE_CODE STA *$D0
LDA *$${itemLoc.toString(16)}
CMP *$D0
BCS CARRY_DONE
INC *$${itemLoc.toString(16)}
LDA *$${itemLoc.toString(16)}
CMP *$D0
BCS CARRY_DONE
INC *$${itemLoc.toString(16)}
CARRY_DONE LDA *$${itemLoc.toString(16)}
`;
  }
  c.codeBytes = assemble(c.code);

  c.text = c.name;
});

module.exports = whips.concat(weapons, inventory, carry);