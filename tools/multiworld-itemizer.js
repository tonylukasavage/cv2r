const core = require('../lib/core');
const items = require('../patch/core/itemizer/items');
const pm = require('../lib/patch-manager');
const vm = require('vm');
const { pad, randomInt } = require('../lib/utils');

const LOGICS = [ 'standard', 'glitch' ];
const numOfWorlds = parseInt(process.argv[2] || '1', 10);
const itemList = [];
const itemKeys = [];
let worlds = [];

const itemToKey = i => i.toUpperCase().replace(/\s+/g, '_');

// init items, only necessary in this tool
const rng = require('seedrandom')('testseed');
try {
	pm.init({ difficulty: 'standard', logic: 'standard', palette: 'simons-quest', simon: 'simon-default' });
} catch (err) {
	console.error(err.stack);
	process.exit(1);
}
items.initItems(pm.core, rng);

for (let i = 1; i <= numOfWorlds; i++) {
	// get item actor list for each world
	const actors = JSON.parse(JSON.stringify(
		core
			.filter(c => c.actors)
			.map(c => c.actors.filter(a => a.holdsItem))
			.filter(c => c.length > 0)
			.reduce((a,c) => a.concat(c), [])
	));
	actors.forEach(a => {
		a.world = i;
		LOGICS.forEach(l => a.requirements[l] = a.requirements[l].replace(/([A-Z_]+)/g, `$1${i}`));
	});
	worlds = worlds.concat(actors);

	// get item list for each world
	items.forEach(item => {
		const count = item.count || 1;
		for (let j = 0; j < count; j++) {
			const newName = item.name + i;
			const newKey = itemToKey(newName);
			itemList.push(newName);
			if (itemKeys.indexOf(newKey) === -1) {
				itemKeys.push(newKey);
			}
		}
	});
}

console.log('World | item            | actor           | location');
console.log('-------------------------------------------------------------------------------');

// distribute all items in the game to actors that can hold them, based on progression logic
function randomize(rng, { logic }) {
	const counts = {};
	const countsSorted = [];

	// get all actors that can hold a game item and sort in descending order
	const actors = worlds;
	actors.forEach((a, index) => {
		a.index = index;

		// if we need to do randomization more than once, make sure to reset logic to original state
		if (a.originalRequirements) {
			a.requirements[logic] = a.originalRequirements;
		} else {
			a.originalRequirements = a.requirements[logic];
		}

		// get a rough count of how often an item is required for prioritization of placement
		a.requirements[logic].replace(/[()&|]/g, '').split(/\s+/).filter(r => r !== '').forEach(r => {
			const name = r.toLowerCase().replace(/_/g, ' ');
			counts[name] = !counts[name] ? 1 : counts[name] + 1;
		});
	});
	Object.keys(counts).forEach(key => countsSorted.push({ name: key, value: counts[key] }));
	const itemDeps = countsSorted.sort((a,b) => b.value - a.value).map(c => c.name);

	// attach an item randomly to an actor
	const baseFuncs = {};
	itemKeys.forEach(ik => {
		baseFuncs[ik] = `base.${ik} = function ${ik}() { return true; };`;
	});

	function processItem(item, isDep) {
		const evalLogic = i => i.replace(/([A-Z_]+\d+)/g, 'funcs.$1(clone())');
		const funcLogic = i => i.replace(/([A-Z_]+\d+)/g, 'funcs.$1(i)');
		const itemToKey = i => i.toUpperCase().replace(/\s+/g, '_');
		const funcs = Object.assign({}, baseFuncs);
		funcs[itemToKey(item)] = `base.${itemToKey(item)} = function ${itemToKey(item)}() { return false; };`;

		// remove dependency from item list (yet to be placed items)
		const index = itemList.findIndex(i => i === item);
		itemList.splice(index, 1);

		// render all dynamically created logic functions before evaluating logic
		let funcCode = `
// generate logic functions with "visited" checks to prevent infinite loop
const base = {};
const items = ${JSON.stringify(itemKeys)};
const funcs = {};
items.forEach(item => {
	funcs[item] = function(v) {
		if (v[item]) { return false; }
		v[item] = true;
		return base[item](v);
	};
});

// execute logic check
const visited = { ${itemToKey(item)}: true };
const clone = () => Object.assign({}, visited);

// base logic functions
`;
		funcCode += Object.keys(funcs).reduce((a,c) => {
			return a + funcs[c] + '\n';
		}, '');

		// evaluate the logic of all available actors
		const choices = actors.filter(actor => {
			if (actor.newItem) { return false; }
			if (!isDep) { return true; }
			if (actor.requirements[logic] === '') { return true; }
			const script = new vm.Script(funcCode + evalLogic(actor.requirements[logic]));
			return script.runInNewContext();
		});

		// bail if we can't find an available actor
		if (!choices.length) {
			throw new Error(`cannot find free actor for ${item}`);
		}

		// choose a random actor in `choices` subset and assign the item to it
		const choiceIndex = randomInt(rng, 0, choices.length - 1);
		const choice = choices[choiceIndex];
		let reqs = choice.requirements[logic];
		choice.itemName = item;

		console.log(`${choice.world}     | ${pad(choice.itemName, 15)} | ${pad(choice.name, 15)} | ${choice.locationName}`);
		// console.log(JSON.stringify({
		// 	world: choice.world,
		// 	loc: choice.locationName,
		// 	name: choice.name,
		// 	item: choice.itemName,
		// 	req: choice.requirements.standard
		// }));

		// remove chosen actor from list after processing
		const aIndex = actors.findIndex(a => a.index === choice.index);
		actors.splice(aIndex, 1);

		// Dyanmically create a logic function for the current item to be
		// used in logic evaluation for all following items.
		const key = itemToKey(item);
		const rx = new RegExp(key, 'g');
		const body = (reqs ? reqs.replace(rx, 'false') : 'true');
		baseFuncs[key] = `base.${key} = function ${key}(i) { return ${funcLogic(body)}; };`;
	}

	// Add items to actors based on dependencies, starting with progression items
	itemDeps.forEach(i => processItem(i, true));
	const listCopy = itemList.slice(0);
	listCopy.forEach(i => processItem(i));
}

randomize(rng, { logic: 'standard' });
