const crc32 = require('crc32');
const { version } = require('../../package.json');
const { TEXT_MAP_TITLE, textToBytes } = require('../utils');

module.exports = {
  patch: function(patchGroup, opts) {
    const { seed } = opts;
    
    // convert text string to bytes and add the patch
    const titlePrint = (text, rom) => patchGroup.add(textToBytes(text, TEXT_MAP_TITLE), rom);
    
    // attempt to provide equal left/right padding on a title string
    const titlePad = (text, size) => {
      let padFront = text.length % 2;
      while (text.length < size) {
        text = `${padFront ? ' ' : ''}${text}${padFront ? '' : ' '}`;
        padFront = !padFront;
      }
      return text;
    };
    
    // It's important that the exact number of characters in the following strings are used.
    titlePrint('  randomizer  ', 0x01041E);
    titlePrint(titlePad(`v${version}`, 13), 0x010169);

    // TODO: I have no idea why this this platform check is necessary, maybe crc32?
    titlePrint(`      seed ${crc32(seed)}     `, 0x010179);

    titlePrint('           ', 0x010194);
    titlePrint('  by bloodsweatandcode  ', 0x0101A2);
  }
};