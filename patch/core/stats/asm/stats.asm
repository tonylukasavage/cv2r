PHP
TXA
PHA

LDA $47A
CMP #$07
BNE DONE

LDX #$00
NAME LDA $<%= statNames %>,X
STA $700,X
INX
CPX #$1E
BNE NAME
STX *$22

; TODO: get stat values

DONE
PLA
PAX
PLP

; replaced code
LDA #$40
STA $47C

RTS