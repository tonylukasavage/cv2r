const core = require('../core');
const { randomInt } = require('../utils');

// random enemy hp
// hp will be +/-50% of the hp of the enemy it's replacing. The code below aims to
// make sure all enemies of a single type have the same hp on a given screen. For example,
// if the first skeleton on a screen has its hp randomized to 3 hp, all skeletons on the
// same screen will have 3 hp.
module.exports = {
	patch: function(pm, opts) {
		const { rng } = opts;

		core.forEach(loc => {
			if (!loc.actors) { return; }
			const hpMap = {};
			loc.actors.filter(a => a.enemy && !a.boss).forEach(enemy => {
				if (!hpMap[enemy.id]) { 
					const half = Math.floor(enemy.data / 2);
					const range = enemy.data < 2 ? [ 1, 2 ] : [ enemy.data - half, enemy.data + half ];
					hpMap[enemy.id] = randomInt(rng, ...range);
				}
				enemy.data = hpMap[enemy.id];

				// enemy (actor) data is stored as x,y,id,hp so we offset the pointer by 3 bytes
				// since we are only modifying hp
				pm.add([ enemy.data ], enemy.pointer + 3);
			});
		});
  }
};