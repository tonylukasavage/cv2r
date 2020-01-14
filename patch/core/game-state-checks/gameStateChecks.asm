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

; flag warp
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

; diamond cross warp?
LDA *$90
CMP #$05
BNE DOJW
LDA #$03
STA $6007
LDA #$14
STA $6008
LDA #23
STA $6009
LDA #$C0
STA $600A
LDA #$02
STA *$30
STA *$51
LDA #$09
STA *$50
LDA #$00
STA $600B
STA *$8E
BEQ DOJUMP

; redirect to jovah
DOJW
LDA #$0D
STA $600B
LDA #$00
STA *$30
STA *$50
STA *$51
STA *$8E
STA $6007
STA $6008
STA $6009
LDA #$8F
STA $600A

; transition code
DOJUMP
JMP $CF8C

DONE RTS