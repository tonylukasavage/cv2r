const camelcase = require('camelcase');

const ORB = 0x25;
const SACRED_FLAME = 0x26;
const BOOK = 0x27;
const SIGN = 0xA4;

const SECRET_MERCHANT = 0x9E;
const WOMAN = 0xA9;
const MAN = 0xAA;
const OLD_LADY = 0xAC;
const MERCHANT = 0xAE;
const PRIEST = 0xAD;
const CRYSTAL_DUDE = 0xAF;
const SHEPHERD = 0xB5;
const FERRY_MAN = 0xBC;

const BAT = 0x01;
const LEECH = 0x02;
const SKELETON = 0x03;
const FISHMAN = 0x04;
const SPEAR_KNIGHT = 0x05;
const LIZARDMAN = 0x06;
const EYEBALL = 0x08;
const ZIGZAG_BAT = 0x09;
const MEDUSA = 0x0A;
const BONE_THROWER = 0x0D;
const SPIDER = 0x0E;
const GARGOYLE = 0x0F;
const FLOATING_SKULL = 0x10;
const MANSION_BAT = 0x11;
const WOLF = 0x12;
const WEREWOLF = 0x13;
const MUDMAN = 0x15;
const GRABBER = 0x16;
const ZOMBIE = 0x17;
const SWAMP_GHOUL = 0x18;
const EAGLE = 0x1B;
const FIRE_GHOUL = 0x1D;
const MANSION_BLOB = 0x1F;
const DEAD_HAND= 0x38;
const GHOST = 0x39;
const MUMMY = 0x3A;
const HARPY = 0x3B;
const ROCK = 0x3E;
const FLOWER = 0x3F;
const HIGH_JUMP_LEECH = 0x40;
const BLOB = 0x41;
const BONE_DRAGON = 0x4A;

const CAMILLA = 0x42;
const DEATH = 0x42;
const DRACULA = 0x42;

const POS_AIR = exports.POS_AIR = 1;
const POS_GROUND = exports.POS_GROUND = 2;
const POS_BELOW = exports.POS_BELOW = 3;
const POS_DEADHAND = exports.POS_DEADHAND = 4;

// Map object ids to their sprite pattern table index. The pattern table index is the 
// value used to get from this array. For example, if you wanted an array of all the 
// objects ids that use the mansion sprite pattern table (0x09), you'd access the array 
// as `exports.enemiesBySprite[0x09]`. Empty arrays represent unused indices or indices 
// used by background pattern tables, which we are not manipulating... yet. 
exports.enemiesBySpritePattern = [
  [],
  [ BAT, ZOMBIE ], // town
  [],
  [ LEECH, SKELETON, FISHMAN, LIZARDMAN, EYEBALL, ZIGZAG_BAT, SPIDER, WOLF, WEREWOLF, MUDMAN ], // woods 1
  [],
  [ SKELETON, FLOATING_SKULL, GRABBER, SWAMP_GHOUL, FIRE_GHOUL, DEAD_HAND, HIGH_JUMP_LEECH, BLOB, BONE_DRAGON ], // woods 2
  [],
  [ MEDUSA, EAGLE, GHOST, MUMMY, HARPY, FLOWER ], // graveyard
  [],
  // I'm excluding ROCK here since rocks are stupid
  [ SKELETON, SPEAR_KNIGHT, BONE_THROWER, SPIDER, GARGOYLE, MANSION_BAT, MANSION_BLOB ], //, ROCK ], // mansion
  [],
  [],
  [ DRACULA ], // castlevania
];

// core object functions
function obj(x, y, data, pointer, typeId, name) {
  return { x, y, data, pointer, typeId, name };
}

const npc = exports.npc = function() {
  const o = obj.apply(null, arguments);
  o.npc = true;
  return o;
};

const enemy = exports.enemy = function() {
  const opts = arguments[arguments.length - 1];
  const o = obj.apply(null, arguments);
  o.enemy = true;
  if (opts.pos) { o.pos = opts.pos; }
  return o;
};

const fixture = exports.fixture = function() {
  const o = obj.apply(null, arguments);
  o.fixture = true;
  return o;
}

// define shorthand function for all fixtures (immobile actors)
fixture.book = function() {
  return fixture.call(null, ...arguments, BOOK, 'book');
}

fixture.orb = function() {
  return fixture.call(null, ...arguments, ORB, 'orb');
}

fixture.sacredFlame = function() {
  return fixture.call(null, ...arguments, SACRED_FLAME, 'sacred flame');
}

fixture.sign = function() {
  return fixture.call(null, ...arguments, SIGN, 'sign');
}

// define shorthand functions for all NPCs
npc.crystalDude = function() {
  return npc.call(null, ...arguments, CRYSTAL_DUDE, 'crystal dude');
}

npc.ferryMan = function() {
  return npc.call(null, ...arguments, FERRY_MAN, 'ferry man');
}

