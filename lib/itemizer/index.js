const { textToBytes } = require('../utils');

// "value" property refers to the value set at 0x0434 (RAM) when you own a whip
const whips = [
  //{ name: 'leather whip', value: 0x00 },
  { name: 'thorn whip', value: 0x01 },
  { name: 'chain whip', value: 0x02 },
  { name: 'morning star', value: 0x03 },
  { name: 'flame whip', value: 0x04 }
];
whips.forEach(w => w.whip = true);

// "value" property refers to the value added to 0x004A (RAM) when you own a weapon
const weapons = [
  { name: 'dagger', value: 0x01 },
  { name: 'silver knife', value: 0x02 },
  { name: 'golden knife', value: 0x04 },
  { name: 'holy water', value: 0x08, progression: true },
  { name: 'diamond', value: 0x10 },
  { name: 'sacred flame', value: 0x20 },
  { name: 'oak stake', value: 0x40, progression: true }
];
weapons.forEach(w => w.weapon = true);

// "value" property refers to the value added to 0x0091 (RAM) when you own an item
const inventory = [
  { name: 'rib', value: 0x01, dracPart: true },
  { name: 'heart', value: 0x02, dracPart: true },
  { name: 'eyeball', value: 0x04, dracPart: true },
  { name: 'nail', value: 0x08, dracPart: true },
  { name: 'ring', value: 0x10, dracPart: true },
  { name: 'white crystal', value: 0x20, crystal: true },
  { name: 'blue crystal', value: 0x40, crystal: true },
  { name: 'red crystal', value: 0x60, crystal: true }
];
inventory.forEach(i => i.progression = true);

// "value" property refers to the value added to 0x0092 (RAM) when you own an item
const carry = [
  { name: 'silk bag', value: 0x01 },
  { name: 'magic cross', value: 0x02, progression: true },
  { name: 'laurels', value: 0x04, progression: true },     // number of laurels at 0x004C
  { name: 'garlic', value: 0x08, progression: true }       // number of garlic at 0x004D
];

module.exports = function(romBuffer, rng) {
  // let buf = Buffer.from(textToBytes('what a\nfucking \nnight to\nhave a\ncurse.'));
  // buf.copy(romBuffer, 0xCC84);
};