LDA $6100
CMP #$FF
BEQ NORMAL

; store the original objset
STA *$30
LDA #$FF
STA $6100

; normal exit code
NORMAL
LDA *$4E
STA *$50
RTS
