; original code we replaced
STA $3BB
PHP

; set whip to thorn
LDA #$01
STA $434

; set level to 2
LDA #$02
STA *$8B

; set HP to 0x40 (64)
LDA #$40
STA *$81
CMP *$80
BCS DONE
STA *$80

DONE
PLP
RTS