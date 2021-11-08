module.exports = {
        id: 'gameboy',
        name: 'gameboy',
        description: 'Burb\'s gameboy palette',
        patch: [
                // Set PPU_MASK to use grayscale mode with green tint. (01011111)
                // Default value: $1E / 00011110
                { offset: 0x01C0C0, bytes: '5F' },
                { offset: 0x01C6B6, bytes: '5F' },
        ]
};
