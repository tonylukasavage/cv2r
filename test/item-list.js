const core = require('../lib/core');
const { items } = require('../lib/itemizer');
const seedrandom = require('seedrandom');
const { randomInt } = require('../lib/utils');

const rng = seedrandom('12345');
const counts = {};
const countsSorted = [];

// get all actors that can hold a game item
const actors = core
  .filter(c => c.actors)
  .map(c => c.actors.filter(a => a.holdsItem))
  .filter(c => c.length > 0)
  .reduce((a,c) => a.concat(c), []);

// sort item dependencies in descending order
actors.forEach(a => {
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
// console.log(itemDeps);

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
// console.log(itemList);
