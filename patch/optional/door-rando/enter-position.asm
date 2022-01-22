; pop stack pointer since we're jumping out
PLA
PLA

; check the new objset
LDA *$30
BEQ TOWN

; mansion music
<%= music %>


; mansion positioning
LDA *$50
SEC
SBC #$06
TAY
LDA $F7A6,Y
STA *$57
LDA #$00
STA *$54
STA *$56
JMP $E7DA

; town positioning
TOWN
LDA #$00
STA *$53
STA *$54
STA *$56
STA *$57
JMP $E775
