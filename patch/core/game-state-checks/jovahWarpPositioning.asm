LDY #$01
LDA #$10
PHP
CPY $600F
BNE DONE

LDA #$03
JSR $C185
JSR $<%= posFunc %>
LDA #$02
JSR $C185

; LDA #$00
; ; y_subpixel
; STA $336
; ; simon_y_delta
; STA $36C
; ; simon_?????
; STA $37E
; ; simon_action
; STA $3D8
; ; jump_flag
; STA $446

; ; sets_FC_y_scroll
; LDA $600B
; STA *$56

; ; LDA #$03
; ; STA *$54
; ; LDA #$14
; ; STA *$58
; ; LDA #$23
; ; STA *$59

; ; sets_map_pos
; LDA #$00
; STA *$5C
; LDA #$1D
; STA *$5D

; LDA #$8F
; ; simon_y_pos
; STA $324
; ; jovah_warp_flag
; STA $600F

; ; accumulator will set simon x pos ($348)
; LDA $600A

DONE PLP
RTS