npc.man = function() {
  return npc.call(null, ...arguments, MAN, 'man');
}

npc.merchant = function() {
  return npc.call(null, ...arguments, MERCHANT, 'merchant');
}

npc.oldLady = function() {
  return npc.call(null, ...arguments, OLD_LADY, 'old lady');
}

npc.priest = function() {
  return npc.call(null, ...arguments, PRIEST, 'priest');
}

npc.woman = function() {
  return npc.call(null, ...arguments, WOMAN, 'woman');
}

npc.secretMerchant = function() {
  return npc.call(null, ...arguments, SECRET_MERCHANT, 'secret merchant');
};

npc.shepherd = function() {
  return npc.call(null, ...arguments, SHEPHERD, 'shepherd');
}

// define shorthand functions for all enemies
const enemies = [
  { name: 'bat', id: BAT, pos: POS_AIR, sprite: 0x01 },
  { name: 'blob', id: BLOB, pos: POS_GROUND, sprite: 0x05 },
  { name: 'bone dragon', id: BONE_DRAGON, pos: POS_GROUND, sprite: 0x05 },
  { name: 'bone thrower', id: BONE_THROWER, pos: POS_GROUND, sprite: 0x09 },
  { name: 'dead hand', id: DEAD_HAND, pos: POS_DEADHAND, sprite: 0x05 },
  { name: 'eagle', id: EAGLE, pos: POS_AIR, sprite: 0x07 },
  { name: 'eyeball', id: EYEBALL, pos: POS_AIR, sprite: 0x03 },
  { name: 'fire ghoul', id: FIRE_GHOUL, pos: POS_GROUND, sprite: 0x05 },
  { name: 'fishman', id: FISHMAN, pos: POS_BELOW, sprite: 0x03 },
  { name: 'floating skull', id: FLOATING_SKULL, pos: POS_AIR, sprite: 0x05 },
  { name: 'flower', id: FLOWER, pos: POS_GROUND, sprite: 0x07 },
  { name: 'gargoyle', id: GARGOYLE, pos: POS_GROUND, sprite: 0x09 },
  { name: 'ghost', id: GHOST, pos: POS_AIR, sprite: 0x07 },
  { name: 'grabber', id: GRABBER, pos: POS_GROUND, sprite: 0x05 },
  { name: 'harpy', id: HARPY, pos: POS_AIR, sprite: 0x07 },
  { name: 'high jump leech', id: HIGH_JUMP_LEECH, pos: POS_BELOW, sprite: 0x05 },
  { name: 'leech', id: LEECH, pos: POS_BELOW, sprite: 0x03 },
  { name: 'lizardman', id: LIZARDMAN, pos: POS_GROUND, sprite: 0x03 },
  { name: 'mansion bat', id: MANSION_BAT, pos: POS_AIR, sprite: 0x09 },
  { name: 'mansion blob', id: MANSION_BLOB, pos: POS_GROUND, sprite: 0x09 },
  { name: 'medusa', id: MEDUSA, pos: POS_AIR, sprite: 0x07 },
  { name: 'mudman', id: MUDMAN, pos: POS_GROUND, sprite: 0x03 },
  { name: 'mummy', id: MUMMY, pos: POS_GROUND, sprite: 0x07 },
  { name: 'rock', id: ROCK, pos: POS_AIR, sprite: 0x09 },
  { name: 'skeleton', id: SKELETON, pos: POS_GROUND, sprite: [ 0x03, 0x05, 0x09 ] },
  { name: 'spear knight', id: SPEAR_KNIGHT, pos: POS_GROUND, sprite: 0x09 },
  { name: 'spider', id: SPIDER, pos: POS_AIR, sprite: [ 0x03, 0x09 ] },
  { name: 'swamp ghoul', id: SWAMP_GHOUL, pos: POS_GROUND, sprite: 0x05 },
  { name: 'werewolf', id: WEREWOLF, pos: POS_GROUND, sprite: 0x03 },
  { name: 'wolf', id: WOLF, pos: POS_GROUND, sprite: 0x03 },
  { name: 'zigzag bat', id: ZIGZAG_BAT, pos: POS_AIR, sprite: 0x03 },
  { name: 'zombie', id: ZOMBIE, pos: POS_GROUND, sprite: 0x01 }
];

enemies.forEach(({ name, id, pos }) => {
  const key = camelcase(name);
  enemy[id] = enemy[key] = function(x, y, data, pointer, opts = {}) {
    return Object.assign({ name, id, pos, x, y, data, pointer, enemy: true }, opts);
  };
  enemy[id].id = enemy[key].id = id;
  enemy[id].pos = enemy[key].pos = pos;
  enemy[id].name = enemy[key].name = name;
});

// enemy.bat = function() {
//   return enemy.call(null, ...arguments, BAT, 'bat', { pos: POS_AIR });
// };

// enemy.harpy = function() {
//   return enemy.call(null, ...arguments, HARPY, 'harpy', { pos: POS_AIR });
// };

