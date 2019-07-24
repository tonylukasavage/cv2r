; orig_code
JSR $C88A

; select+up+a+b
PHP
LDA *$26
CMP #$2
BNE DONE
LDA *$F1
CMP #$C8
BNE DONE
LDA #$00
STA *$26
LDA #$01
STA $600F

; bank_swap
LDA #$02
JSR $C183

; prep_transition
PLP
LDA #$00
STA *$30
STA *$50
STA *$51

; transition_code
JMP $CF8C

DONE 
PLP
RTS
