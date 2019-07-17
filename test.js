const _ = require('lodash');
const core = require('./lib/core');

const lens = [];
core.forEach(c => {
	if (!c.actors) { return; }
	c.actors.forEach(a => {
		if (!a.text || !a.holdsItem) { return; }
		lens.push(a.text.length);
	});
});

console.log({
	min: Math.min(...lens),
	max: Math.max(...lens),
	avg: Math.floor(lens.reduce((a,b) => a + b, 0) / lens.length)
});

console.log(_.uniq(lens).sort());