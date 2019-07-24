LDY #$01
LDA #$10
PHP
CPY $600F
BNE DONE

LDA #$00
; y_subpixel
STA $336
; simon_y_delta
STA $36C
; simon_?????
STA $37E
; simon_action
STA $3D8
; jump_flag
STA $446

; sets_FC_y_scroll
LDA #$2E
STA *$56

; sets_map_pos
LDA #$04
STA *$5C
LDA #$21
STA *$5D

; LDA_#$2E
; STA_*$8C

; accumulator_will_set_simon_x_pos
LDA #$8F
; simon_y_pos
STA $324
; select+up+a+b_flag
STA $600F

DONE PLP
RTS


; t3B_02
; t69_04
; t8C_3D
