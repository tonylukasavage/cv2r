const core = require('../lib/core');
const { items } = require('../lib/itemizer');

const counts = {};
const countsSorted = [];

const actors = core
  .filter(c => c.actors)
  .map(c => c.actors.filter(a => a.holdsItem))
  .filter(c => c.length > 0)
  .reduce((a,c) => a.concat(c), []);

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
countsSorted.sort((a,b) => a.value < b.value);

console.log(countsSorted);

const itemList = [];
items.forEach(item => {
  const count = item.count || 1;
  for (let i = 0; i < count; i++) {
    itemList.push(item.whip ? 'whip' : item.crystal ? 'crystal' : item.name);
  }
});
console.log(itemList);
