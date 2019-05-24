# cv2-rando

Castlevania II: Simon's Quest Randomizer by **BloodSweatAndCode**. Come find me running this and other retro games on [Twitch](https://www.twitch.tv/bloodsweatandcode)!

**WARNING** This is still in very early stages and not really usable yet. Updates are coming fast and furious.

## usage

```
Usage: cv2rando [options] <rom_input>

Castlevania II: Simon's Quest Randomizer by BloodSweatAndCode

Options:
  -V, --version          output the version number
  -o, --output <output>  filepath for randomized rom output
  --run                  immediately run with fceux after randomizing (fceux must be in PATH)
  -s, --seed <seed>      seed to use for randomization
  -d, --double-hearts    [PATCH] double the value of each heart
  -f, --fast-day-night   [PATCH] get rid of the day-night cycle dialog boxes
  -n, --night-party      [PATCH] enable NPCs and door entry at night
  -h, --help             output usage information
```

## TODO

* itemizer
  * merchants, including secret ones
  * drac parts
* enemizer
  * HP randomizer
  * enemy behavior manipulations
* door randomizer
  * mansion shuffle
  * ALL doors shuffle
* death/camilla shuffle
* sequential whip upgrades
* useful, randomizer-seed-specific hints in books
* replace mansion blobs with regular blobs when not in mansion

## developer notes

### progression logic decisions

* The 3 block whip jump in Camilla's Cemetery is **NOT** in logic. This means red crystal is required for Bodley, Laruba, Doina, etc...
* Laurels are considered required for Laruba Mansion
* Laurels are **NOT** considered required to cross the swamp in Belasco Marsh

### dialog text

`0xCC84` is where all the text starts in the ROM. First one is "What a horrible night to have a curse".

| Char | Value |
|------|-------|
| (space) | 0x00 |
| A    | 0x01  |
| B    | 0x02     |
| C    | 0x03     |
| D    | 0x04     |
| E    | 0x05     |
| F    | 0x06     |
| G    | 0x07     |
| H    | 0x08     |
| I    | 0x09     |
| J    | 0x0A    |
| K    | 0x0B    |
| L    | 0x0C    |
| M    | 0x0D    |
| N    | 0x0E    |
| O    | 0x0F    |
| P    | 0x10    |
| Q    | 0x11    |
| R    | 0x12    |
| S    | 0x13    |
| T    | 0x14    |
| U    | 0x15    |
| V    | 0x16    |
| W    | 0x17    |
| X    | 0x18    |
| Y    | 0x19    |
| Z    | 0x1A    |
| .    | 0x1B    |
| '    | 0x1C    |
| ^    | 0x1D    |
| ,    | 0x1E    |
| 0    | 0x36     |
| 1    | 0x37     |
| 2    | 0x38     |
| 3    | 0x39     |
| 4    | 0x3A     |
| 5    | 0x3B     |
| 6    | 0x3C     |
| 7    | 0x3D     |
| 8    | 0x3E     |
| 9    | 0x3F     |
| (new line) | 0xFE |
| (end) | 0xFF |

### in lib/core.js

* **Dead River - Part 2** and **Dead River to Brahm** share the same actors, so this needs to be accounted for during any randomizing that involves the actors in those screens. Essentially, unless otherwise handles, **Dead River - Part 2** will take precedence since it is defined after **Dead River to Brahm** in the `core.js` definition file.
* `npc.crystalDude` is the same as the (secret) merchant in the non-town pattern tables

### pattern table re-mapping

I had to store new 1 byte values (high 4 bits are bg table, low 4 bits are sprite table) for every screen in the game. These needed to stored in a space that could be accessed mathematically based on 3 values: objset ($30), area ($50), and submap ($51 AND #$0xF). Those 3 values together compose a unique reference to every screen. The table below shows how I allocated free bytes in the ROM to essentially store a multi-dimensional array. 

| objset | # of areas | # of submaps | map storage |
|--------|------------|--------------|-------------|
| 0x00   | 24         | 2            | 48          |
| 0x01   | 11         | 4            | 44          |
| 0x02   | 10         | 4            | 40          |
| 0x03   | 5          | 5            | 25          |
| 0x04   | 4          | 2            | 8           |
| 0x05   | 1          | 2            | 2           |


So I'm mapping 167 bytes, only using 93 of those bytes in total, thereby wasting 74 bytes as unused space between the valid values of the mult-dimensional array. The pseduo-code calculation below shows roughly how, stored in this manner, I can access any bg/sprite table index at any time with the objset, area, and submap values:

```
// OBJ_OFFSET is 0x30, as there's equal space between each objset in the stored bytes.
(objset * OBJ_OFFSET) + (area * num_of_submaps_for_this_area) + submap
```

With the values stored, we then hijack the typical rudimentary pattern table mapping code. We write to unused ROM space at `0x7860` the compiled opcodes of the 6502 asm contained in the file at `data/pattern.asm`. This code is responsible for executing the calculation above and then properly selecting a sprite table index based on it. All we need to do after that is overwrite 3 particular bytes of code to point to our new code. Essentially we replace the code at `0x1CCDF` with the following:

```
JSR $B850: 20 50 B8
```

and voila! Each screen now has it's own pattern table mapping! Here's the original mapping, which shows there were only 6 options (instead of the 93 possible options we have now). Here we can see what background and sprite table indexes correspond to what enemy groupings.


objset | pattern pointers | bg   | sprite | name 
-------|------------------|------|--------|--------
0      | 0x1CCF9          | 0x00 | 0x01   | town
1      | 0x1CCFB          | 0x08 | 0x09   | mansion
2      | 0x1CCFD          | 0x02 | 0x03   | woods 1
3      | 0x1CCFF          | 0x04 | 0x05   | woods 2
4      | 0x1CD01          | 0x06 | 0x07   | graveyard
5      | 0x1CD03          | 0x0B | 0x0C   | castlevania

### merchant shuffle

// merchant purchasable items: 0x1ee22-0x1ee39

// code for blue crystal guy at 1:906F(RAM) 0x507F(ROM)

// code for red crystal guy at 1:9088(RAM) 0x5098(ROM)

// 07:C08A function for red crystal


// F7 is dpad
