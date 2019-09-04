const _ = require('lodash');
const { shallowEqualObjects: equal } = require('shallow-equal');

const FISHMAN = 0x04;
const LIZARDMAN = 0x06;
const FERRY_MAN = 0xBC;

// only spawn fishmen over Dead River. Happy now LoZ? :P
module.exports = {
	id: 'lazy-river',
	name: 'Lazy River',
	description: 'Only spawn fishmen on Dead River, like vanilla CV2',
	patch: function(pm) {
		const { core } = require('../../lib');
		const deadRiverLocs = [
			{ objset: 2, area: 6, submap: 0 },
			{ objset: 2, area: 7, submap: 0 },
			{ objset: 2, area: 7, submap: 1 }
		];

		core.filter(loc => {
			const locPick = _.pick(loc, [ 'objset', 'area', 'submap' ]);
			for (let drLoc of deadRiverLocs) {
				if (equal(drLoc, locPick)) {
					return true;
				}
			}
			return false;
		}).forEach(loc => {
			// use the fishman pattern table
			pm.add([ (2 << 4) | 3 ], loc.pattern.pointer);

			// re-insert vanilla enemies
			if (loc.submap === 0) {
				pm.add([ 0x04, 0x0B, LIZARDMAN, 0x04 ], 0x6089);
				pm.add([ 0x08, 0x0B, LIZARDMAN, 0x04 ], 0x608D);
				pm.add([ 0x12, 0x0C, FERRY_MAN, 0x01 ], 0x6091);
				pm.add([ 0x18, 0x0C, FISHMAN, 0x04 ], 0x6095);
				pm.add([ 0x1C, 0x0C, FISHMAN, 0x04 ], 0x6099);
			} else {
				pm.add([ 0x04, 0x0C, FISHMAN, 0x04 ], 0x609E);
				pm.add([ 0x08, 0x0C, FISHMAN, 0x04 ], 0x60A2);
				pm.add([ 0x0E, 0x0C, FERRY_MAN, 0x00 ], 0x60A6);
				pm.add([ 0x18, 0x0B, LIZARDMAN, 0x04 ], 0x60AA);
				pm.add([ 0x1A, 0x0B, LIZARDMAN, 0x04 ], 0x60AE);
			}
		});
	}
};
