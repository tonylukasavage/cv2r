# CHANGELOG

## 1.4.0 - 2020-03-23

* All sprites in the `patch/simon` folder are loadable in the cv2r.com Sprite Maker
* All patches can now be loaded directly from a file. For example, a custom simon sprite patch can be loaded via `--simon /path/to/simon-patch.json`. Or if you had a custom patch to load into a list, `--patch 100-hearts,/path/to/custom-patch.js`. Bear in mind this generally only works with patches that have no dependencies within the cv2r project. Useful for patch testing.
* Patches can now be loaded not only as Javascript files (`.js`) but also now JSON files (`.json`). For example, .
* All Simon sprite ids and descriptions are now listed when you execute `cv2r --help` from the CLI
* Normalized all the ids, names, and descriptions of the current Simon sprite patches. 
* Added "Bang" from Clash at Demonhead to the selectable Simon sprites
* Improved Link from Zelda 2, Samus and Simon Claus sprite

## 1.3.2 - 2020-03-08

* Added "Pit" from Kid Icarus and "Karnov" to the selectable Simon sprites

## 1.3.1 - 2020-03-07

* Added "Hero" from Crystalis and "Ryu Hayabusa" from Ninja Gaiden to the selectable Simon sprites

## 1.3.0 - 2020-03-06

