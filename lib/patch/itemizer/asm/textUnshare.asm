PHP

LDA $600E
BNE NORMAL

JSR $<%= isChecked %>
LDA $600C
CMP #$01
BNE NORMAL
LDA #$<%= refuseLowByte %>
STA *$00
LDA #$<%= refuseHighByte %>
STA *$01
JMP $9999

NORMAL LDA *$7F

CMP #$2F
BNE L_TOP
LDA *$50
CMP #$0C
BNE G_ALBA
<%= garlicAljiba %>
JMP $9999
G_ALBA <%= garlicAlba %>
JMP $9999

L_TOP LDA *$7F
CMP #$30
BNE O_TOP
LDA *$50

CMP #$0E
BNE L_ALBA
<%= laurelsAljiba %>
JMP $9999

L_ALBA CMP #$10
BNE L_ONDO
<%= laurelsAlba %>
JMP $9999

L_ONDO CMP #$13
BNE L_DOIN
<%= laurelsOndol %>
JMP $9999

L_DOIN CMP #$15
BNE L_NONE
<%= laurelsDoina %>
L_NONE JMP $9999

O_TOP LDA *$7F
CMP #$1D
BEQ DO_OAK
JMP $9999
DO_OAK LDA *$50

CMP #$07
BNE O_HEAR
<%= oakRib %>
JMP $9999

O_HEAR CMP #$08
BNE O_EYE
<%= oakHeart %>
JMP $9999

O_EYE CMP #$09
BNE O_NAIL
<%= oakEye %>
JMP $9999

O_NAIL CMP #$0A
BNE O_RING
<%= oakNail %>
JMP $9999

O_RING CMP #$06
BNE F_DONE
<%= oakRing %>

F_DONE PLP

LDA ($00),Y
CMP #$FF
BNE GETOUT

PHP
LDA #$0
STA $600E
LDA ($00),Y
PLP

GETOUT RTS
