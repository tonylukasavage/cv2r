; set menu screen position for fangs
LDA #$0A
JSR $F1BD

; check for fangs in inventory
LDA *$92
AND #$10
BEQ DONE

; execute PPU writing of fangs sprite
JSR $E394
LDA #$4D
JSR $EB9C

; increment menu screen position 2 bytes to the right (for silk bag)
DONE
LDA #$02
JSR $F1BD

RTS
