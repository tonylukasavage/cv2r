const _ = require('lodash');
const assemble = require('../6502assembler');
const bank = require('../bank');
const core = require('../core');
const items = require('./items');
const path = require('path');
const { log, modData, modSubroutine, pad, randomInt, textToBytes } = require('../utils');

const sharedItemTypes = [
  'garlicAljiba',
  'laurelsAljiba',
  'garlicAlba',
  'laurelsAlba',
  'laurelsOndol',
  'laurelsDoina',
  'oakRing',
  'oakRib',
  'oakHeart',
  'oakEye',
  'oakNail'
];

function asmFile(name) {
  return path.join(__dirname, 'asm', name);
}

// return an array of all actors that can hold an item
function itemActors() {
  return core
    .filter(c => c.actors)
    .map(c => c.actors.filter(a => a.holdsItem))
    .filter(c => c.length > 0)
    .reduce((a,c) => a.concat(c), []);
}

// distribute all items in the game to actors that can hold them, based on progression logic
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
      //itemList.push(item.whip ? 'whip' : item.crystal ? 'crystal' : item.name);
      itemList.push(item.name);
    }
  });

  // attach an item randomly to an actor 
  function processItem(item, isDep) {
    
    // remove dependency from item list (yet to be placed items)
    //const key = /crystal/.test(item) ? 'crystal' : item;
    const key = item;
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
}

// Write and re-route data that determines the sales icon and prices for all merchants
function modSaleData(romBuffer) {
  
  // merchant sale data on bank 3 (copying the original data from unhacked ROM)
  const saleBank = bank[3];
  const file = path.join(__dirname, 'data', 'sale.txt');
  const mod = modData(romBuffer, file, saleBank);

  // Write new pointers for copied data, skipping laurel, garlic, and oak entries as
  // they will get custom handling later in the process. We also skip the unused entries
  // where laurels are 2000 hearts and silver knife, as no merchant sells it (at least not
  // untilthis rando!)
  [
    null, // laurels,
    null, // laurels (0x2000 entry)
    null, // garlic
    'holyWater',
    'dagger',
    null, // silver knife
    null, // oak stake
    'whiteCrystal',
    'thorn',
    'chain',
    'morningStar'
  ].forEach(itemType => {
    if (itemType) {
      core.getActor({ itemType }).salePointer = mod.rom;
    }
    mod.rom += 3;
  });

  // change the original sales data pointers to our new ones
  const buf = Buffer.from([ mod.ram & 0xFF, mod.ram >>> 8 ]);
  buf.copy(romBuffer, 0x1ECF5);
  buf.copy(romBuffer, 0x1ED05);
  buf.copy(romBuffer, 0x1ED17);

  // write new sale data for each individual merchant
  const saleValues = {};
  let saleOffset = mod.length;
  function addSaleData(itemType) {
    saleValues[itemType] = saleOffset.toString(16);
    const saleBuf = Buffer.from([ 0, 0, 0 ]);
    const romLoc = saleBank.rom.start + saleBank.offset;
    saleBuf.copy(romBuffer, romLoc);
    core.getActor({ itemType }).salePointer = romLoc; 
    saleBank.offset += 3;
    saleOffset += 3;
  }
  sharedItemTypes.forEach(addSaleData);

  // Hack in the code that lets us generate unique sales icons and prices for each
  // individual merchant. The unhacked ROM shares a single entry for all garlic, laurel,
  // and oak stake merchants.
  modSubroutine(romBuffer, asmFile('saleId.asm'), saleBank, {
    exitOffset: 2,
    values: saleValues,
    invoke: {
      romLoc: 0x1ED46,
      padding: 7
    }
  });
}

