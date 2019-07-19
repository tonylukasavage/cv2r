module.exports = {
	name: 'Penalty Reduction',
	description: 'Cut hearts in half after game over',
	flags: '-g, --penalty-reduction',
	patch: [
		{ offset: 0x01C42B, value: "20 35 FF EA" },
		{ offset: 0x01FF45, value: "A5 48 29 0F 4A 48 A5 48 4A 29 F0 48 A5 48 29 10 F0 06 A9 05 85 48 10 04 A9 00 85 48 68 18 65 48 85 48 68 18 65 48 85 48 A5 49 29 01 F0 07 A9 50 18 65 48 85 48 A5 49 29 0F 4A 48 A5 49 4A 29 F0 48 A5 49 29 10 F0 06 A9 05 85 49 10 04 A9 00 85 49 68 18 65 49 85 49 68 18 65 49 85 49 60" }
	]
};
