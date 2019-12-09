const core = require('../lib/core');

function h(num) {
	const hex = num.toString(16).toUpperCase();
	return '0x' + (parseInt(hex, 16) <= 0xF ? '0' + hex : hex);
}

const logic = process.argv[2];

console.log('\t[');
core.forEach(loc => {
	if (!loc.actors) { return; }
	loc.actors.filter(a => a.requirements != null).forEach((actor, index) => {
		if (index === 0) {
			console.log('');
			console.log(`\t\t// ${loc.name}`);
		}
		console.log(`\t\t{ objset: ${h(loc.objset)}, area: ${h(loc.area)}, submap: ${h(loc.submap)}, actor: '${actor.name}', y: ${h(actor.y)}, logic: '${actor.requirements[logic]}' },`);
	});
});
console.log('\t]');
