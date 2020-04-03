# cv2r - Castlevania II: Simon's Quest Randomizer [![Build Status](https://travis-ci.org/BloodSweatAndCode/cv2r.svg?branch=master)](https://travis-ci.org/BloodSweatAndCode/cv2r)

cv2r - Castlevania II: Simon's Quest Randomizer by **BloodSweatAndCode**. Come find me and the CV2R crew for chat on gameplay, racing, and development in the [Discord](https://discord.gg/wFhkKCK)!

Also, you can skip this repository entirely if you just want to generate a seed and play by going to the [CV2R Website](https://cv2r.herokuapp.com/).

## supported platforms

* NES console
* [NT Mini](https://www.analogue.co/nt-mini/)
* [fceux](http://www.fceux.com/web/home.html)
* [mesen](https://www.mesen.ca/)

### platforms with known issues

* [bizhawk](https://github.com/BloodSweatAndCode/cv2r/issues/108)
  * There is [bizhawk bug](https://github.com/BloodSweatAndCode/cv2r/issues/108) that causes a crash on the "game start" screen after a few seconds when using the `QuickNes` core. If you press start before the crash, gameplay will continue normally. You can avoid the crash entirely by using the `NesHawk` core, but your seed icons will still be glitched.

## usage

```
Castlevania II: Simon's Quest Randomizer by BloodSweatAndCode

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
2. Download the latest build of [cv2r](https://github.com/BloodSweatAndCode/cv2r/archive/master.zip)
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


area pointers: 0xC82F (rooms?)

03:880F - sets area/submap when you enter town door
03:87F1 - sets area/submap when you enter mansion door
07:D05B - sets area/submap when your exit town door
07:D0EA - sets area/submap when you exit mansion thru door

03:847A - sets submap when leaving thru door

458->53

 07:E7C7:F0 F3     BEQ $E7BC
 07:E7C9:A5 50     LDA $0050 = #$02
 07:E7CB:38        SEC
 07:E7CC:E9 06     SBC #$06
 07:E7CE:A8        TAY
 07:E7CF:B9 A6 F7  LDA $F7A6,Y @ $F7AA = #$02
 07:E7D2:85 57     STA $0057 = #$00
 07:E7D4:A9 00     LDA #$00
 07:E7D6:85 54     STA $0054 = #$01
 07:E7D8:85 56     STA $0056 = #$00
 07:E7DA:4C BE E7  JMP $E7BE
 07:E7DD:AD 58 04  LDA $0458 = #$0D
 07:E7E0:85 53     STA $0053 = #$0D
 07:E7E2:AD 6A 04  LDA $046A = #$01
 07:E7E5:85 54     STA $0054 = #$01
 07:E7E7:AD 7C 04  LDA $047C = #$AE
>07:E7EA:85 56     STA $0056 = #$00
 07:E7EC:AD 8E 04  LDA $048E = #$00
 07:E7EF:85 57     STA $0057 = #$00

07:D047 - town door enter code (ROM 0x1D057)

## Town doors

 07:D25C:A5 30     LDA $0030 = #$00
 07:D25E:0A        ASL
 07:D25F:A8        TAY
 07:D260:B9 AB F7  LDA $F7AB,Y @ $F7AB = #$42
 07:D263:85 00     STA $0000 = #$42
 07:D265:B9 AC F7  LDA $F7AC,Y @ $F7AC = #$80
 07:D268:85 01     STA $0001 = #$80
>07:D26A:A5 50     LDA $0050 = #$08
 07:D26C:0A        ASL
 07:D26D:A8        TAY
 07:D26E:B1 00     LDA ($00),Y @ $8053 = #$15
 07:D270:85 02     STA $0002 = #$15
 07:D272:C8        INY
 07:D273:B1 00     LDA ($00),Y @ $8053 = #$FA
 07:D275:85 03     STA $0003 = #$FA

room data?
 D28000FB0000FB00000C80

 >07:D1B2: map/pos stuff after room entry?
 sets 63, 64, 6e, 6f

$4A0 - simon x pos ($348) before entering door
$4B2 - simon y pos ($324) before entering door

rover
00 00 00 02

 ## mansion doors



 0800000000000002FC0B3C3C37540420F02300918810FC00A2373C000000ECF7


## bank 2

```
07:D257:A9 02     LDA #$02
07:D259:20 83 C1  JSR $C183
```
-
replace with

```
07:D257:A9 02     LDA #$03
07:D259:20 ?? ??  JSR $(jsr on bank 2)
```

```
; jsr on bank 2
JSR $C183
JSR $(jsr on bank 3)
LDA #$02
JSR $C183
RTS
```

## jsr on bank 3

```
LDA #$01
STA *$30
LDA #$01
STA *$50
LDA #$00
STA *$51
RTS
```

D772

## values saved when entering a door?

 03:86A4:A9 00     LDA #$00
 03:86A6:85 43     STA $0043 = #$00
 03:86A8:A5 53     LDA $0053 = #$12
 03:86AA:8D 86 01  STA $0186 = #$12
 03:86AD:A5 54     LDA $0054 = #$01
 03:86AF:8D 87 01  STA $0187 = #$01
 03:86B2:A5 56     LDA $0056 = #$AE
 03:86B4:8D 88 01  STA $0188 = #$AE
 03:86B7:A5 57     LDA $0057 = #$00
 03:86B9:8D 89 01  STA $0189 = #$00
 03:86BC:AD 48 03  LDA $0348 = #$80
 03:86BF:8D 8A 01  STA $018A = #$80
 03:86C2:AD 24 03  LDA $0324 = #$8F
 03:86C5:8D 8B 01  STA $018B = #$8F
>03:86C8:A5 30     LDA $0030 = #$00
 03:86CA:8D 8C 01  STA $018C = #$00
 03:86CD:A5 50     LDA $0050 = #$00
 03:86CF:8D 8D 01  STA $018D = #$00
 03:86D2:A5 51     LDA $0051 = #$00
 03:86D4:8D 8E 01  STA $018E = #$00

 ## town door ($30 == 0) vs. mansion door? ($30 == 1)

 07:CD4E:A5 30     LDA $0030 = #$00
 07:CD50:F0 4E     BEQ $CDA0
 07:CD52:C9 01     CMP #$01

 ## town door entry area ($50) update code

 03:87FE:A5 50     LDA $0050 = #$00
 03:8800:0A        ASL
 03:8801:0A        ASL
 03:8802:85 00     STA $0000 = #$00
 03:8804:A5 53     LDA $0053 = #$12
 03:8806:18        CLC
 03:8807:6D 48 03  ADC $0348 = #$80
 03:880A:A5 54     LDA $0054 = #$01
 03:880C:65 00     ADC $0000 = #$00
 03:880E:A8        TAY
 03:880F:B9 1F 88  LDA $881F,Y @ $8820 = #$08
>03:8812:85 50     STA $0050 = #$00

0x3C in $600-$6FF range is a door

## positioning entering mansion

 07:E7C9:A5 50     LDA area = #$08
 07:E7CB:38        SEC
 07:E7CC:E9 06     SBC #$06
 07:E7CE:A8        TAY
 07:E7CF:B9 A6 F7  LDA $F7A6,Y @ $F7A8 = #$02
>07:E7D2:85 57     STA simon_map_y_high = #$00
 07:E7D4:A9 00     LDA #$00
 07:E7D6:85 54     STA simon_map_x_high = #$00
 07:E7D8:85 56     STA simon_map_y_low = #$00

 8F & 4B && 4EA && 194?


 00030000000000000010000A00AC9000000000000000000050000000000000000000000D0100AE0004132A1E14315225D423271D84100400001428000000E9F786FA50FA0DAE00000000000000000044

 000300000000FF000011000A00AC900000000000000000005000000000000000000000120100AE0004131E1E1431502503232B9188100400A21428000000ECF7CF87CE8712AE00000000000000000044


 0x71 has somethign to do with y scroll

## set area and submap after transition

 07:D0E9:C8        INY
 07:D0EA:B1 02     LDA ($02),Y @ $88D6 = #$00
>07:D0EC:85 50     STA area = #$06
 07:D0EE:C8        INY
 07:D0EF:B1 02     LDA ($02),Y @ $88D6 = #$00
 07:D0F1:85 51     STA submap = #$FF
 07:D0F3:20 57 D2  JSR $D257