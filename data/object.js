const ORB = 0x25;
const BOOK = 0x27;
const SIGN = 0xA4;

const WOMAN = 0xA9;
const MAN = 0xAA;
const OLD_LADY = 0xAC;
const MERCHANT = 0xAE;
const PRIEST = 0xAD;
const CRYSTAL_DUDE = 0xAF;
const SHEPHERD = 0xB5;

const BAT = 0x01;
const SKELETON = 0x03;
const SPEAR_KNIGHT = 0x05;
const BONE_THROWER = 0x0D;
const SPIDER = 0x0E;
const GARGOYLE = 0x0F;
const MANSION_BAT = 0x11;
const ZOMBIE = 0x17;
const BLOB = 0x1F;

const CAMILLA = 0x42;
const DEATH = 0x42;
const DRACULA = 0x42;

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
  o.hp = arguments[2];
  return o;
};

const sign = exports.sign = function() {
  const o = obj.call(null, ...arguments, SIGN, 'sign');
  o.sign = true;
  return o;
};

const book = exports.book = function() {
  const o = obj.call(null, ...arguments, BOOK, 'book');
  o.book = true;
  return o;
};

const orb = exports.orb = function() {
  const o = obj.call(null, ...arguments, ORB, 'orb');
  o.orb = true;
  return o;
};

// define shorthand functions for all NPCs
npc.woman = function() {
  return npc.call(null, ...arguments, WOMAN, 'woman');
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

// crystal dude is a merchant in mansions
npc.crystalDude = function() {
  return npc.call(null, ...arguments, CRYSTAL_DUDE, 'crystal dude');
}

npc.shepherd = function() {
  return npc.call(null, ...arguments, SHEPHERD, 'shepherd');
}

// define shorthand functions for all enemies
enemy.bat = function() {
  return enemy.call(null, ...arguments, BAT, 'bat');
};

enemy.mansionBat = function() {
  return enemy.call(null, ...arguments, MANSION_BAT, 'mansion bat');
};

enemy.blob = function() {
  return enemy.call(null, ...arguments, BLOB, 'blob');
};

enemy.camilla = function() {
  return enemy.call(null, ...arguments, CAMILLA, 'camilla');
};

enemy.gargoyle = function() {
  return enemy.call(null, ...arguments, GARGOYLE, 'gargoyle');
};

enemy.skeleton = function() {
  return enemy.call(null, ...arguments, SKELETON, 'skeleton');
};

enemy.boneThrower = function() {
  return enemy.call(null, ...arguments, BONE_THROWER, 'bone thrower');
};

enemy.spearKnight = function() {
  return enemy.call(null, ...arguments, SPEAR_KNIGHT, 'spear knight');
};

enemy.spider = function() {
  return enemy.call(null, ...arguments, SPIDER, 'spider');
};

enemy.zombie = function() {
  return enemy.call(null, ...arguments, ZOMBIE, 'zombie');
};