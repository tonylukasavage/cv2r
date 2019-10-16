; Convert a 16 bit LE hex number to a 5 decimal number.
; 5 bytes are used to store the decimal numbers, lowest
; to highest.
; $D1 - 16-bit hex number (low byte)
; $D2 - 16-bit hex number (high byte)
; $D3-$D7 - 5 digit decimal number, stored lowest to highest.
;           Ex. 12345 stored as 05 04 03 02 01

; clear result values
LDA #$00
STA *$D3
STA *$D4
STA *$D5
STA *$D6
STA *$D7

; 16 bit hex to 5 digit decimal constants
LDA #$20
STA *$D0
LDX #$04
LDY #$0E

; all remaining code is black magic
LOOP
SEC
LDA *$D1
SBC $<%= bcdTableLow %>,Y
STA *$D3
LDA *$D2
SBC $<%= bcdTableHigh %>,Y
BCC TRIALL
STA *$D2
LDA *$D3
STA *$D1
TRIALL
ROL *$D0
DEY
BCC LOOP
LDA *$D0
STA *$D3,X
LDA #$10
STA *$D0
DEX
BNE LOOP
LDA *$D1
STA *$D3

RTS