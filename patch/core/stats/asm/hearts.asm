PHP

LDA $6035
CLC
ADC *$08
BCC ONLYLO
INC $6034
ONLYLO
STA $6035

PLP
JSR $DEDE
RTS