PHP
TXA
PHA
TYA
PHA

; are we on the last screen?
LDA $47A
CMP #$07
BNE DONE

; write stat names to screen
LDX #$00
NAME LDA $<%= statNames %>,X
STA $700,X
INX
CPX #$3C
BNE NAME
STX *$22

; setup deaths
LDA $6030
STA *$D2
LDA $6031
STA *$D1
JSR $<%= bcd16 %>

; load each character of stat value into PPU instructions
LDX #$05
LDY #$0E
; +14
LOOPCH
LDA *$D2,X
BEQ NEXTCH
CLC
ADC #$E0
STA $700,Y
NEXTCH
INY
DEX
BNE LOOPCH

DONE
PLA
TAY
PLA
TAX
PLP

; original code we replaced
LDA #$40
STA $47C

RTS