* Sprite Maker for easily creating new sprites for Simon available at [https://cv2r.herokuapp.com/sprite-maker](https://cv2r.herokuapp.com/sprite-maker)
* Added Mario and Ghost Simon sprites
* Added authors to all sprites

## 1.2.1 - 2020-01-22

* Add "Diamond Warp" difficulty to make it easier to select in website

## 1.2.0 - 2020-01-22

* "Diamond warp" - If you own the magic cross AND have the diamond equipped, doing a select->up+a+b will not take you to Jova. It will instead take you to Bordia Mountains, otherwise known as "dead end swamp", the giant swamp that is very near Dracula's mansion. Diamond warp can be enabled as a patch in any custom difficulty seed. It has NOT been added to any default difficulties.
* To go with the diamond warp ability, I also added diamond warp logic. This will be updated on the website documentation, but in short, having diamond and cross helps put Bodley and Doina in logic. Nothing to the left Bodley is in logic until you get red crystal, though, due to the lake you need to drain.

## 1.1.3 - 2020-01-01

* Added Link from Zelda 2 as a playable sprite for Simon!
* Added `--simon` option to allow you to change Simon's sprite. You can now use any sprite available for Simon without having to create a custom seed. This means selectable sprites will be choosable even in tournament and race settings. Will be selectable from the cv2r website.
* Fixed uncommon logic bug (about 2% of the time) that would cause an error during ROM generation
* Replaced `ava` test framework with `mocha` due to ava crashing during automated testing of ROM generation.

## 1.1.2 - 2019-12-13

* Fixed logic bug that was creating unbeatable seeds on a regular basis
* Added unit tests to verify that thousands of randomly generated seeds can be completed

## 1.1.1 - 2019-12-11

* Glitch logic update: Change Bodley orb requirement from `(HOLY_WATER || NAIL) && ((WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL) || LAURELS) && OAK_STAKE` to `((WHITE_CRYSTAL && BLUE_CRYSTAL && RED_CRYSTAL) || LAURELS) && OAK_STAKE`. In other words, removed holy water or nail as a requirement for Bodley orb.

## 1.1.0 - 2019-12-11

* Logic rework, supports full conditional logic now
* New `--logic` option when generating seeds from CLI, also available on [cv2r.herokuapp.com](https://cv2r.herokuapp.com/). You can now select from `standard` or `glitch` logic. Full explanation of requirements for each set of logic can be found on the [docs site](https://cv2r.herokuapp.com/doc?logic=glitch).
* "Simon Claus" sprite for Simon, thanks to 2snek, just in time for the holidays!

## 1.0.4 - 2019-11-19

* Fixed issues where moving platforms did not spawn in Debious Woods (flame whip dude screen) and the Yuba Lake (the road to Rover) by preventing projectile enemies from spawning there.

## 1.0.3 - 2019-11-13

* ACTUALLY fixed easy seeds, no more price glitching

## 1.0.2 - 2019-11-12

* Fixed bug with ring-marsh-immunity patch that caused all prices to be glitched and/or impossible to afford.
* Fixed bug with [cv2r.herokuapp.com](https:\\cv2r.herokuapp.com) where generating multiple seeds in a row would create corrupted ROMs, resulting in unexpected bugs and quirks in gameplay.

## 1.0.1 - 2019-11-11

* Fixed bug in nail logic that sometimes created unbeatable seeds due to both nail and holy water being behind breakable block checks

## 1.0.0 - 2019-11-05

We made it boys! 1.0.0! Thank you to the awesome CV2R community for helping get this project to this point. I could not have done it without you guys!

* Nail logic implemented
* Patch to give Simon immunity to marshes when Dracula's ring is equipped. Activating this patch will also update the itemizer logic so that any check that required laurels can now be opened with laurels OR ring.
* Difficulty updates
  * `Easy` difficulty now includes the ring marsh immunity patch
  * Created `Elite` difficulty with the following patch list
    * Enemy HP rando
    * Price rando
    * Quick kill disabled
    * Dracula fight downgrade (thorn whip and Simon level 2)
* Implemented optional patches that can be applied BEFORE the core patches. This was necessary when implemeting the logic changes for the ring marsh immunity patch. Any optional patch can be made a pre-core patch by adding the property `pre: true`.

## 0.1.20 - 2019-10-28

* Item base price adjustments (old -> new)
  * Whips: 150 -> 100-150
  * Crystals: 100 -> 50-100
  * Golden knife: 150 -> 125
  * Silver knife: 100 -> 50
  * Sacred flame: 100 -> 75
* Fixed bug where Samus sprite switched back to Simon in Storigoi Graveyard (thanks Burb!)
* Fixed bug with truncated book clues (thanks Kaelari!)

## 0.1.19 - 2019-10-25

* Seed is represented as game icons in the game start menu
* Password option has been removed from the game start menu
* Added stats to all ending screens
* Fixed bug where zeroes did not appear in ending stats
* Mansion blobs will now only appear in screens with ceilings

## 0.1.18 - 2019-10-21

* NEW OPTIONAL PATCH: Disable quick kills, no more last frame subweapon 185 damage!
* NEW OPTIONAL PATCH: Drac Fight Downgrade. Reduces your whip to thorn and your level to 2 once the summoning explosion appears in the Dracula fight.
* Books now contain randomizer-specific clues (thanks kaelari!)
* Fixed rare bug where jovah warp caused a black screen soft lock

## 0.1.17 - 2019-10-18

* Fix best ending text glitch
* Additional checks to prevent immobile enemies on stairs and other bad locations

## 0.1.16 - 2019-10-16

* STATS! Shows the number of death, enemy kills, and hearts collected on the final ending screen.
* I had fun with an alternate set of text for the best ending. Enjoy! :P

## 0.1.15 - 2019-10-02

* "Samus" is a new experimental optional patch that lets you play as Samus, minus the Power Suit. Anything sharing Simon's palette (like HP and hearts) is gonna change to match Samus's colors, meaning lots of green.

## 0.1.14 - 2019-10-01

* Fixed bug with invisible enemies patch filename

## 0.1.13 - 2019-10-01

Thanks to Burb for this update, it was all him!

* "Paint It Black" optional patch where everything except Simon, enemies, stairs, and orbs are black
* "Invisible Enemies" optional patch that, well, makes enemies invisible, including bosses!

## 0.1.12 - 2019-09-21

* OHKO! Everything that does damage kills you in one hit. The lone exception is marshes, which still do the same amount of damage they always did. I may introduce a "OHKO Extreme" mode later where marshes also kill in one touch, but that would require logic changes to make everything left of Belasco Marsh require laurels, and that's a bigger change than I wanna make now.
* Added sound to jovah warp (up+a)
* Not strictly tied to CV2R, but I created the [cv2-crowd-control](https://github.com/BloodSweatAndCode/cv2-crowd-control) project to eventually support [Crowd Control](https://crowdcontrol.live/) with both CV2 and CV2R.

## 0.1.11 - 2019-09-12

* Fixed oak stake glitches by replacing its sprite with the dagger/knife sprite, since it's available on all sprite tables.
* Fixed bug with glitchy flower sprite by no longer animating the flower when it shoots a fireball
* Fixed sprite glitch where visible sprite replaced the transparent "low priority" sprite in locations where there were marshes and dead hands.
* Fixed intermittent sprite glitch that appeared on mansion spider's "line".
* Fixed `--help` multi-line description output
* Added `--dev-force-enemy <enemyId:tableId>` option to force only one type of enemy to be rendered in the randomizer. Useful for testing bugs related to specific enemies.

## 0.1.10 - 2019-09-08

* GRAVEYARD DUCK!!!
* Fixed a bug with the `cv2r patch` command
* Added a tool for extracting sprite tables from a rom at `tools/sprite-extract.js`

## 0.1.9 - 2019-09-05

* Fixed bug where projectiles from enemies sometimes were thrown in the wrong direction

## 0.1.8 - 2019-09-03

* Immobile enemies no longer spawn at the top or bottom of stairs
* Immobile enemies no longer spawn on the block climb to the top of Berkeley Mansion
* The inescapable zigzag bat no longer appears on the stair climb out of Berkeley Mansion
* Improved `cv2r --help`

## 0.1.7 - 2019-09-02

* "Lazy River" patch for vanilla enemies on Dead River

## 0.1.6 - 2019-09-02

* CV2 roms are validated when passed into the CLI
* Added `cv2r patch` command to allow easily creating patches
  * `cv2r patch --method diff cv2.nes cv2-hacked.nes` will generate a ready-to-use patch by diff'ing a vanilla CV2 ROM with a hacked CV2 ROM.
  * `cv2r patch --method ips cv2.ips` will generate a ready-to-use patch by translating an existing [IPS patch](http://fileformats.archiveteam.org/wiki/IPS_(binary_patch_format)) into a cv2r-compatible form.

## 0.1.5 - 2019-08-31

* Huge refactor of patch system. Allows cv2r.com to generate roms with manually specified patches (using a comma-separated list with `--patch`), instead of relying entirely on the difficulty system.

## 0.1.4 - 2019-08-28

* Camilla still drops bag, but Death is back to dropping golden knife due to the fact that the same sprite used for the drop AND all dagger/knife usage by Simon

## 0.1.3 - 2019-08-28

* Boss drop sprites have been changed from golden knife and magic cross to be bags, like the ones inside orbs

## 0.1.2 - 2019-08-28

* git tagging issue, no updates

## 0.1.1 - 2019-08-26

* Rolled back ferry man jovah warp quirk fix, as it caused issues where you couldn't cross Dead River to Brahm's, even with heart equipped

## 0.1.0 (alpha) - 2019-08-25

We are officially **alpha** boys!

* Fixed bug where bosses had randomized hp, which sometimes caused overflow values that gave Camilla extremely low HP
* Fixed regression with jovah warp where the ferry man would be present in Jovah after warp
* Safe guarding against sacred flame and secret merchants despawning by never using projectile enemies (fireballs, bones, or webs) in those screens

## 0.0.21 - 2019-08-24

### [Youtube video explaining 0.0.21 update](https://www.youtube.com/watch?v=FI9WD07OFjM)

* Crystal sale icons update progressively, so you see white crystal as a sales icon from a merchant if you have no crystal, blue if you have white, and red if you have blue.
* With some ROM hacking, `$7F` in RAM can now be used as a unique identifier for any actor Simon is interacting with. The relevant values have been catalogued in the [README](https://github.com/BloodSweatAndCode/cv2r#code-locations-for-all-actors-that-can-hold-items).
* SRAM usage has been documented in the [README](https://github.com/BloodSweatAndCode/cv2r#sram-usage).
* Actors will present "refuse text" if you've already acquired an item from them. It will currently say "NICE TRY SIMON". Additionally, merchants will have their sale icon replaced with an "X" and the sale price will become "9999" to prevent any confusion on attempting to repurchase an already acquired whip/crystal.

## 0.0.20 - 2019-08-17

* Fixed bug with prices being too high (#54)
* Updated `difficulty` settings to support cv2r.com
* Added travis-ci support, all PRs run through linting and tests
* Added code linting to enforce code style

## 0.0.19 - 2019-08-14

* All references and files named `cv2-rando` or `cv2rando` have been changed to `cv2r`, including the repo name. I have saved the `cv2rando` binary for now, but it will be removed in 0.1.0.
* Made `npm test` work on Windows in a [cmder](https://cmder.net/) prompt. Still doesn't work in default Windows command line.

## 0.0.18 - 2019-08-12

* Don't output spoiler csv file when `--json` is used
* update `package.json` to use the bin name `cv2rando`

## 0.0.17 - 2019-08-11

* Fixed title screen bug
* Added ability to have the `cv2rando` process dump the generated rom patch to stdout. This is used by the [cv2r.com](http://cv2r.com) website, but can also be used by anyone who wants access to the patch file generated by the `cv2rando` process.

## 0.0.16 - 2019-08-06

* cv2-rando is now fully patch-driven, including what was internal code like itemizer, enemizer, shared assembly subroutines like clear-objects, etc...
* Added `-d, --difficulty` option for making reasonable groups of patches based on difficulty. For now the options are `easy`, `standard`, and `hard`. `standard` is the default setting.
* Added `-p, --palette` option to allow explicitly picking palettes. Palettes are structured and behave like any other patch but have their own folder at `lib/palette` to keep them all together. By default the palette will be the original Simon's Quest palette.
* Cleaner `--debug` output

## 0.0.15 - 2019-07-27

* Added crc32 sum of the seed to the title screen
* Moved jovah warp, inventory deselect, and SRAM clearing out of itemizer and into core code

## 0.0.14 - 2019-07-27

* Automated testing added
* ROMs are now generated to the `roms` folder by default, not the `tmp` folder

## 0.0.13 - 2019-07-25

* Allow deselecting quest items by pressing B button in inventory
