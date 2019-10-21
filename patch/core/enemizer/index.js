const fs = require('fs').promises;
const path = require('path');
const { assemble, core, object, utils: { randomInt }} = require('../../../lib');

const PATTERN_ASM = path.join(__dirname, 'pattern.asm');

// pattern tables
//
// To allow for maximum variability, each location will get its own pattern
// table pointer and values. The pointer is simply a pointer to the accompanying
// value. The value is a single byte, the high 4 bits are the bg pattern table
// value, the lower 4 bits are the sprite pattern table value.
function ptv(bg, sprite) {
	return (bg << 4) | sprite;
}

const BASE_LOC_PTR = 0x7730;
const OBJ_OFFSET = 0x30;
const mapSize = [ 2, 4, 4, 5, 2, 2 ];
const spritePatternMap = [ 0x01, 0x0A, 0x03, 0x05, 0x07, 0x0C ];

// saving this variable, but we aren't using it because we don't randmize background table
// const bgPatternMap = [ 0x00, 0x08, 0x02, 0x04, 0x06, 0x0B ];

module.exports = {
	patch: async function(pm, opts) {
		const { rng } = opts;
		let deadRiverToBrahm;

		// *** First pass ****
		// Write individual bg/sprite pattern table id for every single screen in the game.
		// Currently we're randomizing only the sprite table (for enemies), not the
		// background table.
		core.forEach(loc => {
			// Save reference to dead river to brahm to overwrite it later. Dead River to
			// Brahm must use the same pattern tables as Dead River to Alba, otherwise
			// you get weird sprite glitches.
			if (loc.deadRiverToBrahm) { deadRiverToBrahm = loc; }

			// Find the offset for the current screen we're processing in our pseudo multi
			// dimensional array in memory
			const offset = (loc.objset * OBJ_OFFSET) + (loc.area * mapSize[loc.objset]) + loc.submap;

			// don't enemize town or castlevania actors
			if ([ 0x00, 0x05 ].includes(loc.objset) || loc.boss) {
				loc.pattern = {
					value: ptv(0, loc.death ? 0x09 : spritePatternMap[loc.objset]),
					pointer: BASE_LOC_PTR + offset
				};
				return;
			}

			// Select a random sprite pattern table for the enemies we'll render in this
			// screen. Currently this excludes town (0x01) and castlevania (0x0C). Town
			// would work, but would be boring since it's only bats and zombies.
			const [ forceEnemy, forceTable ] = opts.devForceEnemy ? opts.devForceEnemy.split(':') : [];
			if (!forceEnemy !== !forceTable) {
				throw new Error('must specify --dev-force-enemy as "enemyId:tableId"');
			}

			const spriteId = randomInt(rng, 1, 4);
			const spritePattern = forceTable ? parseInt(forceTable, 16) : spritePatternMap[spriteId];
			const bgPattern = 0;

			// Assign bg and sprite pattern tables as single byte, as well as a pointer
			// to this byte in memory.
			loc.pattern = {
				value: ptv(0, spritePattern),
				pointer: BASE_LOC_PTR + offset
			};
			if (!loc.actors) { return; }

			// rocks are stupid, never use them
			const exclude = [ 'rock' ];

			// Leech sprite is on background pattern table, not normal sprite table,
			// so only use it when an appropriate bg pattern table is chosen
			if (![ 0x02, 0x04 ].includes(bgPattern)) {
				exclude.push('leech', 'high jump leech');
			}

			// Exclude projectile enemies from screens that have critical sprites that
			// shouldn't be despawned. Specifically sacred flame and the secret garlic
			// merchants can despawn if too many projectile sprites fill the screen.
			if (
				(loc.objset === 2 && loc.area === 3 && loc.submap === 1) || // dabi's path
				(loc.objset === 3 && loc.area === 0 && loc.submap === 0) || // camilla cemetery
				(loc.objset === 3 && loc.area === 1 && loc.submap === 0)    // storigoi graveyard
			) {
				exclude.push(...(object.enemies.filter(e => e.projectile).map(e => e.name)));
			}

			// change enemies for the location based on the pattern table value
			let enemies;
			if (forceEnemy) {
				enemies = object.enemies.filter(e => e.id === parseInt(forceEnemy, 16));
			} else {
				enemies = object.enemiesBySpritePattern(spritePattern, { exclude });
			}
			loc.actors.forEach(a => {
				// we're only randomizing enemies
				if (!a.enemy) { return; }

				// no boss rando for now
				if (a.boss) { return; }

				// if this is an actor normally positioned on top or bottom of a staircase
				// then don't replace it with an immobile enemy
				let filteredEnemies = enemies.slice(0);
				if (a.stairs) {
					filteredEnemies = filteredEnemies.filter(e => !e.immobile);
				}

				// remove this bat as it creates inescapable spawns in certain areas
				// of Berkeley mansion
				if (a.noZigZagBat) {
					filteredEnemies = filteredEnemies.filter(e => e.name !== 'zigzag bat');
				}

				// hey look, a new enemy!
				const len = filteredEnemies.length;
				const newEnemy = filteredEnemies[randomInt(rng, 0, len - 1)];
				a.id = newEnemy.id;

				// try to stop spiders from killing themsevles below the screen
				if (newEnemy.name === 'spider' && a.pos !== object.POS_AIR) {
					a.y = randomInt(rng, a.y - 8, a.y - 6);

				// if the enemy we're replacing is positioned at the bottom...
				} else if (a.pos === object.POS_BELOW) {

					// If the enemy we're replacing is in a marsh, use special positioning
					if ([object.POS_GROUND, object.POS_DEADHAND].includes(newEnemy.pos) && a.marshPos) {
						// dead hands position too low in marshes
						if (newEnemy.pos === object.POS_DEADHAND) {
							a.y = a.marshPos - 1;
						// bone dragons position too high in marshes
						} else if (newEnemy.name === 'bone dragon') {
							a.y = a.marshPos + 1;
						} else if (newEnemy.pos === object.POS_GROUND) {
							a.y = a.marshPos;
						}

					// If ground or dead hand position, use the nearest ground position above the
					// original spawn point
					} else if ([object.POS_GROUND, object.POS_DEADHAND].includes(newEnemy.pos) && a.ground) {
						a.y = newEnemy.pos === object.POS_DEADHAND ? a.ground - 1 : a.ground;

					// If air position, bump it up a random number of tiles
					} else if (newEnemy.pos === object.POS_AIR) {
						a.y = randomInt(rng, a.y - 7, a.y - 1);
					}

				// if the enemy we're replacing is positioned on the ground...
				} else if (a.pos === object.POS_GROUND) {
					// dead hands need to be positioned 1 tile higher
					if (newEnemy.pos === object.POS_DEADHAND) {
						a.y -= 1;
					}

				// if the enemy we're replacing is positioned in the air...
				} else if (a.pos === object.POS_AIR) {
					// If ground or dead hand position, use the nearest ground position below the
					// original spawn point
					if (newEnemy.pos !== object.POS_AIR && a.ground) {
						a.y = newEnemy.pos === object.POS_DEADHAND ? a.ground - 1 : a.ground;
						if (a.groundX) { a.x = a.groundX; }
					}

				// if the enemy we're replacing is positioned like a dead hand...
				} else if (a.pos === object.POS_DEADHAND) {
					// ground needs to be positioned 1 tile lower than dead hands
					if ([ object.POS_GROUND, object.POS_BELOW ].includes(newEnemy.pos)) {
						a.y += 1;
					}
				}

				// write all the enemy position changes to patch
				pm.add([ a.x, a.y, a.id, a.data ], a.pointer);
			});

			// handle dead river to alba overlap with dead river to brahm
			if (loc.deadRiverToAlba) {
				deadRiverToBrahm.pattern.value = loc.pattern.value;
			}
		});

		// *** second pass ***
		// update pattern tables for all locations in patch
		core.forEach(loc => {
			if (loc.pattern && loc.pattern.value != null && loc.pattern.pointer) {
				pm.add([ loc.pattern.value ], loc.pattern.pointer);
			}
		});

		// jump to subroutine that handles pattern table mapping
		let buf = Buffer.concat([Buffer.from([ 0x20, 0x50, 0xB8 ]), Buffer.alloc(17, 0xEA)]);
		pm.add([...buf], 0x1CCDF);

		// write code for mapping pattern table ids to each screen
		buf = Buffer.from(assemble(await fs.readFile(PATTERN_ASM, 'utf8')));
		pm.add([...buf], 0x7860);
	}
};
