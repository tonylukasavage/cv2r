PHP
LDA #$01
CMP $600F
BNE NORM
; clear_objects
JSR $<%= clearObjects %>
PLP
RTS

NORM PLP
LDA $04EC
RTS