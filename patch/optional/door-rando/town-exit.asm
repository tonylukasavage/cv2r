LDA $6100
CMP #$FF
BEQ NORMAL

; door rando code
STA *$30
LDA #$FF
STA $6100

; normal mansion exit code
NORMAL
LDA *$4E
STA *$50
RTS