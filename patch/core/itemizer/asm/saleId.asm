LDA *$40
AND #$1F
STA *$93
ASL A
CLC
ADC *$93

PHP

; garlic
CMP #$6
BNE L_TOP
LDA *$50

; garlic_aljiba
CMP #$0C
BNE G_ALBA
LDA #$<%= garlicAljiba %>
JMP $9999

; garlic_alba
G_ALBA CMP #$0F
BNE G_DONE
LDA #$<%= garlicAlba %>
G_DONE JMP $9999

; laurel
L_TOP CMP #$00
BNE O_TOP
LDA *$50

; laurel_aljiba
CMP #$0E
BNE L_ALBA
LDA #$<%= laurelsAljiba %>
JMP $9999

; laurel_alba
L_ALBA CMP #$10
BNE L_ONDO
LDA #$<%= laurelsAlba %>
JMP $9999

; laurel_ondol
L_ONDO CMP #$13
BNE L_DOIN
LDA #$<%= laurelsOndol %>
JMP $9999

; laurel_doina
L_DOIN CMP #$15
BNE L_DONE
LDA #$<%= laurelsDoina %>
L_DONE JMP $9999

; oak
O_TOP CMP #$12
BNE O_DONE
LDA *$50

; oak_ring
CMP #$06
BNE O_RIB
LDA #$<%= oakRing %>
JMP $9999

; oak_rib
O_RIB CMP #$07
BNE O_HEAR
LDA #$<%= oakRib %>
JMP $9999

; oak_heart
O_HEAR CMP #$08
BNE O_EYE
LDA #$<%= oakHeart %>
JMP $9999

; oak_eye
O_EYE CMP #$09
BNE O_NAIL
LDA #$<%= oakEye %>
JMP $9999

; oak_nail
O_NAIL CMP #$0A
BNE O_DONE
LDA #$<%= oakNail %>
O_DONE JMP $9999

PLP
RTS