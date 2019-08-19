module.exports = {
	rom: 0x507F,
	code: `
LDA #$55
NOP
NOP
NOP
NOP
STA *$7F
LDA #$20
BIT *$91
BEQ DONE
BVS DONE
LDA *$91
AND #$9F
ORA #$40
STA *$91
DONE
`
};
