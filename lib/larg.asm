LDA *$30
TAX
ASL

; load pointer to area from objset
LDA $5678,X
STA $D4
LDA $5679,X
STA $D5
STX #$0


; load pointer to submap from area
LDA *$50
TAX
ASL
LDA ($D4),X
