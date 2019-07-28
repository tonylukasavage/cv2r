const bank = require('./bank');
const camelcase = require('camelcase');
const { cyan, green, yellow } = require('chalk');
const core = require('../lib/core');
const crc32 = require('crc32');
const enemizer = require('../lib/enemizer');
const fs = require('fs').promises;
const itemizer = require('../lib/itemizer');
const mkdirp = require('mkdirp');
const path = require('path');
const { isGameFlag, modSubroutine, randomString, TEXT_MAP_TITLE, textToBytes } = require('./utils');
const seedrandom = require('seedrandom');
const { version } = require('../package.json');

function asmFile(name) {
  return path.join(__dirname, 'asm', name);
}

module.exports = async function create(rom, opts = {}) {
	const seed = opts.seed || randomString();
	const rng = seedrandom(seed);
	const output = opts.output || `roms/cv2-rando-${opts.version()}-${seed}.nes`;

	// read the source rom
	const romBuffer = await fs.readFile(rom);

	// Modify the title screen. It's important that the exact number of characters
	// in the following strings are used.
	const titlePrint = (text, rom) => Buffer.from(textToBytes(text, TEXT_MAP_TITLE)).copy(romBuffer, rom);
	const titlePad = (text, size) => {
		let padFront = text.length % 2;
		while (text.length < size) {
			text = `${padFront ? ' ' : ''}${text}${padFront ? '' : ' '}`;
			padFront = !padFront;
		}
		return text;
	};
	titlePrint('  randomizer  ', 0x01041E);
	titlePrint(titlePad(`v${version}`, 13), 0x010169);
	titlePrint(`      seed ${crc32(seed)}     `, 0x010179);
	titlePrint('           ', 0x010194);
	titlePrint('  by bloodsweatandcode  ', 0x0101A2);

	// Fix Ondol laurel room night time palette pointer
  Buffer.from([ 0xB6 ]).copy(romBuffer, 0x80D0);

  // Fix Alba garlic room night time palette pointer
  Buffer.from([ 0x15 ]).copy(romBuffer, 0x1FA58);

  // This fixes the laurel merchant room, but also changes the night time palette
  // for Alba. It's daylight out and the zombies are orange! I'm not going to
  // put it in place, and the garlic merchant room will still get the night time 
  // palette, but everything, including the dialog, is still clear. If I can 
  // figure out a way to separate the two later, then I'll re-enable this.
  // Buffer.from([ 0x15, 0x2E ]).copy(romBuffer, 0x1FA5A);

  // reset SRAM
  modSubroutine(romBuffer, asmFile('sram.asm'), bank[8], {
    invoke: {
      romLoc: 0x1C02B,
      padding: 2
    }
  });

  // set all objects to 0x00 ($3BA - $3BF)
  const clearObjectsLoc = modSubroutine(romBuffer, asmFile('clearObjects.asm'), bank[9]);

  // Allow de-selecting quest items
  const gameStateChecksLoc = modSubroutine(romBuffer, asmFile('gameStateChecks.asm'), bank[2]);
  
  // setup jovah warp and inventory deselect
  modSubroutine(romBuffer, asmFile('gameStateChecksWrapper.asm'), bank[7], {
    invoke: {
      romLoc: 0x1C09A
    },
    values: {
      gameStateChecks: gameStateChecksLoc.ram.toString(16)
    }
  });

  // update simon positioning+flags and camera positioning on jovah warp
  modSubroutine(romBuffer, asmFile('jovahWarpPositioning.asm'), bank[8], {
    invoke: {
      romLoc: 0x1CFF8,
      padding: 1
    }
  });

  // special handling for jovah warp on ferry
  modSubroutine(romBuffer, asmFile('jovahWarpFerryCheck.asm'), bank[8], {
    invoke: {
      romLoc: 0x1CF4C,
      padding: 1
    },
    values: {
      clearObjects: clearObjectsLoc.ram.toString(16)
    }
  });

	// randomize enemies
	if (opts.enemizer) { await enemizer(romBuffer, rng, opts); }

	// randomize items
	if (opts.itemizer) { await itemizer(romBuffer, rng, opts); }

	// write all indexed and modified core data to rom buffer
	const flags = opts.options.filter(o => isGameFlag(o) && opts[camelcase(o.long)]);
	console.log(`Flags: [${ flags.map(f => cyan(f.long.replace(/^--/, ' '))) } ]`);
	console.log(`Applying flags to ${green('core')} data...`);
	
	core.forEach(loc => {
		// update all actors (npcs, enemies, books, etc...)
		Array.isArray(loc.actors) && loc.actors.forEach(a => {
			let buf = Buffer.from([ a.x, a.y, a.id, a.data ]);
			buf.copy(romBuffer, a.pointer);

			// update text, if necessary
			if (a.text && a.textPointer) {
				const textArray = Array.isArray(a.text) ? a.text.slice(0) : [ a.text ];
				const textPointerArray = Array.isArray(a.textPointer) ? a.textPointer.slice(0) : [ a.textPointer ];
				for (let i = 0; i < textArray.length; i++) {
					buf = Buffer.from(textToBytes(textArray[i]));
					buf.copy(romBuffer, textPointerArray[i]);
				}
			}
		});

		// update pattern tables for all locations
		if (loc.pattern && loc.pattern.value != null && loc.pattern.pointer) {
			romBuffer.writeUInt8(loc.pattern.value, loc.pattern.pointer);
		}
	});

	// process all post patches
	opts.options.filter(o => /^\[PATCH(?:-X)?\]/.test(o.description)).map(o => o.long.replace(/^--/, '')).forEach(p => {
		const { name, patch } = require(`../patch/${p}`);

		// did we enable this patch?
		if (!opts[camelcase(p)]) { return; }
		console.log(`Applying ${yellow(name)} patch...`);

		// process the patch data
		patch.forEach(data => {
			// parse the hex string into an array of hex integers
			const bytes = data.value.split(/\s+/).map(b => parseInt(b, 16));

			// convert the hex integers into a data buffer
			const buf = Buffer.from(bytes);

			// copy the patch bytes to the given offset within the rom buffer
			buf.copy(romBuffer, data.offset);
		});
	});

	// write out the modified rom
	mkdirp.sync(path.dirname(path.resolve(output)));
	await fs.writeFile(output, romBuffer);

	// return the output filename
	return output;
}
