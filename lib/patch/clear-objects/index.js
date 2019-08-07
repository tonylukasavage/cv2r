const bank = require('../../bank');
const mem = require('../../memory-loc');
const path = require('path');
const { modSubroutine } = require('../../utils');

module.exports = {
  patch: function(pm, opts) {
    mem.clearObjects = modSubroutine(pm.name, path.join(__dirname, 'clearObjects.asm'), bank[9]);
  }
};