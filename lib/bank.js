module.exports = [
  // bank 0
  {
    ram: {
      start: 0xB848,
      end: 0xBFCF
    },
    rom: {
      start: 0x3858,
      end: 0x3FDF
    },
    offset: 0
  },

  // bank 1
  {
    ram: {
      start: 0xB8CC,
      end: 0xBFCF
    },
    rom: {
      start: 0x78DC,
      end: 0x7FDF
    },
    offset: 0
  },

  // bank 2
  {},

  // bank 3
  {
    ram: {
      start: 0x9CF6,
      end: 0xBFCF
    },
    rom: {
      start: 0xDD06,
      end: 0xFFDF
    },
    offset: 0
  },
];