const assemble = require('../6502assembler');
const core = require('../core');
const obj = require('../object');
const fs = require('fs').promises;
const path = require('path');
const { randomInt } = require('../utils');

const PATTERN_ASM = path.join(__dirname, 'asm', 'pattern.asm');

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
const bgPatternMap = [ 0x00, 0x08, 0x02, 0x04, 0x06, 0x0B ];
const spritePatternMap = [ 0x01, 0x09, 0x03, 0x05, 0x07, 0x0C ];

module.exports = async function enemizer(romBuffer, rng, opts = {}) {
  // Write individual bg/sprite pattern table id for every single screen in the game.
  // Currently we're randomizing only the sprite table (for enemies), not the 
  // background table.
  const hpMap = {};
  let deadRiverToBrahm;
  core.forEach(loc => {
    // save reference to dead river to brahm to overwrite it later
    if (loc.deadRiverToBrahm) { deadRiverToBrahm = loc; }

    // Find the offset for the current screen we're processing in our pseudo multi
    // dimensional array in memory
    const offset = (loc.objset * OBJ_OFFSET) + (loc.area * mapSize[loc.objset]) + loc.submap;

    // don't enemize town or castlevania actors
    if ([ 0x00, 0x05 ].includes(loc.objset) || loc.boss) { 
      loc.pattern = { 
        value: ptv(bgPatternMap[loc.objset], loc.camilla ? 0x0A : spritePatternMap[loc.objset]),
        pointer: BASE_LOC_PTR + offset 
      };
      return; 
    }

    // Select a random sprite pattern table for the enemies we'll render in this 
    // screen. Currently this excludes town (0x01) and castlevania (0x0C). Town 
    // would work, but would be boring since it's only bats and zombies.
    const spriteId = randomInt(rng, 1, 4);
    const spritePattern = spritePatternMap[spriteId];
    const bgPattern = bgPatternMap[loc.objset];

    // Assign bg and sprite pattern tables as single byte, as well as a pointer 
    // to this byte in memory.
    loc.pattern = { 
        value: ptv(bgPattern, spritePattern),
        pointer: BASE_LOC_PTR + offset 
    };
    if (!loc.actors) { return; }

    // Leech sprite is on background pattern table, not normal sprite table
    const exclude = [ 'rock' ];
    if (![ 0x02, 0x04 ].includes(bgPattern)) {
      exclude.push('leech', 'high jump leech');
    }

    // change enemies for the location based on the pattern table value
    const enemies = obj.enemiesBySpritePattern(spritePattern, { exclude });
    const len = enemies.length;
    loc.actors.forEach(a => {
      // we're only randomizing enemies
      if (!a.enemy) { return; }

      // no boss rando for now
      if (a.boss) { return; }

      // hey look, a new enemy!
      const newEnemy = enemies[randomInt(rng, 0, len - 1)];

      // randomize enemy hp based on enemy type and base hp
      if (opts.enemyHp) {
        if (!hpMap[newEnemy.id]) { hpMap[newEnemy.id] = {}; }
        if (!hpMap[newEnemy.id][a.data]) {  
          if (a.data < 2) {
            hpMap[newEnemy.id][a.data] = randomInt(rng, 1, 2);
          } else {
            const half = Math.floor(a.data / 2);
            hpMap[newEnemy.id][a.data] = randomInt(rng, a.data - half, a.data + half);
          }
        }
        a.origData = a.data;
        a.data = hpMap[newEnemy.id][a.data];
      }

      // swap in the id and name of the new enemy
      a.id = newEnemy.id;
    
      // try to stop spiders from killing themsevles below the screen
      if (newEnemy.name === 'spider' && a.pos !== obj.POS_AIR) {
        a.y = randomInt(rng, a.y - 8, a.y - 6);

      // if the enemy we're replacing is positioned at the bottom...
      } else if (a.pos === obj.POS_BELOW) {
        
        // If the enemy we're replacing is in a marsh, use special positioning
        if ([obj.POS_GROUND, obj.POS_DEADHAND].includes(newEnemy.pos) && a.marshPos) {
          // dead hands position too low in marshes
          if (newEnemy.pos === obj.POS_DEADHAND) {
            a.y = a.marshPos -1;
          // bone dragons position too high in marshes 
          } else if (newEnemy.name === 'bone dragon') {
            a.y = a.marshPos + 1;
          } else if (newEnemy.pos === obj.POS_GROUND) {
            a.y = a.marshPos;
          }

        // If ground or dead hand position, use the nearest ground position above the 
        // original spawn point
        } else if ([obj.POS_GROUND, obj.POS_DEADHAND].includes(newEnemy.pos) && a.ground) {
          a.y = newEnemy.pos === obj.POS_DEADHAND ? a.ground - 1 : a.ground;
        
        // If air position, bump it up a random number of tiles
        } else if (newEnemy.pos === obj.POS_AIR) {
          a.y = randomInt(rng, a.y - 7, a.y - 1);
        }

      // if the enemy we're replacing is positioned on the ground...
      } else if (a.pos === obj.POS_GROUND) {
        // dead hands need to be positioned 1 tile higher
        if (newEnemy.pos === obj.POS_DEADHAND) {
          a.y -= 1;
        }

      // if the enemy we're replacing is positioned in the air...
      } else if (a.pos === obj.POS_AIR) { 
        // If ground or dead hand position, use the nearest ground position below the 
        // original spawn point
        if (newEnemy.pos !== obj.POS_AIR && a.ground) {
          a.y = newEnemy.pos === obj.POS_DEADHAND ? a.ground - 1 : a.ground;
          if (a.groundX) { a.x = a.groundX; }
        }

      // if the enemy we're replacing is positioned like a dead hand...
      } else if (a.pos === obj.POS_DEADHAND) {
        // ground needs to be positioned 1 tile lower than dead hands
        if ([ obj.POS_GROUND, obj.POS_BELOW ].includes(newEnemy.pos)) {
         a.y += 1;
        }
      }
    });

    // handle dead river to alba overlap with dead river to brahm
    if (loc.deadRiverToAlba) {
      deadRiverToBrahm.pattern.value = loc.pattern.value;
    }
  });

  // jump to subroutine that handles pattern table mapping
	let buf = Buffer.concat([Buffer.from([ 0x20, 0x50, 0xB8 ]), Buffer.alloc(17, 0xEA)]);
  buf.copy(romBuffer, 0x1CCDF);
  
	// write code for mapping pattern table ids to each screen
	buf = Buffer.from(assemble(await fs.readFile(PATTERN_ASM, 'utf8')));
	buf.copy(romBuffer, 0x7860);
}