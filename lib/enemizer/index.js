const assemble = require('../../dep/6502assembler');
const core = require('../data/core');
const { enemiesBySprite } = require('../../data/object');
const fs = require('fs').promises;
const path = require('path');
const { randomInt } = require('../utils');

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
const bgPattern = [ 0x00, 0x08, 0x02, 0x04, 0x06, 0x0B ];
const spritePattern = [ 0x01, 0x09, 0x03, 0x05, 0x07, 0x0C ];

module.exports = async function enemizer(romBuffer, rng) {
  const table = core.enemiesBySprite;

  // Write individual bg/sprite pattern table id for every single screen in the game.
  // Currently we're randomizing only the sprite table (for enemies), not the 
  // background table.
  core.forEach((loc, index) => {
    // Find the offset for the current screen we're processing in our pseudo multi
    // dimensional array in memory
    const offset = (loc.objset * OBJ_OFFSET) + (loc.area * mapSize[c.objset]) + loc.submap;

    // Select a random sprite pattern table for the enemies we'll render in this 
    // screen. Currently this excludes town (0x01) and castlevania (0x0C). Town 
    // would work, but would be boring since it's only bats and zombies.
    const spriteId = spritePattern[randomInt(1, 4)];

    // Assign bg and sprite pattern tables as single byte, as well as a pointer 
    // to this byte in memory.
    loc.pattern = { 
        value: ptv(bgPattern[c.objset], spriteId),
        pointer: BASE_LOC_PTR + offset 
    };

    // change actors for the location based on the pattern table value
    loc.actors.forEach(a => {
      if (!a.enemy) { return; }

    });
  });

  // create pattern table mappings for all screens
	let buf = Buffer.from([ 0x20, 0x50, 0xB8 ]);
	buf.copy(romBuffer, 0x1CCDF);

	// write code for mapping pattern table ids to each screen
	buf = Buffer.from(assemble(await fs.readFile(PATTERN_ASM, 'utf8')));
	buf.copy(romBuffer, 0x7860);

}