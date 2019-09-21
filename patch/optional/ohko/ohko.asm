; are we in a swamp?
LDA *$0C
CMP #$03
BNE OHKO
LDA *$8F
CMP #$41
BNE OHKO
LDA *$80
BNE DONE

; no swamp? Kill him!
OHKO
LDA #$00

DONE
SEC
RTS