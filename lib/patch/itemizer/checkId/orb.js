module.exports = {
	rom: 0x47A4,
	code: `
LDA $04C2,X
STA *$7F
LDA $8632,Y
ORA *$91
STA *$91
LDA #$22
JSR $C118
LDA #$80
STA *$3F
`
};