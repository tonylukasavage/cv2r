LDA $6100
CMP #$01
BEQ DONE
PLA
PLA
JMP $E76B

DONE
LDA $F7A6,Y
RTS



LDA $6100
BEQ DONE
PLA
PLA
JMP $E7C9
DONE
LDA #$00
STA *$53
RTS




LDA *$30
BEQ TOWN
JSR $FBD2
STA simon_map_y_high = #$00
LDA #$00
STA simon_map_x_high = #$01
STA simon_map_y_low = #$AE

TOWN
07:E76B:20 E2 FE  JSR $FEE2
 07:E76E:EA        NOP
 07:E76F:85 54     STA simon_map_x_high = #$01
 07:E771:85 56     STA simon_map_y_low = #$AE
 07:E773:85 57     STA simon_map_y_high = #$00


PLA
CMP #$6D
BEQ TOWN



PLA
LDA *$30
BEQ TOWN


TOWN

; 6D,E7 for town door
; D1,E7 for mansion door