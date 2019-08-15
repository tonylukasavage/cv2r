const camelcase = require('camelcase');

const ORB = 0x25;
const SACRED_FLAME = 0x26;
const BOOK = 0x27;
const SIGN = 0xA4;

const SECRET_MERCHANT = 0x9E;
const WOMAN = 0xA9;
const MAN = 0xAA;
const OLD_LADY = 0xAC;
const PRIEST = 0xAD;
const MERCHANT = 0xAE;
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
const DEATH = 0x44;
const DRACULA = 0x47;

const POS_AIR = exports.POS_AIR = 1;
const POS_GROUND = exports.POS_GROUND = 2;
const POS_BELOW = exports.POS_BELOW = 3;
const POS_DEADHAND = exports.POS_DEADHAND = 4;

// define shorthand function for all fixtures (immobile actors)
const fixture = exports.fixture = {};

const fixtures = [
	{ name: 'book', id: BOOK },
	{ name: 'orb', id: ORB, bank: 1 },
	{ name: 'sacred flame', id: SACRED_FLAME, bank: 1 },
	{ name: 'sign', id: SIGN }
];

fixtures.forEach(({ name, id, bank }) => {
	const key = camelcase(name);
	fixture[id] = fixture[key] = function(x, y, data, pointer, opts = {}) {
		return Object.assign({ 
			name, 
			id, 
			x, 
			y, 
			data, 
			pointer, 
			fixture: true,
			holdsItem: [ ORB, SACRED_FLAME ].includes(id),
			bank
		}, opts);
	};
	fixture[id].id = fixture[key].id = id;
	fixture[id].name = fixture[key].name = name;
});


// define shorthand functions for all NPCs
const npc = exports.npc = {};

const npcs = [
	{ name: 'crystal dude', id: CRYSTAL_DUDE },
	{ name: 'ferry man', id: FERRY_MAN },
	{ name: 'man', id: MAN },
	{ name: 'merchant', id: MERCHANT, bank: 3 },
	{ name: 'old lady', id: OLD_LADY },
	{ name: 'priest', id: PRIEST },
	{ name: 'woman', id: WOMAN },
	{ name: 'secret merchant', id: SECRET_MERCHANT },
	{ name: 'shepherd', id: SHEPHERD }
];

npcs.forEach(({ name, id, bank }) => {
	const key = camelcase(name);
	npc[id] = npc[key] = function(x, y, data, pointer, opts = {}) {
		return Object.assign({ 
			name, 
			id, 
			x, 
			y, 
			data, 
			pointer, 
			npc: true,
			holdsItem: [ CRYSTAL_DUDE, MERCHANT, SECRET_MERCHANT ].includes(id),
			bank
		}, opts);
	};
	npc[id].id = npc[key].id = id;
	npc[id].name = npc[key].name = name;
});

// define shorthand functions for all enemies
const enemy = exports.enemy = {};

const enemies = [
	{ name: 'bat', id: BAT, pos: POS_AIR, sprite: 0x01 },
	{ name: 'blob', id: BLOB, pos: POS_GROUND, sprite: 0x05 },
	{ name: 'bone dragon', id: BONE_DRAGON, pos: POS_GROUND, sprite: 0x05 },
	{ name: 'bone thrower', id: BONE_THROWER, pos: POS_GROUND, sprite: 0x09 },
	{ name: 'Camilla', id: CAMILLA, pos: POS_AIR, sprite: 0x09, boss: true, holdsItem: true },
	{ name: 'dead hand', id: DEAD_HAND, pos: POS_DEADHAND, sprite: 0x05 },
	{ name: 'Death', id: DEATH, pos: POS_AIR, sprite: 0x09, boss: true, holdsItem: true },
	{ name: 'Dracula', id: DRACULA, pos: POS_AIR, sprite: 0x0C, boss: true },
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

enemies.forEach(({ name, id, pos, holdsItem = false }) => {
	const key = camelcase(name);
	enemy[id] = enemy[key] = function(x, y, data, pointer, opts = {}) {
		return Object.assign({ name, id, pos, holdsItem, x, y, data, pointer, enemy: true }, opts);
	};
	enemy[id].id = enemy[key].id = id;
	enemy[id].pos = enemy[key].pos = pos;
	enemy[id].name = enemy[key].name = name;
});

function asArray(o) {
	if (Array.isArray(o)) {
		return o;
	} else if (o == null) {
		return [];
	} else {
		return [ o ];
	}
}

exports.enemiesBySpritePattern = function(patternId, opts = {}) {
	return enemies.filter(e => {
		return asArray(e.sprite).includes(patternId)   // enemy belongs to the given pattern table
			&& (!e.boss || (e.boss && opts.boss))        // bosses are only included if explicitly defined
			&& !asArray(opts.exclude).includes(e.name);  // enemy has not been explicitly excluded
	});
};