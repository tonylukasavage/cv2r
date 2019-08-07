## 0.0.16 - 2019-08-06

* cv2-rando is now fully patch-driven, including what was internal code like itemizer, enemizer, shared assembly subroutines like clear-objects, etc...
* Added `-d, --difficulty` option for making reasonable groups of patches based on difficulty. For now the options are `easy`, `standard`, and `hard`. `standard` is the default setting.
* Added `-p, --palette` option to allow explicitly picking palettes. Palettes are structured and behave like any other patch but have their own folder at `lib/palette` to keep them all together. By default the palette will be the original Simon's Quest palette.

## 0.0.15 - 2019-07-27

* Added crc32 sum of the seed to the title screen
* Moved jovah warp, inventory deselect, and SRAM clearing out of itemizer and into core code

## 0.0.14 - 2019-07-27

* Automated testing added
* ROMs are now generated to the `roms` folder by default, not the `tmp` folder

## 0.0.13 - 2019-07-25

* Allow deselecting quest items by pressing B button in inventory