// enemy.medusa = function() {
//   return enemy.call(null, ...arguments, MEDUSA, 'medusa', { pos: POS_AIR });
// };

// enemy.flower = function() {
//   return enemy.call(null, ...arguments, FLOWER, 'flower', { pos: POS_GROUND });
// };

// enemy.ghost = function() {
//   return enemy.call(null, ...arguments, GHOST, 'ghost', { pos: POS_AIR });
// };

// enemy.eagle = function() {
//   return enemy.call(null, ...arguments, EAGLE, 'eagle', { pos: POS_AIR });
// };

// enemy.mummy = function() {
//   return enemy.call(null, ...arguments, MUMMY, 'mummy', { pos: POS_GROUND });
// };

// enemy.mansionBat = function() {
//   return enemy.call(null, ...arguments, MANSION_BAT, 'mansion bat', { pos: POS_AIR });
// };

// enemy.blob = function() {
//   return enemy.call(null, ...arguments, BLOB, 'blob', { pos: POS_GROUND });
// };

// enemy.mansionBlob = function() {
//   return enemy.call(null, ...arguments, MANSION_BLOB, 'mansion blob', { pos: POS_GROUND });
// };

// enemy.boneDragon = function() {
//   return enemy.call(null, ...arguments, BONE_DRAGON, 'bone dragon', { pos: POS_GROUND });
// };

// enemy.boneThrower = function() {
//   return enemy.call(null, ...arguments, BONE_THROWER, 'bone thrower', { pos: POS_GROUND });
// };

enemy.camilla = function() {
  return enemy.call(null, ...arguments, CAMILLA, 'camilla', { pos: POS_AIR });
};

// enemy.deadHand = function() {
//   return enemy.call(null, ...arguments, DEAD_HAND, 'dead hand', { pos: POS_DEADHAND });
// };

enemy.death = function() {
  return enemy.call(null, ...arguments, DEATH, 'death', { pos: POS_AIR });
};

// enemy.eyeball = function() {
//   return enemy.call(null, ...arguments, EYEBALL, 'eyeball', { pos: POS_AIR });
// };

// enemy.fireGhoul = function() {
//   return enemy.call(null, ...arguments, FIRE_GHOUL, 'fire ghoul', { pos: POS_GROUND });
// };

// enemy.fishman = function() {
//   return enemy.call(null, ...arguments, FISHMAN, 'fishman', { pos: POS_BELOW });
// };

// enemy.floatingSkull = function() {
//   return enemy.call(null, ...arguments, FLOATING_SKULL, 'floating skull', { pos: POS_AIR });
// };

// enemy.gargoyle = function() {
//   return enemy.call(null, ...arguments, GARGOYLE, 'gargoyle', { pos: POS_GROUND });
// };

// enemy.grabber = function() {
//   return enemy.call(null, ...arguments, GRABBER, 'grabber', { pos: POS_GROUND });
// };

// enemy.highJumpLeech = function() {
//   return enemy.call(null, ...arguments, HIGH_JUMP_LEECH, 'high jump leech', { pos: POS_BELOW });
// };

// enemy.leech = function() {
//   return enemy.call(null, ...arguments, LEECH, 'leech', { pos: POS_BELOW });
// };

// enemy.lizardman = function() {
//   return enemy.call(null, ...arguments, LIZARDMAN, 'lizardman', { pos: POS_GROUND });
// };

// enemy.mudman = function() {
//   return enemy.call(null, ...arguments, MUDMAN, 'mudman', { pos: POS_GROUND });
// };

// enemy.rock = function() {
//   return enemy.call(null, ...arguments, ROCK, 'rock', { pos: POS_AIR });
// };

// enemy.skeleton = function() {
//   return enemy.call(null, ...arguments, SKELETON, 'skeleton', { pos: POS_GROUND });
// };

// enemy.spearKnight = function() {
//   return enemy.call(null, ...arguments, SPEAR_KNIGHT, 'spear knight', { pos: POS_GROUND });
// };

// enemy.spider = function() {
//   return enemy.call(null, ...arguments, SPIDER, 'spider', { pos: POS_AIR });
// };

// enemy.swampGhoul = function() {
//   return enemy.call(null, ...arguments, SWAMP_GHOUL, 'swamp ghoul', { pos: POS_GROUND });
// };

// enemy.werewolf = function() {
//   return enemy.call(null, ...arguments, WEREWOLF, 'werewolf', { pos: POS_GROUND });
// };

// enemy.wolf = function() {
//   return enemy.call(null, ...arguments, WOLF, 'wolf', { pos: POS_GROUND });
// };

// enemy.zigzagBat = function() {
//   return enemy.call(null, ...arguments, ZIGZAG_BAT, 'zigzag bat', { pos: POS_AIR });
// };

// enemy.zombie = function() {
//   return enemy.call(null, ...arguments, ZOMBIE, 'zombie', { pos: POS_GROUND });
// };