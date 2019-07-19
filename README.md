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

These are roughly ordered in the order I want to tackle them:

* sale icon for progressive crystals can be confusing
* improve text from actors
  * implement text that indicates you already grabbed a progressive item from an actor
* Laurel room in Alba glitches at night
* change sprites on boss drops to match the item you're actually getting
* leeches render improperly sometimes (do i have high jump and low jump mixed up?)
* some spiders still kill themselves by spawning to low on the screen
* represent seed value on title screens with game icons (like ALttP rando)
* Graveyard Duck (come on grom!)
* useful, randomizer-seed-specific hints in books
* adjust sales prices for progression items (re-route ROM access based on inventory)
* ferry man wants something besides heart
* drain water with something other than blue/red crystal
* fix low priority screen rendering
* fix flower rendering when not on "graveyard" pattern tables
* replace mansion blobs with regular blobs when not in mansion
* include dracula's nail in logic (some current holy water logic is also accessible with nail)
* Fast travel
* door randomizer
  * mansion shuffle
  * ALL doors shuffle
* death/camilla shuffle
* patches
  * OHKO
  * disable quick kill

## developer notes

### progression logic decisions

* Whips will be upgraded progressively. No quick jump to morning star or flame whip.
* Crystals will also be encountered progressively to prevent potential super boring back tracking.
* The 3 block whip jump in Camilla's Cemetery is **NOT** in logic. This means red crystal is required for Bodley, Laruba, Doina, etc...
* Laurels are considered required for Laruba Mansion
* Laurels are **NOT** considered required to cross the swamp in Belasco Marsh

### code locations for all actors that can hold items

The `$7F` value is set _after_ the code executes for the given item/weapon/whatever.

| name                           | RAM  | ROM   | identifier | notes                          |
|--------------------------------|------|-------|------------|--------------------|
| merchant (weapon/item)         | EDD8 | 1EDE8 | | values start at $EE12 RAM, $1EE22 ROM  |
| merchant (whip)                | EDF4 | 1EE04 | $7F is #33 (thorn), #34 (chain), or #35 (morning star) | ($40 AND #1F) - #7 = $434 |
| crystal dude (blue)            | 906F | 507F  | | $7F is 0x55 on accept, 0x6B on reject (text???) |
| crystal dude (red)             | 9088 | 5098  | | $7F is 0x56 on accept, 0x6B on reject (text???) |
| orb                            | 8794 | 47A4  | $3BA = #25, $4C2,X=???, $8632,Y=($91 values) |
| laurel dude (laruba)           | 9347 | 5357  | $7F = #78 | |
| flame whip dude                | 8C72 | 4C82  | $7F = #75 | |
| diamond dude                   | AA3A | 6A4A  | $7F = #12 | |
| secret merchant (silver knife) | AE12 | 6E22  | $7F = #10 | |
| secret merchant (silk bag)     | AE07 | 6E17  | $7F = #0F | |
| Death                          | 87C7 | 47D7  | $3BA = #44 (#49 for knife) | still appears as knife no matter what item it actually gives you |
| Camilla                        | 87BF | 47CF  | $3BA = #42 (#?? for cross) | still appears as cross no matter what item it actually gives you |
| sacred flame                   | 87CD | 47DD | | still appears as flame no matter what item it actually gives you (bank 1) |

### progressive whips and crystals

* `$D0` will track in each bit whether or not you've already received a progressive upgrade from a particular actor.

### unused but interesting values

(ROM) 0x1EE25 is 0x092010, which seems to indicate it's a carryable item, but 0x10 doesn't match up with the bit flags currently mapped.

| carry item  | bit |
|-------------|-----|
| silk bag    | 1   |
| magic cross | 2   |
| laurels     | 3   |
| garlic      | 4   |

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

* **Dead River - Part 2** and **Dead River to Brahm** share the same actors, so this needs to be accounted for during any randomizing that involves the actors in those screens. Essentially, unless otherwise handled, **Dead River - Part 2** will take precedence since it is defined after **Dead River to Brahm** in the `core.js` definition file.
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


3, 5, 3

101    11000    101

0 + 0 + 0 + 0x35

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

### sale icons and prices

Code for determining the sale icons and prices is at `0x1ED46` ROM (`07:ED36` in RAM). Mapped bank is 3 for these calls.

### merchant shuffle

// merchant purchasable items: 0x1ee22-0x1ee39

// code for blue crystal guy at 1:906F(RAM) 0x507F(ROM)

// code for red crystal guy at 1:9088(RAM) 0x5098(ROM)

// 07:C08A function for red crystal


// F7 is dpad

// 0x1F6AD is where the dialog starts, 0x0E 0x00 means 0x00 14 times

// 0x83CC code specific to merchants?
// 0x58,0x59 map -- 0x5E,0x5F ???
// 0x80EC - code that stores npc "type", value at 0x9140 for thorn

// 0x3ba is 0x2E which is the lower 7 bits of 0xAE which is the actor "type"
// 0x4da is the actor "value" 0x08
// 0x34e is 0xC0
// 0x32a is 0xC0
// 0x3de is 0x08
// 0x438 is 0x01

// $1F6F7 is the price line in dialog ROM

// 0x414 is 0xOB after a pointer chek on 0x3ba when entering room
// 0x414 times 3 (0x21) goes into 0x94,
// then ised to point to 0xDDC3 = (01 1e 0c)
// 1e goes into 0x306, 0c goes into 3f0
//

// $40 is 0x28, gets set to 0x93
// 0x888D is where whip is checked for merchant chat

// $1ED3D in ROM is 0x5B, which is the whip icon, gets stored at $703
// the format is 3 bytes for each entry. The first byte is the
// icon for sale (index for background PPU table). The second and third
// bytes are the price. PRICE RANDO!
// prices: 0x1ED25-0x1ED45
// price high byte gets stored at $29, $93
// price low byte gets stored at $28

// 0xE09C is where 0x3de AND 0xf7, which excludes only values with the 4th bit
// set, meaning merchants that sell whips. This gets put in 0x3de, or zero

// $f6e7 for line in dialog for dashes and hearts
// 0x1EFE2 is where yes/no dialog choice happens (0xEFD2 RAM)

// $E08C (RAM) watch me whip?

// $40 and $93 determine icon for sale
// $1D is 0x2E, $18 is 0x05

// $7A
// * 0-3 == presenting dialog background
// * 4 == printing dialog text
// * 5 == non-interactive text end, waiting for B press
// * 6 == waiting for yes/no choice

// $7E
// * 0 == start menu
// * 1 == no interaction dialog
// * 2 == yes/no dialog

// $F1 is dpad

// ECC7 is where we move to the whip icon, C5D0 is where pointer is set
// EE9D is the dialog text loop

// 7A increments after dialog completes (5), i think it managed dialog state
// does $164 hold this value at any stage?

// C058 checks $1A, if Z flag not set, skips all merchant logic!

// $7A needs to be 0x01 for normal dialog

// $103???? at C)FB

// Change $3BA (or whatever near location has the merchant 0x2E) to the value 0x35.
// The merchant then moves like a normal NPC and will deliver an npc dialog with no
// yes/no interaction. Dialog now points to the unused "you level has increased..."
// messages, which should be easy to change.

// Using $7F as a unique ID for actors doesn't work because the multiple
// laurel and garlic merchants share the same value. Additionally, laurel
// merchants have a $7F value of 0x00, which is intended to be an empty value
// in the current progressive whip upgrade logic, so that will have to
// change.

// whip sale code 0xEDF4 RAM, 0x1EE04 ROM
