; inventory game state
LDA *$26
CMP #$01
BNE JWARP
; quest items selected in inventory
LDA *$33
BNE DONE
; b pressed
LDA *$F1
CMP #$40
BNE DONE
; deselect quest item
LDA #$00
STA *$4F
BEQ DONE

; select pause game state
JWARP CMP #$02
BNE DONE

; up+a+b pressed
LDA *$F1
CMP #$C8
BNE DONE

; unpause game
LDA #$00
STA *$26

; flag the jovah warp
LDA #$01
STA $600F

; setup warp sound
LDA #$2D
STA *$B4
LDA #$A5
STA *$BA
LDA #$85
STA *$C0
LDA #$01
STA *$C6
STA *$AE

; pop return address and reset flags
PLA
PLA
PLP

; redirect to jovah
LDA #$00
STA *$30
STA *$50
STA *$51
STA *$8E

; transition code
JMP $CF8C

DONE RTS