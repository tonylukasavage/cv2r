LDA $6033
CMP #$FF
BNE LOW
INC $6032
LDA #$00
STA $6033
BEQ DONE
LOW INC $6033

DONE
LDA $03B4,X
RTS