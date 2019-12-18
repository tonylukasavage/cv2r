const spritePatches = [
	{
		offset: 135217,
		bytes: [
			0,
			0
		]
	},
	{
		offset: 135224,
		bytes: [
			7,
			15,
			31,
			31
		]
	},
	{
		offset: 135250,
		bytes: [
			32,
			0
		]
	},
	{
		offset: 135256,
		bytes: [
			128,
			64,
			160,
			192,
			192
		]
	},
	{
		offset: 135344,
		bytes: [
			0,
			0,
			120
		]
	},
	{
		offset: 135352,
		bytes: [
			31,
			62,
			127,
			31
		]
	},
	{
		offset: 135377,
		bytes: [
			64
		]
	},
	{
		offset: 135384,
		bytes: [
			128,
			64
		]
	},
	{
		offset: 135473,
		bytes: [
			0,
			112
		]
	},
	{
		offset: 135480,
		bytes: [
			31,
			62,
			127,
			47
		]
	},
	{
		offset: 135506,
		bytes: [
			64
		]
	},
	{
		offset: 135513,
		bytes: [
			128,
			64
		]
	},
	{
		offset: 135761,
		bytes: [
			0,
			60
		]
	},
	{
		offset: 135768,
		bytes: [
			15,
			31,
			63,
			27
		]
	},
	{
		offset: 135794,
		bytes: [
			16
		]
	},
	{
		offset: 135800,
		bytes: [
			192,
			32,
			144,
			128
		]
	},
	{
		offset: 135889,
		bytes: [
			0,
			1
		]
	},
	{
		offset: 135896,
		bytes: [
			60,
			122,
			253,
			254
		]
	},
	{
		offset: 135985,
		bytes: [
			0,
			28
		]
	},
	{
		offset: 135992,
		bytes: [
			15,
			31,
			31,
			11
		]
	},
	{
		offset: 136018,
		bytes: [
			32,
			0
		]
	},
	{
		offset: 136024,
		bytes: [
			128,
			64,
			160,
			192,
			192
		]
	},
	{
		offset: 136144,
		bytes: [
			8
		]
	},
	{
		offset: 136147,
		bytes: [
			8,
			12,
			15,
			30,
			60,
			8,
			16,
			32,
			104,
			248,
			248,
			243,
			231,
			124,
			125
		]
	},
	{
		offset: 136168,
		bytes: [
			199,
			210
		]
	},
	{
		offset: 136226,
		bytes: [
			31,
			95,
			31,
			24,
			25,
			30
		]
	},
	{
		offset: 136234,
		bytes: [
			48,
			114,
			119,
			119,
			246,
			240
		]
	}
];

// 0x21010 - 0x2C010 every 0x2000 bytes
// 1 3 5 7 9 A C

const offsets = [ 0, 0x2000, 0x4000, 0x6000, 0x8000, 0x9000, 0xB000, 0x17000 ];
const finalSpritePatch = [];
for (let i = 0; i < offsets.length; i++) {
	spritePatches.forEach(sp => {
		finalSpritePatch.push({
			offset: sp.offset + offsets[i],
			bytes: sp.bytes.slice(0)
		});
	});
}

module.exports = {
	id: 'simon-claus',
	name: 'Simon Claus',
	description: '',
	patch: finalSpritePatch
};