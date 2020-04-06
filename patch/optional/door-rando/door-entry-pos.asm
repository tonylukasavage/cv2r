LDA *$30
BEQ TOWN

; mansion door
LDA $F7A6,Y
STA *$57
LDA #$00
STA *$54
STA *$56
BEQ DONE

; town door
TOWN
LDA #$00
STA *$53
STA *$54
STA *$56
STA *$57

DONE
LDA #$02
JSR $C183
JMP $9999

; 6D,E7 for town door
; D1,E7 for mansion door