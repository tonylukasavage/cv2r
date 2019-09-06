module.exports = {
	rom: 0x4C82,
	code: `
LDA #$0E
STA *$7F
LDA $0434
CMP #$03
NOP
NOP
INC $0434
LDA #$22
JSR $C118
LDA #$0E
NOP
NOP
`
};