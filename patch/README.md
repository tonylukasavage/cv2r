## patches

`pre` patches are applied _before_ the core data from `data/core.js` is written to the ROM buffer, and therefore can manipulate the `core` data before it is written. `post` patches are applied directly to the ROM buffer after the `core` data is written to the ROM buffer.