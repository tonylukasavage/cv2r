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

; write stat values to screen
LDY #$00
LDX #$00
DOSTAT
LDA $6030,Y
STA *$D2
LDA $6031,Y
STA *$D1
JSR $<%= bcd16 %>
LDA $<%= statLoc %>,X
STA *$D0
JSR $<%= writeStats %>
INY
INY
INX
CMP #$03
BNE DOSTAT

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