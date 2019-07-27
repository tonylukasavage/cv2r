const _ = require('lodash');
const core = require('./lib/core');

const lens = {};
core.forEach(c => {
	if (!c.actors) { return; }
	c.actors.forEach(a => {
		if (!a.text || !a.holdsItem) { return; }
		if (!lens[a.name]) { lens[a.name] = []; }
		lens[a.name].push(a.text.length);
	});
});

Object.keys(lens).forEach(key => {
	lens[key] = _.uniq(lens[key]).sort();
});

console.log(lens);

// console.log({
// 	min: Math.min(...lens),
// 	max: Math.max(...lens),
// 	avg: Math.floor(lens.reduce((a,b) => a + b, 0) / lens.length)
// });

// console.log(_.uniq(lens).sort());