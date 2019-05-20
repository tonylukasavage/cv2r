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
  const o = obj.apply(null, arguments);
  o.enemy = true;
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
enemy.bat = function() {
  return enemy.call(null, ...arguments, BAT, 'bat');
};

enemy.harpy = function() {
  return enemy.call(null, ...arguments, HARPY, 'harpy');
};

enemy.medusa = function() {
  return enemy.call(null, ...arguments, MEDUSA, 'medusa');
};

enemy.flower = function() {
  return enemy.call(null, ...arguments, FLOWER, 'flower');
};

enemy.ghost = function() {
  return enemy.call(null, ...arguments, GHOST, 'ghost');
};

enemy.eagle = function() {
  return enemy.call(null, ...arguments, EAGLE, 'eagle');
};

enemy.mummy = function() {
  return enemy.call(null, ...arguments, MUMMY, 'mummy');
};

enemy.mansionBat = function() {
  return enemy.call(null, ...arguments, MANSION_BAT, 'mansion bat');
};

enemy.blob = function() {
  return enemy.call(null, ...arguments, BLOB, 'blob');
};

enemy.mansionBlob = function() {
  return enemy.call(null, ...arguments, MANSION_BLOB, 'mansion blob');
};

enemy.boneDragon = function() {
  return enemy.call(null, ...arguments, BONE_DRAGON, 'bone dragon');
};

enemy.boneThrower = function() {
  return enemy.call(null, ...arguments, BONE_THROWER, 'bone thrower');
};

enemy.camilla = function() {
  return enemy.call(null, ...arguments, CAMILLA, 'camilla');
};

enemy.deadHand = function() {
  return enemy.call(null, ...arguments, DEAD_HAND, 'dead hand');
};

enemy.death = function() {
  return enemy.call(null, ...arguments, DEATH, 'death');
};

enemy.eyeball = function() {
  return enemy.call(null, ...arguments, EYEBALL, 'eyeball');
};

enemy.fireGhoul = function() {
  return enemy.call(null, ...arguments, FIRE_GHOUL, 'fire ghoul');
};

enemy.fishman = function() {
  return enemy.call(null, ...arguments, FISHMAN, 'fishman');
};

enemy.floatingSkull = function() {
  return enemy.call(null, ...arguments, FLOATING_SKULL, 'floating skull');
};

enemy.gargoyle = function() {
  return enemy.call(null, ...arguments, GARGOYLE, 'gargoyle');
};

enemy.grabber = function() {
  return enemy.call(null, ...arguments, GRABBER, 'grabber');
};

enemy.highJumpLeech = function() {
  return enemy.call(null, ...arguments, HIGH_JUMP_LEECH, 'high jump leech');
};

enemy.leech = function() {
  return enemy.call(null, ...arguments, LEECH, 'leech');
};

enemy.lizardman = function() {
  return enemy.call(null, ...arguments, LIZARDMAN, 'lizardman');
};

enemy.mudman = function() {
  return enemy.call(null, ...arguments, MUDMAN, 'mudman');
};

enemy.rock = function() {
  return enemy.call(null, ...arguments, ROCK, 'rock');
};

enemy.skeleton = function() {
  return enemy.call(null, ...arguments, SKELETON, 'skeleton');
};

enemy.spearKnight = function() {
  return enemy.call(null, ...arguments, SPEAR_KNIGHT, 'spear knight');
};

enemy.spider = function() {
  return enemy.call(null, ...arguments, SPIDER, 'spider');
};

enemy.swampGhoul = function() {
  return enemy.call(null, ...arguments, SWAMP_GHOUL, 'swamp ghoul');
};

enemy.werewolf = function() {
  return enemy.call(null, ...arguments, WEREWOLF, 'werewolf');
};

enemy.wolf = function() {
  return enemy.call(null, ...arguments, WOLF, 'wolf');
};

enemy.zigzagBat = function() {
  return enemy.call(null, ...arguments, ZIGZAG_BAT, 'zigzag bat');
};

enemy.zombie = function() {
  return enemy.call(null, ...arguments, ZOMBIE, 'zombie');
};