module.exports = {
	rom: 0x6A4A,
	code: `
LDA #$12
STA *$7F
LDA *$4A
ORA #$08
STA *$4A
`
};
