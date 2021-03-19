# cv2r - Castlevania II: Simon's Quest Randomizer [![Build Status](https://travis-ci.org/tonylukasavage/cv2r.svg?branch=master)](https://travis-ci.org/tonylukasavage/cv2r)

cv2r - Castlevania II: Simon's Quest Randomizer by **BloodSweatAndCode**. Come find me and the CV2R crew for chat on gameplay, racing, and development in the [Discord](https://discord.gg/wFhkKCK)!

Also, you can skip this repository entirely if you just want to generate a seed and play by going to the [CV2R Website](https://cv2r.herokuapp.com/).

## supported platforms

* NES console
* [NT Mini](https://www.analogue.co/nt-mini/)
* [fceux](http://www.fceux.com/web/home.html)
* [mesen](https://www.mesen.ca/)

### platforms with known issues

* [bizhawk](https://github.com/tonylukasavage/cv2r/issues/108)
  * There is [bizhawk bug](https://github.com/tonylukasavage/cv2r/issues/108) that causes a crash on the "game start" screen after a few seconds when using the `QuickNes` core. If you press start before the crash, gameplay will continue normally. You can avoid the crash entirely by using the `NesHawk` core, but your seed icons will still be glitched.

## usage

```
Castlevania II: Simon's Quest Randomizer by BloodSweatAndCode (tonylukasavage)

Usage
  cv2r [options] [vanilla_rom_file]

Examples
  # Show this help
  node .\bin\cv2r --help

  # Generate a rom with the seed "BSAC" at standard difficulty
  node .\bin\cv2r --seed BSAC cv2.nes

  # Generate a rom with the seed "BurbAndSath" at hard difficulty
  node .\bin\cv2r --seed BurbAndSath --difficulty hard cv2.nes

  # Generate a rom with a random seed using the "Rondo of Burb" palette
  node .\bin\cv2r --palette rondo-of-burb cv2.nes

  # Generate a custom rom with a list of patches
  node .\bin\cv2r --patch enemy-hp,hearts-patch,price-rando cv2.nes

Options
  -V, --version                      output the version number
  -d, --difficulty <difficulty>      difficulty setting for the game, see list below
  -j, --json                         output patch and spoiler as json, disables all other output
  -o, --output <output>              filepath for randomized rom output
  -p, --palette <palette>            palette for the game, see list below
  -r, --run                          immediately run with emulator after randomizing (fceux or OpenEmu must be in PATH)
  -s, --seed <seed>                  seed to use for randomization
  -x, --patch <patches>              comma separated list of patches to apply, see list below
  -z, --debug                        enable debug output

Difficulties

  easy                               The easiest mode for CV2R. Lots of hearts, reduced penalties, and a little more sanity
                                     around the enemization. A good place to start for brand new players.
                                     PATCHES: double-hearts, 100-hearts, lazy-river, penalty-reduction

  standard                           The most common way to run CV2R. Some heart buffs to keep the game moving, but that's
                                     all the help you'll get. Merchant prices and enemy HP are randomized.
                                     PATCHES: enemy-hp, 100-hearts, penalty-reduction, price-rando

  hard                               Ready for a challenge? No help with your heart grinds. Merchant prices and enemy HP
                                     randomized.
                                     PATCHES: enemy-hp, price-rando


Patches

  100-hearts                         A heart drops on every single enemy kill
  disable-qk                         Disable the vanilla CV2 bug where the last frame of a subweapon does 185 damage, most often used to quick kill Death and Dracula.
  double-hearts                      Doubles the value of every heart dropped
  drac-downgrade                     Once Dracula's summoning blaze lights, Simon is given a thorn whip and has his level set to level 2.
  enemy-hp                           Randomize enemy HP by +/-50%
  invisible-enemies                  The ULTIMATE pain, Invisible enemies - including bosses!
  lazy-river                         Only spawn fishmen on Dead River, like vanilla CV2
  ohko                               Enemies kill Simon in one hit!
  paint-it-black                     The only thing visible in the game is Simon, enemies, stairs, and a few visual cues
  penalty-reduction                  Keep half your hearts after game over
  price-rando                        Randomize merchant prices by +/-25%
  samus                              Samus, minus the Power Suit

Palettes

  rondo-of-burb                      Burb's custom color palette
  simons-quest                       Default Simon's Quest palette

Developer Flags

  --dev-force-enemy <devForceEnemy>  Spawn only one type of enemy, specified as "enemyId:tableId". For example, spawning
                                     only harpies would be "--dev-force-enemy 0x3B:0x7". Values for enemy and table id can
                                     be found in lib/object.js.
```

## install

I plan to make executables so this installation isn't necessary, but until then, follow these steps:

1. Install [node.js](https://nodejs.org/en/)
2. Download the latest build of [cv2r](https://github.com/tonylukasavage/cv2r/archive/master.zip)
3. Extract cv2r to a folder
4. Copy a vanilla cv2 rom into the cv2r folder as "cv2.nes"
5. In a command prompt:
```
cd /path/to/cv2r
npm install

# on Windows, "BSAC" is replaced by your seed (any string)
node --no-warnings .\bin\cv2r --seed BSAC cv2.nes

# on Mac/Linux (I've done ZERO Linux testing), "BSAC" is replaced by your seed (any string)
./bin/cv2r --seed BSAC cv2.nes
```

You can now find your new cv2 rando rom in the `/path/to/cv2r/output` folder
