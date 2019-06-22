const _ = require('lodash');
const assemble = require('../6502assembler');
const core = require('../core');
const fs = require('fs').promises;
const path = require('path');
const { randomInt, textToBytes } = require('../utils');

const TEXT_CHOICE_ASM = path.join(__dirname, 'text-choice.asm');
const WHIP_ASM = path.join(__dirname, 'whip.asm');

// "value" property refers to the value set at 0x0434 (RAM) when you own a whip
const whips = [
  //{ name: 'leather whip', value: 0x00, icon: 0x5B },
  { name: 'thorn whip', value: 0x01, icon: 0x5B, price: 100 },
  { name: 'chain whip', value: 0x02, icon: 0x5B, price: 150 },
  { name: 'morning star', value: 0x03, icon: 0x5B, price: 200 },
  { name: 'flame whip', value: 0x04, icon: 0x5B, price: 226 }
];
whips.forEach(w => w.whip = true);

// "value" property refers to the value added to 0x004A (RAM) when you own a weapon
const weapons = [
  { name: 'dagger', value: 0x01, icon: 0x54, price: 50 },
  { name: 'silver knife', value: 0x02, icon: 0x55, price: 100 },
  { name: 'golden knife', value: 0x04, icon: 0x6F, price: 150 },
  { name: 'holy water', value: 0x08, icon: 0x57, price: 50, progression: true },
  { name: 'diamond', value: 0x10, icon: 0x70, price: 50 },
  { name: 'sacred flame', value: 0x20, icon: 0x69, price: 100 },
  { name: 'oak stake', value: 0x40, icon: 0x59, price: 50, progression: true, count: 5 }
];
weapons.forEach(w => w.weapon = true);

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
  i.progression = true;
  i.price = 100;
});

// "value" property refers to the value added to 0x0092 (RAM) when you own an item
const carry = [
  { name: 'silk bag', value: 0x01, icon: 0x5C, price: 100 },
  { name: 'magic cross', value: 0x02, icon: 0x5A, price: 100, progression: true },
  { name: 'laurels', value: 0x04, icon: 0x58, price: 50, progression: true, count: 5 },     // number of laurels at 0x004C
  { name: 'garlic', value: 0x08, icon: 0x6D, price: 50, progression: true, count: 2 }       // number of garlic at 0x004D
];

function secretMerchant(obj, newObj) {
  let code;
  switch(newObj.type) {
    case 'whip':
      // INC $0434
      code = [ 0xEE, 0x34, 0x04, 0xEA, 0xEA, 0xEA ];
      break;
    case 'item':
      break;
    default:
      throw new Error(`invalid object type ${newObj.type}`);
  }
}

// return an array of all actors that can hold an item
function itemActors() {
  return core
    .filter(c => c.actors)
    .map(c => c.actors.filter(a => a.holdsItem))
    .filter(c => c.length > 0)
    .reduce((a,c) => a.concat(c), []);
}

function randomize(rng) {
  const counts = {};
  const countsSorted = [];

  // get all actors that can hold a game item and sort in descending order
  const actors = itemActors();
  actors.forEach((a, index) => {
    a.index = index;
    a.requirements.forEach(r => {
      if (!counts[r]) {
        counts[r] = 1;
      } else {
        counts[r]++;
      }
    });
  });
  Object.keys(counts).forEach(key => countsSorted.push({ name: key, value: counts[key] }));
  const itemDeps = countsSorted.sort((a,b) => a.value < b.value).map(c => c.name);

  // Make a list of all items to be randomized. Whips are not specified by name
  // as they are updated progressively. Same goes for crystals, though they have 
  // item dependencies, so their order and adherence to dependencies still needs to be 
  // maintained to avoid potential soft locks.
  const itemList = [];
  items.forEach(item => {
    const count = item.count || 1;
    for (let i = 0; i < count; i++) {
      itemList.push(item.whip ? 'whip' : item.crystal ? 'crystal' : item.name);
    }
  });

  // attach an item randomly to an actor 
  function processItem(item, isDep) {
    
    // remove dependency from item list (yet to be placed items)
    const key = /crystal/.test(item) ? 'crystal' : item;
    const index = itemList.findIndex(i => i === key);
    itemList.splice(index, 1);

    // get all actors for which requirements are met and no item has been placed
    const choices = actors.filter(a => ((!a.requirements.includes(item) || !isDep) && !a.newItem));
    if (!choices.length) {
      throw new Error(`cannot find free actor for ${item}`); 
    }

    // choose a random actor in `choices` subset and assign the item to it
    const choiceIndex = randomInt(rng, 0, choices.length - 1);
    const choice = choices[choiceIndex];
    const reqs = choice.requirements;
    choice.itemName = key;

    // remove chosen actor from list after processing
    const aIndex = actors.findIndex(a => a.index === choice.index);
    actors.splice(aIndex, 1);

    // add the requirement(s) of the chosen actor to all other actors that have the
    // current item as a requirement. For example, if we assigned 'holy water' to an
    // actor that has 'garlic' as a requirement, we need to add 'garlic' as a 
    // requirement to all other actors that have 'holy water' as a requirement.
    isDep && actors.forEach(a => {
      if (a.requirements.includes(item)) {
        a.requirements = _.union(a.requirements, reqs);
      }
    });
  }

  // Add items to actors based on dependencies, starting with progression items
  itemDeps.forEach(i => processItem(i, true));
  const listCopy = itemList.slice(0);
  listCopy.forEach(i => processItem(i));

  // now that items have been assigned, let's actually change the code for each
  // actor so that they talk and behave properly
  itemActors().forEach(actor => {
    actor.text
  });
}

const itemizer = module.exports = async function itemizer(romBuffer, rng) {
  let buf;

  // randomize game items amongst all available actors
  randomize(rng);
  
  console.log(core
    .filter(c => c.actors)
    .map(c => c.actors.filter(a => a.holdsItem))
    .filter(c => c.length > 0)
    .reduce((a,c) => a.concat(c), [])
    .filter(a => a.itemName)
  );

  // write code for progressive whip upgrades
	buf = Buffer.from(assemble(await fs.readFile(WHIP_ASM, 'utf8'))); //0x9D90
	buf.copy(romBuffer, 0xDDA0);

  // pointer to whip progression refuse text
  buf = Buffer.from([ 0x42, 0x9D ]);
  buf.copy(romBuffer, 0xDD50);

  // whip progression refuse text
  buf = Buffer.from(textToBytes('you got\nyour whip,\nnow buzz\noff!'));
  buf.copy(romBuffer, 0xDD52);

  // jump to subroutine that handles text choices
	buf = Buffer.from([ 0x20, 0x00, 0x9D, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA, 0xEA ]);
	buf.copy(romBuffer, 0x1EEB4);

  // write code for determining which text to show for a given npc and state
	buf = Buffer.from(assemble(await fs.readFile(TEXT_CHOICE_ASM, 'utf8')));
	buf.copy(romBuffer, 0xDD10);
};

const items = itemizer.items = whips.concat(weapons, inventory, carry);


// 07:EF03:A9 3C     LDA #$3C
//  07:EF05:85 7D     STA $007D = #$06
//  07:EF07:E6 7A     INC $007A = #$04