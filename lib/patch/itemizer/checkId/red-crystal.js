module.exports = {
	rom: 0x5098,
	code: `
LDA #$56
STA *$7F
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
LDA #$56
BNE DONE
DONE RTS
`
};