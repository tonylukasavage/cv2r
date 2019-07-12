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
L_TOP NOP
; L_TOP_CMP_#$0F
; BNE_DONE

; oak

PLP
RTS