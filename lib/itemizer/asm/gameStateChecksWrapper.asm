; original code we replaced
JSR $C88A

PHP

; store original bank
LDA *$1C
STA $600D

; bank swap
LDA #02
JSR $C183

; game state checks
JSR $<%= gameStateChecks %>

; swap to original bank
LDA $600D
JSR $C183

PLP
RTS
