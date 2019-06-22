const _ = require('lodash');
const core = require('../lib/core');
const { items } = require('../lib/itemizer');
const seedrandom = require('seedrandom');
const { randomInt } = require('../lib/utils');

const rng = seedrandom('123456');
const counts = {};
const countsSorted = [];

// return an array of all actors that can hold an item
function itemActors() {
  return core
    .filter(c => c.actors)
    .map(c => c.actors.filter(a => a.holdsItem))
    .filter(c => c.length > 0)
    .reduce((a,c) => a.concat(c), []);
}

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

// Make a list of all items to be randomized. Whips are not specified specifically
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

function processItem(item, isDep) {
  // remove dependency from item list (yet to be placed items)
  const key = /crystal/.test(item) ? 'crystal' : item;
  const index = itemList.findIndex(i => i === key);
  itemList.splice(index, 1);

  // get all actors for which requirements are met and no item has been placed
  const choices = actors.filter(a => ((!a.requirements.includes(item) || !isDep) && !a.newItem));
  if (!choices.length) {
    console.error(actors);
    throw new Error(`cannot find free actor for ${item}`); 
  }

  // choose a random actor in `choices` subset and assign the item to it
  const choiceIndex = randomInt(rng, 0, choices.length - 1);
  const choice = choices[choiceIndex];
  const reqs = choice.requirements;
  choice.newItem = key;
  choice.newDep = item;

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

console.log(itemActors().filter(i => i.newItem));

//console.log(itemList);