// TODO: write code to progressively change merchant icon for crystal purchases
const itemizer = module.exports = async function itemizer(romBuffer, rng, opts = {}) {
  const orbValues = {};
  const whipMerchantValues = {};
  const merchantValues = {};
  const deathValues = {};
  const camillaValues = {};
  const textValues = {};

  // initialize items
  items.initItems(romBuffer);

  // randomize game items amongst all available actors
  randomize(rng);

  // write all merchant sale icon and price data
  modSaleData(romBuffer);

  // re-write code that determines if a merchant is a whip merchant
  modSubroutine(romBuffer, asmFile('merchantId.asm'), bank[3], {
    invoke: {
      romLoc: 0x1EDAE,
      padding: 1
    }
  });

  // process all actors with an item
  const itemActors = core
    .filter(c => c.actors)
    .map(c => c.actors.filter(a => a.holdsItem))
    .filter(c => c.length > 0)
    .reduce((a,c) => a.concat(c), [])
    .filter(a => a.itemName);

  itemActors.forEach(actor => {
    let jsrBuf;
    const item = items.find(i => i.name === actor.itemName);
    
    // garlic and laurels subroutine needs to access the appropriate bank
    if ([ 'garlic', 'laurels' ].includes(item.name) || item.whip || item.crystal) {
      item.code = item.bankCode[actor.bank];
      item.codeBytes = assemble(item.code);
    }

    // change actor text to match new item
    if (item && item.text) { actor.text = item.text; }

    // Write new text pointers for each individual garlic/laurel/oak merchant
    if (sharedItemTypes.includes(actor.itemType)) {
      const textRomLoc = bank[3].rom.start + bank[3].offset;
      const textRamLoc = bank[3].ram.start + bank[3].offset;
      const lowByte = (textRamLoc & 0xFF).toString(16);
      const highByte = (textRamLoc >>> 8).toString(16);
      textValues[actor.itemType] = `
LDA #$${lowByte}
STA *$00
LDA #$${highByte}
STA *$01
`;
      const textBuf = Buffer.from(textToBytes(actor.text));
      textBuf.copy(romBuffer, textRomLoc);
      bank[3].offset += textBuf.length;
    }

    // Death code
    if (actor.name === 'Death') {
      deathValues.itemCode = item.code;
    }

    // Death code
    else if (actor.name === 'Camilla') {
      camillaValues.itemCode = item.code;
    }

    // orb item assignment
    else if (actor.name === 'orb') {
      orbValues[actor.subtype] = item.code;
    }

    // whip merchant item assignment
    else if (actor.name === 'merchant') {
      if (actor.subtype === 'whip') {
        whipMerchantValues[actor.itemType] = item.code;
      } else {
        merchantValues[actor.itemType] = item.code;
      }
    }

    // process actors holding item code
    else if (actor.code && actor.bank != null) {
      let buf = Buffer.from(item.codeBytes);
      let diff = actor.code.length - item.codeBytes.length;

      // uh oh, too much item code for the given actor code space
      if (actor.code.length < item.codeBytes.length) {
        const jsrRamLoc = bank[actor.bank].ram.start + bank[actor.bank].offset;
        const jsrRomLoc = bank[actor.bank].rom.start + bank[actor.bank].offset;
        const lowByteRam = jsrRamLoc & 0xFF;
        const highByteRam = jsrRamLoc >>> 8;

        // Write a JSR operation to jump to an item processing subroutine. This is
        // only 3 bytes and should fit anywhere. Pad with NOPs if necessary to fill
        // any additional space.
        buf = Buffer.from([ 0x20, lowByteRam, highByteRam ]);
        diff = actor.code.length - buf.length;

        // pad with NOPs
        if (diff > 0) {
          buf = Buffer.concat([buf, Buffer.alloc(diff, 0xEA)]);
        // still can't fit the code? We got a problem...
        } else if (diff < 0) {
          throw new Error(JSON.stringify({ 
            message: 'still failed to write item code', item, actor 
          }));
        }

        // Now we need to write the code actually contained in the new subroutine.
        const jsrCode = item.codeBytes.concat([ 0x60 ]);
        jsrBuf = Buffer.from(jsrCode);
        jsrBuf.copy(romBuffer, jsrRomLoc);
        bank[actor.bank].offset += jsrCode.length;
      } else if (actor.code.length > item.codeBytes.length) {
        buf = Buffer.concat([buf, Buffer.alloc(diff, 0xEA)]);
      } 

      // write new code to the actor ROM location
      buf.copy(romBuffer, actor.code.loc.rom);
    }

    // execute actor-specific ROM hacking (for example, merchant sale icons)
    actor.hack && actor.hack(romBuffer, item, rng, opts);

    log(`| ${pad(item.name, 13)} | ${pad(actor.name, 15)} | ${pad(actor.locationName, 37)} |`);
  });

  // new garlic/laurel/oak merchant text goes on bank 3
  modSubroutine(romBuffer, asmFile('textUnshare.asm'), bank[3], {
    exitOffset: 6,
    values: textValues,
    invoke: {
      romLoc: 0x1EEC6,
      padding: 1
    }
  });

  // Death code goes on bank 1
  modSubroutine(romBuffer, asmFile('boss.asm'), bank[1], {
    values: deathValues,
    invoke: {
      romLoc: 0x47D7,
      bytes: [ 0xEA, 0xD0, 0x06 ] 
    }
  });

  // Camilla code goes on bank 1
  modSubroutine(romBuffer, asmFile('boss.asm'), bank[1], {
    values: camillaValues,
    invoke: {
      romLoc: 0x47CF,
      padding: 3 
    }
  });

  // orb code goes on bank 1
  modSubroutine(romBuffer, asmFile('orb.asm'), bank[1], {
    values: orbValues,
    invoke: {
      romLoc: 0x47A7,
      padding: 1 
    }
  });

  // whip merchant code goes on bank 3
  modSubroutine(romBuffer, asmFile('merchantWhip.asm'), bank[3], {
    values: whipMerchantValues,
    invoke: {
      romLoc: 0x1EE04
    }
  });

  // all other merchant code goes on bank 3
  modSubroutine(romBuffer, asmFile('merchant.asm'), bank[3], {
    exitOffset: 4,
    values: merchantValues,
    invoke: {
      romLoc: 0x1EDF4,
      padding: 4
    }
  });
};

itemizer.items = items;
