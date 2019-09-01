module.exports = {
	rom: 0x6E22,
	code: `
LDA #$10
STA *$7F
LDA *$91
ORA #$02
STA *$91
`
};