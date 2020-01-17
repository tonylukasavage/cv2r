LDY #$01
LDA #$10
PHP
CPY $600F
BNE DONE

LDA #$03
JSR $C183
JSR $<%= warpPositioning %>
LDA #$02
JSR $C183

; accumulator will set simon x pos ($348)
LDA $600A

DONE PLP
RTS
