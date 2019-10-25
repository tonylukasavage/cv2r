PHP
TAX
PHA

; set PPU_CONTROL to use 8x8 sprites
LDA $2000
AND #$DF
STA $FF

; add each seed icon as a sprite to OAM
LDX #$13
LOOP
LDA $<%= oamLoc %>,X
STA $200,X
DEX
BPL LOOP

PLA
TAX
PLP

; original code we replaced
LDA $C3BE,Y

RTS