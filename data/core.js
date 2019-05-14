const { book, enemy, npc, sign } = require('./object');

module.exports = [
    {
        name: 'Jovah',
        objset: 0,
        area: 0,
        submap: 0,
        pattern: {
            bg: 0,
            sprite: 0x01,
            pointer: 0x1CCF9
        },
        actors: [
            npc.shepherd(0x04, 0x0C, 0x38, 0x50BC),
            npc.shepherd(0x04, 0x1A, 0x3D, 0x50C0),
            npc.shepherd(0x08, 0x12, 0x3E, 0x50C4),
            sign(0x0C, 0x1A, 0x3A, 0x50C8),
            enemy.zombie(0x0C, 0x0C, 0x01, 0x50CC),
            npc.shepherd(0x14, 0x1A, 0x41, 0x50D0),
            enemy.zombie(0x14, 0x14, 0x01, 0x50D4),
            npc.man(0x18, 0x14, 0x44, 0x50D8),
            enemy.zombie(0x18, 0x0C, 0x01, 0x50DC),
            enemy.zombie(0x1C, 0x1A, 0x01, 0x50E0),
            npc.shepherd(0x24, 0x0C, 0x4C, 0x50E4),
            npc.man(0x28, 0x14, 0x4D, 0x50E8),
            npc.man(0x2C, 0x1A, 0x4E, 0x50EC),
            enemy.zombie(0x28, 0x14, 0x01, 0x50F0),
            enemy.zombie(0x2C, 0x0C, 0x01, 0x50F4),
            npc.merchant(0x34, 0x12, 0x07, 0x50F8),
            enemy.zombie(0x34, 0x12, 0x01, 0x50FC),
            enemy.zombie(0x38, 0x0C, 0x01, 0x5100)
        ]
    },
    {
        name: 'Veros',
        objset: 0,
        area: 0x01,
        submap: 0,
        actors: [
            npc.man(0x04, 0x0C, 0x40, 0x522A),
            enemy.bat(0x04, 0x08, 0x02, 0x522E),
            npc.man(0x0C, 0x0C, 0x43, 0x5232),
            sign(0x0D, 0x0C, 0x3B, 0x5036),
            npc.man(0x14, 0x0C, 0x48, 0x523A),
            npc.woman(0x1A, 0x0C, 0x4F, 0x523E),
            enemy.zombie(0x18, 0x0C, 0x02, 0x5242),
            npc.shepherd(0x1C, 0x0C, 0x50, 0x5246),
            npc.shepherd(0x24, 0x0C, 0x39, 0x524A),
            enemy.zombie(0x28, 0x0C, 0x02, 0x524E),
            enemy.zombie(0x2C, 0x0C, 0x02, 0x5252),
            enemy.zombie(0x34, 0x08, 0x02, 0x5256),
            enemy.bat(0x34, 0x0C, 0x02, 0x525A)
        ]
    },
    {
        name: 'Aljiba',
        objset: 0,
        area: 0x02,
        submap: 0,
        actors: [
            npc.crystalDude(0x08, 0x0C, 0x03, 0x517C),
            enemy.zombie(0x08, 0x0C, 0x02, 0x5180),
            npc.man(0x0C, 0x0C, 0x57, 0x5184),
            sign(0x0C, 0x1A, 0x51, 0x5188),
            enemy.zombie(0x14, 0x0C, 0x02, 0x518C),
            npc.woman(0x18, 0x0C, 0x58, 0x5190),
            npc.shepherd(0x1C, 0x0C, 0x5B, 0x5194),
            enemy.zombie(0x24, 0x1A, 0x05, 0x5198),
            npc.man(0x28, 0x1A, 0x60, 0x519C),
            enemy.zombie(0x2C, 0x0C, 0x02, 0x51A0),
            npc.shepherd(0x34, 0x0C, 0x69, 0x51A4),
            npc.man(0x34, 0x12, 0x67, 0x51A8),
            enemy.zombie(0x38, 0x0C, 0x02, 0x51AC)
        ]
    },
    {
        name: 'Alba',
        objset: 0,
        area: 0x03,
        submap: 0,
        actors: [
            npc.woman(0x08, 0x0C, 0x5F, 0x5105),
            npc.woman(0x08, 0x1A, 0x61, 0x5109),
            npc.woman(0x0C, 0x20, 0x62, 0x510D),
            sign(0x0C, 0x28, 0x52, 0x5111),
            enemy.zombie(0x0C, 0x0C, 0x04, 0x5115),
            npc.woman(0x14, 0x0C, 0x63, 0x5119),
            enemy.zombie(0x14, 0x0C, 0x04, 0x511D),
            enemy.zombie(0x14, 0x1A, 0x04, 0x5121),
            npc.woman(0x18, 0x1A, 0x66, 0x5125),
            enemy.zombie(0x1C, 0x28, 0x04, 0x5129),
            npc.woman(0x24, 0x0C, 0x5D, 0x512D),
            enemy.zombie(0x28, 0x1A, 0x04, 0x5131),
            npc.crystalDude(0x2C, 0x22, 0x04, 0x5135),
            enemy.zombie(0x2C, 0x0C, 0x04, 0x5139),
            enemy.zombie(0x2C, 0x22, 0x04, 0x513D),
            enemy.zombie(0x2C, 0x28, 0x04, 0x5141),
            enemy.zombie(0x34, 0x0C, 0x04, 0x5145),
            npc.woman(0x38, 0x0C, 0x68, 0x5149)
        ]
    },
    {
        name: 'Ondol',
        objset: 0,
        area: 0x04,
        submap: 0,
        actors: [
            npc.shepherd(0x08, 0x0C, 0x3F, 0x525F),
            sign(0x0C, 0x28, 0x3C, 0x5263),
            enemy.zombie(0x0C, 0x0C, 0x04, 0x5267),
            npc.man(0x14, 0x0C, 0x45, 0x526B),
            npc.man(0x14, 0x1A, 0x46, 0x526F),
            enemy.zombie(0x18, 0x0C, 0x04, 0x5273),
            enemy.zombie(0x18, 0x18, 0x04, 0x5277),
            enemy.zombie(0x1C, 0x28, 0x04, 0x527B),
            enemy.zombie(0x24, 0x0C, 0x04, 0x527F),
            enemy.zombie(0x24, 0x14, 0x04, 0x5283),
            npc.shepherd(0x28, 0x14, 0x47, 0x5287),
            npc.shepherd(0x28, 0x24, 0x4A, 0x528B),
            enemy.zombie(0x2C, 0x1A, 0x04, 0x528F),
            npc.shepherd(0x34, 0x0C, 0x4B, 0x5293),
            enemy.zombie(0x34, 0x12, 0x04, 0x5297),
            enemy.zombie(0x38, 0x0C, 0x04, 0x529B),
            enemy.zombie(0x38, 0x1A, 0x04, 0x529F)
        ]
    },
    {
        name: 'Doina',
        objset: 0,
        area: 0x05,
        submap: 0,
        actors: [
            npc.shepherd(0x04, 0x0C, 0x5E, 0x51B1),
            sign(0x0C, 0x0C, 0x53, 0x51B5),
            enemy.zombie(0x14, 0x0C, 0x08, 0x51B9),
            npc.shepherd(0x1C, 0x06, 0x65, 0x51BD),
            enemy.zombie(0x1C, 0x0C, 0x08, 0x51C1),
            enemy.zombie(0x24, 0x0C, 0x08, 0x51C5),
            npc.shepherd(0x28, 0x0C, 0x6A, 0x51C9),
            enemy.zombie(0x2C, 0x0C, 0x08, 0x51CD),
            enemy.zombie(0x34, 0x0C, 0x08, 0x51D1)
        ]
    },
    {
        name: 'Yomi',
        objset: 0,
        area: 0x06,
        submap: 0,
        actors: [
            sign(0x0C, 0x0C, 0x54, 0x51D6),
            enemy.bat(0x14, 0x0C, 0x08, 0x51DA),
            enemy.bat(0x18, 0x06, 0x08, 0x51DE),
            enemy.bat(0x24, 0x0C, 0x08, 0x51E2),
            enemy.bat(0x2C, 0x0C, 0x08, 0x51E6),
            enemy.bat(0x38, 0x0C, 0x08, 0x51EA)
        ]
    },
    {
        name: 'Church',
        objset: 0,
        area: 0x07,
        submap: 0,
        actors: [
            npc.priest(0x08, 0x08, 0x31, 0x4EED)
        ]
    },
    {
        name: 'Jovah - Thorn Whip Room',
        objset: 0,
        area: 0x08,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x08, 0x514E)
        ]
    },
    {
        name: 'Jovah - Holy Water Room',
        objset: 0,
        area: 0x09,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x03, 0x5153)
        ]
    },
    {
        name: 'Veros - Empty Room Before Dagger',
        objset: 0,
        area: 0x0A,
        submap: 0
    },
    {
        name: 'Veros - Dagger Room',
        objset: 0,
        area: 0x0A,
        submap: 0x01,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x04, 0x52A5)
        ]
    },
    {
        name: 'Veros - Chain Whip Room',
        objset: 0,
        area: 0x0B,
        submap: 0,
        actors: [
            npc.merchant(0x0A, 0x1A, 0x09, 0x52AA),
            book(0x0D, 0x17, 0x42, 0x52AE)
        ]
    },
    {
        name: 'Aljiba - Garlic Room',
        objset: 0,
        area: 0x0C,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x1A, 0x02, 0x51EF)
        ]
    },
    {
        name: 'Aljiba - Book Room Before Old Lady',
        objset: 0,
        area: 0x0D,
        submap: 0,
        actors: [
            book(0x03, 0x15, 0x5C, 0x51F4)
        ]
    },
    {
        name: 'Aljiba - Old Lady Room',
        objset: 0,
        area: 0x0D,
        submap: 0x01,
        actors: [
            npc.oldLady(0x0C, 0x1A, 0x59, 0x51F9)
        ]
    },
    {
        name: 'Aljiba - Empty Room Before Laurels',
        objset: 0,
        area: 0x0E,
        submap: 0
    },
    {
        name: 'Aljiba - Laurels Room',
        objset: 0,
        area: 0x0E,
        submap: 0x01,
        actors: [
            npc.merchant(0x0C, 0x1A, 0x00, 0x51FF)
        ]
    },
    {
        name: 'Alba - Empty Room Before Garlic',
        objset: 0,
        area: 0x0F,
        submap: 0
    },
    {
        name: 'Alba - Garlic Room',
        objset: 0,
        area: 0x0F,
        submap: 0x01,
        actors: [
            npc.merchant(0x0C, 0x1A, 0x02, 0x5159)
        ]
    },
    {
        name: 'Alba - Empty Room Before Laurels',
        objset: 0,
        area: 0x10,
        submap: 0
    },
    {
        name: 'Alba - Laurels Room',
        objset: 0,
        area: 0x10,
        submap: 0x01,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x00, 0x515F)
        ]
    },
    {
        name: 'Ondol - Empty Room Before Morning Star',
        objset: 0,
        area: 0x11,
        submap: 0
    },
    {
        name: 'Ondol - Morning Star Room',
        objset: 0,
        area: 0x11,
        submap: 0x01,
        actors: [
            npc.merchant(0x0C, 0x1A, 0x0A, 0x52B4)
        ]
    },
    {
        name: 'Ondol - Death Star Lady Room',
        objset: 0,
        area: 0x12,
        submap: 0,
        actors: [
            npc.oldLady(0x0C, 0x0C, 0x49, 0x52B9)
        ]
    },
    {
        name: 'Ondol - Empty Room',
        objset: 0,
        area: 0x13,
        submap: 0
    },
    {
        name: 'Doina - Get Back Lady Room',
        objset: 0,
        area: 0x14,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x64, 0x5204)
        ]
    },
    {
        name: 'Doina - Laurels Room',
        objset: 0,
        area: 0x15,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x1A, 0x00, 0x5209)
        ]
    },
    {
        name: 'Yomi - Empty Room',
        objset: 0,
        area: 0x16,
        submap: 0
    },
    {
        name: 'Yomi - Old Lady Room',
        objset: 0,
        area: 0x17,
        submap: 0,
        actors: [
            npc.merchant(0x0C, 0x0C, 0x5A, 0x520F)
        ]
    },
];