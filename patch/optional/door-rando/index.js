const path = require('path');
const { assemble, bank, core, utils: { log, modBytes, modSubroutine, randomInt } } = require('../../../lib');

const NOP = 0xEA;
const MANSION_COUNT = 5;

function pad(bytes, len) {
	const ret = bytes.slice(0);
	while (ret.length < len) {
		ret.push(NOP);
	}
	return ret;
}

function getLocation({ objset, area, submap = 0 }) {
	return core.find(c => c.objset === objset && c.area === area && c.submap === submap);
}

module.exports = {
	pre: true,
	id: 'door-rando',
	name: 'Door Rando',
	description: 'All town and mansion doors are randomized',
	patch: function(pm, opts) {
		const { logic, rng } = opts;
		const spoiler = [ [ 'door', 'location' ] ];

		// get a list of all doors annd targets
		const doors = core
			.filter(loc => loc.doors)
			.reduce((a,c) => a.concat(c.doors.data), [])
			.sort((a, b) => a.pointerIndex < b.pointerIndex ? -1 : 1);
		const targets = doors.map(d => d.target);

		// randomize door targets
		log('', true);
		log('Door Rando', true);
		log('----------', true);
		doors.forEach(door => {
			const index = randomInt(rng, 0, targets.length - 1);
			const target = targets[index];
			targets.splice(index, 1);
			door.newTarget = {};
			Object.assign(door.newTarget, target);

			const roomLoc = getLocation(door.newTarget);
			spoiler.push([ door.name, roomLoc.name ]);
			log(`${door.name.padEnd(30, ' ')} --> ${roomLoc.name}`);

			const doorReqs = getLocation(door).doors.requirements[logic];
			const actors = core
				.filter(loc => loc.objset === door.newTarget.objset && loc.area === door.newTarget.area)
				.reduce((a, c) => {
					return a.concat(c.actors || []);
				}, []);
			actors.filter(a => a.holdsItem).forEach(actor => {
				const actorReqs = actor.actorRequirements[logic];
				let newReqs;
				if (doorReqs && actorReqs) {
					newReqs = `(${doorReqs}) && (${actorReqs})`;
				} else if (doorReqs) {
					newReqs = doorReqs;
				} else if (actorReqs) {
					newReqs = actorReqs;
				} else {
					newReqs = '';
				}
				actor.requirements[logic] = newReqs;
			});

			doors.forEach(door => door.target = door.newTarget);
		});
		global.doorSpoiler = spoiler;

		// create array for a location pointer table
		let maxPointer = 0;
		doors.forEach(door => maxPointer = maxPointer < door.pointerIndex ? door.pointerIndex : maxPointer);
		const tableEntryCount = (maxPointer + MANSION_COUNT + 1) * 2;
		const tableBytes = new Array(tableEntryCount);

		// populate pointer table array with door locations
		tableBytes.fill(0xFF, 0, tableEntryCount);
		doors.forEach(door => {
			const { area, objset, pointerIndex, target } = door;
			let offset;
			if (objset === 0) {
				offset = pointerIndex * 2;
			} else {
				offset = (maxPointer + 1 + area) * 2;
			}
			tableBytes[offset] = target.objset;
			tableBytes[offset + 1] = target.area;
		});

		// write pointer table to rom
		const tableMod = modBytes(pm.name, tableBytes, bank[3]);
		global.doorSpoiler.push([ 'door table', tableMod.rom ]);

		// rom patch functions
		const enter = modSubroutine(pm.name, path.join(__dirname, 'enter.asm'), bank[3], {
			values: {
				table: tableMod.ram.toString(16)
			}
		});
		var music = "LDA #$45\r\nJSR $C118";
		pm.patches.forEach ( patch => {
			if (patch == "nomusic" ) {
				music = "";
				console.log("NO MUSIC!");
			}
		} );
		
			
		
		const enterPosition = modSubroutine(pm.name, path.join(__dirname, 'enter-position.asm'), bank[3], {values: {
				music: music
				
			}
		});
		
		
		
		const exit = modSubroutine(pm.name, path.join(__dirname, 'exit.asm'), bank[7]);
		const bankSwitch232 = modSubroutine(pm.name, path.join(__dirname, 'bank-switch.asm'), bank[8], {
			values: {
				enterPosition: enterPosition.ram.toString(16)
			}
		});

		// door enter code
		let code = `JSR $${enter.ram.toString(16)}`;
		let bytes = assemble(code);
		pm.add(bytes, 0xC81F); // town
		pm.add(pad(bytes, 5), 0xC7FC); // mansion

		// bank switch and execute door entry positioning code
		code = `JSR $${bankSwitch232.ram.toString(16)}`;
		bytes = assemble(code);
		pm.add(pad(bytes, 10), 0x1E77B); // town
		pm.add(pad(bytes, 11), 0x1E7DF); // mansion

		// door exit code
		code = `JSR $${exit.ram.toString(16)}`;
		bytes = assemble(code);
		pm.add(pad(bytes, 4), 0x1D069);  // town
		pm.add(bytes, 0x1D0F9);          // mansion
		pm.add([ 0xA9, 0x00 ], 0x1D0FF); // mansion

	}
};
