;-------------------------------------------------------------------------------
; cv2.nes disasembled by DISASM6 v1.5
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; iNES Header
;-------------------------------------------------------------------------------
            .db "NES", $1A     ; Header
            .db 8              ; 8 x 16k PRG banks
            .db 16             ; 16 x 8k CHR banks
            .db %00010000      ; Mirroring: Horizontal
                               ; SRAM: Not used
                               ; 512k Trainer: Not used
                               ; 4 Screen VRAM: Not used
                               ; Mapper: 1
            .db %00000000      ; RomType: NES
            .hex 00 00 00 00   ; iNES Tail 
            .hex 00 00 00 00    

;-------------------------------------------------------------------------------
; Program Origin
;-------------------------------------------------------------------------------
            .org $8000         ; Set program counter

;-------------------------------------------------------------------------------
; ROM Start
;-------------------------------------------------------------------------------
            sbc #$31           ; $8000: e9 31     
            cld                ; $8002: d8        
            bvs __8022         ; $8003: 70 1d     
            brk                ; $8005: 00        
            .hex e4            ; $8006: e4        Suspected data
__8007:     eor $b0            ; $8007: 45 b0     
            .hex e3 40         ; $8009: e3 40     Invalid Opcode - ISC ($40,x)
            .hex 37 e4         ; $800b: 37 e4     Invalid Opcode - RLA $e4,x
            adc $e3,x          ; $800d: 75 e3     
__800f:     jsr __8770         ; $800f: 20 70 87  
            cpx $92            ; $8012: e4 92     
            .hex e3 42         ; $8014: e3 42     Invalid Opcode - ISC ($42,x)
            sta ($e4),y        ; $8016: 91 e4     
__8018:     ldx #$e3           ; $8018: a2 e3     
            .hex 62            ; $801a: 62        Invalid Opcode - KIL 
            lda ($d8,x)        ; $801b: a1 d8     
            .hex 7b 83 15      ; $801d: 7b 83 15  Invalid Opcode - RRA $1583,y
            beq __8007         ; $8020: f0 e5     
__8022:     .hex b0 b0         ; $8022: b0 b0     Illegal Branch - BCS #$b0
            sbc ($e7),y        ; $8024: f1 e7     
            .hex 1c e4 b0      ; $8026: 1c e4 b0  Invalid Opcode - NOP __b0e4,x
            .hex e3 60         ; $8029: e3 60     Invalid Opcode - ISC ($60,x)
            bcs __800f         ; $802b: b0 e2     
            bmi __808f         ; $802d: 30 60     
            .hex b0            ; $802f: b0        Suspected data
__8030:     .hex e7 1e         ; $8030: e7 1e     Invalid Opcode - ISC $1e
            beq __8018         ; $8032: f0 e4     
__8034:     .hex b0 90         ; $8034: b0 90     Illegal Branch - BCS #$90
            bvs __8098         ; $8036: 70 60     
            rti                ; $8038: 40        

;-------------------------------------------------------------------------------
            bmi __807b         ; $8039: 30 40     
            rts                ; $803b: 60        

;-------------------------------------------------------------------------------
            .hex fe ff 00      ; $803c: fe ff 00  Bad Addr Mode - INC $00ff,x
            .hex 80 eb         ; $803f: 80 eb     Invalid Opcode - NOP #$eb
            .hex 22            ; $8041: 22        Invalid Opcode - KIL 
__8042:     asl                ; $8042: 0a        
            sbc #$b1           ; $8043: e9 b1     
            cld                ; $8045: d8        
__8046:     bvs __8064         ; $8046: 70 1c     
            .hex 15            ; $8048: 15        Suspected data
__8049:     .hex f5            ; $8049: f5        Suspected data
__804a:     .hex e2 70         ; $804a: e2 70     Invalid Opcode - NOP #$70
            .hex f4 40         ; $804c: f4 40     Invalid Opcode - NOP $40,x
            .hex f3 e3         ; $804e: f3 e3     Invalid Opcode - ISC ($e3),y
__8050:     bcs __8034         ; $8050: b0 e2     
            bvs __8046         ; $8052: 70 f2     
            rti                ; $8054: 40        

;-------------------------------------------------------------------------------
__8055:     .hex e3            ; $8055: e3        Suspected data
__8056:     bcs __8049         ; $8056: b0 f1     
            .hex e2 70         ; $8058: e2 70     Invalid Opcode - NOP #$70
            rti                ; $805a: 40        

;-------------------------------------------------------------------------------
            sbc $60,x          ; $805b: f5 60     
            .hex f4 30         ; $805d: f4 30     Invalid Opcode - NOP $30,x
            .hex f3            ; $805f: f3        Suspected data
__8060:     .hex e3 90         ; $8060: e3 90     Invalid Opcode - ISC ($90,x)
__8062:     .hex e2            ; $8062: e2        Suspected data
__8063:     rts                ; $8063: 60        

;-------------------------------------------------------------------------------
__8064:     .hex f2            ; $8064: f2        Invalid Opcode - KIL 
            bmi __804a         ; $8065: 30 e3     
            .hex 90            ; $8067: 90        Suspected data
__8068:     sbc ($e2),y        ; $8068: f1 e2     
__806a:     rts                ; $806a: 60        

;-------------------------------------------------------------------------------
            bmi __8062         ; $806b: 30 f5     
            bvs __8063         ; $806d: 70 f4     
            jsr __e3f3         ; $806f: 20 f3 e3  
            bcs __8056         ; $8072: b0 e2     
            bvs __8068         ; $8074: 70 f2     
            jsr __b0e3         ; $8076: 20 e3 b0  
            sbc ($e2),y        ; $8079: f1 e2     
__807b:     bvs __809d         ; $807b: 70 20     
__807d:     sbc $80,x          ; $807d: f5 80     
            .hex f4 20         ; $807f: f4 20     Invalid Opcode - NOP $20,x
            .hex f3 e3         ; $8081: f3 e3     Invalid Opcode - ISC ($e3),y
            .hex 80 e2         ; $8083: 80 e2     Invalid Opcode - NOP #$e2
__8085:     .hex 80 f2         ; $8085: 80 f2     Invalid Opcode - NOP #$f2
            .hex 20            ; $8087: 20        Suspected data
__8088:     .hex e3 80         ; $8088: e3 80     Invalid Opcode - ISC ($80,x)
            sbc ($e2),y        ; $808a: f1 e2     
            .hex 80 20         ; $808c: 80 20     Invalid Opcode - NOP #$20
            .hex f5            ; $808e: f5        Suspected data
__808f:     bcc __8085         ; $808f: 90 f4     
            rti                ; $8091: 40        

;-------------------------------------------------------------------------------
            .hex f3 00         ; $8092: f3 00     Invalid Opcode - ISC ($00),y
            bcc __8088         ; $8094: 90 f2     
__8096:     rti                ; $8096: 40        

;-------------------------------------------------------------------------------
__8097:     brk                ; $8097: 00        
__8098:     .hex f1            ; $8098: f1        Suspected data
__8099:     bcc __80db         ; $8099: 90 40     
            sbc $a0,x          ; $809b: f5 a0     
__809d:     .hex f4 60         ; $809d: f4 60     Invalid Opcode - NOP $60,x
            .hex f3            ; $809f: f3        Suspected data
__80a0:     bpl __8042         ; $80a0: 10 a0     
            .hex f2            ; $80a2: f2        Invalid Opcode - KIL 
            rts                ; $80a3: 60        

;-------------------------------------------------------------------------------
            bpl __8097         ; $80a4: 10 f1     
            ldy #$60           ; $80a6: a0 60     
            sbc #$32           ; $80a8: e9 32     
__80aa:     .hex eb 01         ; $80aa: eb 01     Invalid Opcode - SBC #$01
            brk                ; $80ac: 00        
            cpx $60            ; $80ad: e4 60     
__80af:     rts                ; $80af: 60        

;-------------------------------------------------------------------------------
            sbc ($e4),y        ; $80b0: f1 e4     
            bcs __8097         ; $80b2: b0 e3     
__80b4:     rts                ; $80b4: 60        

;-------------------------------------------------------------------------------
            bcs __8099         ; $80b5: b0 e2     
            bmi __8119         ; $80b7: 30 60     
            .hex b0            ; $80b9: b0        Suspected data
__80ba:     .hex e7 1e         ; $80ba: e7 1e     Invalid Opcode - ISC $1e
            .hex f0            ; $80bc: f0        Suspected data
__80bd:     .hex e3 b0         ; $80bd: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex 90            ; $80bf: 90        Suspected data
__80c0:     bvs __8122         ; $80c0: 70 60     
            rti                ; $80c2: 40        

;-------------------------------------------------------------------------------
            .hex 30            ; $80c3: 30        Suspected data
__80c4:     rti                ; $80c4: 40        

;-------------------------------------------------------------------------------
            rts                ; $80c5: 60        

;-------------------------------------------------------------------------------
__80c6:     inc $40ff,x        ; $80c6: fe ff 40  
            .hex 80 fb         ; $80c9: 80 fb     Invalid Opcode - NOP #$fb
            cld                ; $80cb: d8        
            .hex 20 e4         ; $80cc: 20 e4     Suspected data
__80ce:     eor $b0            ; $80ce: 45 b0     
            .hex e3            ; $80d0: e3        Suspected data
__80d1:     rti                ; $80d1: 40        

;-------------------------------------------------------------------------------
            .hex 37 e4         ; $80d2: 37 e4     Invalid Opcode - RLA $e4,x
__80d4:     adc $e3,x          ; $80d4: 75 e3     
            .hex 20            ; $80d6: 20        Suspected data
__80d7:     bvs __8060         ; $80d7: 70 87     
__80d9:     .hex e4            ; $80d9: e4        Suspected data
__80da:     .hex 92            ; $80da: 92        Invalid Opcode - KIL 
__80db:     .hex e3 42         ; $80db: e3 42     Invalid Opcode - ISC ($42,x)
            sta ($e4),y        ; $80dd: 91 e4     
            .hex a2            ; $80df: a2        Suspected data
__80e0:     .hex e3 62         ; $80e0: e3 62     Invalid Opcode - ISC ($62,x)
            lda ($e4,x)        ; $80e2: a1 e4     
            bcs __8096         ; $80e4: b0 b0     
            .hex c3 d1         ; $80e6: c3 d1     Invalid Opcode - DCP ($d1,x)
            bcc __80ce         ; $80e8: 90 e4     
            rti                ; $80ea: 40        

;-------------------------------------------------------------------------------
            bvs __807d         ; $80eb: 70 90     
            .hex e3 b1         ; $80ed: e3 b1     Invalid Opcode - ISC ($b1,x)
            bcc __8161         ; $80ef: 90 70     
            rti                ; $80f1: 40        

;-------------------------------------------------------------------------------
            and ($12,x)        ; $80f2: 21 12     
            .hex 02            ; $80f4: 02        Invalid Opcode - KIL 
            cld                ; $80f5: d8        
            jsr __b0e4         ; $80f6: 20 e4 b0  
            bcc __816b         ; $80f9: 90 70     
            rts                ; $80fb: 60        

;-------------------------------------------------------------------------------
            rti                ; $80fc: 40        

;-------------------------------------------------------------------------------
            bmi __813f         ; $80fd: 30 40     
            rts                ; $80ff: 60        

;-------------------------------------------------------------------------------
            inc __caff,x       ; $8100: fe ff ca  
            .hex 80 fb         ; $8103: 80 fb     Invalid Opcode - NOP #$fb
            cld                ; $8105: d8        
            lda ($a1),y        ; $8106: b1 a1     
            bcs __80ba         ; $8108: b0 b0     
            ldy #$b1           ; $810a: a0 b1     
            bcs __80af         ; $810c: b0 a1     
            bcs __80c0         ; $810e: b0 b0     
            ldy #$b0           ; $8110: a0 b0     
            lda ($a1),y        ; $8112: b1 a1     
            bcs __80c6         ; $8114: b0 b0     
            ldy #$b1           ; $8116: a0 b1     
            .hex b0            ; $8118: b0        Suspected data
__8119:     lda ($b0,x)        ; $8119: a1 b0     
            bcs __80bd         ; $811b: b0 a0     
            ldy #$b1           ; $811d: a0 b1     
            ldy #$b0           ; $811f: a0 b0     
            .hex b0            ; $8121: b0        Suspected data
__8122:     bcs __80c4         ; $8122: b0 a0     
            bcs __80d7         ; $8124: b0 b1     
            ldy #$b0           ; $8126: a0 b0     
            bcs __80da         ; $8128: b0 b0     
            ldy #$b0           ; $812a: a0 b0     
            ldy #$a3           ; $812c: a0 a3     
            bcs __80d1         ; $812e: b0 a1     
            lda ($a1),y        ; $8130: b1 a1     
            bcs __80d4         ; $8132: b0 a0     
            ldy #$a0           ; $8134: a0 a0     
            inc $04ff,x        ; $8136: fe ff 04  
            sta ($04,x)        ; $8139: 81 04     
            sei                ; $813b: 78        
            .hex 82 04         ; $813c: 82 04     Invalid Opcode - NOP #$04
            txa                ; $813e: 8a        
__813f:     .hex 82 04         ; $813f: 82 04     Invalid Opcode - NOP #$04
            .hex 97 82         ; $8141: 97 82     Invalid Opcode - SAX $82,y
            .hex 04 90         ; $8143: 04 90     Invalid Opcode - NOP $90
            .hex 82 03         ; $8145: 82 03     Invalid Opcode - NOP #$03
            stx $84            ; $8147: 86 84     
            .hex 04 a1         ; $8149: 04 a1     Invalid Opcode - NOP $a1
            .hex 82 04         ; $814b: 82 04     Invalid Opcode - NOP #$04
            ldy $0482,x        ; $814d: bc 82 04  
            .hex c2 82         ; $8150: c2 82     Invalid Opcode - NOP #$82
            .hex 04 cc         ; $8152: 04 cc     Invalid Opcode - NOP $cc
            .hex 82 04         ; $8154: 82 04     Invalid Opcode - NOP #$04
            dec $82,x          ; $8156: d6 82     
            .hex 03 e2         ; $8158: 03 e2     Invalid Opcode - SLO ($e2,x)
            .hex 82 03         ; $815a: 82 03     Invalid Opcode - NOP #$03
            beq __80e0         ; $815c: f0 82     
            .hex 03 01         ; $815e: 03 01     Invalid Opcode - SLO ($01,x)
            .hex 83            ; $8160: 83        Suspected data
__8161:     .hex 04 1b         ; $8161: 04 1b     Invalid Opcode - NOP $1b
            .hex 83 43         ; $8163: 83 43     Invalid Opcode - SAX ($43,x)
            rol $0483          ; $8165: 2e 83 04  
__8168:     .hex 42            ; $8168: 42        Invalid Opcode - KIL 
            .hex 83 04         ; $8169: 83 04     Invalid Opcode - SAX ($04,x)
__816b:     .hex 4b 83         ; $816b: 4b 83     Invalid Opcode - ALR #$83
            .hex 03 50         ; $816d: 03 50     Invalid Opcode - SLO ($50,x)
            .hex 83 03         ; $816f: 83 03     Invalid Opcode - SAX ($03,x)
            .hex 63 83         ; $8171: 63 83     Invalid Opcode - RRA ($83,x)
            .hex 03 7f         ; $8173: 03 7f     Invalid Opcode - SLO ($7f,x)
            .hex 83 04         ; $8175: 83 04     Invalid Opcode - SAX ($04,x)
            sta $4383,x        ; $8177: 9d 83 43  
            .hex 03 87         ; $817a: 03 87     Invalid Opcode - SLO ($87,x)
            .hex 04 25         ; $817c: 04 25     Invalid Opcode - NOP $25
            .hex 87 43         ; $817e: 87 43     Invalid Opcode - SAX $43
            .hex af 83 04      ; $8180: af 83 04  Invalid Opcode - LAX $0483
__8183:     .hex cd 83         ; $8183: cd 83     Suspected data
__8185:     .hex 43 d3         ; $8185: 43 d3     Invalid Opcode - SRE ($d3,x)
__8187:     .hex 83            ; $8187: 83        Suspected data
__8188:     .hex 04 e5         ; $8188: 04 e5     Invalid Opcode - NOP $e5
            .hex 83 04         ; $818a: 83 04     Invalid Opcode - SAX ($04,x)
            .hex f4            ; $818c: f4        Suspected data
__818d:     .hex 83 04         ; $818d: 83 04     Invalid Opcode - SAX ($04,x)
            brk                ; $818f: 00        
            sty $03            ; $8190: 84 03     
__8192:     .hex 10            ; $8192: 10        Suspected data
__8193:     sty $03            ; $8193: 84 03     
            jsr $0384          ; $8195: 20 84 03  
            .hex 2f 84 03      ; $8198: 2f 84 03  Invalid Opcode - RLA $0384
            .hex 42            ; $819b: 42        Invalid Opcode - KIL 
            sty $03            ; $819c: 84 03     
            .hex 6b 84         ; $819e: 6b 84     Invalid Opcode - ARR #$84
            .hex 03 94         ; $81a0: 03 94     Invalid Opcode - SLO ($94,x)
            sty $03            ; $81a2: 84 03     
            ldy $84            ; $81a4: a4 84     
            .hex 03 af         ; $81a6: 03 af     Invalid Opcode - SLO ($af,x)
            sty $03            ; $81a8: 84 03     
            .hex df 84 03      ; $81aa: df 84 03  Invalid Opcode - DCP $0384,x
            .hex c7 84         ; $81ad: c7 84     Invalid Opcode - DCP $84
            .hex 04 f0         ; $81af: 04 f0     Invalid Opcode - NOP $f0
            sty $43            ; $81b1: 84 43     
            and $0485,y        ; $81b3: 39 85 04  
            eor ($85),y        ; $81b6: 51 85     
            .hex 43            ; $81b8: 43        Suspected data
__81b9:     .hex 6f 85 04      ; $81b9: 6f 85 04  Invalid Opcode - RRA $0485
            .hex 87 85         ; $81bc: 87 85     Invalid Opcode - SAX $85
            .hex 43 a5         ; $81be: 43 a5     Invalid Opcode - SRE ($a5,x)
            sta $01            ; $81c0: 85 01     
            .hex c3 85         ; $81c2: c3 85     Invalid Opcode - DCP ($85,x)
            .hex 43 cc         ; $81c4: 43 cc     Invalid Opcode - SRE ($cc,x)
            .hex 85            ; $81c6: 85        Suspected data
__81c7:     ora ($04,x)        ; $81c7: 01 04     
            stx $03            ; $81c9: 86 03     
            .hex 0d 86         ; $81cb: 0d 86     Suspected data
__81cd:     .hex 43 17         ; $81cd: 43 17     Invalid Opcode - SRE ($17,x)
            stx $04            ; $81cf: 86 04     
            .hex 3b 86 43      ; $81d1: 3b 86 43  Invalid Opcode - RLA $4386,y
            .hex 5b 86 01      ; $81d4: 5b 86 01  Invalid Opcode - SRE $0186,y
            cmp $4386          ; $81d7: cd 86 43  
            .hex e2 86         ; $81da: e2 86     Invalid Opcode - NOP #$86
            ora ($f0,x)        ; $81dc: 01 f0     
            stx $03            ; $81de: 86 03     
            dec $86,x          ; $81e0: d6 86     
            cmp ($16,x)        ; $81e2: c1 16     
            stx $1000          ; $81e4: 8e 00 10  
            .hex 8f 02 77      ; $81e7: 8f 02 77  Invalid Opcode - SAX $7702
            bcc __81f1         ; $81ea: 90 05     
            .hex 6b 91         ; $81ec: 6b 91     Invalid Opcode - ARR #$91
__81ee:     .hex c1            ; $81ee: c1        Suspected data
__81ef:     asl                ; $81ef: 0a        
            .hex 92            ; $81f0: 92        Invalid Opcode - KIL 
__81f1:     brk                ; $81f1: 00        
            php                ; $81f2: 08        
            .hex 93 02         ; $81f3: 93 02     Invalid Opcode - AHX ($02),y
            cpx #$94           ; $81f5: e0 94     
            ora $e0            ; $81f7: 05 e0     
            sta $c1,x          ; $81f9: 95 c1     
            .hex d2            ; $81fb: d2        Invalid Opcode - KIL 
            .hex a7 00         ; $81fc: a7 00     Invalid Opcode - LAX $00
            lda $02a8,y        ; $81fe: b9 a8 02  
            cpy $05a9          ; $8201: cc a9 05  
            .hex 7b aa c1      ; $8204: 7b aa c1  Invalid Opcode - RRA __c1aa,y
            .hex ec a3 00      ; $8207: ec a3 00  Bad Addr Mode - CPX $00a3
            .hex 1d a5         ; $820a: 1d a5     Suspected data
__820c:     .hex 02            ; $820c: 02        Invalid Opcode - KIL 
            sta $05a6          ; $820d: 8d a6 05  
            bvc __81b9         ; $8210: 50 a7     
            cmp ($81,x)        ; $8212: c1 81     
            ldy #$00           ; $8214: a0 00     
            eor $02a1,x        ; $8216: 5d a1 02  
            and $05a2          ; $8219: 2d a2 05  
            adc __c1a2         ; $821c: 6d a2 c1  
            brk                ; $821f: 00        
            .hex 80 00         ; $8220: 80 00     Invalid Opcode - NOP #$00
            rti                ; $8222: 40        

;-------------------------------------------------------------------------------
            .hex 80 02         ; $8223: 80 02     Invalid Opcode - NOP #$02
            dex                ; $8225: ca        
            .hex 80 05         ; $8226: 80 05     Invalid Opcode - NOP #$05
            .hex 04 81         ; $8228: 04 81     Invalid Opcode - NOP $81
            cmp ($9f,x)        ; $822a: c1 9f     
            .hex 9f 00 fc      ; $822c: 9f 00 fc  Invalid Opcode - AHX __fc00,y
            .hex 9f 02 63      ; $822f: 9f 02 63  Invalid Opcode - AHX $6302,y
            ldy #$05           ; $8232: a0 05     
__8234:     ror __c1a0,x       ; $8234: 7e a0 c1  
            lda ($9e,x)        ; $8237: a1 9e     
__8239:     brk                ; $8239: 00        
            .hex 03 9f         ; $823a: 03 9f     Invalid Opcode - SLO ($9f,x)
            .hex 02            ; $823c: 02        Invalid Opcode - KIL 
            lsr                ; $823d: 4a        
            .hex 9f 05 7f      ; $823e: 9f 05 7f  Invalid Opcode - AHX $7f05,y
            .hex 9f c1 33      ; $8241: 9f c1 33  Invalid Opcode - AHX $33c1,y
            .hex 87            ; $8244: 87        Suspected data
__8245:     brk                ; $8245: 00        
            ora $0288,y        ; $8246: 19 88 02  
            .hex 74 89         ; $8249: 74 89     Invalid Opcode - NOP $89,x
            ora $fb            ; $824b: 05 fb     
            txa                ; $824d: 8a        
            asl $c4            ; $824e: 06 c4     
            .hex fb 06 c8      ; $8250: fb 06 c8  Invalid Opcode - ISC __c806,y
            .hex fb 06 cc      ; $8253: fb 06 cc  Invalid Opcode - ISC __cc06,y
            .hex fb 03 5a      ; $8256: fb 03 5a  Invalid Opcode - ISC $5a03,y
            .hex 82 05         ; $8259: 82 05     Invalid Opcode - NOP #$05
            .hex 82 88         ; $825b: 82 88     Invalid Opcode - NOP #$88
            bpl __8234         ; $825d: 10 d5     
            bpl __81ef         ; $825f: 10 8e     
            bpl __820c         ; $8261: 10 a9     
            .hex 02            ; $8263: 02        Invalid Opcode - KIL 
            bcs __81ee         ; $8264: b0 88     
            cpx #$6a           ; $8266: e0 6a     
            bne __82d4         ; $8268: d0 6a     
            bcs __82d6         ; $826a: b0 6a     
            ldy #$6a           ; $826c: a0 6a     
            bcc __82da         ; $826e: 90 6a     
            bvs __82dc         ; $8270: 70 6a     
            bvc __82de         ; $8272: 50 6a     
            rti                ; $8274: 40        

;-------------------------------------------------------------------------------
            ror                ; $8275: 6a        
            .hex ff            ; $8276: ff        Suspected data
__8277:     brk                ; $8277: 00        
            ora ($a2,x)        ; $8278: 01 a2     
            lda ($71,x)        ; $827a: a1 71     
__827c:     adc ($61,x)        ; $827c: 61 61     
            bvc __82d1         ; $827e: 50 51     
            bvc __82d3         ; $8280: 50 51     
            bvc __82c5         ; $8282: 50 41     
            bmi __82a6         ; $8284: 30 20     
            jsr $1006          ; $8286: 20 06 10  
            .hex ff 01 65      ; $8289: ff 01 65  Invalid Opcode - ISC $6501,x
            bit $31            ; $828c: 24 31     
            ora ($ff),y        ; $828e: 11 ff     
            ora ($77,x)        ; $8290: 01 77     
            lsr $35,x          ; $8292: 56 35     
            bit $14            ; $8294: 24 14     
            .hex ff 01 ee      ; $8296: ff 01 ee  Invalid Opcode - ISC __ee01,x
            stx $34            ; $8299: 86 34     
            .hex 43 34         ; $829b: 43 34     Invalid Opcode - SRE ($34,x)
            .hex 13 12         ; $829d: 13 12     Invalid Opcode - SLO ($12),y
            .hex 10            ; $829f: 10        Suspected data
__82a0:     .hex ff 02 fb      ; $82a0: ff 02 fb  Invalid Opcode - ISC __fb02,x
            brk                ; $82a3: 00        
            .hex fe ad         ; $82a4: fe ad     Suspected data
__82a6:     .hex cf fe 08      ; $82a6: cf fe 08  Invalid Opcode - DCP $08fe
            inc __bf9d         ; $82a9: ee 9d bf  
            dec __af8d,x       ; $82ac: de 8d af  
            dec __9f7d         ; $82af: ce 7d 9f  
            ldx __8f6d,y       ; $82b2: be 6d 8f  
            ldx $7f5d          ; $82b5: ae 5d 7f  
            .hex 9e 4d 6f      ; $82b8: 9e 4d 6f  Invalid Opcode - SHX $6f4d,y
            .hex ff 01 db      ; $82bb: ff 01 db  Invalid Opcode - ISC __db01,x
            .hex 02            ; $82be: 02        Invalid Opcode - KIL 
            bpl __8245         ; $82bf: 10 84     
            .hex ff 01 6a      ; $82c1: ff 01 6a  Invalid Opcode - ISC $6a01,x
            .hex ab            ; $82c4: ab        Suspected data
__82c5:     jmp (__abbd)       ; $82c5: 6c bd ab  

;-------------------------------------------------------------------------------
            txa                ; $82c8: 8a        
            adc #$49           ; $82c9: 69 49     
            .hex ff 02 56      ; $82cb: ff 02 56  Invalid Opcode - ISC $5602,x
            txa                ; $82ce: 8a        
            .hex 8d 00         ; $82cf: 8d 00     Suspected data
__82d1:     .hex ec bd         ; $82d1: ec bd     Suspected data
__82d3:     .hex 8c            ; $82d3: 8c        Suspected data
__82d4:     .hex 5d ff         ; $82d4: 5d ff     Suspected data
__82d6:     ora ($31,x)        ; $82d6: 01 31     
            cli                ; $82d8: 58        
            .hex 71            ; $82d9: 71        Suspected data
__82da:     tya                ; $82da: 98        
            .hex 11            ; $82db: 11        Suspected data
__82dc:     .hex d6            ; $82dc: d6        Suspected data
__82dd:     .hex c3            ; $82dd: c3        Suspected data
__82de:     ldx $83            ; $82de: a6 83     
            .hex 66            ; $82e0: 66        Suspected data
__82e1:     .hex ff 05 70      ; $82e1: ff 05 70  Invalid Opcode - ISC $7005,x
            .hex 82 40         ; $82e4: 82 40     Invalid Opcode - NOP #$40
            rts                ; $82e6: 60        

;-------------------------------------------------------------------------------
            .hex 02            ; $82e7: 02        Invalid Opcode - KIL 
            .hex 70            ; $82e8: 70        Suspected data
__82e9:     .hex 82 03         ; $82e9: 82 03     Invalid Opcode - NOP #$03
            bcs __8277         ; $82eb: b0 8a     
            .hex 81            ; $82ed: 81        Suspected data
__82ee:     rti                ; $82ee: 40        

;-------------------------------------------------------------------------------
            .hex ff 04 f0      ; $82ef: ff 04 f0  Invalid Opcode - ISC __f004,x
            .hex 82 c2         ; $82f2: 82 c2     Invalid Opcode - NOP #$c2
            .hex 80 a1         ; $82f4: 80 a1     Invalid Opcode - NOP #$a1
            ldy #$04           ; $82f6: a0 04     
            bvs __827c         ; $82f8: 70 82     
            .hex 82 80         ; $82fa: 82 80     Invalid Opcode - NOP #$80
            .hex 62            ; $82fc: 62        Invalid Opcode - KIL 
            cpy #$43           ; $82fd: c0 43     
            brk                ; $82ff: 00        
            .hex ff 04 b0      ; $8300: ff 04 b0  Invalid Opcode - ISC __b004,x
            .hex 8b 47         ; $8303: 8b 47     Invalid Opcode - XAA #$47
            brk                ; $8305: 00        
            .hex 63            ; $8306: 63        Suspected data
__8307:     brk                ; $8307: 00        
            .hex 83 00         ; $8308: 83 00     Invalid Opcode - SAX ($00,x)
            .hex a3 00         ; $830a: a3 00     Invalid Opcode - LAX ($00,x)
            ror $c0            ; $830c: 66 c0     
            .hex 82            ; $830e: 82        Suspected data
__830f:     cpy #$a2           ; $830f: c0 a2     
            cpy #$c2           ; $8311: c0 c2     
            .hex c0            ; $8313: c0        Suspected data
__8314:     .hex 92            ; $8314: 92        Invalid Opcode - KIL 
            .hex 80 62         ; $8315: 80 62     Invalid Opcode - NOP #$62
            .hex 80 32         ; $8317: 80 32     Invalid Opcode - NOP #$32
            .hex 80 ff         ; $8319: 80 ff     Invalid Opcode - NOP #$ff
            .hex 02            ; $831b: 02        Invalid Opcode - KIL 
            bmi __837b         ; $831c: 30 5d     
            .hex 7c 9b 01      ; $831e: 7c 9b 01  Invalid Opcode - NOP $019b,x
            bmi __82dd         ; $8321: 30 ba     
            brk                ; $8323: 00        
            cmp __ba00,y       ; $8324: d9 00 ba  
            brk                ; $8327: 00        
            .hex 9b            ; $8328: 9b        Invalid Opcode - TAS 
            brk                ; $8329: 00        
            .hex 7c 00 5d      ; $832a: 7c 00 5d  Invalid Opcode - NOP $5d00,x
            .hex ff 03 70      ; $832d: ff 03 70  Invalid Opcode - ISC $7003,x
            .hex 8b 43         ; $8330: 8b 43     Invalid Opcode - XAA #$43
            .hex 80 73         ; $8332: 80 73     Invalid Opcode - NOP #$73
            rts                ; $8334: 60        

;-------------------------------------------------------------------------------
            .hex a3 40         ; $8335: a3 40     Invalid Opcode - LAX ($40,x)
            .hex c3 20         ; $8337: c3 20     Invalid Opcode - DCP ($20,x)
            .hex 93 00         ; $8339: 93 00     Invalid Opcode - AHX ($00),y
            .hex 72            ; $833b: 72        Invalid Opcode - KIL 
            cpx #$62           ; $833c: e0 62     
            cpy #$42           ; $833e: c0 42     
            cpy #$ff           ; $8340: c0 ff     
            .hex 03            ; $8342: 03        Suspected data
__8343:     .hex 4f 6e 8d      ; $8343: 4f 6e 8d  Invalid Opcode - SRE __8d6e
            lda $6d8d          ; $8346: ad 8d 6d  
            eor $01ff          ; $8349: 4d ff 01  
            cli                ; $834c: 58        
__834d:     dey                ; $834d: 88        
            tay                ; $834e: a8        
            .hex ff 04 70      ; $834f: ff 04 70  Invalid Opcode - ISC $7004,x
            .hex 89 10         ; $8352: 89 10     Invalid Opcode - NOP #$10
            bvc __8358         ; $8354: 50 02     
            bvs __82e1         ; $8356: 70 89     
__8358:     cpy #$a0           ; $8358: c0 a0     
            ldy #$50           ; $835a: a0 50     
            .hex 80 a0         ; $835c: 80 a0     Invalid Opcode - NOP #$a0
            rts                ; $835e: 60        

;-------------------------------------------------------------------------------
            bvc __83a1         ; $835f: 50 40     
            ldy #$ff           ; $8361: a0 ff     
            .hex 02            ; $8363: 02        Invalid Opcode - KIL 
            beq __82ee         ; $8364: f0 88     
            cpy #$40           ; $8366: c0 40     
            cpy #$30           ; $8368: c0 30     
            cpy #$40           ; $836a: c0 40     
            cpy #$28           ; $836c: c0 28     
            ldy #$40           ; $836e: a0 40     
            ldy #$28           ; $8370: a0 28     
            .hex 80 40         ; $8372: 80 40     Invalid Opcode - NOP #$40
            .hex 80 28         ; $8374: 80 28     Invalid Opcode - NOP #$28
            rts                ; $8376: 60        

;-------------------------------------------------------------------------------
            rti                ; $8377: 40        

;-------------------------------------------------------------------------------
            rts                ; $8378: 60        

;-------------------------------------------------------------------------------
            plp                ; $8379: 28        
            rti                ; $837a: 40        

;-------------------------------------------------------------------------------
__837b:     rti                ; $837b: 40        

;-------------------------------------------------------------------------------
            rti                ; $837c: 40        

;-------------------------------------------------------------------------------
            plp                ; $837d: 28        
            .hex ff 01 b0      ; $837e: ff 01 b0  Invalid Opcode - ISC __b001,x
            dey                ; $8381: 88        
            .hex fb c0 40      ; $8382: fb c0 40  Invalid Opcode - ISC $40c0,y
            bvc __8307         ; $8385: 50 80     
            inc $0102,x        ; $8387: fe 02 01  
            beq __8314         ; $838a: f0 88     
            cpy #$80           ; $838c: c0 80     
            .hex 80 30         ; $838e: 80 30     Invalid Opcode - NOP #$30
            .hex 80 80         ; $8390: 80 80     Invalid Opcode - NOP #$80
            bvs __83c4         ; $8392: 70 30     
__8394:     ldy #$80           ; $8394: a0 80     
            rts                ; $8396: 60        

;-------------------------------------------------------------------------------
            bmi __83d9         ; $8397: 30 40     
            .hex 80 30         ; $8399: 80 30     Invalid Opcode - NOP #$30
            .hex 30            ; $839b: 30        Suspected data
__839c:     .hex ff 02 ad      ; $839c: ff 02 ad  Invalid Opcode - ISC __ad02,x
            .hex 8e 10         ; $839f: 8e 10     Suspected data
__83a1:     bpl __83ad         ; $83a1: 10 0a     
            cmp __cdcd         ; $83a3: cd cd cd  
            cmp __8f04         ; $83a6: cd 04 8f  
            ror $3e4e          ; $83a9: 6e 4e 3e  
            .hex 2e            ; $83ac: 2e        Suspected data
__83ad:     .hex 1e            ; $83ad: 1e        Suspected data
__83ae:     .hex ff 01 f0      ; $83ae: ff 01 f0  Invalid Opcode - ISC __f001,x
            sta ($fb),y        ; $83b1: 91 fb     
__83b3:     bcs __83f5         ; $83b3: b0 40     
            bcs __8417         ; $83b5: b0 60     
            inc $0302,x        ; $83b7: fe 02 03  
            bcs __834d         ; $83ba: b0 91     
            bcs __83ee         ; $83bc: b0 30     
            bcs __8420         ; $83be: b0 60     
            bvs __83f4         ; $83c0: 70 32     
            bvs __8426         ; $83c2: 70 62     
__83c4:     .hex 30            ; $83c4: 30        Suspected data
__83c5:     .hex 34 30         ; $83c5: 34 30     Invalid Opcode - NOP $30,x
            .hex 64 20         ; $83c7: 64 20     Invalid Opcode - NOP $20
            rol $20,x          ; $83c9: 36 20     
            ror $ff            ; $83cb: 66 ff     
__83cd:     ora ($cc,x)        ; $83cd: 01 cc     
            tsx                ; $83cf: ba        
            tay                ; $83d0: a8        
            stx $ff,y          ; $83d1: 96 ff     
            .hex 04            ; $83d3: 04        Suspected data
__83d4:     bcs __8358         ; $83d4: b0 82     
            sbc ($c0,x)        ; $83d6: e1 c0     
            .hex e1            ; $83d8: e1        Suspected data
__83d9:     .hex 80 e1         ; $83d9: 80 e1     Invalid Opcode - NOP #$e1
            rti                ; $83db: 40        

;-------------------------------------------------------------------------------
            cmp ($00,x)        ; $83dc: c1 00     
            ldy #$c0           ; $83de: a0 c0     
            .hex 80 c0         ; $83e0: 80 c0     Invalid Opcode - NOP #$c0
            rts                ; $83e2: 60        

;-------------------------------------------------------------------------------
            .hex c0            ; $83e3: c0        Suspected data
__83e4:     .hex ff 02 6e      ; $83e4: ff 02 6e  Invalid Opcode - ISC $6e02,x
            .hex 5c 4a 38      ; $83e7: 5c 4a 38  Invalid Opcode - NOP $384a,x
            rol $4c,x          ; $83ea: 36 4c     
            lsr                ; $83ec: 4a        
            sec                ; $83ed: 38        
__83ee:     rol $2c,x          ; $83ee: 36 2c     
            rol                ; $83f0: 2a        
            plp                ; $83f1: 28        
            .hex 26            ; $83f2: 26        Suspected data
__83f3:     .hex ff            ; $83f3: ff        Suspected data
__83f4:     .hex 01            ; $83f4: 01        Suspected data
__83f5:     .hex fb 56 a7      ; $83f5: fb 56 a7  Invalid Opcode - ISC __a756,y
            and $86,x          ; $83f8: 35 86     
            .hex 32            ; $83fa: 32        Invalid Opcode - KIL 
            .hex 64 fe         ; $83fb: 64 fe     Invalid Opcode - NOP $fe
            .hex 02            ; $83fd: 02        Invalid Opcode - KIL 
            .hex 53 ff         ; $83fe: 53 ff     Invalid Opcode - SRE ($ff),y
            .hex 03 fa         ; $8400: 03 fa     Invalid Opcode - SLO ($fa,x)
            .hex 8b 10         ; $8402: 8b 10     Invalid Opcode - XAA #$10
            .hex 82 f8         ; $8404: 82 f8     Invalid Opcode - NOP #$f8
            cmp $94,x          ; $8406: d5 94     
            sta $74            ; $8408: 85 74     
            ldx #$82           ; $840a: a2 82     
            .hex 72            ; $840c: 72        Invalid Opcode - KIL 
            .hex 52            ; $840d: 52        Invalid Opcode - KIL 
            and ($ff),y        ; $840e: 31 ff     
            .hex 04            ; $8410: 04        Suspected data
__8411:     beq __8394         ; $8411: f0 81     
            sbc ($00),y        ; $8413: f1 00     
            cpx #$80           ; $8415: e0 80     
__8417:     cpy #$a0           ; $8417: c0 a0     
            ldy #$b0           ; $8419: a0 b0     
            .hex 80 c0         ; $841b: 80 c0     Invalid Opcode - NOP #$c0
            rts                ; $841d: 60        

;-------------------------------------------------------------------------------
            .hex d0            ; $841e: d0        Suspected data
__841f:     .hex ff            ; $841f: ff        Suspected data
__8420:     asl                ; $8420: 0a        
            bcs __83c5         ; $8421: b0 a2     
            ldy #$56           ; $8423: a0 56     
            .hex 05            ; $8425: 05        Suspected data
__8426:     bcs __83b3         ; $8426: b0 8b     
            ldy #$80           ; $8428: a0 80     
            rts                ; $842a: 60        

;-------------------------------------------------------------------------------
            .hex 80 30         ; $842b: 80 30     Invalid Opcode - NOP #$30
            .hex 80 ff         ; $842d: 80 ff     Invalid Opcode - NOP #$ff
            .hex 0b b0         ; $842f: 0b b0     Invalid Opcode - ANC #$b0
            .hex ab a1         ; $8431: ab a1     Invalid Opcode - LAX #$a1
            rti                ; $8433: 40        

;-------------------------------------------------------------------------------
            lda ($00,x)        ; $8434: a1 00     
            php                ; $8436: 08        
            bvs __83e4         ; $8437: 70 ab     
            ldy #$c0           ; $8439: a0 c0     
            .hex 80 c0         ; $843b: 80 c0     Invalid Opcode - NOP #$c0
            rts                ; $843d: 60        

;-------------------------------------------------------------------------------
            cpy #$40           ; $843e: c0 40     
            cpy #$ff           ; $8440: c0 ff     
            .hex 02            ; $8442: 02        Invalid Opcode - KIL 
            beq __83cd         ; $8443: f0 88     
            bpl __8447         ; $8445: 10 00     
__8447:     asl $f0            ; $8447: 06 f0     
            .hex 82 f0         ; $8449: 82 f0     Invalid Opcode - NOP #$f0
            .hex 80 f1         ; $844b: 80 f1     Invalid Opcode - NOP #$f1
            brk                ; $844d: 00        
            cpx #$80           ; $844e: e0 80     
            sbc ($00,x)        ; $8450: e1 00     
            bne __83d4         ; $8452: d0 80     
            cmp ($00),y        ; $8454: d1 00     
            cpy #$80           ; $8456: c0 80     
            cmp ($00,x)        ; $8458: c1 00     
            ldy #$80           ; $845a: a0 80     
            lda ($00,x)        ; $845c: a1 00     
            .hex 80 80         ; $845e: 80 80     Invalid Opcode - NOP #$80
            sta ($00,x)        ; $8460: 81 00     
            rts                ; $8462: 60        

;-------------------------------------------------------------------------------
            .hex 80 61         ; $8463: 80 61     Invalid Opcode - NOP #$61
            brk                ; $8465: 00        
            rti                ; $8466: 40        

;-------------------------------------------------------------------------------
            .hex 80 41         ; $8467: 80 41     Invalid Opcode - NOP #$41
            brk                ; $8469: 00        
            .hex ff 07 b0      ; $846a: ff 07 b0  Invalid Opcode - ISC __b007,x
            .hex 8b 31         ; $846d: 8b 31     Invalid Opcode - XAA #$31
            cpy #$51           ; $846f: c0 51     
            .hex 80 71         ; $8471: 80 71     Invalid Opcode - NOP #$71
            rti                ; $8473: 40        

;-------------------------------------------------------------------------------
            sta ($00),y        ; $8474: 91 00     
            .hex 07 b0         ; $8476: 07 b0     Invalid Opcode - SLO $b0
            txs                ; $8478: 9a        
            cpy #$e0           ; $8479: c0 e0     
            ldy #$e0           ; $847b: a0 e0     
            .hex 80 e0         ; $847d: 80 e0     Invalid Opcode - NOP #$e0
            rts                ; $847f: 60        

;-------------------------------------------------------------------------------
            cpx #$40           ; $8480: e0 40     
            cpx #$20           ; $8482: e0 20     
            cpx #$ff           ; $8484: e0 ff     
            .hex 02            ; $8486: 02        Invalid Opcode - KIL 
            bcs __8411         ; $8487: b0 88     
            .hex fb 80 c0      ; $8489: fb 80 c0  Invalid Opcode - ISC __c080,y
__848c:     .hex 02            ; $848c: 02        Invalid Opcode - KIL 
            bmi __8417         ; $848d: 30 88     
            bvs __84f1         ; $848f: 70 60     
            inc __ff02,x       ; $8491: fe 02 ff  
            .hex 03 b0         ; $8494: 03 b0     Invalid Opcode - SLO ($b0,x)
            .hex 8b 50         ; $8496: 8b 50     Invalid Opcode - XAA #$50
            cli                ; $8498: 58        
            .hex 80 48         ; $8499: 80 48     Invalid Opcode - NOP #$48
            bcs __84d9         ; $849b: b0 3c     
            .hex 80 28         ; $849d: 80 28     Invalid Opcode - NOP #$28
            bvc __84c9         ; $849f: 50 28     
            bmi __84cb         ; $84a1: 30 28     
            .hex ff 01 30      ; $84a3: ff 01 30  Invalid Opcode - ISC $3001,x
            dey                ; $84a6: 88        
            .hex fb a2 00      ; $84a7: fb a2 00  Invalid Opcode - ISC $00a2,y
            .hex e2 40         ; $84aa: e2 40     Invalid Opcode - NOP #$40
            inc __ff08,x       ; $84ac: fe 08 ff  
            .hex 04 70         ; $84af: 04 70     Invalid Opcode - NOP $70
            sty $24c0          ; $84b1: 8c c0 24  
            cpy #$40           ; $84b4: c0 40     
__84b6:     ldy #$24           ; $84b6: a0 24     
            ldy #$40           ; $84b8: a0 40     
            .hex 80 24         ; $84ba: 80 24     Invalid Opcode - NOP #$24
            .hex 80 40         ; $84bc: 80 40     Invalid Opcode - NOP #$40
            rts                ; $84be: 60        

;-------------------------------------------------------------------------------
            bit $60            ; $84bf: 24 60     
            rti                ; $84c1: 40        

;-------------------------------------------------------------------------------
            rti                ; $84c2: 40        

;-------------------------------------------------------------------------------
            bit $20            ; $84c3: 24 20     
            rti                ; $84c5: 40        

;-------------------------------------------------------------------------------
            .hex ff 0f b0      ; $84c6: ff 0f b0  Invalid Opcode - ISC __b00f,x
__84c9:     .hex b2            ; $84c9: b2        Invalid Opcode - KIL 
            rti                ; $84ca: 40        

;-------------------------------------------------------------------------------
__84cb:     rts                ; $84cb: 60        

;-------------------------------------------------------------------------------
            rts                ; $84cc: 60        

;-------------------------------------------------------------------------------
            rts                ; $84cd: 60        

;-------------------------------------------------------------------------------
            .hex 80 60         ; $84ce: 80 60     Invalid Opcode - NOP #$60
            ldy #$60           ; $84d0: a0 60     
            cpy #$60           ; $84d2: c0 60     
            ldy #$60           ; $84d4: a0 60     
            .hex 80 60         ; $84d6: 80 60     Invalid Opcode - NOP #$60
            rts                ; $84d8: 60        

;-------------------------------------------------------------------------------
__84d9:     rts                ; $84d9: 60        

;-------------------------------------------------------------------------------
            rti                ; $84da: 40        

;-------------------------------------------------------------------------------
            rts                ; $84db: 60        

;-------------------------------------------------------------------------------
            jsr __ff60         ; $84dc: 20 60 ff  
            php                ; $84df: 08        
            bcs __848c         ; $84e0: b0 aa     
            ldy #$70           ; $84e2: a0 70     
            asl $70            ; $84e4: 06 70     
            tax                ; $84e6: aa        
            .hex 80 70         ; $84e7: 80 70     Invalid Opcode - NOP #$70
            rts                ; $84e9: 60        

;-------------------------------------------------------------------------------
            bvs __852c         ; $84ea: 70 40     
            bvs __850e         ; $84ec: 70 20     
            .hex 70            ; $84ee: 70        Suspected data
__84ef:     .hex ff 02         ; $84ef: ff 02     Suspected data
__84f1:     .hex fb dd dd      ; $84f1: fb dd dd  Invalid Opcode - ISC __dddd,y
            .hex dc d8 fe      ; $84f4: dc d8 fe  Invalid Opcode - NOP __fed8,x
            .hex 07 fb         ; $84f7: 07 fb     Invalid Opcode - SLO $fb
            cpx __ebec         ; $84f9: ec ec eb  
            nop                ; $84fc: ea        
            inc __fb05,x       ; $84fd: fe 05 fb  
            brk                ; $8500: 00        
            .hex fb 00 fb      ; $8501: fb 00 fb  Invalid Opcode - ISC __fb00,y
            .hex fa            ; $8504: fa        Invalid Opcode - NOP 
            sbc $06fe,y        ; $8505: f9 fe 06  
            .hex fb fa fa      ; $8508: fb fa fa  Invalid Opcode - ISC __fafa,y
            sbc __fef8,y       ; $850b: f9 f8 fe  
__850e:     .hex 07 fb         ; $850e: 07 fb     Invalid Opcode - SLO $fb
            .hex da            ; $8510: da        Invalid Opcode - NOP 
            .hex da            ; $8511: da        Invalid Opcode - NOP 
            cmp __fed8,y       ; $8512: d9 d8 fe  
            ora #$fb           ; $8515: 09 fb     
            tsx                ; $8517: ba        
            tsx                ; $8518: ba        
            lda __feb8,y       ; $8519: b9 b8 fe  
            ora #$fb           ; $851c: 09 fb     
            txs                ; $851e: 9a        
            txs                ; $851f: 9a        
            sta __fe98,y       ; $8520: 99 98 fe  
            ora #$fb           ; $8523: 09 fb     
            .hex 7a            ; $8525: 7a        Invalid Opcode - NOP 
            .hex 7a            ; $8526: 7a        Invalid Opcode - NOP 
            adc __fe78,y       ; $8527: 79 78 fe  
            ora #$fb           ; $852a: 09 fb     
__852c:     .hex 5a            ; $852c: 5a        Invalid Opcode - NOP 
            .hex 5a            ; $852d: 5a        Invalid Opcode - NOP 
            eor __fe58,y       ; $852e: 59 58 fe  
            ora #$fb           ; $8531: 09 fb     
            .hex 3a            ; $8533: 3a        Invalid Opcode - NOP 
            .hex 3a            ; $8534: 3a        Invalid Opcode - NOP 
            and __fe39,y       ; $8535: 39 39 fe  
            .hex ff 0f b0      ; $8538: ff 0f b0  Invalid Opcode - ISC __b00f,x
            .hex ab 34         ; $853b: ab 34     Invalid Opcode - LAX #$34
            brk                ; $853d: 00        
            .hex 54 00         ; $853e: 54 00     Invalid Opcode - NOP $00,x
            .hex 74 00         ; $8540: 74 00     Invalid Opcode - NOP $00,x
            .hex 94            ; $8542: 94        Suspected data
__8543:     brk                ; $8543: 00        
            ldy $00,x          ; $8544: b4 00     
            .hex 93 e0         ; $8546: 93 e0     Invalid Opcode - AHX ($e0),y
            .hex 73 c0         ; $8548: 73 c0     Invalid Opcode - RRA ($c0),y
            .hex 53 a0         ; $854a: 53 a0     Invalid Opcode - SRE ($a0),y
            .hex 33 80         ; $854c: 33 80     Invalid Opcode - RLA ($80),y
            .hex 13 60         ; $854e: 13 60     Invalid Opcode - SLO ($60),y
__8550:     .hex ff 05 29      ; $8550: ff 05 29  Invalid Opcode - ISC $2905,x
            sec                ; $8553: 38        
            eor #$58           ; $8554: 49 58     
            adc #$78           ; $8556: 69 78     
            .hex 89            ; $8558: 89        Suspected data
__8559:     tya                ; $8559: 98        
            lda #$b8           ; $855a: a9 b8     
            cmp #$d8           ; $855c: c9 d8     
            sbc #$d8           ; $855e: e9 d8     
            .hex c9            ; $8560: c9        Suspected data
__8561:     clv                ; $8561: b8        
            lda #$98           ; $8562: a9 98     
            .hex 89 78         ; $8564: 89 78     Invalid Opcode - NOP #$78
            adc #$58           ; $8566: 69 58     
            .hex 49            ; $8568: 49        Suspected data
__8569:     sec                ; $8569: 38        
            and #$28           ; $856a: 29 28     
            ora __ff18,y       ; $856c: 19 18 ff  
            .hex 0f b0         ; $856f: 0f b0     Suspected data
__8571:     .hex ab 34         ; $8571: ab 34     Invalid Opcode - LAX #$34
            brk                ; $8573: 00        
            .hex 54 00         ; $8574: 54 00     Invalid Opcode - NOP $00,x
            .hex 74 00         ; $8576: 74 00     Invalid Opcode - NOP $00,x
            sty $00,x          ; $8578: 94 00     
            ldy $00,x          ; $857a: b4 00     
            .hex 93 e0         ; $857c: 93 e0     Invalid Opcode - AHX ($e0),y
            .hex 73 c0         ; $857e: 73 c0     Invalid Opcode - RRA ($c0),y
            .hex 53 a0         ; $8580: 53 a0     Invalid Opcode - SRE ($a0),y
            .hex 33 80         ; $8582: 33 80     Invalid Opcode - RLA ($80),y
            .hex 13 60         ; $8584: 13 60     Invalid Opcode - SLO ($60),y
            .hex ff 05 29      ; $8586: ff 05 29  Invalid Opcode - ISC $2905,x
            sec                ; $8589: 38        
            eor #$58           ; $858a: 49 58     
            adc #$78           ; $858c: 69 78     
            .hex 89 98         ; $858e: 89 98     Invalid Opcode - NOP #$98
            .hex a9            ; $8590: a9        Suspected data
__8591:     clv                ; $8591: b8        
            cmp #$d8           ; $8592: c9 d8     
            sbc #$d8           ; $8594: e9 d8     
            cmp #$b8           ; $8596: c9 b8     
            lda #$98           ; $8598: a9 98     
            .hex 89 78         ; $859a: 89 78     Invalid Opcode - NOP #$78
            adc #$58           ; $859c: 69 58     
            eor #$38           ; $859e: 49 38     
            and #$28           ; $85a0: 29 28     
            .hex 19 18         ; $85a2: 19 18     Suspected data
__85a4:     .hex ff 0f b0      ; $85a4: ff 0f b0  Invalid Opcode - ISC __b00f,x
            ldy __e051,x       ; $85a7: bc 51 e0  
            adc ($c0),y        ; $85aa: 71 c0     
            sta ($a0),y        ; $85ac: 91 a0     
            lda ($80),y        ; $85ae: b1 80     
            lda ($60,x)        ; $85b0: a1 60     
            sta ($40,x)        ; $85b2: 81 40     
            adc ($20),y        ; $85b4: 71 20     
            adc ($00,x)        ; $85b6: 61 00     
            eor ($00),y        ; $85b8: 51 00     
            .hex 41            ; $85ba: 41        Suspected data
__85bb:     brk                ; $85bb: 00        
            and ($00),y        ; $85bc: 31 00     
            and ($00,x)        ; $85be: 21 00     
            ora ($00),y        ; $85c0: 11 00     
            .hex ff 02 30      ; $85c2: ff 02 30  Invalid Opcode - ISC $3002,x
            dey                ; $85c5: 88        
            bpl __85c8         ; $85c6: 10 00     
__85c8:     inc __a5ff,x       ; $85c8: fe ff a5  
__85cb:     sta $04            ; $85cb: 85 04     
            beq __8550         ; $85cd: f0 81     
__85cf:     beq __8591         ; $85cf: f0 c0     
            beq __85f3         ; $85d1: f0 20     
            cpx #$80           ; $85d3: e0 80     
            cpx #$20           ; $85d5: e0 20     
            bne __8559         ; $85d7: d0 80     
            bne __85fb         ; $85d9: d0 20     
            cpy #$80           ; $85db: c0 80     
            cpy #$20           ; $85dd: c0 20     
            bcs __8561         ; $85df: b0 80     
            bcs __8603         ; $85e1: b0 20     
            ldy #$80           ; $85e3: a0 80     
            ldy #$20           ; $85e5: a0 20     
__85e7:     bcc __8569         ; $85e7: 90 80     
            bcc __860b         ; $85e9: 90 20     
            .hex 80 80         ; $85eb: 80 80     Invalid Opcode - NOP #$80
            .hex 80 20         ; $85ed: 80 20     Invalid Opcode - NOP #$20
            bvs __8571         ; $85ef: 70 80     
            bvs __8613         ; $85f1: 70 20     
__85f3:     rts                ; $85f3: 60        

;-------------------------------------------------------------------------------
            .hex 80            ; $85f4: 80        Suspected data
__85f5:     rts                ; $85f5: 60        

;-------------------------------------------------------------------------------
            jsr __8050         ; $85f6: 20 50 80  
            bvc __861b         ; $85f9: 50 20     
__85fb:     rti                ; $85fb: 40        

;-------------------------------------------------------------------------------
            .hex 80 40         ; $85fc: 80 40     Invalid Opcode - NOP #$40
            jsr __8030         ; $85fe: 20 30 80  
__8601:     bmi __8623         ; $8601: 30 20     
__8603:     .hex ff 01 f0      ; $8603: ff 01 f0  Invalid Opcode - ISC __f001,x
            dey                ; $8606: 88        
            bpl __8609         ; $8607: 10 00     
__8609:     .hex fe ff         ; $8609: fe ff     Suspected data
__860b:     cpy $0785          ; $860b: cc 85 07  
            .hex b0            ; $860e: b0        Suspected data
__860f:     cmp #$90           ; $860f: c9 90     
            cpy #$60           ; $8611: c0 60     
__8613:     cpy #$30           ; $8613: c0 30     
            cpy #$ff           ; $8615: c0 ff     
            .hex 04 f0         ; $8617: 04 f0     Invalid Opcode - NOP $f0
            .hex 82 63         ; $8619: 82 63     Invalid Opcode - NOP #$63
__861b:     brk                ; $861b: 00        
            .hex 83            ; $861c: 83        Suspected data
__861d:     brk                ; $861d: 00        
            .hex 03            ; $861e: 03        Suspected data
__861f:     beq __85a4         ; $861f: f0 83     
            ldy $00            ; $8621: a4 00     
__8623:     .hex fb c4 00      ; $8623: fb c4 00  Invalid Opcode - ISC $00c4,y
            ldy $00,x          ; $8626: b4 00     
            .hex fe            ; $8628: fe        Suspected data
__8629:     bpl __85cf         ; $8629: 10 a4     
            brk                ; $862b: 00        
            sty $00,x          ; $862c: 94 00     
            sty $00            ; $862e: 84 00     
            .hex 74 00         ; $8630: 74 00     Invalid Opcode - NOP $00,x
__8632:     .hex 64 00         ; $8632: 64 00     Invalid Opcode - NOP $00
            .hex 54 00         ; $8634: 54 00     Invalid Opcode - NOP $00,x
            .hex 44 00         ; $8636: 44 00     Invalid Opcode - NOP $00
            .hex 34            ; $8638: 34        Suspected data
__8639:     brk                ; $8639: 00        
            .hex ff 01 69      ; $863a: ff 01 69  Invalid Opcode - ISC $6901,x
            txa                ; $863d: 8a        
            .hex ab cd         ; $863e: ab cd     Invalid Opcode - LAX #$cd
            bpl __8646         ; $8640: 10 04     
            brk                ; $8642: 00        
            inc __ed00         ; $8643: ee 00 ed  
__8646:     inc __cedf         ; $8646: ee df ce  
__8649:     .hex cf be af      ; $8649: cf be af  Invalid Opcode - DCP __afbe
            .hex bf ae 9f      ; $864c: bf ae 9f  Invalid Opcode - LAX __9fae,y
            ldx __9faf,y       ; $864f: be af 9f  
            stx $6e7f          ; $8652: 8e 7f 6e  
            .hex 5f 4e 3f      ; $8655: 5f 4e 3f  Invalid Opcode - SRE $3f4e,x
            rol __ff1f         ; $8658: 2e 1f ff  
            .hex 02            ; $865b: 02        Invalid Opcode - KIL 
            .hex b0            ; $865c: b0        Suspected data
__865d:     .hex 82 b0         ; $865d: 82 b0     Invalid Opcode - NOP #$b0
            rti                ; $865f: 40        

;-------------------------------------------------------------------------------
            bcs __86ae         ; $8660: b0 4c     
            .hex b0            ; $8662: b0        Suspected data
__8663:     .hex 5a            ; $8663: 5a        Invalid Opcode - NOP 
            bcs __86d1         ; $8664: b0 6b     
            bcs __85e7         ; $8666: b0 7f     
            bcs __8601         ; $8668: b0 97     
            beq __866c         ; $866a: f0 00     
__866c:     bcc __86ae         ; $866c: 90 40     
            bcc __86bc         ; $866e: 90 4c     
            bcc __86cc         ; $8670: 90 5a     
            bcc __86df         ; $8672: 90 6b     
            bcc __85f5         ; $8674: 90 7f     
            bcc __860f         ; $8676: 90 97     
            beq __867a         ; $8678: f0 00     
__867a:     bvs __86bc         ; $867a: 70 40     
            bvs __86ca         ; $867c: 70 4c     
            bvs __86da         ; $867e: 70 5a     
            bvs __86ed         ; $8680: 70 6b     
            bvs __8603         ; $8682: 70 7f     
            bvs __861d         ; $8684: 70 97     
            beq __8688         ; $8686: f0 00     
__8688:     rts                ; $8688: 60        

;-------------------------------------------------------------------------------
            rti                ; $8689: 40        

;-------------------------------------------------------------------------------
            rts                ; $868a: 60        

;-------------------------------------------------------------------------------
            jmp $5a60          ; $868b: 4c 60 5a  

;-------------------------------------------------------------------------------
            rts                ; $868e: 60        

;-------------------------------------------------------------------------------
            .hex 6b 60         ; $868f: 6b 60     Invalid Opcode - ARR #$60
            .hex 7f 60 97      ; $8691: 7f 60 97  Invalid Opcode - RRA __9760,x
            beq __8696         ; $8694: f0 00     
__8696:     bvc __86d8         ; $8696: 50 40     
            bvc __86e6         ; $8698: 50 4c     
            bvc __86f6         ; $869a: 50 5a     
            bvc __8709         ; $869c: 50 6b     
            bvc __861f         ; $869e: 50 7f     
            bvc __8639         ; $86a0: 50 97     
            beq __86a4         ; $86a2: f0 00     
__86a4:     rti                ; $86a4: 40        

;-------------------------------------------------------------------------------
            rti                ; $86a5: 40        

;-------------------------------------------------------------------------------
            rti                ; $86a6: 40        

;-------------------------------------------------------------------------------
            jmp $5a40          ; $86a7: 4c 40 5a  

;-------------------------------------------------------------------------------
            rti                ; $86aa: 40        

;-------------------------------------------------------------------------------
            .hex 6b 40         ; $86ab: 6b 40     Invalid Opcode - ARR #$40
            .hex 7f            ; $86ad: 7f        Suspected data
__86ae:     rti                ; $86ae: 40        

;-------------------------------------------------------------------------------
            .hex 97 f0         ; $86af: 97 f0     Invalid Opcode - SAX $f0,y
            brk                ; $86b1: 00        
            jsr $2040          ; $86b2: 20 40 20  
            jmp $5a20          ; $86b5: 4c 20 5a  

;-------------------------------------------------------------------------------
            jsr $206b          ; $86b8: 20 6b 20  
            .hex 7f            ; $86bb: 7f        Suspected data
__86bc:     jsr __f097         ; $86bc: 20 97 f0  
            brk                ; $86bf: 00        
__86c0:     bpl __8702         ; $86c0: 10 40     
            bpl __8710         ; $86c2: 10 4c     
            bpl __8720         ; $86c4: 10 5a     
            bpl __8733         ; $86c6: 10 6b     
            bpl __8649         ; $86c8: 10 7f     
__86ca:     bpl __8663         ; $86ca: 10 97     
__86cc:     .hex ff 01 70      ; $86cc: ff 01 70  Invalid Opcode - ISC $7001,x
__86cf:     stx $10            ; $86cf: 86 10     
__86d1:     brk                ; $86d1: 00        
            inc $5bff,x        ; $86d2: fe ff 5b  
            stx $02            ; $86d5: 86 02     
            .hex 30            ; $86d7: 30        Suspected data
__86d8:     txa                ; $86d8: 8a        
            .hex a0            ; $86d9: a0        Suspected data
__86da:     rti                ; $86da: 40        

;-------------------------------------------------------------------------------
            bcc __8725         ; $86db: 90 48     
            .hex 80 50         ; $86dd: 80 50     Invalid Opcode - NOP #$50
__86df:     bvs __8739         ; $86df: 70 58     
            .hex ff            ; $86e1: ff        Suspected data
__86e2:     asl $f0            ; $86e2: 06 f0     
            .hex 82 f2         ; $86e4: 82 f2     Invalid Opcode - NOP #$f2
__86e6:     .hex 80 e0         ; $86e6: 80 e0     Invalid Opcode - NOP #$e0
            cpx #$80           ; $86e8: e0 80     
            .hex e0            ; $86ea: e0        Suspected data
__86eb:     .hex 80 e0         ; $86eb: 80 e0     Invalid Opcode - NOP #$e0
__86ed:     bvc __86cf         ; $86ed: 50 e0     
            .hex ff 02 f0      ; $86ef: ff 02 f0  Invalid Opcode - ISC __f002,x
            dey                ; $86f2: 88        
            bpl __86f5         ; $86f3: 10 00     
__86f5:     .hex 06            ; $86f5: 06        Suspected data
__86f6:     beq __867a         ; $86f6: f0 82     
            .hex f2            ; $86f8: f2        Invalid Opcode - KIL 
            .hex 80 e0         ; $86f9: 80 e0     Invalid Opcode - NOP #$e0
            .hex e0            ; $86fb: e0        Suspected data
__86fc:     .hex 80 e0         ; $86fc: 80 e0     Invalid Opcode - NOP #$e0
            .hex 80 e0         ; $86fe: 80 e0     Invalid Opcode - NOP #$e0
            bvc __86e2         ; $8700: 50 e0     
__8702:     .hex ff 03 b0      ; $8702: ff 03 b0  Invalid Opcode - ISC __b003,x
            dey                ; $8705: 88        
            cpx #$15           ; $8706: e0 15     
            .hex e0            ; $8708: e0        Suspected data
__8709:     bpl __86eb         ; $8709: 10 e0     
            rol                ; $870b: 2a        
            cpx #$20           ; $870c: e0 20     
            .hex 03            ; $870e: 03        Suspected data
__870f:     .hex b0            ; $870f: b0        Suspected data
__8710:     dey                ; $8710: 88        
            bpl __8713         ; $8711: 10 00     
__8713:     .hex 03 b0         ; $8713: 03 b0     Invalid Opcode - SLO ($b0,x)
            dey                ; $8715: 88        
            bne __8728         ; $8716: d0 10     
            bne __8724         ; $8718: d0 0a     
            bne __8741         ; $871a: d0 25     
            bne __8738         ; $871c: d0 1a     
            bpl __8720         ; $871e: 10 00     
__8720:     ldy #$15           ; $8720: a0 15     
            ldy #$10           ; $8722: a0 10     
__8724:     .hex ff            ; $8724: ff        Suspected data
__8725:     .hex 03 f4         ; $8725: 03 f4     Invalid Opcode - SLO ($f4,x)
            .hex f4            ; $8727: f4        Suspected data
__8728:     .hex f4 10         ; $8728: f4 10     Invalid Opcode - NOP $10,x
            .hex f4 e7         ; $872a: f4 e7     Invalid Opcode - NOP $e7,x
            .hex e3 e1         ; $872c: e3 e1     Invalid Opcode - ISC ($e1,x)
            .hex e2 e5         ; $872e: e2 e5     Invalid Opcode - NOP #$e5
            .hex b2            ; $8730: b2        Invalid Opcode - KIL 
            .hex ff            ; $8731: ff        Suspected data
__8732:     .hex ff            ; $8732: ff        Suspected data
__8733:     .hex eb 01         ; $8733: eb 01     Invalid Opcode - SBC #$01
            bpl __870f         ; $8735: 10 d8     
            .hex 70            ; $8737: 70        Suspected data
__8738:     .hex 24            ; $8738: 24        Suspected data
__8739:     asl $e9,x          ; $8739: 16 e9     
            lda $e3,x          ; $873b: b5 e3     
            .hex 07 73         ; $873d: 07 73     Invalid Opcode - SLO $73
            .hex 03 05         ; $873f: 03 05     Invalid Opcode - SLO ($05,x)
__8741:     cpx $b0            ; $8741: e4 b0     
            bcc __86fc         ; $8743: 90 b7     
            .hex e3 27         ; $8745: e3 27     Invalid Opcode - ISC ($27,x)
            sta $21            ; $8747: 85 21     
            eor $40,x          ; $8749: 55 40     
            jsr $7747          ; $874b: 20 47 77  
            .hex e2 07         ; $874e: e2 07     Invalid Opcode - NOP #$07
            .hex e3 a3         ; $8750: e3 a3     Invalid Opcode - ISC ($a3,x)
            .hex 8b 57         ; $8752: 8b 57     Invalid Opcode - XAA #$57
            lda $51            ; $8754: a5 51     
            .hex 83 7b         ; $8756: 83 7b     Invalid Opcode - SAX ($7b,x)
            .hex 37 83         ; $8758: 37 83     Invalid Opcode - RLA $83,x
            .hex 33 75         ; $875a: 33 75     Invalid Opcode - RLA ($75),y
            bvc __879e         ; $875c: 50 40     
            .hex 57 e7         ; $875e: 57 e7     Invalid Opcode - SRE $e7,x
            plp                ; $8760: 28        
            .hex e2 0d         ; $8761: e2 0d     Invalid Opcode - NOP #$0d
            .hex e7 24         ; $8763: e7 24     Invalid Opcode - ISC $24
            jsr __e300         ; $8765: 20 00 e3  
__8768:     lda __89ea,y       ; $8768: b9 ea 89  
            .hex e3 b1         ; $876b: e3 b1     Invalid Opcode - ISC ($b1,x)
            .hex e2 01         ; $876d: e2 01     Invalid Opcode - NOP #$01
            .hex 21            ; $876f: 21        Suspected data
__8770:     nop                ; $8770: ea        
            .hex 03 e3         ; $8771: 03 e3     Invalid Opcode - SLO ($e3,x)
            .hex 07 73         ; $8773: 07 73     Invalid Opcode - SLO $73
            .hex 03 05         ; $8775: 03 05     Invalid Opcode - SLO ($05,x)
            cpx $b0            ; $8777: e4 b0     
            bcc __8732         ; $8779: 90 b7     
            .hex e3 27         ; $877b: e3 27     Invalid Opcode - ISC ($27,x)
            sta $21            ; $877d: 85 21     
            eor $40,x          ; $877f: 55 40     
            jsr $7747          ; $8781: 20 47 77  
            .hex e2 07         ; $8784: e2 07     Invalid Opcode - NOP #$07
            .hex e3 a3         ; $8786: e3 a3     Invalid Opcode - ISC ($a3,x)
            .hex 8b 57         ; $8788: 8b 57     Invalid Opcode - XAA #$57
            lda $51            ; $878a: a5 51     
            .hex 83 7b         ; $878c: 83 7b     Invalid Opcode - SAX ($7b,x)
            .hex 37 83         ; $878e: 37 83     Invalid Opcode - RLA $83,x
            .hex 33 75         ; $8790: 33 75     Invalid Opcode - RLA ($75),y
            bvc __87d4         ; $8792: 50 40     
            .hex 57 e7         ; $8794: 57 e7     Invalid Opcode - SRE $e7,x
            plp                ; $8796: 28        
            .hex e2 0d         ; $8797: e2 0d     Invalid Opcode - NOP #$0d
            .hex e7 24         ; $8799: e7 24     Invalid Opcode - ISC $24
            jsr __e300         ; $879b: 20 00 e3  
__879e:     lda $00ea,y        ; $879e: b9 ea 00  
            cpx $b1            ; $87a1: e4 b1     
            .hex e3 01         ; $87a3: e3 01     Invalid Opcode - ISC ($01,x)
            and ($e9,x)        ; $87a5: 21 e9     
            lda ($e3),y        ; $87a7: b1 e3     
            .hex 07 73         ; $87a9: 07 73     Invalid Opcode - SLO $73
            .hex 03 05         ; $87ab: 03 05     Invalid Opcode - SLO ($05,x)
            cpx $b0            ; $87ad: e4 b0     
            bcc __8768         ; $87af: 90 b7     
            .hex e3 27         ; $87b1: e3 27     Invalid Opcode - ISC ($27,x)
            sta $21            ; $87b3: 85 21     
            eor $40,x          ; $87b5: 55 40     
            jsr $7747          ; $87b7: 20 47 77  
            .hex e2 07         ; $87ba: e2 07     Invalid Opcode - NOP #$07
            .hex e3 a3         ; $87bc: e3 a3     Invalid Opcode - ISC ($a3,x)
            .hex 8b 57         ; $87be: 8b 57     Invalid Opcode - XAA #$57
            lda $51            ; $87c0: a5 51     
            .hex 83 7b         ; $87c2: 83 7b     Invalid Opcode - SAX ($7b,x)
            .hex 37 83         ; $87c4: 37 83     Invalid Opcode - RLA $83,x
__87c6:     .hex 33 75         ; $87c6: 33 75     Invalid Opcode - RLA ($75),y
            bvc __880a         ; $87c8: 50 40     
            .hex 57 e7         ; $87ca: 57 e7     Invalid Opcode - SRE $e7,x
            plp                ; $87cc: 28        
            .hex e2 0d         ; $87cd: e2 0d     Invalid Opcode - NOP #$0d
            .hex e7 24         ; $87cf: e7 24     Invalid Opcode - ISC $24
            jsr __e300         ; $87d1: 20 00 e3  
__87d4:     lda __b1e4,y       ; $87d4: b9 e4 b1  
            .hex e3 01         ; $87d7: e3 01     Invalid Opcode - ISC ($01,x)
            and ($e9,x)        ; $87d9: 21 e9     
            and $d8,x          ; $87db: 35 d8     
            .hex 70            ; $87dd: 70        Suspected data
__87de:     and $00            ; $87de: 25 00     
            .hex eb 01         ; $87e0: eb 01     Invalid Opcode - SBC #$01
            bpl __87c6         ; $87e2: 10 e2     
            .hex 0f e7 27      ; $87e4: 0f e7 27  Invalid Opcode - SLO $27e7
            inx                ; $87e7: e8        
            asl $e3,x          ; $87e8: 16 e3     
            .hex 33 e2         ; $87ea: 33 e2     Invalid Opcode - RLA ($e2),y
            and ($31,x)        ; $87ec: 21 31     
            eor ($21),y        ; $87ee: 51 21     
            ora ($e3,x)        ; $87f0: 01 e3     
            lda ($e8,x)        ; $87f2: a1 e8     
            brk                ; $87f4: 00        
            .hex e7 25         ; $87f5: e7 25     Invalid Opcode - ISC $25
            .hex e2 0f         ; $87f7: e2 0f     Invalid Opcode - NOP #$0f
            inx                ; $87f9: e8        
            asl $e7,x          ; $87fa: 16 e7     
            .hex 27 e3         ; $87fc: 27 e3     Invalid Opcode - RLA $e3
            .hex 33 e2         ; $87fe: 33 e2     Invalid Opcode - RLA ($e2),y
            adc ($51),y        ; $8800: 71 51     
            and ($51),y        ; $8802: 31 51     
            and ($31,x)        ; $8804: 21 31     
            sbc #$31           ; $8806: e9 31     
            .hex e7 25         ; $8808: e7 25     Invalid Opcode - ISC $25
__880a:     inx                ; $880a: e8        
            brk                ; $880b: 00        
            inc $09            ; $880c: e6 09     
            .hex 07 e6         ; $880e: 07 e6     Invalid Opcode - SLO $e6
            asl                ; $8810: 0a        
            .hex 07 f1         ; $8811: 07 f1     Invalid Opcode - SLO $f1
            .hex e7 27         ; $8813: e7 27     Invalid Opcode - ISC $27
            inc $0c            ; $8815: e6 0c     
            .hex 0f ff eb      ; $8817: 0f ff eb  Invalid Opcode - SLO __ebff
            ora ($0f,x)        ; $881a: 01 0f     
            sbc #$35           ; $881c: e9 35     
            cld                ; $881e: d8        
            bvs __8847         ; $881f: 70 26     
            .hex 17 f2         ; $8821: 17 f2     Invalid Opcode - SLO $f2,x
            .hex e2 0b         ; $8823: e2 0b     Invalid Opcode - NOP #$0b
            .hex 73 25         ; $8825: 73 25     Invalid Opcode - RRA ($25),y
            .hex e7 23         ; $8827: e7 23     Invalid Opcode - ISC $23
            .hex e3 70         ; $8829: e3 70     Invalid Opcode - ISC ($70,x)
            bvc __88a4         ; $882b: 50 77     
            .hex e7 26         ; $882d: e7 26     Invalid Opcode - ISC $26
            .hex b7 e2         ; $882f: b7 e2     Invalid Opcode - LAX $e2,y
            .hex 23 83         ; $8831: 23 83     Invalid Opcode - RLA ($83,x)
            adc $e7,x          ; $8833: 75 e7     
            .hex 23 00         ; $8835: 23 00     Invalid Opcode - RLA ($00,x)
            .hex e3 b0         ; $8837: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 07         ; $8839: e2 07     Invalid Opcode - NOP #$07
            .hex e7 26         ; $883b: e7 26     Invalid Opcode - ISC $26
            .hex 47 77         ; $883d: 47 77     Invalid Opcode - SRE $77
            .hex 73 85         ; $883f: 73 85     Invalid Opcode - RRA ($85),y
            .hex e7 23         ; $8841: e7 23     Invalid Opcode - ISC $23
            .hex e3 a1         ; $8843: e3 a1     Invalid Opcode - ISC ($a1,x)
            .hex e2 01         ; $8845: e2 01     Invalid Opcode - NOP #$01
__8847:     .hex e3 81         ; $8847: e3 81     Invalid Opcode - ISC ($81,x)
            .hex e7 26         ; $8849: e7 26     Invalid Opcode - ISC $26
            .hex e2 27         ; $884b: e2 27     Invalid Opcode - NOP #$27
            .hex 57 53         ; $884d: 57 53     Invalid Opcode - SRE $53,x
            adc $e7,x          ; $884f: 75 e7     
            .hex 23 e3         ; $8851: 23 e3     Invalid Opcode - RLA ($e3,x)
            sta ($a1,x)        ; $8853: 81 a1     
__8855:     adc ($e7),y        ; $8855: 71 e7     
            rol $e2            ; $8857: 26 e2     
            .hex 89 e7         ; $8859: 89 e7     Invalid Opcode - NOP #$e7
            .hex 23 71         ; $885b: 23 71     Invalid Opcode - RLA ($71,x)
            eor ($31),y        ; $885d: 51 31     
            .hex e7            ; $885f: e7        Suspected data
__8860:     rol $79            ; $8860: 26 79     
            .hex e7 23         ; $8862: e7 23     Invalid Opcode - ISC $23
            eor ($41),y        ; $8864: 51 41     
            eor ($e3),y        ; $8866: 51 e3     
            .hex 77 57         ; $8868: 77 57     Invalid Opcode - RRA $57,x
            .hex e2 51         ; $886a: e2 51     Invalid Opcode - NOP #$51
            .hex f2            ; $886c: f2        Invalid Opcode - KIL 
            jsr __e300         ; $886d: 20 00 e3  
            .hex b1            ; $8870: b1        Suspected data
__8871:     .hex f4 e2         ; $8871: f4 e2     Invalid Opcode - NOP $e2,x
            jsr __e300         ; $8873: 20 00 e3  
            lda ($f0),y        ; $8876: b1 f0     
            nop                ; $8878: ea        
            .hex 89 e3         ; $8879: 89 e3     Invalid Opcode - NOP #$e3
            adc ($91),y        ; $887b: 71 91     
            lda ($ea),y        ; $887d: b1 ea     
            .hex 89 f2         ; $887f: 89 f2     Invalid Opcode - NOP #$f2
            .hex e2 0b         ; $8881: e2 0b     Invalid Opcode - NOP #$0b
            .hex 73 25         ; $8883: 73 25     Invalid Opcode - RRA ($25),y
            .hex e7 23         ; $8885: e7 23     Invalid Opcode - ISC $23
            .hex e2 70         ; $8887: e2 70     Invalid Opcode - NOP #$70
            bvc __8902         ; $8889: 50 77     
            .hex e7 26         ; $888b: e7 26     Invalid Opcode - ISC $26
__888d:     .hex e3 b7         ; $888d: e3 b7     Invalid Opcode - ISC ($b7,x)
            .hex e2 23         ; $888f: e2 23     Invalid Opcode - NOP #$23
            .hex 83 75         ; $8891: 83 75     Invalid Opcode - SAX ($75,x)
            .hex e7 23         ; $8893: e7 23     Invalid Opcode - ISC $23
            .hex f2            ; $8895: f2        Invalid Opcode - KIL 
            sbc ($00,x)        ; $8896: e1 00     
            .hex e2 b0         ; $8898: e2 b0     Invalid Opcode - NOP #$b0
            sbc ($07,x)        ; $889a: e1 07     
            .hex e7 26         ; $889c: e7 26     Invalid Opcode - ISC $26
            .hex e2 47         ; $889e: e2 47     Invalid Opcode - NOP #$47
            .hex 77 73         ; $88a0: 77 73     Invalid Opcode - RRA $73,x
            sta $e7            ; $88a2: 85 e7     
__88a4:     .hex 23 e2         ; $88a4: 23 e2     Invalid Opcode - RLA ($e2,x)
            lda ($e1,x)        ; $88a6: a1 e1     
            ora ($e2,x)        ; $88a8: 01 e2     
            sta ($e7,x)        ; $88aa: 81 e7     
            rol $e2            ; $88ac: 26 e2     
            .hex 27 57         ; $88ae: 27 57     Invalid Opcode - RLA $57
            .hex 53 75         ; $88b0: 53 75     Invalid Opcode - SRE ($75),y
            .hex e7 23         ; $88b2: e7 23     Invalid Opcode - ISC $23
            .hex e2 81         ; $88b4: e2 81     Invalid Opcode - NOP #$81
            lda ($71,x)        ; $88b6: a1 71     
            .hex e7 26         ; $88b8: e7 26     Invalid Opcode - ISC $26
            .hex e2 89         ; $88ba: e2 89     Invalid Opcode - NOP #$89
            .hex e7 23         ; $88bc: e7 23     Invalid Opcode - ISC $23
            sbc ($71,x)        ; $88be: e1 71     
            .hex 51            ; $88c0: 51        Suspected data
__88c1:     and ($e7),y        ; $88c1: 31 e7     
            rol $e2            ; $88c3: 26 e2     
            adc $23e7,y        ; $88c5: 79 e7 23  
__88c8:     sbc ($51,x)        ; $88c8: e1 51     
            eor ($51,x)        ; $88ca: 41 51     
            .hex e2 77         ; $88cc: e2 77     Invalid Opcode - NOP #$77
            .hex 57 e1         ; $88ce: 57 e1     Invalid Opcode - SRE $e1,x
            eor ($f2),y        ; $88d0: 51 f2     
            jsr __e200         ; $88d2: 20 00 e2  
            lda ($f4),y        ; $88d5: b1 f4     
            sbc ($20,x)        ; $88d7: e1 20     
            brk                ; $88d9: 00        
            .hex e2 b1         ; $88da: e2 b1     Invalid Opcode - NOP #$b1
            beq __88c8         ; $88dc: f0 ea     
            brk                ; $88de: 00        
            cpx $71            ; $88df: e4 71     
            sta ($b1),y        ; $88e1: 91 b1     
            .hex f2            ; $88e3: f2        Invalid Opcode - KIL 
            .hex e2 0b         ; $88e4: e2 0b     Invalid Opcode - NOP #$0b
            .hex 73 25         ; $88e6: 73 25     Invalid Opcode - RRA ($25),y
            .hex e7 23         ; $88e8: e7 23     Invalid Opcode - ISC $23
            .hex e3 70         ; $88ea: e3 70     Invalid Opcode - ISC ($70,x)
            bvc __8965         ; $88ec: 50 77     
            .hex e7 26         ; $88ee: e7 26     Invalid Opcode - ISC $26
            .hex b7 e2         ; $88f0: b7 e2     Invalid Opcode - LAX $e2,y
            .hex 23 83         ; $88f2: 23 83     Invalid Opcode - RLA ($83,x)
            adc $e7,x          ; $88f4: 75 e7     
            .hex 23 00         ; $88f6: 23 00     Invalid Opcode - RLA ($00,x)
            .hex e3 b0         ; $88f8: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 07         ; $88fa: e2 07     Invalid Opcode - NOP #$07
            .hex e7 26         ; $88fc: e7 26     Invalid Opcode - ISC $26
            .hex 47 77         ; $88fe: 47 77     Invalid Opcode - SRE $77
            .hex 73 85         ; $8900: 73 85     Invalid Opcode - RRA ($85),y
__8902:     .hex e7 23         ; $8902: e7 23     Invalid Opcode - ISC $23
            .hex e3 a1         ; $8904: e3 a1     Invalid Opcode - ISC ($a1,x)
            .hex e2 01         ; $8906: e2 01     Invalid Opcode - NOP #$01
            .hex e3 81         ; $8908: e3 81     Invalid Opcode - ISC ($81,x)
            .hex e7 26         ; $890a: e7 26     Invalid Opcode - ISC $26
            .hex e2 27         ; $890c: e2 27     Invalid Opcode - NOP #$27
            .hex 57 53         ; $890e: 57 53     Invalid Opcode - SRE $53,x
            adc $e7,x          ; $8910: 75 e7     
            .hex 23 e3         ; $8912: 23 e3     Invalid Opcode - RLA ($e3,x)
            sta ($a1,x)        ; $8914: 81 a1     
            adc ($e7),y        ; $8916: 71 e7     
            rol $e2            ; $8918: 26 e2     
            .hex 89 e7         ; $891a: 89 e7     Invalid Opcode - NOP #$e7
            .hex 23 71         ; $891c: 23 71     Invalid Opcode - RLA ($71,x)
__891e:     eor ($31),y        ; $891e: 51 31     
            .hex e7 26         ; $8920: e7 26     Invalid Opcode - ISC $26
            adc $23e7,y        ; $8922: 79 e7 23  
            eor ($41),y        ; $8925: 51 41     
            eor ($e3),y        ; $8927: 51 e3     
            .hex 77 57         ; $8929: 77 57     Invalid Opcode - RRA $57,x
            .hex e2 51         ; $892b: e2 51     Invalid Opcode - NOP #$51
            .hex f2            ; $892d: f2        Invalid Opcode - KIL 
            jsr __e300         ; $892e: 20 00 e3  
            lda ($f4),y        ; $8931: b1 f4     
            .hex e2 20         ; $8933: e2 20     Invalid Opcode - NOP #$20
            brk                ; $8935: 00        
            .hex e3 b1         ; $8936: e3 b1     Invalid Opcode - ISC ($b1,x)
            beq __891e         ; $8938: f0 e4     
            adc ($91),y        ; $893a: 71 91     
            lda ($eb),y        ; $893c: b1 eb     
            ora ($0f,x)        ; $893e: 01 0f     
            cld                ; $8940: d8        
            bvs __896a         ; $8941: 70 27     
            .hex 17 e9         ; $8943: 17 e9     Invalid Opcode - SLO $e9,x
__8945:     and $e3,x          ; $8945: 35 e3     
            .hex 33 f1         ; $8947: 33 f1     Invalid Opcode - RLA ($f1),y
            .hex 33 f0         ; $8949: 33 f0     Invalid Opcode - RLA ($f0),y
            .hex 23 f1         ; $894b: 23 f1     Invalid Opcode - RLA ($f1,x)
            .hex 23 f0         ; $894d: 23 f0     Invalid Opcode - RLA ($f0,x)
            .hex 03 51         ; $894f: 03 51     Invalid Opcode - SLO ($51,x)
            adc ($81),y        ; $8951: 71 81     
            eor ($31),y        ; $8953: 51 31     
            and ($33,x)        ; $8955: 21 33     
            sbc ($33),y        ; $8957: f1 33     
            beq __897e         ; $8959: f0 23     
            sbc ($23),y        ; $895b: f1 23     
            beq __8962         ; $895d: f0 03     
__895f:     lda ($81,x)        ; $895f: a1 81     
            .hex 71            ; $8961: 71        Suspected data
__8962:     sta ($51,x)        ; $8962: 81 51     
            .hex 71            ; $8964: 71        Suspected data
__8965:     sbc ($e9),y        ; $8965: f1 e9     
            and ($e8),y        ; $8967: 31 e8     
            brk                ; $8969: 00        
__896a:     inc $09            ; $896a: e6 09     
            .hex 57 e6         ; $896c: 57 e6     Invalid Opcode - SRE $e6,x
            asl                ; $896e: 0a        
            .hex 27 e6         ; $896f: 27 e6     Invalid Opcode - RLA $e6
__8971:     .hex 0c            ; $8971: 0c        Suspected data
__8972:     .hex 4f ff d8      ; $8972: 4f ff d8  Invalid Opcode - SRE __d8ff
            ora $e3,x          ; $8975: 15 e3     
            ora $05            ; $8977: 05 05     
            cld                ; $8979: d8        
            .hex 1f 03 d8      ; $897a: 1f 03 d8  Invalid Opcode - SLO __d803,x
            .hex 15            ; $897d: 15        Suspected data
__897e:     cpx $75            ; $897e: e4 75     
            .hex 75            ; $8980: 75        Suspected data
__8981:     cld                ; $8981: d8        
            ora __d873,x       ; $8982: 1d 73 d8  
            ora $75,x          ; $8985: 15 75     
            adc $d8,x          ; $8987: 75 d8     
            .hex 1f b3 d8      ; $8989: 1f b3 d8  Invalid Opcode - SLO __d8b3,x
            bpl __8971         ; $898c: 10 e3     
            .hex 07 d8         ; $898e: 07 d8     Invalid Opcode - SLO $d8
            .hex 1f 43 73      ; $8990: 1f 43 73  Invalid Opcode - SLO $7343,x
            eor ($71,x)        ; $8993: 41 71     
            cld                ; $8995: d8        
            .hex 12            ; $8996: 12        Invalid Opcode - KIL 
            .hex 43 d8         ; $8997: 43 d8     Invalid Opcode - SRE ($d8,x)
__8999:     .hex 1f 41 01      ; $8999: 1f 41 01  Invalid Opcode - SLO $0141,x
            and ($41,x)        ; $899c: 21 41     
            eor ($81),y        ; $899e: 51 81     
            cld                ; $89a0: d8        
            .hex 12            ; $89a1: 12        Invalid Opcode - KIL 
            .hex 53 d8         ; $89a2: 53 d8     Invalid Opcode - SRE ($d8),y
            .hex 1f 51 71      ; $89a4: 1f 51 71  Invalid Opcode - SLO $7151,x
            sta ($51,x)        ; $89a7: 81 51     
            and ($a1,x)        ; $89a9: 21 a1     
            cld                ; $89ab: d8        
            .hex 12            ; $89ac: 12        Invalid Opcode - KIL 
            .hex 23 d8         ; $89ad: 23 d8     Invalid Opcode - RLA ($d8,x)
            .hex 1f 21 31      ; $89af: 1f 21 31  Invalid Opcode - SLO $3121,x
            eor ($21),y        ; $89b2: 51 21     
            and ($a1),y        ; $89b4: 31 a1     
            cld                ; $89b6: d8        
            .hex 12            ; $89b7: 12        Invalid Opcode - KIL 
            .hex 33 d8         ; $89b8: 33 d8     Invalid Opcode - RLA ($d8),y
            .hex 1f 31 51      ; $89ba: 1f 31 51  Invalid Opcode - SLO $5131,x
            .hex 71            ; $89bd: 71        Suspected data
__89be:     and ($e4),y        ; $89be: 31 e4     
__89c0:     sta ($e3,x)        ; $89c0: 81 e3     
            ora ($31,x)        ; $89c2: 01 31     
            sta ($e4,x)        ; $89c4: 81 e4     
            sta ($e3,x)        ; $89c6: 81 e3     
            ora ($31,x)        ; $89c8: 01 31     
            sta ($e4,x)        ; $89ca: 81 e4     
            eor ($81),y        ; $89cc: 51 81     
            .hex e3 11         ; $89ce: e3 11     Invalid Opcode - ISC ($11,x)
            eor ($e4),y        ; $89d0: 51 e4     
            eor ($81),y        ; $89d2: 51 81     
            .hex e3 11         ; $89d4: e3 11     Invalid Opcode - ISC ($11,x)
            eor ($e4),y        ; $89d6: 51 e4     
            adc ($e3),y        ; $89d8: 71 e3     
            ora ($21,x)        ; $89da: 01 21     
            eor ($71),y        ; $89dc: 51 71     
            .hex e2 01         ; $89de: e2 01     Invalid Opcode - NOP #$01
            and ($51,x)        ; $89e0: 21 51     
            .hex e3 77         ; $89e2: e3 77     Invalid Opcode - ISC ($77,x)
            .hex c7 ea         ; $89e4: c7 ea     Invalid Opcode - DCP $ea
            .hex 03 d8         ; $89e6: 03 d8     Invalid Opcode - SLO ($d8,x)
            ora $e3,x          ; $89e8: 15 e3     
__89ea:     ora $d8            ; $89ea: 05 d8     
            .hex 14 05         ; $89ec: 14 05     Invalid Opcode - NOP $05,x
            cld                ; $89ee: d8        
            .hex 1f 03 d8      ; $89ef: 1f 03 d8  Invalid Opcode - SLO __d803,x
            ora $e4,x          ; $89f2: 15 e4     
            adc $d8,x          ; $89f4: 75 d8     
            .hex 14 75         ; $89f6: 14 75     Invalid Opcode - NOP $75,x
            cld                ; $89f8: d8        
            ora __d873,x       ; $89f9: 1d 73 d8  
            ora $75,x          ; $89fc: 15 75     
            cld                ; $89fe: d8        
            .hex 14 75         ; $89ff: 14 75     Invalid Opcode - NOP $75,x
            cld                ; $8a01: d8        
            .hex 1f b3 d8      ; $8a02: 1f b3 d8  Invalid Opcode - SLO __d8b3,x
            bpl __89ea         ; $8a05: 10 e3     
            .hex 07 d8         ; $8a07: 07 d8     Invalid Opcode - SLO $d8
            .hex 1f 43 73      ; $8a09: 1f 43 73  Invalid Opcode - SLO $7343,x
            eor ($71,x)        ; $8a0c: 41 71     
            cld                ; $8a0e: d8        
            .hex 12            ; $8a0f: 12        Invalid Opcode - KIL 
            .hex 43 d8         ; $8a10: 43 d8     Invalid Opcode - SRE ($d8,x)
            .hex 1f 41 01      ; $8a12: 1f 41 01  Invalid Opcode - SLO $0141,x
            and ($41,x)        ; $8a15: 21 41     
            eor ($81),y        ; $8a17: 51 81     
            cld                ; $8a19: d8        
            .hex 12            ; $8a1a: 12        Invalid Opcode - KIL 
            .hex 53 d8         ; $8a1b: 53 d8     Invalid Opcode - SRE ($d8),y
            .hex 1f 51 71      ; $8a1d: 1f 51 71  Invalid Opcode - SLO $7151,x
            sta ($51,x)        ; $8a20: 81 51     
            and ($a1,x)        ; $8a22: 21 a1     
            cld                ; $8a24: d8        
            .hex 12            ; $8a25: 12        Invalid Opcode - KIL 
            .hex 23 d8         ; $8a26: 23 d8     Invalid Opcode - RLA ($d8,x)
            .hex 1f 21 31      ; $8a28: 1f 21 31  Invalid Opcode - SLO $3121,x
            eor ($21),y        ; $8a2b: 51 21     
            and ($a1),y        ; $8a2d: 31 a1     
            cld                ; $8a2f: d8        
            .hex 12            ; $8a30: 12        Invalid Opcode - KIL 
            .hex 33 d8         ; $8a31: 33 d8     Invalid Opcode - RLA ($d8),y
            .hex 1f 31 51      ; $8a33: 1f 31 51  Invalid Opcode - SLO $5131,x
            adc ($31),y        ; $8a36: 71 31     
            cpx $81            ; $8a38: e4 81     
            .hex e3 01         ; $8a3a: e3 01     Invalid Opcode - ISC ($01,x)
            and ($81),y        ; $8a3c: 31 81     
            cpx $81            ; $8a3e: e4 81     
            .hex e3 01         ; $8a40: e3 01     Invalid Opcode - ISC ($01,x)
            and ($81),y        ; $8a42: 31 81     
            cpx $51            ; $8a44: e4 51     
            sta ($e3,x)        ; $8a46: 81 e3     
            ora ($51),y        ; $8a48: 11 51     
            cpx $51            ; $8a4a: e4 51     
            sta ($e3,x)        ; $8a4c: 81 e3     
            ora ($51),y        ; $8a4e: 11 51     
            cpx $71            ; $8a50: e4 71     
__8a52:     .hex e3 01         ; $8a52: e3 01     Invalid Opcode - ISC ($01,x)
            and ($51,x)        ; $8a54: 21 51     
            adc ($e2),y        ; $8a56: 71 e2     
            ora ($21,x)        ; $8a58: 01 21     
            eor ($e3),y        ; $8a5a: 51 e3     
            .hex 77 c7         ; $8a5c: 77 c7     Invalid Opcode - RRA $c7,x
            nop                ; $8a5e: ea        
            brk                ; $8a5f: 00        
            cld                ; $8a60: d8        
            ora $e3,x          ; $8a61: 15 e3     
__8a63:     ora $d8            ; $8a63: 05 d8     
            .hex 14 05         ; $8a65: 14 05     Invalid Opcode - NOP $05,x
            cld                ; $8a67: d8        
            .hex 1f 03 d8      ; $8a68: 1f 03 d8  Invalid Opcode - SLO __d803,x
            ora $e4,x          ; $8a6b: 15 e4     
            adc $d8,x          ; $8a6d: 75 d8     
            .hex 14 75         ; $8a6f: 14 75     Invalid Opcode - NOP $75,x
            cld                ; $8a71: d8        
            ora __d873,x       ; $8a72: 1d 73 d8  
            ora $75,x          ; $8a75: 15 75     
            cld                ; $8a77: d8        
            .hex 14 75         ; $8a78: 14 75     Invalid Opcode - NOP $75,x
            cld                ; $8a7a: d8        
            .hex 1f b3 d8      ; $8a7b: 1f b3 d8  Invalid Opcode - SLO __d8b3,x
            bpl __8a63         ; $8a7e: 10 e3     
            .hex 07            ; $8a80: 07        Suspected data
__8a81:     cld                ; $8a81: d8        
            .hex 1f 43 73      ; $8a82: 1f 43 73  Invalid Opcode - SLO $7343,x
            eor ($71,x)        ; $8a85: 41 71     
            cld                ; $8a87: d8        
            .hex 12            ; $8a88: 12        Invalid Opcode - KIL 
__8a89:     .hex 43 d8         ; $8a89: 43 d8     Invalid Opcode - SRE ($d8,x)
            .hex 1f 41 01      ; $8a8b: 1f 41 01  Invalid Opcode - SLO $0141,x
            and ($41,x)        ; $8a8e: 21 41     
            eor ($81),y        ; $8a90: 51 81     
            cld                ; $8a92: d8        
            .hex 12            ; $8a93: 12        Invalid Opcode - KIL 
            .hex 53 d8         ; $8a94: 53 d8     Invalid Opcode - SRE ($d8),y
            .hex 1f 51 71      ; $8a96: 1f 51 71  Invalid Opcode - SLO $7151,x
            sta ($51,x)        ; $8a99: 81 51     
            and ($a1,x)        ; $8a9b: 21 a1     
            cld                ; $8a9d: d8        
            .hex 12            ; $8a9e: 12        Invalid Opcode - KIL 
            .hex 23 d8         ; $8a9f: 23 d8     Invalid Opcode - RLA ($d8,x)
            .hex 1f 21 31      ; $8aa1: 1f 21 31  Invalid Opcode - SLO $3121,x
            eor ($21),y        ; $8aa4: 51 21     
__8aa6:     and ($a1),y        ; $8aa6: 31 a1     
            cld                ; $8aa8: d8        
            .hex 12            ; $8aa9: 12        Invalid Opcode - KIL 
            .hex 33            ; $8aaa: 33        Suspected data
__8aab:     cld                ; $8aab: d8        
            .hex 1f 31 51      ; $8aac: 1f 31 51  Invalid Opcode - SLO $5131,x
            adc ($31),y        ; $8aaf: 71 31     
            cpx $81            ; $8ab1: e4 81     
            .hex e3 01         ; $8ab3: e3 01     Invalid Opcode - ISC ($01,x)
            and ($81),y        ; $8ab5: 31 81     
            cpx $81            ; $8ab7: e4 81     
            .hex e3 01         ; $8ab9: e3 01     Invalid Opcode - ISC ($01,x)
            and ($81),y        ; $8abb: 31 81     
            cpx $51            ; $8abd: e4 51     
            .hex 81            ; $8abf: 81        Suspected data
__8ac0:     .hex e3            ; $8ac0: e3        Suspected data
__8ac1:     ora ($51),y        ; $8ac1: 11 51     
            cpx $51            ; $8ac3: e4 51     
            sta ($e3,x)        ; $8ac5: 81 e3     
            ora ($51),y        ; $8ac7: 11 51     
            cpx $71            ; $8ac9: e4 71     
            .hex e3 01         ; $8acb: e3 01     Invalid Opcode - ISC ($01,x)
            and ($51,x)        ; $8acd: 21 51     
            adc ($e2),y        ; $8acf: 71 e2     
            ora ($21,x)        ; $8ad1: 01 21     
            .hex 51            ; $8ad3: 51        Suspected data
__8ad4:     .hex e3 77         ; $8ad4: e3 77     Invalid Opcode - ISC ($77,x)
            .hex c7 fb         ; $8ad6: c7 fb     Invalid Opcode - DCP $fb
            cld                ; $8ad8: d8        
            .hex 1a            ; $8ad9: 1a        Invalid Opcode - NOP 
            .hex e3 01         ; $8ada: e3 01     Invalid Opcode - ISC ($01,x)
            ora ($01,x)        ; $8adc: 01 01     
            ora ($e4,x)        ; $8ade: 01 e4     
            lda ($a1,x)        ; $8ae0: a1 a1     
            lda ($a1,x)        ; $8ae2: a1 a1     
            sta ($81,x)        ; $8ae4: 81 81     
            sta ($81,x)        ; $8ae6: 81 81     
            lda ($a1,x)        ; $8ae8: a1 a1     
            lda ($a1,x)        ; $8aea: a1 a1     
            inc __d902,x       ; $8aec: fe 02 d9  
            bcc __8ad4         ; $8aef: 90 e3     
            .hex 03 03         ; $8af1: 03 03     Invalid Opcode - SLO ($03,x)
            .hex da            ; $8af3: da        Invalid Opcode - NOP 
            .hex 1f 03 03      ; $8af4: 1f 03 03  Invalid Opcode - SLO $0303,x
            .hex dc 90 0f      ; $8af7: dc 90 0f  Invalid Opcode - NOP $0f90,x
            .hex ff d8 fb      ; $8afa: ff d8 fb  Invalid Opcode - ISC __fbd8,x
            .hex cf cf fe      ; $8afd: cf cf fe  Invalid Opcode - DCP __fecf
            asl $fb            ; $8b00: 06 fb     
            .hex bf cf fe      ; $8b02: bf cf fe  Invalid Opcode - LAX __fecf,y
            ora $bf            ; $8b05: 05 bf     
            .hex bf fb b7      ; $8b07: bf fb b7  Invalid Opcode - LAX __b7fb,y
            .hex 17 b7         ; $8b0a: 17 b7     Invalid Opcode - SLO $b7,x
__8b0c:     .hex 17 fe         ; $8b0c: 17 fe     Invalid Opcode - SLO $fe,x
            .hex 02            ; $8b0e: 02        Invalid Opcode - KIL 
            .hex fb b5 b1      ; $8b0f: fb b5 b1  Invalid Opcode - ISC __b1b5,y
            lda $b1,x          ; $8b12: b5 b1     
            lda $b1,x          ; $8b14: b5 b1     
            .hex b3 a3         ; $8b16: b3 a3     Invalid Opcode - LAX ($a3),y
            inc __b703,x       ; $8b18: fe 03 b7  
            .hex a7            ; $8b1b: a7        Suspected data
__8b1c:     .hex b7 a1         ; $8b1c: b7 a1     Invalid Opcode - LAX $a1,y
__8b1e:     lda ($a1),y        ; $8b1e: b1 a1     
__8b20:     lda ($fb,x)        ; $8b20: a1 fb     
__8b22:     lda ($11),y        ; $8b22: b1 11     
__8b24:     ora ($11),y        ; $8b24: 11 11     
__8b26:     lda ($11,x)        ; $8b26: a1 11     
            ora ($b1),y        ; $8b28: 11 b1     
            lda ($11),y        ; $8b2a: b1 11     
            ora ($11),y        ; $8b2c: 11 11     
            lda ($11,x)        ; $8b2e: a1 11     
            ora ($11),y        ; $8b30: 11 11     
            inc __d902,x       ; $8b32: fe 02 d9  
            .hex b7 da         ; $8b35: b7 da     Invalid Opcode - LAX $da,y
            .hex b7 b0         ; $8b37: b7 b0     Invalid Opcode - LAX $b0,y
            .hex ff            ; $8b39: ff        Suspected data
__8b3a:     txs                ; $8b3a: 9a        
__8b3b:     .hex 8b a0         ; $8b3b: 8b a0     Invalid Opcode - XAA #$a0
            .hex 8b a6         ; $8b3d: 8b a6     Invalid Opcode - XAA #$a6
            .hex 8b af         ; $8b3f: 8b af     Invalid Opcode - XAA #$af
            .hex 8b b3         ; $8b41: 8b b3     Invalid Opcode - XAA #$b3
            .hex 8b bb         ; $8b43: 8b bb     Invalid Opcode - XAA #$bb
            .hex 8b c2         ; $8b45: 8b c2     Invalid Opcode - XAA #$c2
            .hex 8b c7         ; $8b47: 8b c7     Invalid Opcode - XAA #$c7
            .hex 8b d1         ; $8b49: 8b d1     Invalid Opcode - XAA #$d1
            .hex 8b dc         ; $8b4b: 8b dc     Invalid Opcode - XAA #$dc
            .hex 8b e1         ; $8b4d: 8b e1     Invalid Opcode - XAA #$e1
            .hex 8b eb         ; $8b4f: 8b eb     Invalid Opcode - XAA #$eb
            .hex 8b f3         ; $8b51: 8b f3     Invalid Opcode - XAA #$f3
            .hex 8b fa         ; $8b53: 8b fa     Invalid Opcode - XAA #$fa
            .hex 8b 02         ; $8b55: 8b 02     Invalid Opcode - XAA #$02
            sty __8c08         ; $8b57: 8c 08 8c  
            asl $128c          ; $8b5a: 0e 8c 12  
            sty __8c1b         ; $8b5d: 8c 1b 8c  
            .hex 23 8c         ; $8b60: 23 8c     Invalid Opcode - RLA ($8c,x)
            bit $368c          ; $8b62: 2c 8c 36  
            sty __8c3d         ; $8b65: 8c 3d 8c  
            .hex 43 8c         ; $8b68: 43 8c     Invalid Opcode - SRE ($8c,x)
            .hex 4b 8c         ; $8b6a: 4b 8c     Invalid Opcode - ALR #$8c
            .hex 52            ; $8b6c: 52        Invalid Opcode - KIL 
            sty __8c59         ; $8b6d: 8c 59 8c  
            eor $5f8c,y        ; $8b70: 59 8c 5f  
            sty __8c65         ; $8b73: 8c 65 8c  
            adc ($8c),y        ; $8b76: 71 8c     
            ror $8c,x          ; $8b78: 76 8c     
            .hex 82 8c         ; $8b7a: 82 8c     Invalid Opcode - NOP #$8c
            .hex 8b 8c         ; $8b7c: 8b 8c     Invalid Opcode - XAA #$8c
__8b7e:     bcc __8b0c         ; $8b7e: 90 8c     
            sta $8c,x          ; $8b80: 95 8c     
            .hex 9c 8c a2      ; $8b82: 9c 8c a2  Invalid Opcode - SHY __a28c,x
            sty __8cad         ; $8b85: 8c ad 8c  
            lda $8c,x          ; $8b88: b5 8c     
            iny                ; $8b8a: c8        
            sty __8cd0         ; $8b8b: 8c d0 8c  
            bne __8b1c         ; $8b8e: d0 8c     
            bne __8b1e         ; $8b90: d0 8c     
            bne __8b20         ; $8b92: d0 8c     
            bne __8b22         ; $8b94: d0 8c     
            bne __8b24         ; $8b96: d0 8c     
            bne __8b26         ; $8b98: d0 8c     
            .hex 14 16         ; $8b9a: 14 16     Invalid Opcode - NOP $16,x
            .hex 17 16         ; $8b9c: 17 16     Invalid Opcode - SLO $16,x
            sbc $ff,x          ; $8b9e: f5 ff     
            .hex 14 15         ; $8ba0: 14 15     Invalid Opcode - NOP $15,x
            .hex 17 26         ; $8ba2: 17 26     Invalid Opcode - SLO $26,x
            sbc $ff,x          ; $8ba4: f5 ff     
            .hex 12            ; $8ba6: 12        Invalid Opcode - KIL 
            .hex 13 14         ; $8ba7: 13 14     Invalid Opcode - SLO ($14),y
            ora $16,x          ; $8ba9: 15 16     
            .hex 27 16         ; $8bab: 27 16     Invalid Opcode - RLA $16
            sbc $ff,x          ; $8bad: f5 ff     
            ora __f627,y       ; $8baf: 19 27 f6  
            .hex ff 1d 1b      ; $8bb2: ff 1d 1b  Invalid Opcode - ISC $1b1d,x
            .hex 1a            ; $8bb5: 1a        Invalid Opcode - NOP 
            .hex 15            ; $8bb6: 15        Suspected data
__8bb7:     .hex 17 16         ; $8bb7: 17 16     Invalid Opcode - SLO $16,x
            sbc $ff,x          ; $8bb9: f5 ff     
            .hex 13 15         ; $8bbb: 13 15     Invalid Opcode - SLO ($15),y
            .hex 17 18         ; $8bbd: 17 18     Invalid Opcode - SLO $18,x
            .hex 17 f6         ; $8bbf: 17 f6     Invalid Opcode - SLO $f6,x
            .hex ff 14 45      ; $8bc1: ff 14 45  Invalid Opcode - ISC $4514,x
            .hex f4 f3         ; $8bc4: f4 f3     Invalid Opcode - NOP $f3,x
            .hex ff 18 16      ; $8bc6: ff 18 16  Invalid Opcode - ISC $1618,x
            eor $54            ; $8bc9: 45 54     
            .hex 23 25         ; $8bcb: 23 25     Invalid Opcode - RLA ($25,x)
            bit $23            ; $8bcd: 24 23     
            and $ff            ; $8bcf: 25 ff     
            .hex 17 18         ; $8bd1: 17 18     Invalid Opcode - SLO $18,x
            .hex 17 16         ; $8bd3: 17 16     Invalid Opcode - SLO $16,x
            and $14,x          ; $8bd5: 35 14     
            ora $16,x          ; $8bd7: 15 16     
            .hex 27 28         ; $8bd9: 27 28     Invalid Opcode - RLA $28
            .hex ff 18         ; $8bdb: ff 18     Suspected data
__8bdd:     .hex 17 26         ; $8bdd: 17 26     Invalid Opcode - SLO $26,x
            lda $ff,x          ; $8bdf: b5 ff     
            .hex 17            ; $8be1: 17        Suspected data
__8be2:     ora $1718,y        ; $8be2: 19 18 17  
            rol $44,x          ; $8be5: 36 44     
__8be7:     eor $46            ; $8be7: 45 46     
            .hex 47 ff         ; $8be9: 47 ff     Invalid Opcode - SRE $ff
            .hex 42            ; $8beb: 42        Invalid Opcode - KIL 
            .hex 43 44         ; $8bec: 43 44     Invalid Opcode - SRE ($44,x)
            and $26            ; $8bee: 25 26     
            .hex 25            ; $8bf0: 25        Suspected data
__8bf1:     .hex f4            ; $8bf1: f4        Suspected data
__8bf2:     .hex ff 17 19      ; $8bf2: ff 17 19  Invalid Opcode - ISC $1917,x
            clc                ; $8bf5: 18        
            .hex 17 15         ; $8bf6: 17 15     Invalid Opcode - SLO $15,x
            ror $ff,x          ; $8bf8: 76 ff     
            .hex 17 16         ; $8bfa: 17 16     Invalid Opcode - SLO $16,x
            ora $13,x          ; $8bfc: 15 13     
            ora $14,x          ; $8bfe: 15 14     
            .hex a3 ff         ; $8c00: a3 ff     Invalid Opcode - LAX ($ff,x)
            ora $27,x          ; $8c02: 15 27     
            rol $65            ; $8c04: 26 65     
            .hex f4 ff         ; $8c06: f4 ff     Invalid Opcode - NOP $ff,x
__8c08:     .hex 82 83         ; $8c08: 82 83     Invalid Opcode - NOP #$83
            sty $85            ; $8c0a: 84 85     
            stx $ff            ; $8c0c: 86 ff     
            asl $17,x          ; $8c0e: 16 17     
            inc $ff,x          ; $8c10: f6 ff     
            .hex 14            ; $8c12: 14        Suspected data
__8c13:     asl $17,x          ; $8c13: 16 17     
            clc                ; $8c15: 18        
            .hex 12            ; $8c16: 12        Invalid Opcode - KIL 
            .hex 13 14         ; $8c17: 13 14     Invalid Opcode - SLO ($14),y
            ora $ff,x          ; $8c19: 15 ff     
__8c1b:     .hex 22            ; $8c1b: 22        Invalid Opcode - KIL 
            .hex 23 24         ; $8c1c: 23 24     Invalid Opcode - RLA ($24,x)
            and $26            ; $8c1e: 25 26     
            eor $f4            ; $8c20: 45 f4     
            .hex ff 1a 28      ; $8c22: ff 1a 28  Invalid Opcode - ISC $281a,x
            .hex 17 16         ; $8c25: 17 16     Invalid Opcode - SLO $16,x
            ora $14,x          ; $8c27: 15 14     
            ora $f6,x          ; $8c29: 15 f6     
            .hex ff 12 13      ; $8c2b: ff 12 13  Invalid Opcode - ISC $1312,x
            .hex 14 25         ; $8c2e: 14 25     Invalid Opcode - NOP $25,x
            .hex 26            ; $8c30: 26        Suspected data
__8c31:     .hex 27 16         ; $8c31: 27 16     Invalid Opcode - RLA $16
            ora $f6,x          ; $8c33: 15 f6     
            .hex ff 1a 18      ; $8c35: ff 1a 18  Invalid Opcode - ISC $181a,x
            .hex 17 16         ; $8c38: 17 16     Invalid Opcode - SLO $16,x
            ora $a4,x          ; $8c3a: 15 a4     
            .hex ff            ; $8c3c: ff        Suspected data
__8c3d:     .hex 1a            ; $8c3d: 1a        Invalid Opcode - NOP 
            clc                ; $8c3e: 18        
            .hex 17 16         ; $8c3f: 17 16     Invalid Opcode - SLO $16,x
            lda $ff            ; $8c41: a5 ff     
            clc                ; $8c43: 18        
            .hex 27            ; $8c44: 27        Suspected data
__8c45:     rol $15            ; $8c45: 26 15     
            .hex 14 85         ; $8c47: 14 85     Invalid Opcode - NOP $85,x
            ror $ff,x          ; $8c49: 76 ff     
            .hex 1a            ; $8c4b: 1a        Invalid Opcode - NOP 
            .hex 17 16         ; $8c4c: 17 16     Invalid Opcode - SLO $16,x
            .hex 13 35         ; $8c4e: 13 35     Invalid Opcode - SLO ($35),y
            .hex f4 ff         ; $8c50: f4 ff     Invalid Opcode - NOP $ff,x
            rol $25            ; $8c52: 26 25     
            bit $15            ; $8c54: 24 15     
            bit $53            ; $8c56: 24 53     
            .hex ff            ; $8c58: ff        Suspected data
__8c59:     bit $43            ; $8c59: 24 43     
            .hex 14 23         ; $8c5b: 14 23     Invalid Opcode - NOP $23,x
            .hex 62            ; $8c5d: 62        Invalid Opcode - KIL 
            .hex ff 17 26      ; $8c5e: ff 17 26  Invalid Opcode - ISC $2617,x
            and $26            ; $8c61: 25 26     
            .hex f7 ff         ; $8c63: f7 ff     Invalid Opcode - ISC $ff,x
__8c65:     .hex fb 83 44      ; $8c65: fb 83 44  Invalid Opcode - ISC $4483,y
            sta $86            ; $8c68: 85 86     
            eor $86            ; $8c6a: 45 86     
            eor $86            ; $8c6c: 45 86     
            eor $86            ; $8c6e: 45 86     
            .hex ff 18 17      ; $8c70: ff 18 17  Invalid Opcode - ISC $1718,x
            asl $f5,x          ; $8c73: 16 f5     
            .hex ff 14 16      ; $8c75: ff 14 16  Invalid Opcode - ISC $1614,x
            .hex 17 f6         ; $8c78: 17 f6     Invalid Opcode - SLO $f6,x
            sbc $f5,x          ; $8c7a: f5 f5     
            .hex f4 f4         ; $8c7c: f4 f4     Invalid Opcode - NOP $f4,x
            .hex f4 f3         ; $8c7e: f4 f3     Invalid Opcode - NOP $f3,x
            .hex f2            ; $8c80: f2        Invalid Opcode - KIL 
            .hex ff 13 15      ; $8c81: ff 13 15  Invalid Opcode - ISC $1513,x
            rol $11            ; $8c84: 26 11     
            .hex 22            ; $8c86: 22        Invalid Opcode - KIL 
            .hex 13 14         ; $8c87: 13 14     Invalid Opcode - SLO ($14),y
            .hex 25            ; $8c89: 25        Suspected data
__8c8a:     .hex ff 11 12      ; $8c8a: ff 11 12  Invalid Opcode - ISC $1211,x
__8c8d:     .hex 14 f5         ; $8c8d: 14 f5     Invalid Opcode - NOP $f5,x
            .hex ff 31 32      ; $8c8f: ff 31 32  Invalid Opcode - ISC $3231,x
            .hex 33 f4         ; $8c92: 33 f4     Invalid Opcode - RLA ($f4),y
            .hex ff 13 15      ; $8c94: ff 13 15  Invalid Opcode - ISC $1513,x
            asl $35,x          ; $8c97: 16 35     
            .hex 23 f4         ; $8c99: 23 f4     Invalid Opcode - RLA ($f4,x)
            .hex ff 15 16      ; $8c9b: ff 15 16  Invalid Opcode - ISC $1615,x
            and $14            ; $8c9e: 25 14     
            sbc $ff,x          ; $8ca0: f5 ff     
            sbc ($f1),y        ; $8ca2: f1 f1     
            .hex f2            ; $8ca4: f2        Invalid Opcode - KIL 
            .hex f2            ; $8ca5: f2        Invalid Opcode - KIL 
            .hex f3 f3         ; $8ca6: f3 f3     Invalid Opcode - ISC ($f3),y
            .hex f4 f4         ; $8ca8: f4 f4     Invalid Opcode - NOP $f4,x
            .hex f4 f4         ; $8caa: f4 f4     Invalid Opcode - NOP $f4,x
            .hex ff            ; $8cac: ff        Suspected data
__8cad:     .hex 22            ; $8cad: 22        Invalid Opcode - KIL 
            .hex 23 24         ; $8cae: 23 24     Invalid Opcode - RLA ($24,x)
            and $16            ; $8cb0: 25 16     
            sbc $f4,x          ; $8cb2: f5 f4     
            .hex ff 15         ; $8cb4: ff 15     Suspected data
__8cb6:     asl $18,x          ; $8cb6: 16 18     
            asl $25,x          ; $8cb8: 16 25     
            bit $f5            ; $8cba: 24 f5     
            sbc $f4,x          ; $8cbc: f5 f4     
            .hex f4 f4         ; $8cbe: f4 f4     Invalid Opcode - NOP $f4,x
            .hex f3 f3         ; $8cc0: f3 f3     Invalid Opcode - ISC ($f3),y
            .hex f3 f2         ; $8cc2: f3 f2     Invalid Opcode - ISC ($f2),y
            .hex f2            ; $8cc4: f2        Invalid Opcode - KIL 
            .hex f2            ; $8cc5: f2        Invalid Opcode - KIL 
            .hex f2            ; $8cc6: f2        Invalid Opcode - KIL 
            .hex ff 41 42      ; $8cc7: ff 41 42  Invalid Opcode - ISC $4241,x
            .hex 43 44         ; $8cca: 43 44     Invalid Opcode - SRE ($44,x)
            eor $46            ; $8ccc: 45 46     
            sbc $ff,x          ; $8cce: f5 ff     
__8cd0:     .hex 10            ; $8cd0: 10        Suspected data
__8cd1:     sta __8d13         ; $8cd1: 8d 13 8d  
            bit $8d            ; $8cd4: 24 8d     
            .hex 32            ; $8cd6: 32        Invalid Opcode - KIL 
            sta __8d43         ; $8cd7: 8d 43 8d  
            .hex 54            ; $8cda: 54        Suspected data
__8cdb:     sta __8d6c         ; $8cdb: 8d 6c 8d  
            adc __8c8d,x       ; $8cde: 7d 8d 8c  
            sta __8d9a         ; $8ce1: 8d 9a 8d  
            tay                ; $8ce4: a8        
            sta __8db1         ; $8ce5: 8d b1 8d  
            cmp #$8d           ; $8ce8: c9 8d     
            sbc ($8d,x)        ; $8cea: e1 8d     
            .hex eb 8d         ; $8cec: eb 8d     Invalid Opcode - SBC #$8d
            .hex f3 8d         ; $8cee: f3 8d     Invalid Opcode - ISC ($8d),y
            .hex 04 8e         ; $8cf0: 04 8e     Invalid Opcode - NOP $8e
            ora $8e,x          ; $8cf2: 15 8e     
            ora $8e,x          ; $8cf4: 15 8e     
            ora $8e,x          ; $8cf6: 15 8e     
            ora $8e,x          ; $8cf8: 15 8e     
            ora $8e,x          ; $8cfa: 15 8e     
            ora $8e,x          ; $8cfc: 15 8e     
            ora $8e,x          ; $8cfe: 15 8e     
            ora $8e,x          ; $8d00: 15 8e     
            ora $8e,x          ; $8d02: 15 8e     
            ora $8e,x          ; $8d04: 15 8e     
            ora $8e,x          ; $8d06: 15 8e     
            ora $8e,x          ; $8d08: 15 8e     
            ora $8e,x          ; $8d0a: 15 8e     
            ora $8e,x          ; $8d0c: 15 8e     
            ora $8e,x          ; $8d0e: 15 8e     
            .hex fb 1f         ; $8d10: fb 1f     Suspected data
__8d12:     .hex ff            ; $8d12: ff        Suspected data
__8d13:     .hex fb 80 fb      ; $8d13: fb 80 fb  Invalid Opcode - ISC __fb80,y
            jsr $202f          ; $8d16: 20 2f 20  
__8d19:     and ($fe,x)        ; $8d19: 21 fe     
            ora ($fb,x)        ; $8d1b: 01 fb     
            jsr $202e          ; $8d1d: 20 2e 20  
            .hex 22            ; $8d20: 22        Invalid Opcode - KIL 
            inc __ff0f,x       ; $8d21: fe 0f ff  
            .hex fb 17 15      ; $8d24: fb 17 15  Invalid Opcode - ISC $1517,y
            .hex 13 11         ; $8d27: 13 11     Invalid Opcode - SLO ($11),y
            cpy #$fb           ; $8d29: c0 fb     
            jsr $202f          ; $8d2b: 20 2f 20  
            and ($fe,x)        ; $8d2e: 21 fe     
            .hex 0f ff         ; $8d30: 0f ff     Suspected data
__8d32:     .hex fb e0 fb      ; $8d32: fb e0 fb  Invalid Opcode - ISC __fbe0,y
            bpl __8d66         ; $8d35: 10 2f     
            jsr __fe21         ; $8d37: 20 21 fe  
            .hex 02            ; $8d3a: 02        Invalid Opcode - KIL 
            .hex fb 10 2e      ; $8d3b: fb 10 2e  Invalid Opcode - ISC $2e10,y
            jsr __fe22         ; $8d3e: 20 22 fe  
            .hex 0f ff         ; $8d41: 0f ff     Suspected data
__8d43:     .hex fb 80 fb      ; $8d43: fb 80 fb  Invalid Opcode - ISC __fb80,y
            .hex 2f 20 21      ; $8d46: 2f 20 21  Invalid Opcode - RLA $2120
            .hex 20 fe         ; $8d49: 20 fe     Suspected data
__8d4b:     .hex 03 fb         ; $8d4b: 03 fb     Invalid Opcode - SLO ($fb,x)
            jsr $202e          ; $8d4d: 20 2e 20  
            .hex 22            ; $8d50: 22        Invalid Opcode - KIL 
            inc __ff0f,x       ; $8d51: fe 0f ff  
            .hex fb 80 fb      ; $8d54: fb 80 fb  Invalid Opcode - ISC __fb80,y
            .hex 2f 20 21      ; $8d57: 2f 20 21  Invalid Opcode - RLA $2120
            jsr $02fe          ; $8d5a: 20 fe 02  
            .hex fb 20 2e      ; $8d5d: fb 20 2e  Invalid Opcode - ISC $2e20,y
            jsr __fe22         ; $8d60: 20 22 fe  
            .hex 02            ; $8d63: 02        Invalid Opcode - KIL 
            .hex fb            ; $8d64: fb        Suspected data
__8d65:     .hex 20            ; $8d65: 20        Suspected data
__8d66:     and $2320          ; $8d66: 2d 20 23  
            .hex fe            ; $8d69: fe        Suspected data
__8d6a:     .hex 0f ff         ; $8d6a: 0f ff     Suspected data
__8d6c:     .hex fb 70 fb      ; $8d6c: fb 70 fb  Invalid Opcode - ISC __fb70,y
            bpl __8da0         ; $8d6f: 10 2f     
            jsr __fe21         ; $8d71: 20 21 fe  
            .hex 02            ; $8d74: 02        Invalid Opcode - KIL 
            .hex fb            ; $8d75: fb        Suspected data
__8d76:     bpl __8da6         ; $8d76: 10 2e     
            jsr __fe22         ; $8d78: 20 22 fe  
            .hex 0f ff fb      ; $8d7b: 0f ff fb  Invalid Opcode - SLO __fbff
            .hex 17 15         ; $8d7e: 17 15     Invalid Opcode - SLO $15,x
            .hex 13 12         ; $8d80: 13 12     Invalid Opcode - SLO ($12),y
            ora ($f0),y        ; $8d82: 11 f0     
            .hex fb 1f 10      ; $8d84: fb 1f 10  Invalid Opcode - ISC $101f,y
            ora ($10),y        ; $8d87: 11 10     
            inc __ff0f,x       ; $8d89: fe 0f ff  
            .hex fb fb 20      ; $8d8c: fb fb 20  Invalid Opcode - ISC $20fb,y
            .hex 2f 20 21      ; $8d8f: 2f 20 21  Invalid Opcode - RLA $2120
            jsr $202e          ; $8d92: 20 2e 20  
            .hex 22            ; $8d95: 22        Invalid Opcode - KIL 
            jsr $0ffe          ; $8d96: 20 fe 0f  
            .hex ff            ; $8d99: ff        Suspected data
__8d9a:     .hex fb fb 2f      ; $8d9a: fb fb 2f  Invalid Opcode - ISC $2ffb,y
            rol $202f          ; $8d9d: 2e 2f 20  
__8da0:     .hex 2f 2d 2f      ; $8da0: 2f 2d 2f  Invalid Opcode - RLA $2f2d
            and ($2f,x)        ; $8da3: 21 2f     
            .hex fe            ; $8da5: fe        Suspected data
__8da6:     .hex 0f ff fb      ; $8da6: 0f ff fb  Invalid Opcode - SLO __fbff
            .hex fb            ; $8da9: fb        Suspected data
__8daa:     jsr $202f          ; $8daa: 20 2f 20  
            and ($fe,x)        ; $8dad: 21 fe     
            .hex 0f ff         ; $8daf: 0f ff     Suspected data
__8db1:     .hex fb e0 fb      ; $8db1: fb e0 fb  Invalid Opcode - ISC __fbe0,y
            jsr $202f          ; $8db4: 20 2f 20  
            and ($fe,x)        ; $8db7: 21 fe     
            .hex 02            ; $8db9: 02        Invalid Opcode - KIL 
            .hex fb 20 2e      ; $8dba: fb 20 2e  Invalid Opcode - ISC $2e20,y
            jsr __fe22         ; $8dbd: 20 22 fe  
            .hex 02            ; $8dc0: 02        Invalid Opcode - KIL 
            .hex fb 20 2d      ; $8dc1: fb 20 2d  Invalid Opcode - ISC $2d20,y
            jsr __fe23         ; $8dc4: 20 23 fe  
            .hex 0f ff fb      ; $8dc7: 0f ff fb  Invalid Opcode - SLO __fbff
            .hex ef fb 2f      ; $8dca: ef fb 2f  Invalid Opcode - ISC $2ffb
            rol $202f          ; $8dcd: 2e 2f 20  
            inc __fb02,x       ; $8dd0: fe 02 fb  
            .hex 2f 2d 2f      ; $8dd3: 2f 2d 2f  Invalid Opcode - RLA $2f2d
            and ($fe,x)        ; $8dd6: 21 fe     
            .hex 02            ; $8dd8: 02        Invalid Opcode - KIL 
            .hex fb 2f 2c      ; $8dd9: fb 2f 2c  Invalid Opcode - ISC $2c2f,y
            .hex 2f 22 fe      ; $8ddc: 2f 22 fe  Invalid Opcode - RLA __fe22
            .hex 0f ff fb      ; $8ddf: 0f ff fb  Invalid Opcode - SLO __fbff
            .hex 90            ; $8de2: 90        Suspected data
__8de3:     .hex fb 30 3f      ; $8de3: fb 30 3f  Invalid Opcode - ISC $3f30,y
            .hex 30            ; $8de6: 30        Suspected data
__8de7:     and ($fe),y        ; $8de7: 31 fe     
            .hex 0f            ; $8de9: 0f        Suspected data
__8dea:     .hex ff fb 17      ; $8dea: ff fb 17  Invalid Opcode - ISC $17fb,x
            .hex 15            ; $8ded: 15        Suspected data
__8dee:     .hex 13 12         ; $8dee: 13 12     Invalid Opcode - SLO ($12),y
            and ($f0,x)        ; $8df0: 21 f0     
            .hex ff fb 8f      ; $8df2: ff fb 8f  Invalid Opcode - ISC __8ffb,x
            .hex fb 2f 2e      ; $8df5: fb 2f 2e  Invalid Opcode - ISC $2e2f,y
            .hex 2f 20 fe      ; $8df8: 2f 20 fe  Invalid Opcode - RLA __fe20
            .hex 04 fb         ; $8dfb: 04 fb     Invalid Opcode - NOP $fb
__8dfd:     .hex 2f            ; $8dfd: 2f        Suspected data
__8dfe:     .hex 2d            ; $8dfe: 2d        Suspected data
__8dff:     .hex 2f 21 fe      ; $8dff: 2f 21 fe  Invalid Opcode - RLA __fe21
            .hex 0f ff fb      ; $8e02: 0f ff fb  Invalid Opcode - SLO __fbff
            .hex 80 fb         ; $8e05: 80 fb     Invalid Opcode - NOP #$fb
            jsr $202f          ; $8e07: 20 2f 20  
            .hex 21            ; $8e0a: 21        Suspected data
__8e0b:     inc __fb04,x       ; $8e0b: fe 04 fb  
            jsr $202e          ; $8e0e: 20 2e 20  
            .hex 22            ; $8e11: 22        Invalid Opcode - KIL 
            inc __ff0f,x       ; $8e12: fe 0f ff  
            .hex ff eb         ; $8e15: ff eb     Suspected data
__8e17:     .hex f1            ; $8e17: f1        Suspected data
__8e18:     ora ($e9,x)        ; $8e18: 01 e9     
            and ($d8),y        ; $8e1a: 31 d8     
            adc ($01),y        ; $8e1c: 71 01     
            eor $e2,x          ; $8e1e: 55 e2     
            .hex 71            ; $8e20: 71        Suspected data
__8e21:     .hex e3 70         ; $8e21: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e2 5a         ; $8e23: e2 5a     Invalid Opcode - NOP #$5a
            .hex e2            ; $8e25: e2        Suspected data
__8e26:     rti                ; $8e26: 40        

;-------------------------------------------------------------------------------
            bvc __8e6b         ; $8e27: 50 42     
            plp                ; $8e29: 28        
            .hex e3 a0         ; $8e2a: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex 90            ; $8e2c: 90        Suspected data
__8e2d:     ldy #$e2           ; $8e2d: a0 e2     
            brk                ; $8e2f: 00        
            .hex e2 70         ; $8e30: e2 70     Invalid Opcode - NOP #$70
            bvs __8e17         ; $8e32: 70 e3     
            bvs __8e18         ; $8e34: 70 e2     
            cli                ; $8e36: 58        
            .hex e3 a0         ; $8e37: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 00         ; $8e39: e2 00     Invalid Opcode - NOP #$00
            rti                ; $8e3b: 40        

;-------------------------------------------------------------------------------
            bvc __8e80         ; $8e3c: 50 42     
            plp                ; $8e3e: 28        
            .hex e3 a0         ; $8e3f: e3 a0     Invalid Opcode - ISC ($a0,x)
            bcc __8de3         ; $8e41: 90 a0     
            .hex e2 00         ; $8e43: e2 00     Invalid Opcode - NOP #$00
            sbc #$34           ; $8e45: e9 34     
            .hex eb 01         ; $8e47: eb 01     Invalid Opcode - SBC #$01
            ora ($d8,x)        ; $8e49: 01 d8     
            lda ($00),y        ; $8e4b: b1 00     
            .hex 16            ; $8e4d: 16        Suspected data
__8e4e:     .hex fb e2 20      ; $8e4e: fb e2 20  Invalid Opcode - ISC $20e2,y
            bpl __8e53         ; $8e51: 10 00     
__8e53:     .hex e3 7a         ; $8e53: e3 7a     Invalid Opcode - ISC ($7a,x)
            bvs __8de7         ; $8e55: 70 90     
__8e57:     .hex 72            ; $8e57: 72        Invalid Opcode - KIL 
            .hex 62            ; $8e58: 62        Invalid Opcode - KIL 
            .hex 92            ; $8e59: 92        Invalid Opcode - KIL 
            .hex e2 02         ; $8e5a: e2 02     Invalid Opcode - NOP #$02
            and ($61),y        ; $8e5c: 31 61     
            .hex fe 02         ; $8e5e: fe 02     Suspected data
__8e60:     sbc #$34           ; $8e60: e9 34     
            .hex eb            ; $8e62: eb        Suspected data
__8e63:     ora ($01,x)        ; $8e63: 01 01     
            cld                ; $8e65: d8        
            lda $1782,y        ; $8e66: b9 82 17  
            beq __8e4e         ; $8e69: f0 e3     
__8e6b:     bcc __8e60         ; $8e6b: 90 f3     
            bcc __8e63         ; $8e6d: 90 f4     
            bcc __8e63         ; $8e6f: 90 f2     
            and ($60,x)        ; $8e71: 21 60     
            bcc __8e57         ; $8e73: 90 e2     
            brk                ; $8e75: 00        
            sbc ($e3),y        ; $8e76: f1 e3     
            ldy #$f3           ; $8e78: a0 f3     
            ldy #$f4           ; $8e7a: a0 f4     
            ldy #$f5           ; $8e7c: a0 f5     
            ldy #$f2           ; $8e7e: a0 f2     
__8e80:     jsr __a070         ; $8e80: 20 70 a0  
            .hex e2            ; $8e83: e2        Suspected data
__8e84:     jsr $00f1          ; $8e84: 20 f1 00  
            .hex f3            ; $8e87: f3        Suspected data
__8e88:     brk                ; $8e88: 00        
            .hex f4            ; $8e89: f4        Suspected data
__8e8a:     brk                ; $8e8a: 00        
__8e8b:     .hex f2            ; $8e8b: f2        Invalid Opcode - KIL 
__8e8c:     .hex e3 51         ; $8e8c: e3 51     Invalid Opcode - ISC ($51,x)
__8e8e:     .hex 90            ; $8e8e: 90        Suspected data
__8e8f:     .hex e2 00         ; $8e8f: e2 00     Invalid Opcode - NOP #$00
            bvc __8e84         ; $8e91: 50 f1     
            bmi __8e88         ; $8e93: 30 f3     
            bmi __8e8b         ; $8e95: 30 f4     
            bmi __8e8e         ; $8e97: 30 f5     
            bmi __8e8c         ; $8e99: 30 f1     
            .hex 20 f3         ; $8e9b: 20 f3     Suspected data
__8e9d:     jsr $20f4          ; $8e9d: 20 f4 20  
            sbc $20,x          ; $8ea0: f5 20     
            sbc ($20),y        ; $8ea2: f1 20     
            .hex f3            ; $8ea4: f3        Suspected data
__8ea5:     jsr $20f4          ; $8ea5: 20 f4 20  
__8ea8:     .hex f2            ; $8ea8: f2        Invalid Opcode - KIL 
__8ea9:     .hex e3 71         ; $8ea9: e3 71     Invalid Opcode - ISC ($71,x)
__8eab:     bcs __8e8f         ; $8eab: b0 e2     
__8ead:     jsr __f170         ; $8ead: 20 70 f1  
__8eb0:     .hex 50            ; $8eb0: 50        Suspected data
__8eb1:     .hex f3 50         ; $8eb1: f3 50     Invalid Opcode - ISC ($50),y
__8eb3:     .hex f4 50         ; $8eb3: f4 50     Invalid Opcode - NOP $50,x
            sbc $50,x          ; $8eb5: f5 50     
            sbc ($30),y        ; $8eb7: f1 30     
            .hex f3 30         ; $8eb9: f3 30     Invalid Opcode - ISC ($30),y
            .hex f4 30         ; $8ebb: f4 30     Invalid Opcode - NOP $30,x
            sbc $30,x          ; $8ebd: f5 30     
            sbc ($e7),y        ; $8ebf: f1 e7     
            ora ($74,x)        ; $8ec1: 01 74     
            bpl __8f05         ; $8ec3: 10 40     
            bvs __8f2e         ; $8ec5: 70 67     
            sbc #$35           ; $8ec7: e9 35     
            .hex eb 01         ; $8ec9: eb 01     Invalid Opcode - SBC #$01
            .hex 02            ; $8ecb: 02        Invalid Opcode - KIL 
            cld                ; $8ecc: d8        
            adc ($05),y        ; $8ecd: 71 05     
            .hex 17 e2         ; $8ecf: 17 e2     Invalid Opcode - SLO $e2,x
            .hex 72            ; $8ed1: 72        Invalid Opcode - KIL 
            .hex e2 52         ; $8ed2: e2 52     Invalid Opcode - NOP #$52
            .hex eb 01         ; $8ed4: eb 01     Invalid Opcode - SBC #$01
            ora ($e2,x)        ; $8ed6: 01 e2     
            and #$e7           ; $8ed8: 29 e7     
            .hex 03 e3         ; $8eda: 03 e3     Invalid Opcode - SLO ($e3,x)
            brk                ; $8edc: 00        
            .hex e2 00         ; $8edd: e2 00     Invalid Opcode - NOP #$00
            sbc ($00,x)        ; $8edf: e1 00     
            cpx $60            ; $8ee1: e4 60     
            .hex e3 60         ; $8ee3: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 60         ; $8ee5: e2 60     Invalid Opcode - NOP #$60
            .hex e7 05         ; $8ee7: e7 05     Invalid Opcode - ISC $05
            .hex e3 79         ; $8ee9: e3 79     Invalid Opcode - ISC ($79,x)
__8eeb:     .hex eb 03         ; $8eeb: eb 03     Invalid Opcode - SBC #$03
            .hex 02            ; $8eed: 02        Invalid Opcode - KIL 
__8eee:     .hex e3 72         ; $8eee: e3 72     Invalid Opcode - ISC ($72,x)
            .hex e3 52         ; $8ef0: e3 52     Invalid Opcode - ISC ($52,x)
            .hex eb 01         ; $8ef2: eb 01     Invalid Opcode - SBC #$01
            ora ($e3,x)        ; $8ef4: 01 e3     
            and #$e7           ; $8ef6: 29 e7     
            .hex 03 e3         ; $8ef8: 03 e3     Invalid Opcode - SLO ($e3,x)
            brk                ; $8efa: 00        
            brk                ; $8efb: 00        
            brk                ; $8efc: 00        
            cpx $60            ; $8efd: e4 60     
            rts                ; $8eff: 60        

;-------------------------------------------------------------------------------
            rts                ; $8f00: 60        

;-------------------------------------------------------------------------------
            .hex 73 e4         ; $8f01: 73 e4     Invalid Opcode - RRA ($e4),y
            .hex 70            ; $8f03: 70        Suspected data
__8f04:     .hex e3            ; $8f04: e3        Suspected data
__8f05:     bvs __8eeb         ; $8f05: 70 e4     
            jsr __9060         ; $8f07: 20 60 90  
            .hex e3 20         ; $8f0a: e3 20     Invalid Opcode - ISC ($20,x)
            inc $45ff,x        ; $8f0c: fe ff 45  
            stx __f1eb         ; $8f0f: 8e eb f1  
            ora ($e9,x)        ; $8f12: 01 e9     
            and ($d8),y        ; $8f14: 31 d8     
            bvs __8f19         ; $8f16: 70 01     
            .hex 55            ; $8f18: 55        Suspected data
__8f19:     sbc ($e3),y        ; $8f19: f1 e3     
__8f1b:     lda ($f2,x)        ; $8f1b: a1 f2     
            cpx $a0            ; $8f1d: e4 a0     
            .hex e2 0a         ; $8f1f: e2 0a     Invalid Opcode - NOP #$0a
            .hex e2 00         ; $8f21: e2 00     Invalid Opcode - NOP #$00
            jsr __e302         ; $8f23: 20 02 e3  
            tay                ; $8f26: a8        
            sbc ($e3),y        ; $8f27: f1 e3     
            bvc __8f6b         ; $8f29: 50 40     
            bvc __8f9d         ; $8f2b: 50 70     
            .hex e3            ; $8f2d: e3        Suspected data
__8f2e:     ldy #$f2           ; $8f2e: a0 f2     
            ldy #$e4           ; $8f30: a0 e4     
            ldy #$e2           ; $8f32: a0 e2     
            php                ; $8f34: 08        
            .hex e3 70         ; $8f35: e3 70     Invalid Opcode - ISC ($70,x)
            bcc __8f1b         ; $8f37: 90 e2     
            brk                ; $8f39: 00        
            jsr __e302         ; $8f3a: 20 02 e3  
            tay                ; $8f3d: a8        
            sbc ($e3),y        ; $8f3e: f1 e3     
            bvc __8f82         ; $8f40: 50 40     
            bvc __8fb4         ; $8f42: 50 70     
            .hex fb eb 00      ; $8f44: fb eb 00  Invalid Opcode - ISC $00eb,y
            brk                ; $8f47: 00        
            sbc #$34           ; $8f48: e9 34     
            cld                ; $8f4a: d8        
            bvs __8f4f         ; $8f4b: 70 02     
            .hex 17 f2         ; $8f4d: 17 f2     Invalid Opcode - SLO $f2,x
__8f4f:     .hex e3            ; $8f4f: e3        Suspected data
__8f50:     lda ($e4,x)        ; $8f50: a1 e4     
            .hex 20            ; $8f52: 20        Suspected data
__8f53:     .hex e3 22         ; $8f53: e3 22     Invalid Opcode - ISC ($22,x)
            .hex 12            ; $8f55: 12        Invalid Opcode - KIL 
            .hex 02            ; $8f56: 02        Invalid Opcode - KIL 
            cpx $a1            ; $8f57: e4 a1     
            bvs __8eeb         ; $8f59: 70 90     
            sbc #$31           ; $8f5b: e9 31     
__8f5d:     sbc ($e7),y        ; $8f5d: f1 e7     
            .hex 03 e6         ; $8f5f: 03 e6     Invalid Opcode - SLO ($e6,x)
            ora ($e5,x)        ; $8f61: 01 e5     
            jsr $2ee4          ; $8f63: 20 e4 2e  
            sbc $20            ; $8f66: e5 20     
            cpx $2e            ; $8f68: e4 2e     
            .hex e4            ; $8f6a: e4        Suspected data
__8f6b:     .hex 20 e3         ; $8f6b: 20 e3     Suspected data
__8f6d:     .hex 2e e5         ; $8f6d: 2e e5     Suspected data
__8f6f:     jsr $26e4          ; $8f6f: 20 e4 26  
            sbc $20            ; $8f72: e5 20     
            cpx $26            ; $8f74: e4 26     
            sbc $70            ; $8f76: e5 70     
            cpx $76            ; $8f78: e4 76     
            sbc $80            ; $8f7a: e5 80     
            cpx $86            ; $8f7c: e4 86     
            sbc $90            ; $8f7e: e5 90     
            cpx $9e            ; $8f80: e4 9e     
__8f82:     cpx $20            ; $8f82: e4 20     
            .hex e3 26         ; $8f84: e3 26     Invalid Opcode - ISC ($26,x)
            cpx $20            ; $8f86: e4 20     
            .hex e3 26         ; $8f88: e3 26     Invalid Opcode - ISC ($26,x)
            sbc $20            ; $8f8a: e5 20     
            .hex e4            ; $8f8c: e4        Suspected data
__8f8d:     rol $e4            ; $8f8d: 26 e4     
            jsr $26e3          ; $8f8f: 20 e3 26  
            inc __eb02,x       ; $8f92: fe 02 eb  
            ora ($01,x)        ; $8f95: 01 01     
            sbc #$31           ; $8f97: e9 31     
            cld                ; $8f99: d8        
            bvs __8f9f         ; $8f9a: 70 03     
            .hex 16            ; $8f9c: 16        Suspected data
__8f9d:     sbc ($e5),y        ; $8f9d: f1 e5     
__8f9f:     rts                ; $8f9f: 60        

;-------------------------------------------------------------------------------
            rts                ; $8fa0: 60        

;-------------------------------------------------------------------------------
            cpx $60            ; $8fa1: e4 60     
            sbc $60            ; $8fa3: e5 60     
            .hex f2            ; $8fa5: f2        Invalid Opcode - KIL 
            .hex e7 02         ; $8fa6: e7 02     Invalid Opcode - ISC $02
            .hex e2 03         ; $8fa8: e2 03     Invalid Opcode - NOP #$03
            .hex e7 03         ; $8faa: e7 03     Invalid Opcode - ISC $03
            sbc ($e5),y        ; $8fac: f1 e5     
            bvs __9020         ; $8fae: 70 70     
            cpx $70            ; $8fb0: e4 70     
            sbc $70            ; $8fb2: e5 70     
__8fb4:     .hex f2            ; $8fb4: f2        Invalid Opcode - KIL 
            .hex e7 02         ; $8fb5: e7 02     Invalid Opcode - ISC $02
            cpx $a0            ; $8fb7: e4 a0     
            .hex e3 20         ; $8fb9: e3 20     Invalid Opcode - ISC ($20,x)
            bvs __8f5d         ; $8fbb: 70 a0     
            sbc ($e7),y        ; $8fbd: f1 e7     
            .hex 03 e5         ; $8fbf: 03 e5     Invalid Opcode - SLO ($e5,x)
            bcc __8f53         ; $8fc1: 90 90     
            cpx $90            ; $8fc3: e4 90     
            sbc $90            ; $8fc5: e5 90     
            .hex f2            ; $8fc7: f2        Invalid Opcode - KIL 
            .hex e7 02         ; $8fc8: e7 02     Invalid Opcode - ISC $02
            .hex e2 03         ; $8fca: e2 03     Invalid Opcode - NOP #$03
            sbc ($e7),y        ; $8fcc: f1 e7     
            .hex 03 e5         ; $8fce: 03 e5     Invalid Opcode - SLO ($e5,x)
            ldy #$a0           ; $8fd0: a0 a0     
            cpx $a0            ; $8fd2: e4 a0     
            sbc $a0            ; $8fd4: e5 a0     
            .hex f2            ; $8fd6: f2        Invalid Opcode - KIL 
            .hex e7 02         ; $8fd7: e7 02     Invalid Opcode - ISC $02
            .hex e3 a0         ; $8fd9: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 20         ; $8fdb: e2 20     Invalid Opcode - NOP #$20
            bvc __8f6f         ; $8fdd: 50 90     
            .hex 82 24         ; $8fdf: 82 24     Invalid Opcode - NOP #$24
            .hex e2 03         ; $8fe1: e2 03     Invalid Opcode - NOP #$03
            .hex e3 73         ; $8fe3: e3 73     Invalid Opcode - ISC ($73,x)
            .hex 44 40         ; $8fe5: 44 40     Invalid Opcode - NOP $40
            rti                ; $8fe7: 40        

;-------------------------------------------------------------------------------
            rti                ; $8fe8: 40        

;-------------------------------------------------------------------------------
            .hex e7 04         ; $8fe9: e7 04     Invalid Opcode - ISC $04
            .hex f2            ; $8feb: f2        Invalid Opcode - KIL 
            inc $01            ; $8fec: e6 01     
            cpx $60            ; $8fee: e4 60     
__8ff0:     .hex e3 66         ; $8ff0: e3 66     Invalid Opcode - ISC ($66,x)
            cpx $90            ; $8ff2: e4 90     
            .hex e3 96         ; $8ff4: e3 96     Invalid Opcode - ISC ($96,x)
            .hex e3 00         ; $8ff6: e3 00     Invalid Opcode - ISC ($00,x)
            .hex e2 06         ; $8ff8: e2 06     Invalid Opcode - NOP #$06
            cpx $30            ; $8ffa: e4 30     
            .hex e3 36         ; $8ffc: e3 36     Invalid Opcode - ISC ($36,x)
            cpx $60            ; $8ffe: e4 60     
            .hex e3 66         ; $9000: e3 66     Invalid Opcode - ISC ($66,x)
            cpx $90            ; $9002: e4 90     
            .hex e3 96         ; $9004: e3 96     Invalid Opcode - ISC ($96,x)
            cpx $00            ; $9006: e4 00     
            .hex e3            ; $9008: e3        Suspected data
__9009:     asl $e4            ; $9009: 06 e4     
            bmi __8ff0         ; $900b: 30 e3     
            rol $eb,x          ; $900d: 36 eb     
            .hex 01            ; $900f: 01        Suspected data
__9010:     .hex 02            ; $9010: 02        Invalid Opcode - KIL 
__9011:     sbc #$75           ; $9011: e9 75     
            cld                ; $9013: d8        
            .hex 31            ; $9014: 31        Suspected data
__9015:     ora $17            ; $9015: 05 17     
            .hex e2 22         ; $9017: e2 22     Invalid Opcode - NOP #$22
            .hex e2 02         ; $9019: e2 02     Invalid Opcode - NOP #$02
            .hex eb 01         ; $901b: eb 01     Invalid Opcode - SBC #$01
            ora ($e3,x)        ; $901d: 01 e3     
            .hex a3            ; $901f: a3        Suspected data
__9020:     .hex e7 03         ; $9020: e7 03     Invalid Opcode - ISC $03
            cpx $a0            ; $9022: e4 a0     
            .hex 90            ; $9024: 90        Suspected data
__9025:     .hex a0            ; $9025: a0        Suspected data
__9026:     bvc __9078         ; $9026: 50 50     
            sbc $a0            ; $9028: e5 a0     
            .hex e4            ; $902a: e4        Suspected data
__902b:     bvs __9010         ; $902b: 70 e3     
            bvs __9011         ; $902d: 70 e2     
            bvs __9015         ; $902f: 70 e4     
            jsr $20e3          ; $9031: 20 e3 20  
            .hex e2 20         ; $9034: e2 20     Invalid Opcode - NOP #$20
            .hex e7 05         ; $9036: e7 05     Invalid Opcode - ISC $05
            .hex e3 23         ; $9038: e3 23     Invalid Opcode - ISC ($23,x)
            .hex e7 03         ; $903a: e7 03     Invalid Opcode - ISC $03
__903c:     cpx $70            ; $903c: e4 70     
            bvs __90b0         ; $903e: 70 70     
            sbc $71            ; $9040: e5 71     
            bvs __902b         ; $9042: 70 e7     
__9044:     ora $eb            ; $9044: 05 eb     
            .hex 03 02         ; $9046: 03 02     Invalid Opcode - SLO ($02,x)
            .hex e3 22         ; $9048: e3 22     Invalid Opcode - ISC ($22,x)
            .hex e3 02         ; $904a: e3 02     Invalid Opcode - ISC ($02,x)
            .hex eb 01         ; $904c: eb 01     Invalid Opcode - SBC #$01
            ora ($e4,x)        ; $904e: 01 e4     
            .hex a3 e7         ; $9050: a3 e7     Invalid Opcode - LAX ($e7,x)
            .hex 03 e5         ; $9052: 03 e5     Invalid Opcode - SLO ($e5,x)
            ldy #$a0           ; $9054: a0 a0     
__9056:     cpx $a0            ; $9056: e4 a0     
            sbc $a1            ; $9058: e5 a1     
            ldy #$e4           ; $905a: a0 e4     
            bvs __90ce         ; $905c: 70 70     
            bvs __9044         ; $905e: 70 e4     
__9060:     jsr $2020          ; $9060: 20 20 20  
            .hex e7 05         ; $9063: e7 05     Invalid Opcode - ISC $05
            .hex e4            ; $9065: e4        Suspected data
__9066:     .hex 23 e7         ; $9066: 23 e7     Invalid Opcode - RLA ($e7,x)
            .hex 03 e5         ; $9068: 03 e5     Invalid Opcode - SLO ($e5,x)
            .hex 70            ; $906a: 70        Suspected data
__906b:     cpx $70            ; $906b: e4 70     
            sbc $20            ; $906d: e5 20     
            rts                ; $906f: 60        

;-------------------------------------------------------------------------------
            bcc __9056         ; $9070: 90 e4     
            jsr $fffe          ; $9072: 20 fe ff  
            .hex 44 8f         ; $9075: 44 8f     Invalid Opcode - NOP $8f
            .hex fb            ; $9077: fb        Suspected data
__9078:     cld                ; $9078: d8        
            .hex 1a            ; $9079: 1a        Invalid Opcode - NOP 
            cpx $71            ; $907a: e4 71     
            adc ($e3),y        ; $907c: 71 e3     
__907e:     adc ($e4),y        ; $907e: 71 e4     
            bvs __90f2         ; $9080: 70 70     
            bvs __9025         ; $9082: 70 a1     
            bcc __9026         ; $9084: 90 a0     
            bcs __906b         ; $9086: b0 e3     
            jsr __e420         ; $9088: 20 20 e4  
            adc ($71),y        ; $908b: 71 71     
            .hex e3 71         ; $908d: e3 71     Invalid Opcode - ISC ($71,x)
            cpx $70            ; $908f: e4 70     
            .hex 70            ; $9091: 70        Suspected data
__9092:     ldy #$a0           ; $9092: a0 a0     
            .hex e3 a0         ; $9094: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpx $a0            ; $9096: e4 a0     
            .hex e3 a0         ; $9098: e3 a0     Invalid Opcode - ISC ($a0,x)
            bcc __903c         ; $909a: 90 a0     
            .hex e2 00         ; $909c: e2 00     Invalid Opcode - NOP #$00
            .hex fe 02         ; $909e: fe 02     Suspected data
__90a0:     .hex fb e4         ; $90a0: fb e4     Suspected data
__90a2:     adc ($71),y        ; $90a2: 71 71     
            ldy #$90           ; $90a4: a0 90     
            bvs __90c8         ; $90a6: 70 20     
            adc ($71),y        ; $90a8: 71 71     
            .hex e3 70         ; $90aa: e3 70     Invalid Opcode - ISC ($70,x)
            bvs __9092         ; $90ac: 70 e4     
            ldy #$70           ; $90ae: a0 70     
__90b0:     .hex e3 21         ; $90b0: e3 21     Invalid Opcode - ISC ($21,x)
            .hex 21            ; $90b2: 21        Suspected data
__90b3:     .hex e2 21         ; $90b3: e2 21     Invalid Opcode - NOP #$21
            .hex e3            ; $90b5: e3        Suspected data
__90b6:     .hex 21            ; $90b6: 21        Suspected data
__90b7:     brk                ; $90b7: 00        
            bpl __90db         ; $90b8: 10 21     
            .hex e2 20         ; $90ba: e2 20     Invalid Opcode - NOP #$20
            .hex 20            ; $90bc: 20        Suspected data
__90bd:     .hex e3 20         ; $90bd: e3 20     Invalid Opcode - ISC ($20,x)
            .hex e2 20         ; $90bf: e2 20     Invalid Opcode - NOP #$20
            .hex fe            ; $90c1: fe        Suspected data
__90c2:     .hex 02            ; $90c2: 02        Invalid Opcode - KIL 
            cpx $60            ; $90c3: e4 60     
            rts                ; $90c5: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $90c6: e3 60     Invalid Opcode - ISC ($60,x)
__90c8:     cpx $60            ; $90c8: e4 60     
            sta ($20),y        ; $90ca: 91 20     
            rts                ; $90cc: 60        

;-------------------------------------------------------------------------------
            .hex 70            ; $90cd: 70        Suspected data
__90ce:     .hex 70            ; $90ce: 70        Suspected data
__90cf:     .hex e3 70         ; $90cf: e3 70     Invalid Opcode - ISC ($70,x)
            cpx $70            ; $90d1: e4 70     
            .hex e3 71         ; $90d3: e3 71     Invalid Opcode - ISC ($71,x)
            cpx $70            ; $90d5: e4 70     
            bvs __90bd         ; $90d7: 70 e4     
            bcc __906b         ; $90d9: 90 90     
__90db:     .hex e3 90         ; $90db: e3 90     Invalid Opcode - ISC ($90,x)
            cpx $90            ; $90dd: e4 90     
            .hex e3 91         ; $90df: e3 91     Invalid Opcode - ISC ($91,x)
            bvc __9133         ; $90e1: 50 50     
            .hex e4            ; $90e3: e4        Suspected data
__90e4:     ldy #$a0           ; $90e4: a0 a0     
            .hex e3 a0         ; $90e6: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpx $a0            ; $90e8: e4 a0     
            ldy #$e3           ; $90ea: a0 e3     
__90ec:     bcc __907e         ; $90ec: 90 90     
__90ee:     ldy #$e4           ; $90ee: a0 e4     
            .hex b0            ; $90f0: b0        Suspected data
__90f1:     .hex b0            ; $90f1: b0        Suspected data
__90f2:     .hex e3 b0         ; $90f2: e3 b0     Invalid Opcode - ISC ($b0,x)
__90f4:     cpx $b0            ; $90f4: e4 b0     
__90f6:     cpx $b1            ; $90f6: e4 b1     
            .hex e3            ; $90f8: e3        Suspected data
__90f9:     .hex b0            ; $90f9: b0        Suspected data
__90fa:     cpx $b0            ; $90fa: e4 b0     
            .hex e3 00         ; $90fc: e3 00     Invalid Opcode - ISC ($00,x)
            brk                ; $90fe: 00        
            .hex e2 00         ; $90ff: e2 00     Invalid Opcode - NOP #$00
            .hex e3 00         ; $9101: e3 00     Invalid Opcode - ISC ($00,x)
            .hex e2 01         ; $9103: e2 01     Invalid Opcode - NOP #$01
            cpx $70            ; $9105: e4 70     
            bvs __90ec         ; $9107: 70 e3     
            bpl __911b         ; $9109: 10 10     
            .hex e2 10         ; $910b: e2 10     Invalid Opcode - NOP #$10
            .hex e3 10         ; $910d: e3 10     Invalid Opcode - ISC ($10,x)
            cpx $90            ; $910f: e4 90     
            bcs __90f6         ; $9111: b0 e3     
            bpl __90f9         ; $9113: 10 e4     
            .hex 90            ; $9115: 90        Suspected data
__9116:     .hex e3            ; $9116: e3        Suspected data
__9117:     jsr $0020          ; $9117: 20 20 00  
            .hex 10            ; $911a: 10        Suspected data
__911b:     jsr $70e4          ; $911b: 20 e4 70  
            .hex 80 e3         ; $911e: 80 e3     Invalid Opcode - NOP #$e3
            .hex 50            ; $9120: 50        Suspected data
__9121:     cpx $71            ; $9121: e4 71     
            .hex e3 70         ; $9123: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e4            ; $9125: e4        Suspected data
__9126:     sta ($e3),y        ; $9126: 91 e3     
            .hex 90            ; $9128: 90        Suspected data
__9129:     cpx $a3            ; $9129: e4 a3     
__912b:     .hex e3 a0         ; $912b: e3 a0     Invalid Opcode - ISC ($a0,x)
__912d:     .hex 90            ; $912d: 90        Suspected data
__912e:     ldy #$50           ; $912e: a0 50     
            bvc __9116         ; $9130: 50 e4     
            .hex a0            ; $9132: a0        Suspected data
__9133:     .hex e3 00         ; $9133: e3 00     Invalid Opcode - ISC ($00,x)
            brk                ; $9135: 00        
            brk                ; $9136: 00        
            jsr $2020          ; $9137: 20 20 20  
            .hex 73 70         ; $913a: 73 70     Invalid Opcode - RRA ($70),y
__913c:     bvs __91ae         ; $913c: 70 70     
            cpx $71            ; $913e: e4 71     
            bvs __91b3         ; $9140: 70 71     
__9142:     .hex e3            ; $9142: e3        Suspected data
__9143:     bvs __9129         ; $9143: 70 e4     
            .hex 91            ; $9145: 91        Suspected data
__9146:     .hex e3 90         ; $9146: e3 90     Invalid Opcode - ISC ($90,x)
__9148:     .hex e4            ; $9148: e4        Suspected data
__9149:     .hex a3 a0         ; $9149: a3 a0     Invalid Opcode - LAX ($a0,x)
            .hex a0            ; $914b: a0        Suspected data
__914c:     .hex e3 a0         ; $914c: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpx $a1            ; $914e: e4 a1     
            .hex a0            ; $9150: a0        Suspected data
__9151:     .hex e3 00         ; $9151: e3 00     Invalid Opcode - ISC ($00,x)
__9153:     brk                ; $9153: 00        
            .hex e2 00         ; $9154: e2 00     Invalid Opcode - NOP #$00
            .hex e3 20         ; $9156: e3 20     Invalid Opcode - ISC ($20,x)
            .hex 20            ; $9158: 20        Suspected data
__9159:     .hex e2 20         ; $9159: e2 20     Invalid Opcode - NOP #$20
            .hex e3            ; $915b: e3        Suspected data
__915c:     .hex 73 e4         ; $915c: 73 e4     Invalid Opcode - RRA ($e4),y
            bvs __9143         ; $915e: 70 e3     
__9160:     bvs __9146         ; $9160: 70 e4     
            .hex 20 60         ; $9162: 20 60     Suspected data
__9164:     bcc __9149         ; $9164: 90 e3     
__9166:     jsr $fffe          ; $9166: 20 fe ff  
__9169:     ldy #$90           ; $9169: a0 90     
            cld                ; $916b: d8        
            lda ($10),y        ; $916c: b1 10     
__916e:     bpl __9121         ; $916e: 10 b1     
__9170:     .hex 10            ; $9170: 10        Suspected data
__9171:     .hex 12            ; $9171: 12        Invalid Opcode - KIL 
            .hex 10            ; $9172: 10        Suspected data
__9173:     bpl __9126         ; $9173: 10 b1     
            rti                ; $9175: 40        

;-------------------------------------------------------------------------------
__9176:     .hex 12            ; $9176: 12        Invalid Opcode - KIL 
            .hex 10            ; $9177: 10        Suspected data
__9178:     bpl __912b         ; $9178: 10 b1     
            bpl __918c         ; $917a: 10 10     
            bcs __912e         ; $917c: b0 b0     
            bpl __9190         ; $917e: 10 10     
            .hex 41            ; $9180: 41        Suspected data
__9181:     rti                ; $9181: 40        

;-------------------------------------------------------------------------------
__9182:     rti                ; $9182: 40        

;-------------------------------------------------------------------------------
            .hex b1            ; $9183: b1        Suspected data
__9184:     bpl __9196         ; $9184: 10 10     
            .hex b1            ; $9186: b1        Suspected data
__9187:     bpl __919b         ; $9187: 10 12     
            bpl __919b         ; $9189: 10 10     
            .hex b1            ; $918b: b1        Suspected data
__918c:     rti                ; $918c: 40        

;-------------------------------------------------------------------------------
            .hex 12            ; $918d: 12        Invalid Opcode - KIL 
__918e:     bpl __91a0         ; $918e: 10 10     
__9190:     lda ($10),y        ; $9190: b1 10     
            bpl __91d4         ; $9192: 10 40     
            rti                ; $9194: 40        

;-------------------------------------------------------------------------------
            .hex 41            ; $9195: 41        Suspected data
__9196:     eor ($40,x)        ; $9196: 41 40     
            rti                ; $9198: 40        

;-------------------------------------------------------------------------------
            .hex fb            ; $9199: fb        Suspected data
__919a:     .hex b1            ; $919a: b1        Suspected data
__919b:     bcs __91ad         ; $919b: b0 10     
            lda ($10,x)        ; $919d: a1 10     
            .hex 10            ; $919f: 10        Suspected data
__91a0:     .hex b0            ; $91a0: b0        Suspected data
__91a1:     bpl __9153         ; $91a1: 10 b0     
__91a3:     .hex 10            ; $91a3: 10        Suspected data
__91a4:     lda ($10,x)        ; $91a4: a1 10     
            bpl __9159         ; $91a6: 10 b1     
            bcs __91ba         ; $91a8: b0 10     
            lda ($10,x)        ; $91aa: a1 10     
            .hex 10            ; $91ac: 10        Suspected data
__91ad:     .hex b0            ; $91ad: b0        Suspected data
__91ae:     bpl __9160         ; $91ae: 10 b0     
            bpl __9153         ; $91b0: 10 a1     
            .hex a0            ; $91b2: a0        Suspected data
__91b3:     ldy #$fe           ; $91b3: a0 fe     
            .hex 02            ; $91b5: 02        Invalid Opcode - KIL 
            .hex fb            ; $91b6: fb        Suspected data
__91b7:     bcs __9169         ; $91b7: b0 b0     
            .hex 10            ; $91b9: 10        Suspected data
__91ba:     bpl __915c         ; $91ba: 10 a0     
            .hex 10            ; $91bc: 10        Suspected data
__91bd:     bpl __91cf         ; $91bd: 10 10     
            bcs __9171         ; $91bf: b0 b0     
            bpl __91d3         ; $91c1: 10 10     
            ldy #$10           ; $91c3: a0 10     
            ldy #$a0           ; $91c5: a0 a0     
            inc __b003,x       ; $91c7: fe 03 b0  
            .hex b0            ; $91ca: b0        Suspected data
__91cb:     bpl __91dd         ; $91cb: 10 10     
            .hex a0            ; $91cd: a0        Suspected data
__91ce:     .hex 10            ; $91ce: 10        Suspected data
__91cf:     bpl __91e1         ; $91cf: 10 10     
            .hex b0            ; $91d1: b0        Suspected data
__91d2:     .hex a0            ; $91d2: a0        Suspected data
__91d3:     .hex a0            ; $91d3: a0        Suspected data
__91d4:     bpl __9176         ; $91d4: 10 a0     
            bpl __9178         ; $91d6: 10 a0     
            ldy #$b1           ; $91d8: a0 b1     
            ldy #$b1           ; $91da: a0 b1     
__91dc:     .hex a0            ; $91dc: a0        Suspected data
__91dd:     .hex b3 a1         ; $91dd: b3 a1     Invalid Opcode - LAX ($a1),y
            .hex a1            ; $91df: a1        Suspected data
__91e0:     .hex a0            ; $91e0: a0        Suspected data
__91e1:     ldy #$b0           ; $91e1: a0 b0     
            ldy #$a0           ; $91e3: a0 a0     
            bcs __9187         ; $91e5: b0 a0     
            ldy #$b3           ; $91e7: a0 b3     
            ldy #$a0           ; $91e9: a0 a0     
            bcs __918e         ; $91eb: b0 a1     
            ldy #$b1           ; $91ed: a0 b1     
            ldy #$b1           ; $91ef: a0 b1     
            ldy #$b3           ; $91f1: a0 b3     
            ldy #$a0           ; $91f3: a0 a0     
            lda ($a0,x)        ; $91f5: a1 a0     
            ldy #$b0           ; $91f7: a0 b0     
            .hex a0            ; $91f9: a0        Suspected data
__91fa:     ldy #$b0           ; $91fa: a0 b0     
            .hex a0            ; $91fc: a0        Suspected data
__91fd:     .hex a0            ; $91fd: a0        Suspected data
__91fe:     .hex b2            ; $91fe: b2        Invalid Opcode - KIL 
            bcs __91a1         ; $91ff: b0 a0     
__9201:     .hex a0            ; $9201: a0        Suspected data
__9202:     bcs __91a4         ; $9202: b0 a0     
            .hex a0            ; $9204: a0        Suspected data
__9205:     .hex a0            ; $9205: a0        Suspected data
__9206:     inc __99ff,x       ; $9206: fe ff 99  
            sta ($eb),y        ; $9209: 91 eb     
            brk                ; $920b: 00        
            brk                ; $920c: 00        
            sbc #$71           ; $920d: e9 71     
            .hex d7            ; $920f: d7        Suspected data
__9210:     rol $82,x          ; $9210: 36 82     
            asl $f0,x          ; $9212: 16 f0     
            .hex fb e2 a0      ; $9214: fb e2 a0  Invalid Opcode - ISC __a0e2,y
            bvc __91fa         ; $9217: 50 e1     
            bvc __91fd         ; $9219: 50 e2     
            bvc __91fe         ; $921b: 50 e1     
            bmi __9201         ; $921d: 30 e2     
            bvc __9202         ; $921f: 50 e1     
            bpl __9205         ; $9221: 10 e2     
            bvc __9206         ; $9223: 50 e1     
            brk                ; $9225: 00        
            .hex e2 50         ; $9226: e2 50     Invalid Opcode - NOP #$50
            sbc ($10,x)        ; $9228: e1 10     
            .hex e2 50         ; $922a: e2 50     Invalid Opcode - NOP #$50
            sbc ($00,x)        ; $922c: e1 00     
            .hex e2 50         ; $922e: e2 50     Invalid Opcode - NOP #$50
            ldy #$50           ; $9230: a0 50     
            sbc ($00,x)        ; $9232: e1 00     
            .hex e2 50         ; $9234: e2 50     Invalid Opcode - NOP #$50
            sbc ($10,x)        ; $9236: e1 10     
            .hex e2 50         ; $9238: e2 50     Invalid Opcode - NOP #$50
            sbc ($30,x)        ; $923a: e1 30     
            .hex e2 50         ; $923c: e2 50     Invalid Opcode - NOP #$50
            sbc ($10,x)        ; $923e: e1 10     
            .hex e2 50         ; $9240: e2 50     Invalid Opcode - NOP #$50
            sbc ($00,x)        ; $9242: e1 00     
            .hex e2 50         ; $9244: e2 50     Invalid Opcode - NOP #$50
            .hex 80 50         ; $9246: 80 50     Invalid Opcode - NOP #$50
            sbc ($00,x)        ; $9248: e1 00     
            .hex e2 50         ; $924a: e2 50     Invalid Opcode - NOP #$50
            ldy #$50           ; $924c: a0 50     
            inc __e902,x       ; $924e: fe 02 e9  
            and $eb,x          ; $9251: 35 eb     
            ora ($03,x)        ; $9253: 01 03     
            .hex d7 70         ; $9255: d7 70     Invalid Opcode - DCP $70,x
            asl $17            ; $9257: 06 17     
            .hex e2 31         ; $9259: e2 31     Invalid Opcode - NOP #$31
            .hex 80 58         ; $925b: 80 58     Invalid Opcode - NOP #$58
            and ($11),y        ; $925d: 31 11     
            .hex 32            ; $925f: 32        Invalid Opcode - KIL 
            .hex 82 55         ; $9260: 82 55     Invalid Opcode - NOP #$55
            and ($11),y        ; $9262: 31 11     
            and ($80),y        ; $9264: 31 80     
            cli                ; $9266: 58        
            and ($51),y        ; $9267: 31 51     
            sbc #$32           ; $9269: e9 32     
            .hex e7 0b         ; $926b: e7 0b     Invalid Opcode - ISC $0b
            .hex 62            ; $926d: 62        Invalid Opcode - KIL 
            sty $52            ; $926e: 84 52     
            .hex 64 e9         ; $9270: 64 e9     Invalid Opcode - NOP $e9
            and $eb,x          ; $9272: 35 eb     
            ora ($03,x)        ; $9274: 01 03     
            .hex d7 70         ; $9276: d7 70     Invalid Opcode - DCP $70,x
            asl $17            ; $9278: 06 17     
            .hex e2 31         ; $927a: e2 31     Invalid Opcode - NOP #$31
            .hex 80 58         ; $927c: 80 58     Invalid Opcode - NOP #$58
            and ($11),y        ; $927e: 31 11     
            .hex 32            ; $9280: 32        Invalid Opcode - KIL 
            .hex 82 55         ; $9281: 82 55     Invalid Opcode - NOP #$55
            and ($11),y        ; $9283: 31 11     
            and ($80),y        ; $9285: 31 80     
            cli                ; $9287: 58        
            and ($51),y        ; $9288: 31 51     
            sbc #$32           ; $928a: e9 32     
            .hex e7 0b         ; $928c: e7 0b     Invalid Opcode - ISC $0b
            .hex 62            ; $928e: 62        Invalid Opcode - KIL 
            sty $e7            ; $928f: 84 e7     
            asl $51            ; $9291: 06 51     
            adc ($91),y        ; $9293: 71 91     
            sbc ($01,x)        ; $9295: e1 01     
            sbc #$74           ; $9297: e9 74     
            .hex eb 00         ; $9299: eb 00     Invalid Opcode - SBC #$00
            brk                ; $929b: 00        
            .hex d7 30         ; $929c: d7 30     Invalid Opcode - DCP $30,x
            php                ; $929e: 08        
            ora $f0,x          ; $929f: 15 f0     
            .hex e2 00         ; $92a1: e2 00     Invalid Opcode - NOP #$00
            .hex f3 00         ; $92a3: f3 00     Invalid Opcode - ISC ($00),y
            sbc $00,x          ; $92a5: f5 00     
            sbc ($e3),y        ; $92a7: f1 e3     
            .hex a2            ; $92a9: a2        Suspected data
__92aa:     .hex e2 a1         ; $92aa: e2 a1     Invalid Opcode - NOP #$a1
            .hex f0            ; $92ac: f0        Suspected data
__92ad:     brk                ; $92ad: 00        
            .hex f3 00         ; $92ae: f3 00     Invalid Opcode - ISC ($00),y
            sbc $00,x          ; $92b0: f5 00     
            sbc ($e3),y        ; $92b2: f1 e3     
            ldx #$e2           ; $92b4: a2 e2     
            lda ($f0,x)        ; $92b6: a1 f0     
            brk                ; $92b8: 00        
            .hex f3 00         ; $92b9: f3 00     Invalid Opcode - ISC ($00),y
            sbc $00,x          ; $92bb: f5 00     
            sbc ($e3),y        ; $92bd: f1 e3     
            ldx #$e2           ; $92bf: a2 e2     
            lda ($e7,x)        ; $92c1: a1 e7     
            ora #$e9           ; $92c3: 09 e9     
            adc ($f0),y        ; $92c5: 71 f0     
            bpl __92aa         ; $92c7: 10 e1     
            bpl __92ad         ; $92c9: 10 e2     
            brk                ; $92cb: 00        
            .hex e1            ; $92cc: e1        Suspected data
__92cd:     brk                ; $92cd: 00        
            .hex e3 a0         ; $92ce: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 a0         ; $92d0: e2 a0     Invalid Opcode - NOP #$a0
            .hex e3 80         ; $92d2: e3 80     Invalid Opcode - ISC ($80,x)
            .hex e2 80         ; $92d4: e2 80     Invalid Opcode - NOP #$80
            .hex e7 0a         ; $92d6: e7 0a     Invalid Opcode - ISC $0a
            sbc #$74           ; $92d8: e9 74     
            .hex eb 01         ; $92da: eb 01     Invalid Opcode - SBC #$01
            .hex 03 f0         ; $92dc: 03 f0     Invalid Opcode - SLO ($f0,x)
            brk                ; $92de: 00        
            .hex f3 00         ; $92df: f3 00     Invalid Opcode - ISC ($00),y
            sbc ($e3),y        ; $92e1: f1 e3     
            .hex a0            ; $92e3: a0        Suspected data
__92e4:     .hex e2 a4         ; $92e4: e2 a4     Invalid Opcode - NOP #$a4
            beq __92e8         ; $92e6: f0 00     
__92e8:     .hex f3 00         ; $92e8: f3 00     Invalid Opcode - ISC ($00),y
            sbc ($e3),y        ; $92ea: f1 e3     
            ldy #$e2           ; $92ec: a0 e2     
            ldy $f0            ; $92ee: a4 f0     
            brk                ; $92f0: 00        
            .hex f3 00         ; $92f1: f3 00     Invalid Opcode - ISC ($00),y
            sbc ($e3),y        ; $92f3: f1 e3     
            ldy #$e2           ; $92f5: a0 e2     
            ldy $e9            ; $92f7: a4 e9     
            bmi __92e4         ; $92f9: 30 e9     
            adc $e7,x          ; $92fb: 75 e7     
            ora #$f0           ; $92fd: 09 f0     
            sbc ($11,x)        ; $92ff: e1 11     
            and ($00),y        ; $9301: 31 00     
            .hex 12            ; $9303: 12        Invalid Opcode - KIL 
            inc $0aff,x        ; $9304: fe ff 0a  
            .hex 92            ; $9307: 92        Invalid Opcode - KIL 
            sbc #$00           ; $9308: e9 00     
            nop                ; $930a: ea        
            sty $01eb          ; $930b: 8c eb 01  
            brk                ; $930e: 00        
            .hex d1            ; $930f: d1        Suspected data
__9310:     rol $82,x          ; $9310: 36 82     
            clc                ; $9312: 18        
            beq __9310         ; $9313: f0 fb     
            .hex e3 a0         ; $9315: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 a5         ; $9317: e2 a5     Invalid Opcode - NOP #$a5
            .hex e3 50         ; $9319: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $931b: e2 55     Invalid Opcode - NOP #$55
            .hex e2 50         ; $931d: e2 50     Invalid Opcode - NOP #$50
            sbc ($55,x)        ; $931f: e1 55     
            .hex e3 50         ; $9321: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9323: e2 55     Invalid Opcode - NOP #$55
            .hex e2 30         ; $9325: e2 30     Invalid Opcode - NOP #$30
            sbc ($35,x)        ; $9327: e1 35     
            .hex e3 50         ; $9329: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $932b: e2 55     Invalid Opcode - NOP #$55
            .hex e2 10         ; $932d: e2 10     Invalid Opcode - NOP #$10
            sbc ($15,x)        ; $932f: e1 15     
            .hex e3 50         ; $9331: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9333: e2 55     Invalid Opcode - NOP #$55
            .hex e2 00         ; $9335: e2 00     Invalid Opcode - NOP #$00
            sbc ($05,x)        ; $9337: e1 05     
            .hex e3 50         ; $9339: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $933b: e2 55     Invalid Opcode - NOP #$55
            .hex e2 10         ; $933d: e2 10     Invalid Opcode - NOP #$10
            sbc ($15,x)        ; $933f: e1 15     
            .hex e3 50         ; $9341: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9343: e2 55     Invalid Opcode - NOP #$55
            .hex e2 00         ; $9345: e2 00     Invalid Opcode - NOP #$00
            sbc ($05,x)        ; $9347: e1 05     
            .hex e3 50         ; $9349: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $934b: e2 55     Invalid Opcode - NOP #$55
            .hex e3 a0         ; $934d: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 a5         ; $934f: e2 a5     Invalid Opcode - NOP #$a5
            .hex e3 50         ; $9351: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9353: e2 55     Invalid Opcode - NOP #$55
            .hex e2 00         ; $9355: e2 00     Invalid Opcode - NOP #$00
            sbc ($05,x)        ; $9357: e1 05     
            .hex e3 50         ; $9359: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $935b: e2 55     Invalid Opcode - NOP #$55
            .hex e2 10         ; $935d: e2 10     Invalid Opcode - NOP #$10
            sbc ($15,x)        ; $935f: e1 15     
            .hex e3 50         ; $9361: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9363: e2 55     Invalid Opcode - NOP #$55
            .hex e2 30         ; $9365: e2 30     Invalid Opcode - NOP #$30
            sbc ($35,x)        ; $9367: e1 35     
            .hex e3 50         ; $9369: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $936b: e2 55     Invalid Opcode - NOP #$55
            .hex e2 10         ; $936d: e2 10     Invalid Opcode - NOP #$10
            sbc ($15,x)        ; $936f: e1 15     
            .hex e3 50         ; $9371: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9373: e2 55     Invalid Opcode - NOP #$55
            .hex e2 00         ; $9375: e2 00     Invalid Opcode - NOP #$00
            sbc ($05,x)        ; $9377: e1 05     
            .hex e3 50         ; $9379: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $937b: e2 55     Invalid Opcode - NOP #$55
            .hex e3 80         ; $937d: e3 80     Invalid Opcode - ISC ($80,x)
            .hex e2 85         ; $937f: e2 85     Invalid Opcode - NOP #$85
            .hex e3 50         ; $9381: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9383: e2 55     Invalid Opcode - NOP #$55
            .hex e2 00         ; $9385: e2 00     Invalid Opcode - NOP #$00
            sbc ($05,x)        ; $9387: e1 05     
            .hex e3 50         ; $9389: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $938b: e2 55     Invalid Opcode - NOP #$55
            .hex e3 a0         ; $938d: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 a5         ; $938f: e2 a5     Invalid Opcode - NOP #$a5
            .hex e3 50         ; $9391: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 55         ; $9393: e2 55     Invalid Opcode - NOP #$55
            inc __e902,x       ; $9395: fe 02 e9  
            and $ea,x          ; $9398: 35 ea     
            brk                ; $939a: 00        
            .hex eb 01         ; $939b: eb 01     Invalid Opcode - SBC #$01
            .hex 03 d7         ; $939d: 03 d7     Invalid Opcode - SLO ($d7,x)
            bvs __93a7         ; $939f: 70 06     
            .hex 17 e2         ; $93a1: 17 e2     Invalid Opcode - SLO $e2,x
            ora ($30,x)        ; $93a3: 01 30     
            ora ($e9),y        ; $93a5: 11 e9     
__93a7:     lda $e7,x          ; $93a7: b5 e7     
            .hex 07 e6         ; $93a9: 07 e6     Invalid Opcode - SLO $e6
            ora ($e4,x)        ; $93ab: 01 e4     
            brk                ; $93ad: 00        
            .hex e3 05         ; $93ae: e3 05     Invalid Opcode - ISC ($05,x)
            sbc $a0            ; $93b0: e5 a0     
            cpx $a5            ; $93b2: e4 a5     
            cpx $00            ; $93b4: e4 00     
            .hex e3 05         ; $93b6: e3 05     Invalid Opcode - ISC ($05,x)
            cpx $10            ; $93b8: e4 10     
            .hex e3 1c         ; $93ba: e3 1c     Invalid Opcode - ISC ($1c,x)
            cpx $30            ; $93bc: e4 30     
            .hex e3 3c         ; $93be: e3 3c     Invalid Opcode - ISC ($3c,x)
            inc $07            ; $93c0: e6 07     
            .hex 53 e9         ; $93c2: 53 e9     Invalid Opcode - SRE ($e9),y
            and $e7,x          ; $93c4: 35 e7     
            asl $e2            ; $93c6: 06 e2     
            .hex 02            ; $93c8: 02        Invalid Opcode - KIL 
            .hex 52            ; $93c9: 52        Invalid Opcode - KIL 
__93ca:     ora $01,x          ; $93ca: 15 01     
            .hex e3 a1         ; $93cc: e3 a1     Invalid Opcode - ISC ($a1,x)
            .hex e2 01         ; $93ce: e2 01     Invalid Opcode - NOP #$01
            bmi __93e3         ; $93d0: 30 11     
            sbc #$b5           ; $93d2: e9 b5     
            .hex e7 07         ; $93d4: e7 07     Invalid Opcode - ISC $07
            inc $01            ; $93d6: e6 01     
            cpx $30            ; $93d8: e4 30     
            .hex e3 35         ; $93da: e3 35     Invalid Opcode - ISC ($35,x)
            cpx $10            ; $93dc: e4 10     
            .hex e3 15         ; $93de: e3 15     Invalid Opcode - ISC ($15,x)
            cpx $30            ; $93e0: e4 30     
            .hex e3            ; $93e2: e3        Suspected data
__93e3:     and $e4,x          ; $93e3: 35 e4     
            bvc __93ca         ; $93e5: 50 e3     
            .hex 5c e4 60      ; $93e7: 5c e4 60  Invalid Opcode - NOP $60e4,x
            .hex e3 6c         ; $93ea: e3 6c     Invalid Opcode - ISC ($6c,x)
            cpx $80            ; $93ec: e4 80     
            .hex e3 8c         ; $93ee: e3 8c     Invalid Opcode - ISC ($8c,x)
            cpx $a0            ; $93f0: e4 a0     
            .hex e3 ac         ; $93f2: e3 ac     Invalid Opcode - ISC ($ac,x)
            inc $07            ; $93f4: e6 07     
            sbc #$32           ; $93f6: e9 32     
            .hex e7 0b         ; $93f8: e7 0b     Invalid Opcode - ISC $0b
            .hex e2 02         ; $93fa: e2 02     Invalid Opcode - NOP #$02
            .hex 04 e3         ; $93fc: 04 e3     Invalid Opcode - NOP $e3
            ldx #$a4           ; $93fe: a2 a4     
            sbc #$35           ; $9400: e9 35     
            .hex eb 01         ; $9402: eb 01     Invalid Opcode - SBC #$01
            .hex 03 d7         ; $9404: 03 d7     Invalid Opcode - SLO ($d7,x)
            bvs __940e         ; $9406: 70 06     
            .hex 17 e2         ; $9408: 17 e2     Invalid Opcode - SLO $e2,x
            ora ($30,x)        ; $940a: 01 30     
            ora ($e9),y        ; $940c: 11 e9     
__940e:     lda $e7,x          ; $940e: b5 e7     
            .hex 07 e6         ; $9410: 07 e6     Invalid Opcode - SLO $e6
            ora ($e4,x)        ; $9412: 01 e4     
            brk                ; $9414: 00        
            .hex e3 05         ; $9415: e3 05     Invalid Opcode - ISC ($05,x)
            sbc $a0            ; $9417: e5 a0     
            cpx $a5            ; $9419: e4 a5     
            brk                ; $941b: 00        
            .hex e3 05         ; $941c: e3 05     Invalid Opcode - ISC ($05,x)
            cpx $10            ; $941e: e4 10     
            .hex e3 1c         ; $9420: e3 1c     Invalid Opcode - ISC ($1c,x)
            cpx $30            ; $9422: e4 30     
            .hex e3 3c         ; $9424: e3 3c     Invalid Opcode - ISC ($3c,x)
            inc $07            ; $9426: e6 07     
            .hex 53 e9         ; $9428: 53 e9     Invalid Opcode - SRE ($e9),y
            and $e7,x          ; $942a: 35 e7     
            asl $e2            ; $942c: 06 e2     
            .hex 02            ; $942e: 02        Invalid Opcode - KIL 
            .hex 52            ; $942f: 52        Invalid Opcode - KIL 
__9430:     ora $01,x          ; $9430: 15 01     
            .hex e3 a1         ; $9432: e3 a1     Invalid Opcode - ISC ($a1,x)
            .hex e2 01         ; $9434: e2 01     Invalid Opcode - NOP #$01
            bmi __9449         ; $9436: 30 11     
            sbc #$b5           ; $9438: e9 b5     
            .hex e7 07         ; $943a: e7 07     Invalid Opcode - ISC $07
            inc $01            ; $943c: e6 01     
            cpx $30            ; $943e: e4 30     
            .hex e3 35         ; $9440: e3 35     Invalid Opcode - ISC ($35,x)
            cpx $10            ; $9442: e4 10     
            .hex e3 15         ; $9444: e3 15     Invalid Opcode - ISC ($15,x)
            cpx $30            ; $9446: e4 30     
            .hex e3            ; $9448: e3        Suspected data
__9449:     and $e4,x          ; $9449: 35 e4     
            bvc __9430         ; $944b: 50 e3     
            .hex 5c e4 60      ; $944d: 5c e4 60  Invalid Opcode - NOP $60e4,x
            .hex e3 6c         ; $9450: e3 6c     Invalid Opcode - ISC ($6c,x)
            cpx $80            ; $9452: e4 80     
            .hex e3 8c         ; $9454: e3 8c     Invalid Opcode - ISC ($8c,x)
            cpx $a0            ; $9456: e4 a0     
            .hex e3 ac         ; $9458: e3 ac     Invalid Opcode - ISC ($ac,x)
            inc $07            ; $945a: e6 07     
            sbc #$32           ; $945c: e9 32     
            .hex e7 0b         ; $945e: e7 0b     Invalid Opcode - ISC $0b
            .hex e2 02         ; $9460: e2 02     Invalid Opcode - NOP #$02
            .hex 04 e3         ; $9462: 04 e3     Invalid Opcode - NOP $e3
            .hex e7            ; $9464: e7        Suspected data
__9465:     asl $e3            ; $9465: 06 e3     
            sta ($a1),y        ; $9467: 91 a1     
            .hex e2 01         ; $9469: e2 01     Invalid Opcode - NOP #$01
            .hex 31            ; $946b: 31        Suspected data
__946c:     sbc #$74           ; $946c: e9 74     
__946e:     .hex eb 01         ; $946e: eb 01     Invalid Opcode - SBC #$01
__9470:     brk                ; $9470: 00        
            .hex d7 30         ; $9471: d7 30     Invalid Opcode - DCP $30,x
            php                ; $9473: 08        
            ora $f0,x          ; $9474: 15 f0     
            .hex e3 30         ; $9476: e3 30     Invalid Opcode - ISC ($30,x)
            .hex f3            ; $9478: f3        Suspected data
__9479:     bmi __9470         ; $9479: 30 f5     
            bmi __946e         ; $947b: 30 f1     
            .hex 12            ; $947d: 12        Invalid Opcode - KIL 
            .hex e2 11         ; $947e: e2 11     Invalid Opcode - NOP #$11
__9480:     beq __9465         ; $9480: f0 e3     
__9482:     .hex 30            ; $9482: 30        Suspected data
__9483:     .hex f3 30         ; $9483: f3 30     Invalid Opcode - ISC ($30),y
            .hex f5            ; $9485: f5        Suspected data
__9486:     bmi __9479         ; $9486: 30 f1     
            .hex 12            ; $9488: 12        Invalid Opcode - KIL 
            .hex e2 11         ; $9489: e2 11     Invalid Opcode - NOP #$11
            beq __9470         ; $948b: f0 e3     
            bmi __9482         ; $948d: 30 f3     
            bmi __9486         ; $948f: 30 f5     
            bmi __9483         ; $9491: 30 f0     
            .hex 12            ; $9493: 12        Invalid Opcode - KIL 
            .hex e2 11         ; $9494: e2 11     Invalid Opcode - NOP #$11
            sbc ($e7),y        ; $9496: f1 e7     
            ora #$e9           ; $9498: 09 e9     
            lda ($e3),y        ; $949a: b1 e3     
            bpl __9480         ; $949c: 10 e2     
__949e:     bpl __9483         ; $949e: 10 e3     
            brk                ; $94a0: 00        
            .hex e2            ; $94a1: e2        Suspected data
__94a2:     brk                ; $94a2: 00        
            cpx $a0            ; $94a3: e4 a0     
            .hex e3 a0         ; $94a5: e3 a0     Invalid Opcode - ISC ($a0,x)
__94a7:     cpx $80            ; $94a7: e4 80     
            .hex e3 80         ; $94a9: e3 80     Invalid Opcode - ISC ($80,x)
__94ab:     .hex eb 01         ; $94ab: eb 01     Invalid Opcode - SBC #$01
            .hex 03 f0         ; $94ad: 03 f0     Invalid Opcode - SLO ($f0,x)
            .hex e7            ; $94af: e7        Suspected data
__94b0:     asl                ; $94b0: 0a        
            sbc #$30           ; $94b1: e9 30     
            .hex e9            ; $94b3: e9        Suspected data
__94b4:     .hex 74 e3         ; $94b4: 74 e3     Invalid Opcode - NOP $e3,x
            bmi __94ab         ; $94b6: 30 f3     
            bmi __94ab         ; $94b8: 30 f1     
__94ba:     bpl __949e         ; $94ba: 10 e2     
            .hex 14            ; $94bc: 14        Suspected data
__94bd:     beq __94a2         ; $94bd: f0 e3     
            bmi __94b4         ; $94bf: 30 f3     
            bmi __94b4         ; $94c1: 30 f1     
            bpl __94a7         ; $94c3: 10 e2     
            .hex 14 f0         ; $94c5: 14 f0     Invalid Opcode - NOP $f0,x
            .hex e3 30         ; $94c7: e3 30     Invalid Opcode - ISC ($30,x)
            .hex f3 30         ; $94c9: f3 30     Invalid Opcode - ISC ($30),y
            sbc ($10),y        ; $94cb: f1 10     
            .hex e2 14         ; $94cd: e2 14     Invalid Opcode - NOP #$14
            .hex e7 09         ; $94cf: e7 09     Invalid Opcode - ISC $09
            sbc #$b5           ; $94d1: e9 b5     
            .hex eb 01         ; $94d3: eb 01     Invalid Opcode - SBC #$01
            brk                ; $94d5: 00        
            beq __94ba         ; $94d6: f0 e2     
            ora ($31),y        ; $94d8: 11 31     
            brk                ; $94da: 00        
            .hex 12            ; $94db: 12        Invalid Opcode - KIL 
            .hex fe ff         ; $94dc: fe ff     Suspected data
__94de:     php                ; $94de: 08        
            .hex 93 d7         ; $94df: 93 d7     Invalid Opcode - AHX ($d7),y
            bcc __94de         ; $94e1: 90 fb     
            cpx $af            ; $94e3: e4 af     
            cpx $57            ; $94e5: e4 57     
            .hex e3 57         ; $94e7: e3 57     Invalid Opcode - ISC ($57,x)
            inc __d702,x       ; $94e9: fe 02 d7  
            ora $e4,x          ; $94ec: 15 e4     
            lda ($e3,x)        ; $94ee: a1 e3     
            ldy #$e4           ; $94f0: a0 e4     
            ldy #$c0           ; $94f2: a0 c0     
            ldy #$e3           ; $94f4: a0 e3     
            ldy #$c0           ; $94f6: a0 c0     
            cpx $a0            ; $94f8: e4 a0     
            ldy #$e3           ; $94fa: a0 e3     
            ldy #$c0           ; $94fc: a0 c0     
            .hex e4            ; $94fe: e4        Suspected data
__94ff:     ldy #$c0           ; $94ff: a0 c0     
__9501:     .hex e3 a0         ; $9501: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpy #$e4           ; $9503: c0 e4     
            .hex 81            ; $9505: 81        Suspected data
__9506:     .hex e3 80         ; $9506: e3 80     Invalid Opcode - ISC ($80,x)
            cpx $80            ; $9508: e4 80     
            cpy #$80           ; $950a: c0 80     
            .hex e3 80         ; $950c: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $950e: c0 e4     
            .hex 80 c0         ; $9510: 80 c0     Invalid Opcode - NOP #$c0
            .hex e3 80         ; $9512: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $9514: c0 e4     
            .hex 80 80         ; $9516: 80 80     Invalid Opcode - NOP #$80
            .hex e3 80         ; $9518: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $951a: c0 e4     
            adc ($e3,x)        ; $951c: 61 e3     
            rts                ; $951e: 60        

;-------------------------------------------------------------------------------
            cpx $60            ; $951f: e4 60     
            cpy #$60           ; $9521: c0 60     
            .hex e3 60         ; $9523: e3 60     Invalid Opcode - ISC ($60,x)
            cpy #$e4           ; $9525: c0 e4     
            rts                ; $9527: 60        

;-------------------------------------------------------------------------------
            rts                ; $9528: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $9529: e3 60     Invalid Opcode - ISC ($60,x)
            cpy #$e4           ; $952b: c0 e4     
            rts                ; $952d: 60        

;-------------------------------------------------------------------------------
            cpy #$e3           ; $952e: c0 e3     
            rts                ; $9530: 60        

;-------------------------------------------------------------------------------
            cpy #$e4           ; $9531: c0 e4     
            bvc __9585         ; $9533: 50 50     
            .hex e3 50         ; $9535: e3 50     Invalid Opcode - ISC ($50,x)
            cpx $50            ; $9537: e4 50     
            cpy #$50           ; $9539: c0 50     
            .hex e3 50         ; $953b: e3 50     Invalid Opcode - ISC ($50,x)
            cpy #$e4           ; $953d: c0 e4     
            bvc __9501         ; $953f: 50 c0     
            .hex e3 50         ; $9541: e3 50     Invalid Opcode - ISC ($50,x)
            cpy #$e4           ; $9543: c0 e4     
            bvc __9597         ; $9545: 50 50     
            .hex e3 50         ; $9547: e3 50     Invalid Opcode - ISC ($50,x)
            cpy #$e4           ; $9549: c0 e4     
            lda ($e3,x)        ; $954b: a1 e3     
            ldy #$e4           ; $954d: a0 e4     
            ldy #$c0           ; $954f: a0 c0     
            ldy #$e3           ; $9551: a0 e3     
            ldy #$c0           ; $9553: a0 c0     
            cpx $a0            ; $9555: e4 a0     
            ldy #$e3           ; $9557: a0 e3     
            ldy #$c0           ; $9559: a0 c0     
__955b:     cpx $a0            ; $955b: e4 a0     
            cpy #$e3           ; $955d: c0 e3     
            ldy #$c0           ; $955f: a0 c0     
            cpx $81            ; $9561: e4 81     
            .hex e3 80         ; $9563: e3 80     Invalid Opcode - ISC ($80,x)
            cpx $80            ; $9565: e4 80     
            cpy #$80           ; $9567: c0 80     
            .hex e3 80         ; $9569: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $956b: c0 e4     
            .hex 80 c0         ; $956d: 80 c0     Invalid Opcode - NOP #$c0
            .hex e3 80         ; $956f: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $9571: c0 e4     
            .hex 80 80         ; $9573: 80 80     Invalid Opcode - NOP #$80
            .hex e3 80         ; $9575: e3 80     Invalid Opcode - ISC ($80,x)
            cpy #$e4           ; $9577: c0 e4     
            adc ($e3,x)        ; $9579: 61 e3     
            rts                ; $957b: 60        

;-------------------------------------------------------------------------------
__957c:     cpx $60            ; $957c: e4 60     
            cpy #$60           ; $957e: c0 60     
            .hex e3 60         ; $9580: e3 60     Invalid Opcode - ISC ($60,x)
            cpy #$e4           ; $9582: c0 e4     
            rts                ; $9584: 60        

;-------------------------------------------------------------------------------
__9585:     rts                ; $9585: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $9586: e3 60     Invalid Opcode - ISC ($60,x)
__9588:     .hex c0            ; $9588: c0        Suspected data
__9589:     cpx $60            ; $9589: e4 60     
            cpy #$e3           ; $958b: c0 e3     
            rts                ; $958d: 60        

;-------------------------------------------------------------------------------
            cpy #$e4           ; $958e: c0 e4     
            bvc __95e2         ; $9590: 50 50     
            .hex e3 50         ; $9592: e3 50     Invalid Opcode - ISC ($50,x)
            cpx $50            ; $9594: e4 50     
            .hex c0            ; $9596: c0        Suspected data
__9597:     bvc __957c         ; $9597: 50 e3     
            bvc __955b         ; $9599: 50 c0     
            cpx $50            ; $959b: e4 50     
            .hex e3 50         ; $959d: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e4            ; $959f: e4        Suspected data
__95a0:     bvs __9585         ; $95a0: 70 e3     
            bvs __9588         ; $95a2: 70 e4     
            bcc __9589         ; $95a4: 90 e3     
            bcc __95a8         ; $95a6: 90 00     
__95a8:     .hex e2            ; $95a8: e2        Suspected data
__95a9:     brk                ; $95a9: 00        
            cpx $a2            ; $95aa: e4 a2     
            ldx #$a0           ; $95ac: a2 a0     
            .hex e3 a0         ; $95ae: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpx $82            ; $95b0: e4 82     
            .hex 82            ; $95b2: 82        Suspected data
__95b3:     .hex 80 e3         ; $95b3: 80 e3     Invalid Opcode - NOP #$e3
            .hex 80 e4         ; $95b5: 80 e4     Invalid Opcode - NOP #$e4
            .hex 62            ; $95b7: 62        Invalid Opcode - KIL 
            .hex 62            ; $95b8: 62        Invalid Opcode - KIL 
            rts                ; $95b9: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $95ba: e3 60     Invalid Opcode - ISC ($60,x)
__95bc:     .hex e4            ; $95bc: e4        Suspected data
__95bd:     .hex 82 82         ; $95bd: 82 82     Invalid Opcode - NOP #$82
            .hex 80 e3         ; $95bf: 80 e3     Invalid Opcode - NOP #$e3
            .hex 80 e4         ; $95c1: 80 e4     Invalid Opcode - NOP #$e4
            ldx #$a2           ; $95c3: a2 a2     
            .hex a0            ; $95c5: a0        Suspected data
__95c6:     .hex e3 a0         ; $95c6: e3 a0     Invalid Opcode - ISC ($a0,x)
            cpx $82            ; $95c8: e4 82     
__95ca:     .hex 82 80         ; $95ca: 82 80     Invalid Opcode - NOP #$80
__95cc:     .hex 80 e4         ; $95cc: 80 e4     Invalid Opcode - NOP #$e4
            .hex 62            ; $95ce: 62        Invalid Opcode - KIL 
            .hex 62            ; $95cf: 62        Invalid Opcode - KIL 
__95d0:     rts                ; $95d0: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $95d1: e3 60     Invalid Opcode - ISC ($60,x)
            cpx $81            ; $95d3: e4 81     
            .hex e3 81         ; $95d5: e3 81     Invalid Opcode - ISC ($81,x)
            .hex e4            ; $95d7: e4        Suspected data
__95d8:     .hex 80            ; $95d8: 80        Suspected data
__95d9:     .hex 80 e3         ; $95d9: 80 e3     Invalid Opcode - NOP #$e3
            sta ($fe,x)        ; $95db: 81 fe     
            .hex ff e0 94      ; $95dd: ff e0 94  Invalid Opcode - ISC __94e0,x
            .hex d7            ; $95e0: d7        Suspected data
__95e1:     .hex bf            ; $95e1: bf        Suspected data
__95e2:     .hex b7 b3         ; $95e2: b7 b3     Invalid Opcode - LAX $b3,y
            .hex a3 bf         ; $95e4: a3 bf     Invalid Opcode - LAX ($bf,x)
            .hex b7            ; $95e6: b7        Suspected data
__95e7:     .hex b3 a1         ; $95e7: b3 a1     Invalid Opcode - LAX ($a1),y
            ldy #$a0           ; $95e9: a0 a0     
            .hex fb b1 a0      ; $95eb: fb b1 a0  Invalid Opcode - ISC __a0b1,y
            lda ($b0),y        ; $95ee: b1 b0     
            lda ($b1,x)        ; $95f0: a1 b1     
            lda ($b0,x)        ; $95f2: a1 b0     
            bcs __9597         ; $95f4: b0 a1     
            lda ($a0),y        ; $95f6: b1 a0     
            lda ($b0),y        ; $95f8: b1 b0     
            lda ($b1,x)        ; $95fa: a1 b1     
            lda ($b0,x)        ; $95fc: a1 b0     
__95fe:     bcs __95a0         ; $95fe: b0 a0     
            ldy #$fe           ; $9600: a0 fe     
            .hex 02            ; $9602: 02        Invalid Opcode - KIL 
            .hex b1            ; $9603: b1        Suspected data
__9604:     ldy #$b1           ; $9604: a0 b1     
            bcs __95a9         ; $9606: b0 a1     
            lda ($a1),y        ; $9608: b1 a1     
__960a:     bcs __95bc         ; $960a: b0 b0     
            lda ($b1,x)        ; $960c: a1 b1     
            ldy #$b1           ; $960e: a0 b1     
__9610:     bcs __95b3         ; $9610: b0 a1     
            lda ($a1),y        ; $9612: b1 a1     
            lda ($a0),y        ; $9614: b1 a0     
__9616:     ldy #$b1           ; $9616: a0 b1     
__9618:     ldy #$b1           ; $9618: a0 b1     
            bcs __95bd         ; $961a: b0 a1     
__961c:     lda ($a1),y        ; $961c: b1 a1     
            bcs __95d0         ; $961e: b0 b0     
            lda ($b1,x)        ; $9620: a1 b1     
__9622:     ldy #$b1           ; $9622: a0 b1     
            bcs __95c6         ; $9624: b0 a0     
            ldy #$b1           ; $9626: a0 b1     
            bcs __95ca         ; $9628: b0 a0     
            bcs __95cc         ; $962a: b0 a0     
            ldy #$a0           ; $962c: a0 a0     
            .hex fb b1 a0      ; $962e: fb b1 a0  Invalid Opcode - ISC __a0b1,y
            lda ($b0),y        ; $9631: b1 b0     
            lda ($b1,x)        ; $9633: a1 b1     
            ldy #$b1           ; $9635: a0 b1     
            bcs __95d9         ; $9637: b0 a0     
            ldy #$fe           ; $9639: a0 fe     
            .hex 03 b1         ; $963b: 03 b1     Invalid Opcode - SLO ($b1,x)
            ldy #$b1           ; $963d: a0 b1     
            bcs __95e1         ; $963f: b0 a0     
            lda ($b0),y        ; $9641: b1 b0     
            ldy #$a0           ; $9643: a0 a0     
            bcs __95e7         ; $9645: b0 a0     
            ldy #$a0           ; $9647: a0 a0     
            lda ($10),y        ; $9649: b1 10     
            bpl __95fe         ; $964b: 10 b1     
            bpl __965f         ; $964d: 10 10     
            ora ($10),y        ; $964f: 11 10     
            bpl __9604         ; $9651: 10 b1     
            bpl __9665         ; $9653: 10 10     
            ora ($10),y        ; $9655: 11 10     
            bpl __960a         ; $9657: 10 b1     
            bpl __966b         ; $9659: 10 10     
            ora ($10),y        ; $965b: 11 10     
            bpl __9610         ; $965d: 10 b1     
__965f:     ldy #$10           ; $965f: a0 10     
            lda ($10),y        ; $9661: b1 10     
            bpl __9616         ; $9663: 10 b1     
__9665:     bpl __9677         ; $9665: 10 10     
            ora ($10),y        ; $9667: 11 10     
            bpl __961c         ; $9669: 10 b1     
__966b:     bpl __967d         ; $966b: 10 10     
            ora ($10),y        ; $966d: 11 10     
            bpl __9622         ; $966f: 10 b1     
            bpl __9683         ; $9671: 10 10     
            ora ($b0),y        ; $9673: 11 b0     
            bcs __9618         ; $9675: b0 a1     
__9677:     ldy #$a0           ; $9677: a0 a0     
            inc __ebff,x       ; $9679: fe ff eb  
            .hex 95            ; $967c: 95        Suspected data
__967d:     lda $4015          ; $967d: ad 15 40  
            and #$10           ; $9680: 29 10     
            .hex d0            ; $9682: d0        Suspected data
__9683:     ora $a9            ; $9683: 05 a9     
            brk                ; $9685: 00        
            sta $016c          ; $9686: 8d 6c 01  
            inc $a9            ; $9689: e6 a9     
            lda $aa            ; $968b: a5 aa     
            beq __96b6         ; $968d: f0 27     
            lda $a9            ; $968f: a5 a9     
            and #$3f           ; $9691: 29 3f     
            bne __96b6         ; $9693: d0 21     
            inc $aa            ; $9695: e6 aa     
            lda $aa            ; $9697: a5 aa     
            cmp #$04           ; $9699: c9 04     
            bne __96a3         ; $969b: d0 06     
            jsr __a2af         ; $969d: 20 af a2  
            jmp __96b6         ; $96a0: 4c b6 96  

;-------------------------------------------------------------------------------
__96a3:     cmp #$03           ; $96a3: c9 03     
            bne __96ab         ; $96a5: d0 04     
            lda #$00           ; $96a7: a9 00     
            sta $b6            ; $96a9: 85 b6     
__96ab:     cmp #$02           ; $96ab: c9 02     
            bne __96b6         ; $96ad: d0 07     
            lda #$00           ; $96af: a9 00     
            sta $b3            ; $96b1: 85 b3     
            sta $4008          ; $96b3: 8d 08 40  
__96b6:     ldx #$00           ; $96b6: a2 00     
            ldy #$00           ; $96b8: a0 00     
__96ba:     stx $0164          ; $96ba: 8e 64 01  
            lda $b1,x          ; $96bd: b5 b1     
            beq __96c4         ; $96bf: f0 03     
            jsr __96ca         ; $96c1: 20 ca 96  
__96c4:     inx                ; $96c4: e8        
            cpx #$06           ; $96c5: e0 06     
            bcc __96ba         ; $96c7: 90 f1     
__96c9:     rts                ; $96c9: 60        

;-------------------------------------------------------------------------------
__96ca:     jsr __9d9c         ; $96ca: 20 9c 9d  
            dec $ab,x          ; $96cd: d6 ab     
            bne __96d4         ; $96cf: d0 03     
            jmp __9751         ; $96d1: 4c 51 97  

;-------------------------------------------------------------------------------
__96d4:     cpx #$05           ; $96d4: e0 05     
            beq __96c9         ; $96d6: f0 f1     
            cpx #$02           ; $96d8: e0 02     
            beq __96c9         ; $96da: f0 ed     
            cpx #$04           ; $96dc: e0 04     
            beq __96c9         ; $96de: f0 e9     
            lda #$41           ; $96e0: a9 41     
            sta $015c          ; $96e2: 8d 5c 01  
            lda $c3,x          ; $96e5: b5 c3     
            bit $015c          ; $96e7: 2c 5c 01  
            beq __96ee         ; $96ea: f0 02     
            bne __96c9         ; $96ec: d0 db     
__96ee:     lda #$00           ; $96ee: a9 00     
            sta $99            ; $96f0: 85 99     
            dec $014e,x        ; $96f2: de 4e 01  
            bne __9703         ; $96f5: d0 0c     
            inc $0152,x        ; $96f7: fe 52 01  
            jsr __9c64         ; $96fa: 20 64 9c  
            jsr __9cbb         ; $96fd: 20 bb 9c  
            jsr __9bb7         ; $9700: 20 b7 9b  
__9703:     lda $0136,x        ; $9703: bd 36 01  
            and #$80           ; $9706: 29 80     
            beq __9718         ; $9708: f0 0e     
            lda $0150,x        ; $970a: bd 50 01  
            beq __9723         ; $970d: f0 14     
            dec $0150,x        ; $970f: de 50 01  
            inc $0140,x        ; $9712: fe 40 01  
            jmp __9723         ; $9715: 4c 23 97  

;-------------------------------------------------------------------------------
__9718:     dec $014c,x        ; $9718: de 4c 01  
            bne __9723         ; $971b: d0 06     
            inc $0150,x        ; $971d: fe 50 01  
            jsr __9cc6         ; $9720: 20 c6 9c  
__9723:     lda $0129,x        ; $9723: bd 29 01  
            sta $9a            ; $9726: 85 9a     
            lda $ab,x          ; $9728: b5 ab     
            cmp $013a,x        ; $972a: dd 3a 01  
            bcs __9744         ; $972d: b0 15     
            dec $013c,x        ; $972f: de 3c 01  
            bne __9741         ; $9732: d0 0d     
            lda $0138,x        ; $9734: bd 38 01  
            lsr                ; $9737: 4a        
            lsr                ; $9738: 4a        
            lsr                ; $9739: 4a        
            lsr                ; $973a: 4a        
            sta $013c,x        ; $973b: 9d 3c 01  
            inc $0140,x        ; $973e: fe 40 01  
__9741:     jsr __9d20         ; $9741: 20 20 9d  
__9744:     jsr __9ced         ; $9744: 20 ed 9c  
            jsr __9e0e         ; $9747: 20 0e 9e  
            bcs __974f         ; $974a: b0 03     
            jmp __9dd0         ; $974c: 4c d0 9d  

;-------------------------------------------------------------------------------
__974f:     rts                ; $974f: 60        

;-------------------------------------------------------------------------------
__9750:     iny                ; $9750: c8        
__9751:     lda ($a1),y        ; $9751: b1 a1     
            cmp #$fb           ; $9753: c9 fb     
            bcs __975a         ; $9755: b0 03     
            jmp __982c         ; $9757: 4c 2c 98  

;-------------------------------------------------------------------------------
__975a:     sec                ; $975a: 38        
            sbc #$fb           ; $975b: e9 fb     
            jsr __9e7e         ; $975d: 20 7e 9e  
            ror                ; $9760: 6a        
            .hex 97 6a         ; $9761: 97 6a     Invalid Opcode - SAX $6a,y
            .hex 97 7b         ; $9763: 97 7b     Invalid Opcode - SAX $7b,y
            .hex 97 8d         ; $9765: 97 8d     Invalid Opcode - SAX $8d,y
            .hex 97 d2         ; $9767: 97 d2     Invalid Opcode - SAX $d2,y
            .hex 97 20         ; $9769: 97 20     Invalid Opcode - SAX $20,y
            .hex a7 9d         ; $976b: a7 9d     Invalid Opcode - LAX $9d
            lda $b7,x          ; $976d: b5 b7     
            sta $e1,x          ; $976f: 95 e1     
            lda $bd,x          ; $9771: b5 bd     
            sta $e7,x          ; $9773: 95 e7     
            jsr __9d9c         ; $9775: 20 9c 9d  
            jmp __9751         ; $9778: 4c 51 97  

;-------------------------------------------------------------------------------
            lda $c3,x          ; $977b: b5 c3     
            ora #$02           ; $977d: 09 02     
            sta $c3,x          ; $977f: 95 c3     
            jsr __9db7         ; $9781: 20 b7 9d  
            jsr __9dc2         ; $9784: 20 c2 9d  
            jsr __9d9c         ; $9787: 20 9c 9d  
            jmp __9751         ; $978a: 4c 51 97  

;-------------------------------------------------------------------------------
            iny                ; $978d: c8        
            lda ($a1),y        ; $978e: b1 a1     
            cmp #$ff           ; $9790: c9 ff     
            beq __97b2         ; $9792: f0 1e     
            lda $db,x          ; $9794: b5 db     
            clc                ; $9796: 18        
            adc #$01           ; $9797: 69 01     
            cmp ($a1),y        ; $9799: d1 a1     
            beq __97bb         ; $979b: f0 1e     
            bmi __97a2         ; $979d: 30 03     
            sec                ; $979f: 38        
            sbc #$01           ; $97a0: e9 01     
__97a2:     sta $db,x          ; $97a2: 95 db     
            lda $e1,x          ; $97a4: b5 e1     
            sta $b7,x          ; $97a6: 95 b7     
            lda $e7,x          ; $97a8: b5 e7     
            sta $bd,x          ; $97aa: 95 bd     
            jsr __9d9c         ; $97ac: 20 9c 9d  
            jmp __9751         ; $97af: 4c 51 97  

;-------------------------------------------------------------------------------
__97b2:     jsr __9db7         ; $97b2: 20 b7 9d  
            jsr __9d9c         ; $97b5: 20 9c 9d  
            jmp __9751         ; $97b8: 4c 51 97  

;-------------------------------------------------------------------------------
__97bb:     lda #$00           ; $97bb: a9 00     
            sta $db,x          ; $97bd: 95 db     
            iny                ; $97bf: c8        
            tya                ; $97c0: 98        
            clc                ; $97c1: 18        
            adc $a1            ; $97c2: 65 a1     
            sta $b7,x          ; $97c4: 95 b7     
            lda #$00           ; $97c6: a9 00     
            adc $a2            ; $97c8: 65 a2     
            sta $bd,x          ; $97ca: 95 bd     
            jsr __9d9c         ; $97cc: 20 9c 9d  
            jmp __9751         ; $97cf: 4c 51 97  

;-------------------------------------------------------------------------------
            lda $c3,x          ; $97d2: b5 c3     
            and #$02           ; $97d4: 29 02     
            beq __97ec         ; $97d6: f0 14     
            lda $c3,x          ; $97d8: b5 c3     
            and #$fd           ; $97da: 29 fd     
            sta $c3,x          ; $97dc: 95 c3     
            lda $cf,x          ; $97de: b5 cf     
            sta $b7,x          ; $97e0: 95 b7     
            lda $d5,x          ; $97e2: b5 d5     
            sta $bd,x          ; $97e4: 95 bd     
            jsr __9d9c         ; $97e6: 20 9c 9d  
            jmp __9751         ; $97e9: 4c 51 97  

;-------------------------------------------------------------------------------
__97ec:     lda $b1,x          ; $97ec: b5 b1     
            sta $99            ; $97ee: 85 99     
            lda #$00           ; $97f0: a9 00     
            sta $b1,x          ; $97f2: 95 b1     
            sta $011a,x        ; $97f4: 9d 1a 01  
            sta $c3,x          ; $97f7: 95 c3     
            lda $99            ; $97f9: a5 99     
            cmp #$2f           ; $97fb: c9 2f     
            bne __9807         ; $97fd: d0 08     
            .hex 20            ; $97ff: 20        Suspected data
__9800:     .hex af a2 a9      ; $9800: af a2 a9  Invalid Opcode - LAX __a9a2
            eor $4c            ; $9803: 45 4c     
            .hex 9b            ; $9805: 9b        Invalid Opcode - TAS 
            .hex a2            ; $9806: a2        Suspected data
__9807:     cpx #$05           ; $9807: e0 05     
            beq __982b         ; $9809: f0 20     
            cpx #$03           ; $980b: e0 03     
            bne __9816         ; $980d: d0 07     
            lda $b1            ; $980f: a5 b1     
            beq __9816         ; $9811: f0 03     
            jmp __9e41         ; $9813: 4c 41 9e  

;-------------------------------------------------------------------------------
__9816:     lda #$00           ; $9816: a9 00     
            sta $011a,x        ; $9818: 9d 1a 01  
            sta $c3,x          ; $981b: 95 c3     
            cpx #$02           ; $981d: e0 02     
            .hex f0            ; $981f: f0        Suspected data
__9820:     .hex 02            ; $9820: 02        Invalid Opcode - KIL 
            lda #$30           ; $9821: a9 30     
__9823:     jsr __9e0e         ; $9823: 20 0e 9e  
            bcs __982b         ; $9826: b0 03     
            jmp __9dd0         ; $9828: 4c d0 9d  

;-------------------------------------------------------------------------------
__982b:     rts                ; $982b: 60        

;-------------------------------------------------------------------------------
__982c:     lda $c3,x          ; $982c: b5 c3     
            and #$01           ; $982e: 29 01     
            bne __9835         ; $9830: d0 03     
            jmp __98e8         ; $9832: 4c e8 98  

;-------------------------------------------------------------------------------
__9835:     lda ($a1),y        ; $9835: b1 a1     
            and #$f0           ; $9837: 29 f0     
            bne __984b         ; $9839: d0 10     
            lda $0164          ; $983b: ad 64 01  
            jsr __9e7e         ; $983e: 20 7e 9e  
            lsr $98,x          ; $9841: 56 98     
            lsr $98,x          ; $9843: 56 98     
            .hex 89 98         ; $9845: 89 98     Invalid Opcode - NOP #$98
            lsr $98,x          ; $9847: 56 98     
            sta ($98),y        ; $9849: 91 98     
__984b:     lda $c9,x          ; $984b: b5 c9     
            sta $ab,x          ; $984d: 95 ab     
            cpx #$04           ; $984f: e0 04     
            bne __98a0         ; $9851: d0 4d     
            jmp __98c9         ; $9853: 4c c9 98  

;-------------------------------------------------------------------------------
            lda ($a1),y        ; $9856: b1 a1     
            bne __985d         ; $9858: d0 03     
            jmp __989f         ; $985a: 4c 9f 98  

;-------------------------------------------------------------------------------
__985d:     sta $c9,x          ; $985d: 95 c9     
            iny                ; $985f: c8        
            lda ($a1),y        ; $9860: b1 a1     
            and #$f0           ; $9862: 29 f0     
            sta $0129,x        ; $9864: 9d 29 01  
            iny                ; $9867: c8        
            lda $c3,x          ; $9868: b5 c3     
            ora #$08           ; $986a: 09 08     
            sta $c3,x          ; $986c: 95 c3     
            lda ($a1),y        ; $986e: b1 a1     
            beq __9876         ; $9870: f0 04     
            cmp #$88           ; $9872: c9 88     
            bne __987c         ; $9874: d0 06     
__9876:     lda $c3,x          ; $9876: b5 c3     
            and #$f7           ; $9878: 29 f7     
            sta $c3,x          ; $987a: 95 c3     
__987c:     lda ($a1),y        ; $987c: b1 a1     
            jsr __9e0e         ; $987e: 20 0e 9e  
            bcs __9886         ; $9881: b0 03     
            jsr __9dd9         ; $9883: 20 d9 9d  
__9886:     .hex 4c            ; $9886: 4c        Suspected data
__9887:     bvc __9820         ; $9887: 50 97     
            lda ($a1),y        ; $9889: b1 a1     
            sta $c9,x          ; $988b: 95 c9     
            iny                ; $988d: c8        
            jmp __987c         ; $988e: 4c 7c 98  

;-------------------------------------------------------------------------------
            lda ($a1),y        ; $9891: b1 a1     
            beq __98c8         ; $9893: f0 33     
            sta $c9,x          ; $9895: 95 c9     
            lda #$30           ; $9897: a9 30     
            sta $0129,x        ; $9899: 9d 29 01  
            jmp __9750         ; $989c: 4c 50 97  

;-------------------------------------------------------------------------------
__989f:     iny                ; $989f: c8        
__98a0:     lda $c9,x          ; $98a0: b5 c9     
            sta $ab,x          ; $98a2: 95 ab     
            lda ($a1),y        ; $98a4: b1 a1     
            lsr                ; $98a6: 4a        
            lsr                ; $98a7: 4a        
            lsr                ; $98a8: 4a        
            lsr                ; $98a9: 4a        
            ora $0129,x        ; $98aa: 1d 29 01  
            jsr __9e0e         ; $98ad: 20 0e 9e  
            bcs __98b5         ; $98b0: b0 03     
__98b2:     jsr __9dd0         ; $98b2: 20 d0 9d  
__98b5:     lda ($a1),y        ; $98b5: b1 a1     
            and #$07           ; $98b7: 29 07     
            sta $0115,x        ; $98b9: 9d 15 01  
__98bc:     iny                ; $98bc: c8        
            lda ($a1),y        ; $98bd: b1 a1     
            sta $0110,x        ; $98bf: 9d 10 01  
__98c2:     jsr __9b92         ; $98c2: 20 92 9b  
            jmp __9da7         ; $98c5: 4c a7 9d  

;-------------------------------------------------------------------------------
__98c8:     iny                ; $98c8: c8        
__98c9:     .hex b5            ; $98c9: b5        Suspected data
__98ca:     cmp #$95           ; $98ca: c9 95     
            .hex ab b1         ; $98cc: ab b1     Invalid Opcode - LAX #$b1
            .hex a1            ; $98ce: a1        Suspected data
__98cf:     lsr                ; $98cf: 4a        
            lsr                ; $98d0: 4a        
            lsr                ; $98d1: 4a        
            lsr                ; $98d2: 4a        
            ora $0129,x        ; $98d3: 1d 29 01  
            jsr __9dd0         ; $98d6: 20 d0 9d  
            lda #$00           ; $98d9: a9 00     
            sta $0115,x        ; $98db: 9d 15 01  
            lda ($a1),y        ; $98de: b1 a1     
            and #$0f           ; $98e0: 29 0f     
            sta $0110,x        ; $98e2: 9d 10 01  
            jmp __98c2         ; $98e5: 4c c2 98  

;-------------------------------------------------------------------------------
__98e8:     lda ($a1),y        ; $98e8: b1 a1     
            cmp #$d0           ; $98ea: c9 d0     
            bcs __98f1         ; $98ec: b0 03     
            jmp __9a53         ; $98ee: 4c 53 9a  

;-------------------------------------------------------------------------------
__98f1:     sec                ; $98f1: 38        
            sbc #$d0           ; $98f2: e9 d0     
__98f4:     lsr                ; $98f4: 4a        
            lsr                ; $98f5: 4a        
            lsr                ; $98f6: 4a        
            lsr                ; $98f7: 4a        
            jsr __9e7e         ; $98f8: 20 7e 9e  
            ora ($99,x)        ; $98fb: 01 99     
            .hex 5f 99 87      ; $98fd: 5f 99 87  Invalid Opcode - SRE __8799,x
            .hex 99            ; $9900: 99        Suspected data
__9901:     lda ($a1),y        ; $9901: b1 a1     
            and #$0f           ; $9903: 29 0f     
            sta $c9,x          ; $9905: 95 c9     
            iny                ; $9907: c8        
            cpx #$05           ; $9908: e0 05     
            bne __990f         ; $990a: d0 03     
            jmp __9751         ; $990c: 4c 51 97  

;-------------------------------------------------------------------------------
__990f:     lda ($a1),y        ; $990f: b1 a1     
            sta $0124,x        ; $9911: 9d 24 01  
            cpx #$02           ; $9914: e0 02     
            bne __991b         ; $9916: d0 03     
            jmp __9750         ; $9918: 4c 50 97  

;-------------------------------------------------------------------------------
__991b:     and #$f0           ; $991b: 29 f0     
            sta $0129,x        ; $991d: 9d 29 01  
            lda $0124,x        ; $9920: bd 24 01  
            .hex 29            ; $9923: 29        Suspected data
__9924:     .hex 0f 9d 3e      ; $9924: 0f 9d 3e  Invalid Opcode - SLO $3e9d
            ora ($9d,x)        ; $9927: 01 9d     
            bit $01            ; $9929: 24 01     
            iny                ; $992b: c8        
            cpx #$02           ; $992c: e0 02     
            bne __9933         ; $992e: d0 03     
            .hex 4c            ; $9930: 4c        Suspected data
__9931:     bvc __98ca         ; $9931: 50 97     
__9933:     lda ($a1),y        ; $9933: b1 a1     
            sta $0136,x        ; $9935: 9d 36 01  
            and #$80           ; $9938: 29 80     
            beq __9943         ; $993a: f0 07     
            lda ($a1),y        ; $993c: b1 a1     
            and #$0f           ; $993e: 29 0f     
            sta $0150,x        ; $9940: 9d 50 01  
__9943:     iny                ; $9943: c8        
            lda ($a1),y        ; $9944: b1 a1     
__9946:     sta $0138,x        ; $9946: 9d 38 01  
            and #$f0           ; $9949: 29 f0     
            bne __9955         ; $994b: d0 08     
            lda $0138,x        ; $994d: bd 38 01  
            ora #$10           ; $9950: 09 10     
            sta $0138,x        ; $9952: 9d 38 01  
__9955:     lsr                ; $9955: 4a        
            lsr                ; $9956: 4a        
            lsr                ; $9957: 4a        
            lsr                ; $9958: 4a        
            sta $013c,x        ; $9959: 9d 3c 01  
            jmp __9991         ; $995c: 4c 91 99  

;-------------------------------------------------------------------------------
__995f:     lda ($a1),y        ; $995f: b1 a1     
            and #$0f           ; $9961: 29 0f     
            cmp #$06           ; $9963: c9 06     
            bcc __9981         ; $9965: 90 1a     
            sec                ; $9967: 38        
            sbc #$06           ; $9968: e9 06     
            jsr __9e7e         ; $996a: 20 7e 9e  
            sta __a499,x       ; $996d: 9d 99 a4  
            sta __99ad,y       ; $9970: 99 ad 99  
            .hex b3 99         ; $9973: b3 99     Invalid Opcode - LAX ($99),y
            dec __d799         ; $9975: ce 99 d7  
            sta __99f1,y       ; $9978: 99 f1 99  
            sbc ($99),y        ; $997b: f1 99     
            sbc ($99),y        ; $997d: f1 99     
            sbc ($99),y        ; $997f: f1 99     
__9981:     sta $012e,x        ; $9981: 9d 2e 01  
            jmp __9991         ; $9984: 4c 91 99  

;-------------------------------------------------------------------------------
            lda ($a1),y        ; $9987: b1 a1     
            and #$0f           ; $9989: 29 0f     
            sta $013e,x        ; $998b: 9d 3e 01  
            jmp __9991         ; $998e: 4c 91 99  

;-------------------------------------------------------------------------------
__9991:     iny                ; $9991: c8        
            lda ($a1),y        ; $9992: b1 a1     
            and #$f0           ; $9994: 29 f0     
            cmp #$e0           ; $9996: c9 e0     
            beq __995f         ; $9998: f0 c5     
            jmp __9751         ; $999a: 4c 51 97  

;-------------------------------------------------------------------------------
            iny                ; $999d: c8        
            lda ($a1),y        ; $999e: b1 a1     
            sta $c9,x          ; $99a0: 95 c9     
            bne __9991         ; $99a2: d0 ed     
            iny                ; $99a4: c8        
            lda ($a1),y        ; $99a5: b1 a1     
            sta $0136,x        ; $99a7: 9d 36 01  
            jmp __9991         ; $99aa: 4c 91 99  

;-------------------------------------------------------------------------------
__99ad:     iny                ; $99ad: c8        
            lda ($a1),y        ; $99ae: b1 a1     
            jmp __9946         ; $99b0: 4c 46 99  

;-------------------------------------------------------------------------------
            lda #$0f           ; $99b3: a9 0f     
            sta $015c          ; $99b5: 8d 5c 01  
__99b8:     iny                ; $99b8: c8        
            lda ($a1),y        ; $99b9: b1 a1     
            beq __99c2         ; $99bb: f0 05     
            bit $015c          ; $99bd: 2c 5c 01  
            beq __99c8         ; $99c0: f0 06     
__99c2:     sta $0134,x        ; $99c2: 9d 34 01  
            jmp __9991         ; $99c5: 4c 91 99  

;-------------------------------------------------------------------------------
__99c8:     sta $0129,x        ; $99c8: 9d 29 01  
            jmp __9991         ; $99cb: 4c 91 99  

;-------------------------------------------------------------------------------
            iny                ; $99ce: c8        
            lda ($a1),y        ; $99cf: b1 a1     
            sta $0131,x        ; $99d1: 9d 31 01  
            jmp __9991         ; $99d4: 4c 91 99  

;-------------------------------------------------------------------------------
            iny                ; $99d7: c8        
            lda ($a1),y        ; $99d8: b1 a1     
            and #$0f           ; $99da: 29 0f     
            sta $0146,x        ; $99dc: 9d 46 01  
            lda ($a1),y        ; $99df: b1 a1     
            lsr                ; $99e1: 4a        
            lsr                ; $99e2: 4a        
            lsr                ; $99e3: 4a        
            lsr                ; $99e4: 4a        
            sta $0148,x        ; $99e5: 9d 48 01  
            iny                ; $99e8: c8        
            lda ($a1),y        ; $99e9: b1 a1     
            sta $014a,x        ; $99eb: 9d 4a 01  
            jmp __9991         ; $99ee: 4c 91 99  

;-------------------------------------------------------------------------------
__99f1:     lda #$0f           ; $99f1: a9 0f     
            sta $015c          ; $99f3: 8d 5c 01  
            iny                ; $99f6: c8        
            lda ($a1),y        ; $99f7: b1 a1     
            beq __9a00         ; $99f9: f0 05     
            bit $015c          ; $99fb: 2c 5c 01  
            .hex f0            ; $99fe: f0        Suspected data
__99ff:     .hex 06            ; $99ff: 06        Suspected data
__9a00:     sta $0134,x        ; $9a00: 9d 34 01  
            jmp __9a09         ; $9a03: 4c 09 9a  

;-------------------------------------------------------------------------------
__9a06:     sta $0129,x        ; $9a06: 9d 29 01  
__9a09:     iny                ; $9a09: c8        
            lda ($a1),y        ; $9a0a: b1 a1     
            and #$0f           ; $9a0c: 29 0f     
            sta $0146,x        ; $9a0e: 9d 46 01  
            lda ($a1),y        ; $9a11: b1 a1     
            lsr                ; $9a13: 4a        
            lsr                ; $9a14: 4a        
            lsr                ; $9a15: 4a        
            lsr                ; $9a16: 4a        
            sta $0148,x        ; $9a17: 9d 48 01  
            iny                ; $9a1a: c8        
            lda ($a1),y        ; $9a1b: b1 a1     
            sta $014a,x        ; $9a1d: 9d 4a 01  
            iny                ; $9a20: c8        
            jmp __9901         ; $9a21: 4c 01 99  

;-------------------------------------------------------------------------------
__9a24:     lda ($a1),y        ; $9a24: b1 a1     
            lsr                ; $9a26: 4a        
            lsr                ; $9a27: 4a        
            lsr                ; $9a28: 4a        
            lsr                ; $9a29: 4a        
            cmp #$0c           ; $9a2a: c9 0c     
            beq __9a46         ; $9a2c: f0 18     
            tax                ; $9a2e: aa        
            cmp #$0a           ; $9a2f: c9 0a     
            bne __9a3a         ; $9a31: d0 07     
            lda #$03           ; $9a33: a9 03     
            jsr __a29b         ; $9a35: 20 9b a2  
            ldx #$0a           ; $9a38: a2 0a     
__9a3a:     lda __9a47,x       ; $9a3a: bd 47 9a  
            sta $0169          ; $9a3d: 8d 69 01  
            jsr __a29b         ; $9a40: 20 9b a2  
            ldx $0164          ; $9a43: ae 64 01  
__9a46:     rts                ; $9a46: 60        

;-------------------------------------------------------------------------------
__9a47:     .hex 02            ; $9a47: 02        Invalid Opcode - KIL 
            .hex 02            ; $9a48: 02        Invalid Opcode - KIL 
            .hex 02            ; $9a49: 02        Invalid Opcode - KIL 
            .hex 02            ; $9a4a: 02        Invalid Opcode - KIL 
            .hex 03 03         ; $9a4b: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 03         ; $9a4d: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 03 04         ; $9a4f: 03 04     Invalid Opcode - SLO ($04,x)
            .hex 5d 5e         ; $9a51: 5d 5e     Suspected data
__9a53:     jsr __9da7         ; $9a53: 20 a7 9d  
            dey                ; $9a56: 88        
            lda ($a1),y        ; $9a57: b1 a1     
            and #$0f           ; $9a59: 29 0f     
            sta $99            ; $9a5b: 85 99     
            beq __9a6a         ; $9a5d: f0 0b     
            lda $c9,x          ; $9a5f: b5 c9     
            clc                ; $9a61: 18        
__9a62:     adc $c9,x          ; $9a62: 75 c9     
            dec $99            ; $9a64: c6 99     
            bne __9a62         ; $9a66: d0 fa     
            beq __9a6c         ; $9a68: f0 02     
__9a6a:     lda $c9,x          ; $9a6a: b5 c9     
__9a6c:     sta $ab,x          ; $9a6c: 95 ab     
            cpx #$05           ; $9a6e: e0 05     
            bne __9a75         ; $9a70: d0 03     
            jmp __9a24         ; $9a72: 4c 24 9a  

;-------------------------------------------------------------------------------
__9a75:     lda ($a1),y        ; $9a75: b1 a1     
            and #$f0           ; $9a77: 29 f0     
            cmp #$c0           ; $9a79: c9 c0     
            bne __9aa2         ; $9a7b: d0 25     
            lda #$40           ; $9a7d: a9 40     
            ora $c3,x          ; $9a7f: 15 c3     
            sta $c3,x          ; $9a81: 95 c3     
            cpx #$02           ; $9a83: e0 02     
            beq __9a95         ; $9a85: f0 0e     
            lda #$30           ; $9a87: a9 30     
            ora $0129,x        ; $9a89: 1d 29 01  
            jsr __9e0e         ; $9a8c: 20 0e 9e  
            bcs __9a94         ; $9a8f: b0 03     
            jmp __9dd0         ; $9a91: 4c d0 9d  

;-------------------------------------------------------------------------------
__9a94:     rts                ; $9a94: 60        

;-------------------------------------------------------------------------------
__9a95:     lda #$00           ; $9a95: a9 00     
            jsr __9dd0         ; $9a97: 20 d0 9d  
            lda #$ff           ; $9a9a: a9 ff     
            sta $011c          ; $9a9c: 8d 1c 01  
            jmp __9deb         ; $9a9f: 4c eb 9d  

;-------------------------------------------------------------------------------
__9aa2:     lda $c3,x          ; $9aa2: b5 c3     
            and #$bf           ; $9aa4: 29 bf     
            sta $c3,x          ; $9aa6: 95 c3     
            cpx #$02           ; $9aa8: e0 02     
            bne __9aee         ; $9aaa: d0 42     
            lda $0124,x        ; $9aac: bd 24 01  
            cmp #$81           ; $9aaf: c9 81     
            bcs __9ad2         ; $9ab1: b0 1f     
            lda ($a1),y        ; $9ab3: b1 a1     
            and #$0f           ; $9ab5: 29 0f     
            sta $99            ; $9ab7: 85 99     
            sta $9b            ; $9ab9: 85 9b     
            beq __9ad2         ; $9abb: f0 15     
            lda $0124,x        ; $9abd: bd 24 01  
            clc                ; $9ac0: 18        
__9ac1:     adc $0124,x        ; $9ac1: 7d 24 01  
            cmp #$81           ; $9ac4: c9 81     
            bcs __9acc         ; $9ac6: b0 04     
            dec $99            ; $9ac8: c6 99     
            bne __9ac1         ; $9aca: d0 f5     
__9acc:     clc                ; $9acc: 18        
            adc $9b            ; $9acd: 65 9b     
            jmp __9ad5         ; $9acf: 4c d5 9a  

;-------------------------------------------------------------------------------
__9ad2:     lda $0124,x        ; $9ad2: bd 24 01  
__9ad5:     sta $9b            ; $9ad5: 85 9b     
            lda $c3,x          ; $9ad7: b5 c3     
            and #$80           ; $9ad9: 29 80     
            beq __9ae9         ; $9adb: f0 0c     
            lda #$ff           ; $9add: a9 ff     
            sta $011c          ; $9adf: 8d 1c 01  
            jsr __9deb         ; $9ae2: 20 eb 9d  
            lda #$00           ; $9ae5: a9 00     
            beq __9aeb         ; $9ae7: f0 02     
__9ae9:     lda $9b            ; $9ae9: a5 9b     
__9aeb:     jmp __9b5e         ; $9aeb: 4c 5e 9b  

;-------------------------------------------------------------------------------
__9aee:     lda $0138,x        ; $9aee: bd 38 01  
            and #$0f           ; $9af1: 29 0f     
            sta $99            ; $9af3: 85 99     
            beq __9b16         ; $9af5: f0 1f     
            lda #$00           ; $9af7: a9 00     
            sta $9a            ; $9af9: 85 9a     
__9afb:     clc                ; $9afb: 18        
            adc $ab,x          ; $9afc: 75 ab     
            bcc __9b02         ; $9afe: 90 02     
            inc $9a            ; $9b00: e6 9a     
__9b02:     dec $99            ; $9b02: c6 99     
            bne __9afb         ; $9b04: d0 f5     
            sta $99            ; $9b06: 85 99     
            lda #$04           ; $9b08: a9 04     
            sta $9b            ; $9b0a: 85 9b     
__9b0c:     lsr $9a            ; $9b0c: 46 9a     
            ror $99            ; $9b0e: 66 99     
            dec $9b            ; $9b10: c6 9b     
            bne __9b0c         ; $9b12: d0 f8     
            lda $99            ; $9b14: a5 99     
__9b16:     sta $013a,x        ; $9b16: 9d 3a 01  
            lda #$00           ; $9b19: a9 00     
            sta $0150,x        ; $9b1b: 9d 50 01  
            sta $0154,x        ; $9b1e: 9d 54 01  
            sta $0158,x        ; $9b21: 9d 58 01  
            sta $0140,x        ; $9b24: 9d 40 01  
            sta $0152,x        ; $9b27: 9d 52 01  
            sta $0156,x        ; $9b2a: 9d 56 01  
            sta $015a,x        ; $9b2d: 9d 5a 01  
            lda #$01           ; $9b30: a9 01     
            sta $014c,x        ; $9b32: 9d 4c 01  
            lda $0148,x        ; $9b35: bd 48 01  
            sta $014e,x        ; $9b38: 9d 4e 01  
            lda #$80           ; $9b3b: a9 80     
            sta $015c          ; $9b3d: 8d 5c 01  
            lda $0136,x        ; $9b40: bd 36 01  
            bit $015c          ; $9b43: 2c 5c 01  
            bne __9b4e         ; $9b46: d0 06     
            jsr __9cc6         ; $9b48: 20 c6 9c  
            jmp __9b53         ; $9b4b: 4c 53 9b  

;-------------------------------------------------------------------------------
__9b4e:     and #$0f           ; $9b4e: 29 0f     
            sta $0150,x        ; $9b50: 9d 50 01  
__9b53:     jsr __9d2f         ; $9b53: 20 2f 9d  
            jsr __9ced         ; $9b56: 20 ed 9c  
            jsr __9e0e         ; $9b59: 20 0e 9e  
            bcs __9b61         ; $9b5c: b0 03     
__9b5e:     jsr __9dd0         ; $9b5e: 20 d0 9d  
__9b61:     lda ($a1),y        ; $9b61: b1 a1     
            lsr                ; $9b63: 4a        
            lsr                ; $9b64: 4a        
            lsr                ; $9b65: 4a        
            lsr                ; $9b66: 4a        
            sta $99            ; $9b67: 85 99     
            jsr __9c4d         ; $9b69: 20 4d 9c  
            clc                ; $9b6c: 18        
            adc $99            ; $9b6d: 65 99     
            clc                ; $9b6f: 18        
            adc #$0c           ; $9b70: 69 0c     
            asl                ; $9b72: 0a        
            tay                ; $9b73: a8        
            lda __9c05,y       ; $9b74: b9 05 9c  
            sta $0110,x        ; $9b77: 9d 10 01  
            lda __9c06,y       ; $9b7a: b9 06 9c  
            sta $0115,x        ; $9b7d: 9d 15 01  
            ldy $012e,x        ; $9b80: bc 2e 01  
__9b83:     tya                ; $9b83: 98        
            cmp #$05           ; $9b84: c9 05     
            beq __9b92         ; $9b86: f0 0a     
            lsr $0115,x        ; $9b88: 5e 15 01  
            ror $0110,x        ; $9b8b: 7e 10 01  
            iny                ; $9b8e: c8        
            jmp __9b83         ; $9b8f: 4c 83 9b  

;-------------------------------------------------------------------------------
__9b92:     lda $0115,x        ; $9b92: bd 15 01  
            ora #$08           ; $9b95: 09 08     
            sta $0115,x        ; $9b97: 9d 15 01  
            jsr __9cbb         ; $9b9a: 20 bb 9c  
            lda #$00           ; $9b9d: a9 00     
            sta $99            ; $9b9f: 85 99     
            cpx #$02           ; $9ba1: e0 02     
            beq __9bed         ; $9ba3: f0 48     
            cpx #$04           ; $9ba5: e0 04     
            beq __9bb7         ; $9ba7: f0 0e     
            lda $c3,x          ; $9ba9: b5 c3     
            and #$01           ; $9bab: 29 01     
            bne __9bb7         ; $9bad: d0 08     
            lda $014e,x        ; $9baf: bd 4e 01  
            bne __9bb7         ; $9bb2: d0 03     
            jsr __9c64         ; $9bb4: 20 64 9c  
__9bb7:     lda $99            ; $9bb7: a5 99     
            bmi __9bc9         ; $9bb9: 30 0e     
            lda $9b            ; $9bbb: a5 9b     
            clc                ; $9bbd: 18        
            adc $99            ; $9bbe: 65 99     
            sta $9b            ; $9bc0: 85 9b     
            bcc __9bd4         ; $9bc2: 90 10     
            inc $9c            ; $9bc4: e6 9c     
            jmp __9bd4         ; $9bc6: 4c d4 9b  

;-------------------------------------------------------------------------------
__9bc9:     lda $9b            ; $9bc9: a5 9b     
            clc                ; $9bcb: 18        
            adc $99            ; $9bcc: 65 99     
            sta $9b            ; $9bce: 85 9b     
            bcs __9bd4         ; $9bd0: b0 02     
            dec $9c            ; $9bd2: c6 9c     
__9bd4:     lda $9c            ; $9bd4: a5 9c     
            cmp $011a,x        ; $9bd6: dd 1a 01  
            bne __9bea         ; $9bd9: d0 0f     
            lda $0129,x        ; $9bdb: bd 29 01  
            and #$10           ; $9bde: 29 10     
            beq __9bed         ; $9be0: f0 0b     
            lda $c3,x          ; $9be2: b5 c3     
            and #$08           ; $9be4: 29 08     
            bne __9bed         ; $9be6: d0 05     
            beq __9bf7         ; $9be8: f0 0d     
__9bea:     sta $011a,x        ; $9bea: 9d 1a 01  
__9bed:     lda $9c            ; $9bed: a5 9c     
            jsr __9e0e         ; $9bef: 20 0e 9e  
            bcs __9bf7         ; $9bf2: b0 03     
            jsr __9deb         ; $9bf4: 20 eb 9d  
__9bf7:     lda $9b            ; $9bf7: a5 9b     
            sta $011f,x        ; $9bf9: 9d 1f 01  
            jsr __9e0e         ; $9bfc: 20 0e 9e  
            bcs __9c04         ; $9bff: b0 03     
            jsr __9de2         ; $9c01: 20 e2 9d  
__9c04:     rts                ; $9c04: 60        

;-------------------------------------------------------------------------------
__9c05:     .hex 5c            ; $9c05: 5c        Suspected data
__9c06:     ora $0c9c          ; $9c06: 0d 9c 0c  
            inx                ; $9c09: e8        
            .hex 0b 3c         ; $9c0a: 0b 3c     Invalid Opcode - ANC #$3c
            .hex 0b 9a         ; $9c0c: 0b 9a     Invalid Opcode - ANC #$9a
            asl                ; $9c0e: 0a        
            .hex 02            ; $9c0f: 02        Invalid Opcode - KIL 
            asl                ; $9c10: 0a        
            .hex 72            ; $9c11: 72        Invalid Opcode - KIL 
            ora #$ea           ; $9c12: 09 ea     
            php                ; $9c14: 08        
            ror                ; $9c15: 6a        
            php                ; $9c16: 08        
            .hex f2            ; $9c17: f2        Invalid Opcode - KIL 
            .hex 07 80         ; $9c18: 07 80     Invalid Opcode - SLO $80
            .hex 07 14         ; $9c1a: 07 14     Invalid Opcode - SLO $14
            .hex 07 ae         ; $9c1c: 07 ae     Invalid Opcode - SLO $ae
            asl $4e            ; $9c1e: 06 4e     
            asl $f4            ; $9c20: 06 f4     
            ora $9e            ; $9c22: 05 9e     
            ora $4d            ; $9c24: 05 4d     
            ora $01            ; $9c26: 05 01     
            ora $b9            ; $9c28: 05 b9     
            .hex 04 75         ; $9c2a: 04 75     Invalid Opcode - NOP $75
            .hex 04 35         ; $9c2c: 04 35     Invalid Opcode - NOP $35
            .hex 04 f9         ; $9c2e: 04 f9     Invalid Opcode - NOP $f9
            .hex 03 c0         ; $9c30: 03 c0     Invalid Opcode - SLO ($c0,x)
            .hex 03 8a         ; $9c32: 03 8a     Invalid Opcode - SLO ($8a,x)
            .hex 03 57         ; $9c34: 03 57     Invalid Opcode - SLO ($57,x)
            .hex 03 27         ; $9c36: 03 27     Invalid Opcode - SLO ($27,x)
            .hex 03 fa         ; $9c38: 03 fa     Invalid Opcode - SLO ($fa,x)
            .hex 02            ; $9c3a: 02        Invalid Opcode - KIL 
            .hex cf 02 a7      ; $9c3b: cf 02 a7  Invalid Opcode - DCP __a702
            .hex 02            ; $9c3e: 02        Invalid Opcode - KIL 
            sta ($02,x)        ; $9c3f: 81 02     
            eor $3b02,x        ; $9c41: 5d 02 3b  
            .hex 02            ; $9c44: 02        Invalid Opcode - KIL 
            .hex 1b 02 fc      ; $9c45: 1b 02 fc  Invalid Opcode - SLO __fc02,y
            ora ($e0,x)        ; $9c48: 01 e0     
            ora ($c5,x)        ; $9c4a: 01 c5     
            .hex 01            ; $9c4c: 01        Suspected data
__9c4d:     lda #$80           ; $9c4d: a9 80     
            sta $015c          ; $9c4f: 8d 5c 01  
            lda $0131,x        ; $9c52: bd 31 01  
            bit $015c          ; $9c55: 2c 5c 01  
            beq __9c63         ; $9c58: f0 09     
            and #$0f           ; $9c5a: 29 0f     
            sta $9a            ; $9c5c: 85 9a     
            lda #$00           ; $9c5e: a9 00     
            sec                ; $9c60: 38        
            sbc $9a            ; $9c61: e5 9a     
__9c63:     rts                ; $9c63: 60        

;-------------------------------------------------------------------------------
__9c64:     lda #$00           ; $9c64: a9 00     
            sta $99            ; $9c66: 85 99     
            lda $014a,x        ; $9c68: bd 4a 01  
            asl                ; $9c6b: 0a        
            sty $a5            ; $9c6c: 84 a5     
            tay                ; $9c6e: a8        
            lda __8cd0,y       ; $9c6f: b9 d0 8c  
            sta $99            ; $9c72: 85 99     
            lda __8cd1,y       ; $9c74: b9 d1 8c  
            sta $9a            ; $9c77: 85 9a     
            stx $a5            ; $9c79: 86 a5     
            lda #$02           ; $9c7b: a9 02     
            clc                ; $9c7d: 18        
            adc $a5            ; $9c7e: 65 a5     
            tax                ; $9c80: aa        
            jsr __9d48         ; $9c81: 20 48 9d  
            ldx $a5            ; $9c84: a6 a5     
            lda $99            ; $9c86: a5 99     
            lsr                ; $9c88: 4a        
            lsr                ; $9c89: 4a        
            lsr                ; $9c8a: 4a        
            lsr                ; $9c8b: 4a        
            sta $014e,x        ; $9c8c: 9d 4e 01  
            lda $99            ; $9c8f: a5 99     
            and #$0f           ; $9c91: 29 0f     
            sta $99            ; $9c93: 85 99     
            ldy $0146,x        ; $9c95: bc 46 01  
            bne __9c9d         ; $9c98: d0 03     
            tya                ; $9c9a: 98        
            beq __9cb6         ; $9c9b: f0 19     
__9c9d:     lda #$08           ; $9c9d: a9 08     
            sta $015c          ; $9c9f: 8d 5c 01  
            lda $99            ; $9ca2: a5 99     
            bit $015c          ; $9ca4: 2c 5c 01  
            beq __9cad         ; $9ca7: f0 04     
            ora #$f0           ; $9ca9: 09 f0     
            sta $99            ; $9cab: 85 99     
__9cad:     dey                ; $9cad: 88        
            beq __9cb6         ; $9cae: f0 06     
            clc                ; $9cb0: 18        
            adc $99            ; $9cb1: 65 99     
            jmp __9cad         ; $9cb3: 4c ad 9c  

;-------------------------------------------------------------------------------
__9cb6:     sta $99            ; $9cb6: 85 99     
            ldy $a5            ; $9cb8: a4 a5     
            rts                ; $9cba: 60        

;-------------------------------------------------------------------------------
__9cbb:     lda $0110,x        ; $9cbb: bd 10 01  
            sta $9b            ; $9cbe: 85 9b     
            lda $0115,x        ; $9cc0: bd 15 01  
            sta $9c            ; $9cc3: 85 9c     
            rts                ; $9cc5: 60        

;-------------------------------------------------------------------------------
__9cc6:     lda $0136,x        ; $9cc6: bd 36 01  
            asl                ; $9cc9: 0a        
            sty $a5            ; $9cca: 84 a5     
            tay                ; $9ccc: a8        
            lda __8b3a,y       ; $9ccd: b9 3a 8b  
            sta $99            ; $9cd0: 85 99     
            lda __8b3b,y       ; $9cd2: b9 3b 8b  
            sta $9a            ; $9cd5: 85 9a     
            jsr __9d48         ; $9cd7: 20 48 9d  
            lda $99            ; $9cda: a5 99     
            and #$0f           ; $9cdc: 29 0f     
            sta $0124,x        ; $9cde: 9d 24 01  
            lda $99            ; $9ce1: a5 99     
            lsr                ; $9ce3: 4a        
            lsr                ; $9ce4: 4a        
            lsr                ; $9ce5: 4a        
            lsr                ; $9ce6: 4a        
            sta $014c,x        ; $9ce7: 9d 4c 01  
            ldy $a5            ; $9cea: a4 a5     
            rts                ; $9cec: 60        

;-------------------------------------------------------------------------------
__9ced:     lda $0134,x        ; $9ced: bd 34 01  
            and #$04           ; $9cf0: 29 04     
            beq __9cff         ; $9cf2: f0 0b     
            lda #$02           ; $9cf4: a9 02     
            sta $99            ; $9cf6: 85 99     
            lda $ab,x          ; $9cf8: b5 ab     
            .hex dd 3a         ; $9cfa: dd 3a     Suspected data
__9cfc:     ora ($90,x)        ; $9cfc: 01 90     
            .hex 1c            ; $9cfe: 1c        Suspected data
__9cff:     lda $0124,x        ; $9cff: bd 24 01  
            .hex f0            ; $9d02: f0        Suspected data
__9d03:     ora $38,x          ; $9d03: 15 38     
            sbc $013e,x        ; $9d05: fd 3e 01  
            bcc __9d17         ; $9d08: 90 0d     
            sec                ; $9d0a: 38        
            sbc $0140,x        ; $9d0b: fd 40 01  
            bcc __9d17         ; $9d0e: 90 07     
            sec                ; $9d10: 38        
            sbc $aa            ; $9d11: e5 aa     
            beq __9d17         ; $9d13: f0 02     
            bcs __9d19         ; $9d15: b0 02     
__9d17:     lda #$01           ; $9d17: a9 01     
__9d19:     sta $99            ; $9d19: 85 99     
__9d1b:     lda $9a            ; $9d1b: a5 9a     
            ora $99            ; $9d1d: 05 99     
            rts                ; $9d1f: 60        

;-------------------------------------------------------------------------------
__9d20:     .hex bd 34         ; $9d20: bd 34     Suspected data
__9d22:     ora ($29,x)        ; $9d22: 01 29     
            .hex 02            ; $9d24: 02        Invalid Opcode - KIL 
            beq __9d2e         ; $9d25: f0 07     
            lda $0134,x        ; $9d27: bd 34 01  
            and #$f0           ; $9d2a: 29 f0     
            sta $9a            ; $9d2c: 85 9a     
__9d2e:     rts                ; $9d2e: 60        

;-------------------------------------------------------------------------------
__9d2f:     lda $0129,x        ; $9d2f: bd 29 01  
            sta $9a            ; $9d32: 85 9a     
            lda #$01           ; $9d34: a9 01     
            sta $015c          ; $9d36: 8d 5c 01  
            lda $0134,x        ; $9d39: bd 34 01  
            bit $015c          ; $9d3c: 2c 5c 01  
            beq __9d1b         ; $9d3f: f0 da     
            and #$f0           ; $9d41: 29 f0     
            sta $9a            ; $9d43: 85 9a     
            jmp __9d1b         ; $9d45: 4c 1b 9d  

;-------------------------------------------------------------------------------
__9d48:     ldy $0150,x        ; $9d48: bc 50 01  
            lda ($99),y        ; $9d4b: b1 99     
            cmp #$fb           ; $9d4d: c9 fb     
            bcc __9d61         ; $9d4f: 90 10     
            sec                ; $9d51: 38        
            sbc #$fb           ; $9d52: e9 fb     
            jsr __9e7e         ; $9d54: 20 7e 9e  
            .hex 64 9d         ; $9d57: 64 9d     Invalid Opcode - NOP $9d
            .hex 64 9d         ; $9d59: 64 9d     Invalid Opcode - NOP $9d
            .hex 64 9d         ; $9d5b: 64 9d     Invalid Opcode - NOP $9d
            bvs __9cfc         ; $9d5d: 70 9d     
            .hex 8d 9d         ; $9d5f: 8d 9d     Suspected data
__9d61:     sta $99            ; $9d61: 85 99     
            rts                ; $9d63: 60        

;-------------------------------------------------------------------------------
            inc $0150,x        ; $9d64: fe 50 01  
            lda $0150,x        ; $9d67: bd 50 01  
            .hex 9d            ; $9d6a: 9d        Suspected data
__9d6b:     .hex 54 01         ; $9d6b: 54 01     Invalid Opcode - NOP $01,x
            jmp __9d48         ; $9d6d: 4c 48 9d  

;-------------------------------------------------------------------------------
            iny                ; $9d70: c8        
            lda ($99),y        ; $9d71: b1 99     
            cmp $0158,x        ; $9d73: dd 58 01  
            beq __9d84         ; $9d76: f0 0c     
            inc $0158,x        ; $9d78: fe 58 01  
            lda $0154,x        ; $9d7b: bd 54 01  
            sta $0150,x        ; $9d7e: 9d 50 01  
            jmp __9d48         ; $9d81: 4c 48 9d  

;-------------------------------------------------------------------------------
__9d84:     inc $0150,x        ; $9d84: fe 50 01  
            inc $0150,x        ; $9d87: fe 50 01  
            jmp __9d48         ; $9d8a: 4c 48 9d  

;-------------------------------------------------------------------------------
            dec $0150,x        ; $9d8d: de 50 01  
            jmp __9d48         ; $9d90: 4c 48 9d  

;-------------------------------------------------------------------------------
__9d93:     nop                ; $9d93: ea        
            nop                ; $9d94: ea        
            nop                ; $9d95: ea        
            nop                ; $9d96: ea        
            nop                ; $9d97: ea        
            nop                ; $9d98: ea        
            nop                ; $9d99: ea        
            nop                ; $9d9a: ea        
            rts                ; $9d9b: 60        

;-------------------------------------------------------------------------------
__9d9c:     .hex a0            ; $9d9c: a0        Suspected data
__9d9d:     brk                ; $9d9d: 00        
            lda $b7,x          ; $9d9e: b5 b7     
            sta $a1            ; $9da0: 85 a1     
            lda $bd,x          ; $9da2: b5 bd     
            sta $a2            ; $9da4: 85 a2     
            rts                ; $9da6: 60        

;-------------------------------------------------------------------------------
__9da7:     iny                ; $9da7: c8        
            tya                ; $9da8: 98        
            clc                ; $9da9: 18        
            adc $a1            ; $9daa: 65 a1     
            sta $b7,x          ; $9dac: 95 b7     
            bcc __9db6         ; $9dae: 90 06     
            lda $a2            ; $9db0: a5 a2     
            adc #$00           ; $9db2: 69 00     
            sta $bd,x          ; $9db4: 95 bd     
__9db6:     rts                ; $9db6: 60        

;-------------------------------------------------------------------------------
__9db7:     iny                ; $9db7: c8        
            lda ($a1),y        ; $9db8: b1 a1     
            sta $b7,x          ; $9dba: 95 b7     
            iny                ; $9dbc: c8        
            lda ($a1),y        ; $9dbd: b1 a1     
            sta $bd,x          ; $9dbf: 95 bd     
            rts                ; $9dc1: 60        

;-------------------------------------------------------------------------------
__9dc2:     iny                ; $9dc2: c8        
            tya                ; $9dc3: 98        
            clc                ; $9dc4: 18        
            adc $a1            ; $9dc5: 65 a1     
            sta $cf,x          ; $9dc7: 95 cf     
            lda $a2            ; $9dc9: a5 a2     
            adc #$00           ; $9dcb: 69 00     
            sta $d5,x          ; $9dcd: 95 d5     
            rts                ; $9dcf: 60        

;-------------------------------------------------------------------------------
__9dd0:     jsr __9df4         ; $9dd0: 20 f4 9d  
            sta $4000,x        ; $9dd3: 9d 00 40  
            jmp __9dfc         ; $9dd6: 4c fc 9d  

;-------------------------------------------------------------------------------
__9dd9:     jsr __9df4         ; $9dd9: 20 f4 9d  
            sta $4001,x        ; $9ddc: 9d 01 40  
            jmp __9dfc         ; $9ddf: 4c fc 9d  

;-------------------------------------------------------------------------------
__9de2:     jsr __9df4         ; $9de2: 20 f4 9d  
            sta $4002,x        ; $9de5: 9d 02 40  
            jmp __9dfc         ; $9de8: 4c fc 9d  

;-------------------------------------------------------------------------------
__9deb:     jsr __9df4         ; $9deb: 20 f4 9d  
            sta $4003,x        ; $9dee: 9d 03 40  
            jmp __9dfc         ; $9df1: 4c fc 9d  

;-------------------------------------------------------------------------------
__9df4:     sta $99            ; $9df4: 85 99     
            jsr __9e09         ; $9df6: 20 09 9e  
            lda $99            ; $9df9: a5 99     
            rts                ; $9dfb: 60        

;-------------------------------------------------------------------------------
__9dfc:     .hex 20 93         ; $9dfc: 20 93     Suspected data
__9dfe:     sta $64ae,x        ; $9dfe: 9d ae 64  
            ora ($60,x)        ; $9e01: 01 60     
__9e03:     brk                ; $9e03: 00        
            .hex 04 08         ; $9e04: 04 08     Invalid Opcode - NOP $08
            brk                ; $9e06: 00        
            .hex 0c 0c         ; $9e07: 0c 0c     Suspected data
__9e09:     lda __9e03,x       ; $9e09: bd 03 9e  
            tax                ; $9e0c: aa        
            rts                ; $9e0d: 60        

;-------------------------------------------------------------------------------
__9e0e:     pha                ; $9e0e: 48        
            cpx #$00           ; $9e0f: e0 00     
            bne __9e1c         ; $9e11: d0 09     
            lda $b4            ; $9e13: a5 b4     
            .hex f0            ; $9e15: f0        Suspected data
__9e16:     ora $d0            ; $9e16: 05 d0     
            brk                ; $9e18: 00        
            sec                ; $9e19: 38        
            pla                ; $9e1a: 68        
            rts                ; $9e1b: 60        

;-------------------------------------------------------------------------------
__9e1c:     clc                ; $9e1c: 18        
            pla                ; $9e1d: 68        
            rts                ; $9e1e: 60        

;-------------------------------------------------------------------------------
__9e1f:     lda #$30           ; $9e1f: a9 30     
            sta $4000          ; $9e21: 8d 00 40  
            jsr __9d93         ; $9e24: 20 93 9d  
            sta $4004          ; $9e27: 8d 04 40  
            jsr __9d93         ; $9e2a: 20 93 9d  
            sta $400c          ; $9e2d: 8d 0c 40  
            jsr __9d93         ; $9e30: 20 93 9d  
            lda #$00           ; $9e33: a9 00     
            sta $4008          ; $9e35: 8d 08 40  
            lda #$ff           ; $9e38: a9 ff     
            sta $011c          ; $9e3a: 8d 1c 01  
            sta $400b          ; $9e3d: 8d 0b 40  
            rts                ; $9e40: 60        

;-------------------------------------------------------------------------------
__9e41:     ldx #$00           ; $9e41: a2 00     
            lda $0129,x        ; $9e43: bd 29 01  
            sta $9a            ; $9e46: 85 9a     
            lda #$00           ; $9e48: a9 00     
            sta $99            ; $9e4a: 85 99     
            lda #$7f           ; $9e4c: a9 7f     
            sta $4001          ; $9e4e: 8d 01 40  
            jsr __9d93         ; $9e51: 20 93 9d  
            lda $011f          ; $9e54: ad 1f 01  
            sta $4002          ; $9e57: 8d 02 40  
            jsr __9d93         ; $9e5a: 20 93 9d  
            lda $011a          ; $9e5d: ad 1a 01  
            sta $4003          ; $9e60: 8d 03 40  
            jsr __9d93         ; $9e63: 20 93 9d  
            lda $b1            ; $9e66: a5 b1     
            beq __9e73         ; $9e68: f0 09     
            lda $c3            ; $9e6a: a5 c3     
            and #$40           ; $9e6c: 29 40     
            bne __9e73         ; $9e6e: d0 03     
            jsr __9cff         ; $9e70: 20 ff 9c  
__9e73:     lda $9a            ; $9e73: a5 9a     
            ora $99            ; $9e75: 05 99     
            jsr __9dd0         ; $9e77: 20 d0 9d  
            ldx $0164          ; $9e7a: ae 64 01  
            rts                ; $9e7d: 60        

;-------------------------------------------------------------------------------
__9e7e:     asl                ; $9e7e: 0a        
__9e7f:     stx $015d          ; $9e7f: 8e 5d 01  
            sty $015c          ; $9e82: 8c 5c 01  
            tay                ; $9e85: a8        
            iny                ; $9e86: c8        
            pla                ; $9e87: 68        
            sta $a7            ; $9e88: 85 a7     
            pla                ; $9e8a: 68        
            sta $a8            ; $9e8b: 85 a8     
            lda ($a7),y        ; $9e8d: b1 a7     
            tax                ; $9e8f: aa        
            iny                ; $9e90: c8        
            .hex b1            ; $9e91: b1        Suspected data
__9e92:     .hex a7 85         ; $9e92: a7 85     Invalid Opcode - LAX $85
            tay                ; $9e94: a8        
            stx $a7            ; $9e95: 86 a7     
            ldy $015c          ; $9e97: ac 5c 01  
            ldx $015d          ; $9e9a: ae 5d 01  
            jmp ($00a7)        ; $9e9d: 6c a7 00  

;-------------------------------------------------------------------------------
            .hex ff da 70      ; $9ea0: ff da 70  Invalid Opcode - ISC $70da,x
            jsr __fb17         ; $9ea3: 20 17 fb  
            .hex e3 00         ; $9ea6: e3 00     Invalid Opcode - ISC ($00,x)
            bpl __9eca         ; $9ea8: 10 20     
            bmi __9ecc         ; $9eaa: 30 20     
            .hex 10            ; $9eac: 10        Suspected data
__9ead:     inc __f106,x       ; $9ead: fe 06 f1  
            nop                ; $9eb0: ea        
            .hex 07 fb         ; $9eb1: 07 fb     Invalid Opcode - SLO $fb
            .hex e2 00         ; $9eb3: e2 00     Invalid Opcode - NOP #$00
            bpl __9ed7         ; $9eb5: 10 20     
            bmi __9ed9         ; $9eb7: 30 20     
            bpl __9ead         ; $9eb9: 10 f2     
            inc __ea02,x       ; $9ebb: fe 02 ea  
            brk                ; $9ebe: 00        
            .hex eb 91         ; $9ebf: eb 91     Invalid Opcode - SBC #$91
            ora $70da          ; $9ec1: 0d da 70  
            .hex 22            ; $9ec4: 22        Invalid Opcode - KIL 
            and $e2,x          ; $9ec5: 35 e2     
            .hex ab e3         ; $9ec7: ab e3     Invalid Opcode - LAX #$e3
            .hex 6b            ; $9ec9: 6b        Suspected data
__9eca:     .hex e7 21         ; $9eca: e7 21     Invalid Opcode - ISC $21
__9ecc:     .hex eb 0f         ; $9ecc: eb 0f     Invalid Opcode - SBC #$0f
            asl __a2e2         ; $9ece: 0e e2 a2  
            .hex eb            ; $9ed1: eb        Suspected data
__9ed2:     .hex 1f 0e f2      ; $9ed2: 1f 0e f2  Invalid Opcode - SLO __f20e,x
__9ed5:     ldx #$eb           ; $9ed5: a2 eb     
__9ed7:     .hex 2f 0e         ; $9ed7: 2f 0e     Suspected data
__9ed9:     .hex f3 a2         ; $9ed9: f3 a2     Invalid Opcode - ISC ($a2),y
            .hex eb 3f         ; $9edb: eb 3f     Invalid Opcode - SBC #$3f
__9edd:     asl __a2f4         ; $9edd: 0e f4 a2  
            .hex eb 01         ; $9ee0: eb 01     Invalid Opcode - SBC #$01
            ora __e4f0         ; $9ee2: 0d f0 e4  
            rts                ; $9ee5: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $9ee6: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 60         ; $9ee8: e2 60     Invalid Opcode - NOP #$60
            .hex f2            ; $9eea: f2        Invalid Opcode - KIL 
            cpx $60            ; $9eeb: e4 60     
            .hex e3 60         ; $9eed: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 60         ; $9eef: e2 60     Invalid Opcode - NOP #$60
            .hex f3 e4         ; $9ef1: f3 e4     Invalid Opcode - ISC ($e4),y
            rts                ; $9ef3: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $9ef4: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 60         ; $9ef6: e2 60     Invalid Opcode - NOP #$60
            .hex f4 e4         ; $9ef8: f4 e4     Invalid Opcode - NOP $e4,x
            rts                ; $9efa: 60        

;-------------------------------------------------------------------------------
            .hex e3 60         ; $9efb: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 60         ; $9efd: e2 60     Invalid Opcode - NOP #$60
            .hex fe ff         ; $9eff: fe ff     Suspected data
__9f01:     lda ($9e,x)        ; $9f01: a1 9e     
            .hex eb 11         ; $9f03: eb 11     Invalid Opcode - SBC #$11
            brk                ; $9f05: 00        
            .hex da            ; $9f06: da        Invalid Opcode - NOP 
            bvs __9f29         ; $9f07: 70 20     
            .hex 17 e3         ; $9f09: 17 e3     Invalid Opcode - SLO $e3,x
            brk                ; $9f0b: 00        
            .hex f2            ; $9f0c: f2        Invalid Opcode - KIL 
            .hex fb e3 00      ; $9f0d: fb e3 00  Invalid Opcode - ISC $00e3,y
            bpl __9f32         ; $9f10: 10 20     
            bmi __9f34         ; $9f12: 30 20     
            bpl __9f01         ; $9f14: 10 eb     
            and ($00,x)        ; $9f16: 21 00     
__9f18:     inc __e303,x       ; $9f18: fe 03 e3  
            brk                ; $9f1b: 00        
            bpl __9f3e         ; $9f1c: 10 20     
            bmi __9f40         ; $9f1e: 30 20     
            .hex eb 31         ; $9f20: eb 31     Invalid Opcode - SBC #$31
            brk                ; $9f22: 00        
            sbc ($fb),y        ; $9f23: f1 fb     
            .hex e2 00         ; $9f25: e2 00     Invalid Opcode - NOP #$00
            bpl __9f49         ; $9f27: 10 20     
__9f29:     bmi __9f4b         ; $9f29: 30 20     
            bpl __9f18         ; $9f2b: 10 eb     
            eor ($00,x)        ; $9f2d: 41 00     
            .hex fe            ; $9f2f: fe        Suspected data
__9f30:     .hex 04            ; $9f30: 04        Suspected data
__9f31:     .hex eb            ; $9f31: eb        Suspected data
__9f32:     ora ($00,x)        ; $9f32: 01 00     
__9f34:     .hex fb f0 e2      ; $9f34: fb f0 e2  Invalid Opcode - ISC __e2f0,y
            brk                ; $9f37: 00        
            .hex 10            ; $9f38: 10        Suspected data
__9f39:     jsr $2030          ; $9f39: 20 30 20  
__9f3c:     bpl __9f31         ; $9f3c: 10 f3     
__9f3e:     brk                ; $9f3e: 00        
            .hex 10            ; $9f3f: 10        Suspected data
__9f40:     jsr $2030          ; $9f40: 20 30 20  
__9f43:     .hex 10            ; $9f43: 10        Suspected data
__9f44:     inc __fe04,x       ; $9f44: fe 04 fe  
__9f47:     .hex ff            ; $9f47: ff        Suspected data
__9f48:     .hex 03            ; $9f48: 03        Suspected data
__9f49:     .hex 9f da         ; $9f49: 9f da     Suspected data
__9f4b:     bcc __9f30         ; $9f4b: 90 e3     
            .hex 0b 1b         ; $9f4d: 0b 1b     Invalid Opcode - ANC #$1b
            .hex 0b 1b         ; $9f4f: 0b 1b     Invalid Opcode - ANC #$1b
            .hex da            ; $9f51: da        Invalid Opcode - NOP 
            ora $fb,x          ; $9f52: 15 fb     
            .hex e3 00         ; $9f54: e3 00     Invalid Opcode - ISC ($00,x)
            bvs __9f58         ; $9f56: 70 00     
__9f58:     bvs __9f3c         ; $9f58: 70 e2     
__9f5a:     brk                ; $9f5a: 00        
            .hex e3            ; $9f5b: e3        Suspected data
__9f5c:     bvs __9f5e         ; $9f5c: 70 00     
__9f5e:     bvs __9f60         ; $9f5e: 70 00     
__9f60:     bvs __9f44         ; $9f60: 70 e2     
            brk                ; $9f62: 00        
            .hex e3 70         ; $9f63: e3 70     Invalid Opcode - ISC ($70,x)
            cpx $80            ; $9f65: e4 80     
            .hex e3 30         ; $9f67: e3 30     Invalid Opcode - ISC ($30,x)
            cpx $80            ; $9f69: e4 80     
            .hex e3 60         ; $9f6b: e3 60     Invalid Opcode - ISC ($60,x)
            bvc __9faf         ; $9f6d: 50 40     
            cpx $80            ; $9f6f: e4 80     
            .hex e3 30         ; $9f71: e3 30     Invalid Opcode - ISC ($30,x)
            cpx $80            ; $9f73: e4 80     
            .hex e3 60         ; $9f75: e3 60     Invalid Opcode - ISC ($60,x)
            bvc __9fb9         ; $9f77: 50 40     
            inc __fe02,x       ; $9f79: fe 02 fe  
            .hex ff            ; $9f7c: ff        Suspected data
__9f7d:     lsr                ; $9f7d: 4a        
            .hex 9f da bb      ; $9f7e: 9f da bb  Invalid Opcode - AHX __bbda,y
            clv                ; $9f81: b8        
            ldy #$a0           ; $9f82: a0 a0     
            ldy #$bb           ; $9f84: a0 bb     
            clv                ; $9f86: b8        
            bcs __9f29         ; $9f87: b0 a0     
            ldy #$c2           ; $9f89: a0 c2     
            lda $b5,x          ; $9f8b: b5 b5     
            .hex b5            ; $9f8d: b5        Suspected data
__9f8e:     bcs __9f30         ; $9f8e: b0 a0     
            .hex a3 b5         ; $9f90: a3 b5     Invalid Opcode - LAX ($b5,x)
            lda ($a3),y        ; $9f92: b1 a3     
            .hex b2            ; $9f94: b2        Invalid Opcode - KIL 
            bcs __9f47         ; $9f95: b0 b0     
            bcs __9f39         ; $9f97: b0 a0     
            ldy #$a0           ; $9f99: a0 a0     
            inc $7fff,x        ; $9f9b: fe ff 7f  
            .hex 9f e9 34      ; $9f9e: 9f e9 34  Invalid Opcode - AHX $34e9,y
            cmp ($77),y        ; $9fa1: d1 77     
            .hex 82 15         ; $9fa3: 82 15     Invalid Opcode - NOP #$15
            .hex f2            ; $9fa5: f2        Invalid Opcode - KIL 
            cpx $46            ; $9fa6: e4 46     
            sbc ($e3),y        ; $9fa8: f1 e3     
            bcs __9f8e         ; $9faa: b0 e2     
            lda $e3,x          ; $9fac: b5 e3     
            .hex 90            ; $9fae: 90        Suspected data
__9faf:     .hex e2 95         ; $9faf: e2 95     Invalid Opcode - NOP #$95
            .hex e3 b0         ; $9fb1: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fb3: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 70         ; $9fb5: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e2 75         ; $9fb7: e2 75     Invalid Opcode - NOP #$75
__9fb9:     .hex e3 b0         ; $9fb9: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fbb: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 60         ; $9fbd: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 65         ; $9fbf: e2 65     Invalid Opcode - NOP #$65
            .hex e3 b0         ; $9fc1: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fc3: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 40         ; $9fc5: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 45         ; $9fc7: e2 45     Invalid Opcode - NOP #$45
            .hex e3 b0         ; $9fc9: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fcb: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 30         ; $9fcd: e3 30     Invalid Opcode - ISC ($30,x)
            .hex e2 35         ; $9fcf: e2 35     Invalid Opcode - NOP #$35
            .hex e3 b0         ; $9fd1: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fd3: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 40         ; $9fd5: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 45         ; $9fd7: e2 45     Invalid Opcode - NOP #$45
            .hex e3 b0         ; $9fd9: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fdb: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 60         ; $9fdd: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 65         ; $9fdf: e2 65     Invalid Opcode - NOP #$65
            .hex e3 b0         ; $9fe1: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $9fe3: e2 b5     Invalid Opcode - NOP #$b5
            inx                ; $9fe5: e8        
            asl $f0,x          ; $9fe6: 16 f0     
            inc $07            ; $9fe8: e6 07     
            .hex eb 01         ; $9fea: eb 01     Invalid Opcode - SBC #$01
            .hex 0b 41         ; $9fec: 0b 41     Invalid Opcode - ANC #$41
            .hex e3 e6         ; $9fee: e3 e6     Invalid Opcode - ISC ($e6,x)
            ora #$b1           ; $9ff0: 09 b1     
            inc $0a            ; $9ff2: e6 0a     
            sta ($b1),y        ; $9ff4: 91 b1     
            .hex df 70 1f      ; $9ff6: df 70 1f  Invalid Opcode - DCP $1f70,x
            brk                ; $9ff9: 00        
__9ffa:     .hex 47 ff         ; $9ffa: 47 ff     Invalid Opcode - SRE $ff
__9ffc:     nop                ; $9ffc: ea        
            .hex 8c            ; $9ffd: 8c        Suspected data
__9ffe:     .hex eb 01         ; $9ffe: eb 01     Invalid Opcode - SBC #$01
            brk                ; $a000: 00        
            sbc #$34           ; $a001: e9 34     
            cmp ($77),y        ; $a003: d1 77     
            .hex 82 15         ; $a005: 82 15     Invalid Opcode - NOP #$15
            sbc ($e5),y        ; $a007: f1 e5     
            .hex 46            ; $a009: 46        Suspected data
__a00a:     .hex e3 b0         ; $a00a: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a00c: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 90         ; $a00e: e3 90     Invalid Opcode - ISC ($90,x)
            .hex e2 95         ; $a010: e2 95     Invalid Opcode - NOP #$95
            .hex e3 b0         ; $a012: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a014: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 70         ; $a016: e3 70     Invalid Opcode - ISC ($70,x)
__a018:     .hex e2 75         ; $a018: e2 75     Invalid Opcode - NOP #$75
            .hex e3 b0         ; $a01a: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a01c: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 60         ; $a01e: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 65         ; $a020: e2 65     Invalid Opcode - NOP #$65
            .hex e3 b0         ; $a022: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a024: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 40         ; $a026: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 45         ; $a028: e2 45     Invalid Opcode - NOP #$45
            .hex e3 b0         ; $a02a: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a02c: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 30         ; $a02e: e3 30     Invalid Opcode - ISC ($30,x)
            .hex e2 35         ; $a030: e2 35     Invalid Opcode - NOP #$35
            .hex e3 b0         ; $a032: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a034: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 40         ; $a036: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 45         ; $a038: e2 45     Invalid Opcode - NOP #$45
            .hex e3 b0         ; $a03a: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a03c: e2 b5     Invalid Opcode - NOP #$b5
            .hex e3 60         ; $a03e: e3 60     Invalid Opcode - ISC ($60,x)
            .hex e2 65         ; $a040: e2 65     Invalid Opcode - NOP #$65
            .hex e3 b0         ; $a042: e3 b0     Invalid Opcode - ISC ($b0,x)
            .hex e2 b5         ; $a044: e2 b5     Invalid Opcode - NOP #$b5
            lsr $c1            ; $a046: 46 c1     
            .hex f2            ; $a048: f2        Invalid Opcode - KIL 
            nop                ; $a049: ea        
            brk                ; $a04a: 00        
            inx                ; $a04b: e8        
            asl $e6,x          ; $a04c: 16 e6     
            .hex 07 eb         ; $a04e: 07 eb     Invalid Opcode - SLO $eb
            ora ($0c,x)        ; $a050: 01 0c     
            eor ($e3,x)        ; $a052: 41 e3     
            inc $09            ; $a054: e6 09     
            lda ($e6),y        ; $a056: b1 e6     
            asl                ; $a058: 0a        
            sta ($e6),y        ; $a059: 91 e6     
            ora ($ba,x)        ; $a05b: 01 ba     
            .hex df 70 1f      ; $a05d: df 70 1f  Invalid Opcode - DCP $1f70,x
            brk                ; $a060: 00        
            .hex 47 ff         ; $a061: 47 ff     Invalid Opcode - SRE $ff
            dec __e31b,x       ; $a063: de 1b e3  
            rti                ; $a066: 40        

;-------------------------------------------------------------------------------
            rts                ; $a067: 60        

;-------------------------------------------------------------------------------
            bvs __9ffa         ; $a068: 70 90     
            bcs __9ffc         ; $a06a: b0 90     
            bvs __9ffe         ; $a06c: 70 90     
            .hex d7 90         ; $a06e: d7 90     Invalid Opcode - DCP $90,x
__a070:     cpx $e4            ; $a070: e4 e4     
            eor ($d9,x)        ; $a072: 41 d9     
            bcc __a0b7         ; $a074: 90 41     
            .hex da            ; $a076: da        Invalid Opcode - NOP 
            bcc __a00a         ; $a077: 90 91     
            sta ($df),y        ; $a079: 91 df     
            bcc __a0c4         ; $a07b: 90 47     
            .hex ff dd         ; $a07d: ff dd     Suspected data
__a07f:     .hex b0            ; $a07f: b0        Suspected data
__a080:     .hex ff ea 00      ; $a080: ff ea 00  Bad Addr Mode - ISC $00ea,x
            .hex eb 00         ; $a083: eb 00     Invalid Opcode - SBC #$00
            brk                ; $a085: 00        
            sbc #$34           ; $a086: e9 34     
            cmp ($70),y        ; $a088: d1 70     
__a08a:     ora __fb17,y       ; $a08a: 19 17 fb  
            sbc $90            ; $a08d: e5 90     
            cpx $9a            ; $a08f: e4 9a     
            jsr $2ae3          ; $a091: 20 e3 2a  
            cpx $50            ; $a094: e4 50     
            .hex e3 5a         ; $a096: e3 5a     Invalid Opcode - ISC ($5a,x)
__a098:     sbc ($e4),y        ; $a098: f1 e4     
            bcc __a07f         ; $a09a: 90 e3     
__a09c:     txs                ; $a09c: 9a        
            jsr $2ae2          ; $a09d: 20 e2 2a  
            .hex e3 50         ; $a0a0: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 5a         ; $a0a2: e2 5a     Invalid Opcode - NOP #$5a
            .hex f0            ; $a0a4: f0        Suspected data
__a0a5:     .hex e3            ; $a0a5: e3        Suspected data
__a0a6:     bcc __a08a         ; $a0a6: 90 e2     
            txs                ; $a0a8: 9a        
            .hex e3 50         ; $a0a9: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2            ; $a0ab: e2        Suspected data
__a0ac:     .hex 5a            ; $a0ac: 5a        Invalid Opcode - NOP 
            .hex e3 20         ; $a0ad: e3 20     Invalid Opcode - ISC ($20,x)
            .hex e2 2a         ; $a0af: e2 2a     Invalid Opcode - NOP #$2a
__a0b1:     sbc ($e4),y        ; $a0b1: f1 e4     
            bcc __a098         ; $a0b3: 90 e3     
            txs                ; $a0b5: 9a        
            .hex e4            ; $a0b6: e4        Suspected data
__a0b7:     bvc __a09c         ; $a0b7: 50 e3     
            .hex 5a            ; $a0b9: 5a        Invalid Opcode - NOP 
            .hex e4            ; $a0ba: e4        Suspected data
__a0bb:     .hex 20            ; $a0bb: 20        Suspected data
__a0bc:     .hex e3 2a         ; $a0bc: e3 2a     Invalid Opcode - ISC ($2a,x)
            beq __a0a5         ; $a0be: f0 e5     
__a0c0:     bvc __a0a6         ; $a0c0: 50 e4     
            .hex 5a            ; $a0c2: 5a        Invalid Opcode - NOP 
            .hex e5            ; $a0c3: e5        Suspected data
__a0c4:     ldy #$e4           ; $a0c4: a0 e4     
            tax                ; $a0c6: aa        
            bpl __a0ac         ; $a0c7: 10 e3     
            .hex 1a            ; $a0c9: 1a        Invalid Opcode - NOP 
            sbc ($e4),y        ; $a0ca: f1 e4     
            bvc __a0b1         ; $a0cc: 50 e3     
            .hex 5a            ; $a0ce: 5a        Invalid Opcode - NOP 
            cpx $a0            ; $a0cf: e4 a0     
            .hex e3 aa         ; $a0d1: e3 aa     Invalid Opcode - ISC ($aa,x)
            bpl __a0b7         ; $a0d3: 10 e2     
            .hex 1a            ; $a0d5: 1a        Invalid Opcode - NOP 
            beq __a0bb         ; $a0d6: f0 e3     
            bvc __a0bc         ; $a0d8: 50 e2     
            .hex 5a            ; $a0da: 5a        Invalid Opcode - NOP 
            .hex e3            ; $a0db: e3        Suspected data
__a0dc:     bpl __a0c0         ; $a0dc: 10 e2     
            .hex 1a            ; $a0de: 1a        Invalid Opcode - NOP 
            cpx $a0            ; $a0df: e4 a0     
            .hex e3 aa         ; $a0e1: e3 aa     Invalid Opcode - ISC ($aa,x)
            sbc ($70),y        ; $a0e3: f1 70     
            .hex e2            ; $a0e5: e2        Suspected data
__a0e6:     .hex 7a            ; $a0e6: 7a        Invalid Opcode - NOP 
            .hex e3 30         ; $a0e7: e3 30     Invalid Opcode - ISC ($30,x)
            .hex e2 3a         ; $a0e9: e2 3a     Invalid Opcode - NOP #$3a
            cpx $a0            ; $a0eb: e4 a0     
            .hex e3 aa         ; $a0ed: e3 aa     Invalid Opcode - ISC ($aa,x)
            inc __ea02,x       ; $a0ef: fe 02 ea  
__a0f2:     .hex 03 fb         ; $a0f2: 03 fb     Invalid Opcode - SLO ($fb,x)
            sbc ($e5),y        ; $a0f4: f1 e5     
            bcc __a0dc         ; $a0f6: 90 e4     
            txs                ; $a0f8: 9a        
            jsr $2ae3          ; $a0f9: 20 e3 2a  
__a0fc:     cpx $50            ; $a0fc: e4 50     
            .hex e3 5a         ; $a0fe: e3 5a     Invalid Opcode - ISC ($5a,x)
            beq __a0e6         ; $a100: f0 e4     
            .hex 90            ; $a102: 90        Suspected data
__a103:     .hex e3 9a         ; $a103: e3 9a     Invalid Opcode - ISC ($9a,x)
            jsr $2ae2          ; $a105: 20 e2 2a  
            .hex e3 50         ; $a108: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 5a         ; $a10a: e2 5a     Invalid Opcode - NOP #$5a
            sbc ($e3),y        ; $a10c: f1 e3     
__a10e:     bcc __a0f2         ; $a10e: 90 e2     
            txs                ; $a110: 9a        
            .hex e3 50         ; $a111: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 5a         ; $a113: e2 5a     Invalid Opcode - NOP #$5a
            .hex e3 20         ; $a115: e3 20     Invalid Opcode - ISC ($20,x)
            .hex e2 2a         ; $a117: e2 2a     Invalid Opcode - NOP #$2a
__a119:     .hex f2            ; $a119: f2        Invalid Opcode - KIL 
__a11a:     cpx $90            ; $a11a: e4 90     
            .hex e3 9a         ; $a11c: e3 9a     Invalid Opcode - ISC ($9a,x)
            cpx $50            ; $a11e: e4 50     
__a120:     .hex e3            ; $a120: e3        Suspected data
__a121:     .hex 5a            ; $a121: 5a        Invalid Opcode - NOP 
            cpx $20            ; $a122: e4 20     
            .hex e3 2a         ; $a124: e3 2a     Invalid Opcode - ISC ($2a,x)
            sbc ($e5),y        ; $a126: f1 e5     
            bvc __a10e         ; $a128: 50 e4     
            .hex 5a            ; $a12a: 5a        Invalid Opcode - NOP 
            sbc $a0            ; $a12b: e5 a0     
            cpx $aa            ; $a12d: e4 aa     
            cpx $10            ; $a12f: e4 10     
            .hex e3 1a         ; $a131: e3 1a     Invalid Opcode - ISC ($1a,x)
            beq __a119         ; $a133: f0 e4     
            bvc __a11a         ; $a135: 50 e3     
            .hex 5a            ; $a137: 5a        Invalid Opcode - NOP 
            cpx $a0            ; $a138: e4 a0     
            .hex e3 aa         ; $a13a: e3 aa     Invalid Opcode - ISC ($aa,x)
            bpl __a120         ; $a13c: 10 e2     
            .hex 1a            ; $a13e: 1a        Invalid Opcode - NOP 
            .hex e3 50         ; $a13f: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 5a         ; $a141: e2 5a     Invalid Opcode - NOP #$5a
            .hex e3 10         ; $a143: e3 10     Invalid Opcode - ISC ($10,x)
            .hex e2 1a         ; $a145: e2 1a     Invalid Opcode - NOP #$1a
            cpx $a0            ; $a147: e4 a0     
            .hex e3 aa         ; $a149: e3 aa     Invalid Opcode - ISC ($aa,x)
            .hex e3 70         ; $a14b: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e2 7a         ; $a14d: e2 7a     Invalid Opcode - NOP #$7a
            .hex e3 30         ; $a14f: e3 30     Invalid Opcode - ISC ($30,x)
__a151:     .hex e2 3a         ; $a151: e2 3a     Invalid Opcode - NOP #$3a
            .hex e4            ; $a153: e4        Suspected data
__a154:     ldy #$e3           ; $a154: a0 e3     
            tax                ; $a156: aa        
            inc __fe02,x       ; $a157: fe 02 fe  
            .hex ff 81 a0      ; $a15a: ff 81 a0  Invalid Opcode - ISC __a081,x
            nop                ; $a15d: ea        
            brk                ; $a15e: 00        
            sbc #$34           ; $a15f: e9 34     
__a161:     .hex dc 70         ; $a161: dc 70     Suspected data
__a163:     .hex 1b 17 eb      ; $a163: 1b 17 eb  Invalid Opcode - SLO __eb17,y
            ora ($00,x)        ; $a166: 01 00     
            cpx $90            ; $a168: e4 90     
            beq __a0fc         ; $a16a: f0 90     
            .hex e3 20         ; $a16c: e3 20     Invalid Opcode - ISC ($20,x)
            bvc __a161         ; $a16e: 50 f1     
            bcc __a154         ; $a170: 90 e2     
            jsr __f050         ; $a172: 20 50 f0  
            bcc __a1c7         ; $a175: 90 50     
            .hex 20 f1         ; $a177: 20 f1     Suspected data
__a179:     .hex e3 90         ; $a179: e3 90     Invalid Opcode - ISC ($90,x)
            .hex 50            ; $a17b: 50        Suspected data
__a17c:     .hex 20            ; $a17c: 20        Suspected data
__a17d:     beq __a163         ; $a17d: f0 e4     
            bvc __a121         ; $a17f: 50 a0     
__a181:     .hex e3 10         ; $a181: e3 10     Invalid Opcode - ISC ($10,x)
            sbc ($50),y        ; $a183: f1 50     
            ldy #$e2           ; $a185: a0 e2     
__a187:     bpl __a179         ; $a187: 10 f0     
            bvc __a19b         ; $a189: 50 10     
            .hex e3            ; $a18b: e3        Suspected data
__a18c:     ldy #$f1           ; $a18c: a0 f1     
__a18e:     .hex e2 70         ; $a18e: e2 70     Invalid Opcode - NOP #$70
            .hex 30            ; $a190: 30        Suspected data
__a191:     .hex e3 a0         ; $a191: e3 a0     Invalid Opcode - ISC ($a0,x)
__a193:     .hex eb 02         ; $a193: eb 02     Invalid Opcode - SBC #$02
            brk                ; $a195: 00        
            beq __a17c         ; $a196: f0 e4     
            bcc __a17d         ; $a198: 90 e3     
            .hex 20            ; $a19a: 20        Suspected data
__a19b:     bvc __a18e         ; $a19b: 50 f1     
            bcc __a181         ; $a19d: 90 e2     
__a19f:     jsr __f050         ; $a19f: 20 50 f0  
            bcc __a1f4         ; $a1a2: 90 50     
            jsr __e3f1         ; $a1a4: 20 f1 e3  
            bcc __a1f9         ; $a1a7: 90 50     
            jsr $03eb          ; $a1a9: 20 eb 03  
            brk                ; $a1ac: 00        
            beq __a193         ; $a1ad: f0 e4     
            bvc __a151         ; $a1af: 50 a0     
            .hex e3 10         ; $a1b1: e3 10     Invalid Opcode - ISC ($10,x)
            sbc ($50),y        ; $a1b3: f1 50     
            .hex a0            ; $a1b5: a0        Suspected data
__a1b6:     .hex e2 10         ; $a1b6: e2 10     Invalid Opcode - NOP #$10
            beq __a20a         ; $a1b8: f0 50     
__a1ba:     bpl __a19f         ; $a1ba: 10 e3     
            ldy #$f1           ; $a1bc: a0 f1     
__a1be:     .hex e2 70         ; $a1be: e2 70     Invalid Opcode - NOP #$70
            .hex 30            ; $a1c0: 30        Suspected data
__a1c1:     nop                ; $a1c1: ea        
            .hex 03 e9         ; $a1c2: 03 e9     Invalid Opcode - SLO ($e9,x)
            adc $d1,x          ; $a1c4: 75 d1     
            .hex 30            ; $a1c6: 30        Suspected data
__a1c7:     ora __e417,y       ; $a1c7: 19 17 e4  
            .hex 93 e6         ; $a1ca: 93 e6     Invalid Opcode - AHX ($e6),y
            .hex 0c eb 11      ; $a1cc: 0c eb 11  Invalid Opcode - NOP $11eb
            ora #$f1           ; $a1cf: 09 f1     
            bcc __a1b6         ; $a1d1: 90 e3     
            .hex 20 50         ; $a1d3: 20 50     Suspected data
__a1d5:     .hex f0            ; $a1d5: f0        Suspected data
__a1d6:     bcc __a1ba         ; $a1d6: 90 e2     
            .hex 20 50         ; $a1d8: 20 50     Suspected data
__a1da:     .hex f1            ; $a1da: f1        Suspected data
__a1db:     bcc __a22d         ; $a1db: 90 50     
            jsr __e3f2         ; $a1dd: 20 f2 e3  
__a1e0:     bcc __a232         ; $a1e0: 90 50     
            .hex 20 f1         ; $a1e2: 20 f1     Suspected data
__a1e4:     cpx $50            ; $a1e4: e4 50     
            ldy #$e3           ; $a1e6: a0 e3     
            bpl __a1da         ; $a1e8: 10 f0     
            bvc __a18c         ; $a1ea: 50 a0     
            .hex e2 10         ; $a1ec: e2 10     Invalid Opcode - NOP #$10
            sbc ($50),y        ; $a1ee: f1 50     
            bpl __a1d5         ; $a1f0: 10 e3     
            .hex a0            ; $a1f2: a0        Suspected data
__a1f3:     .hex f2            ; $a1f3: f2        Invalid Opcode - KIL 
__a1f4:     .hex e2 70         ; $a1f4: e2 70     Invalid Opcode - NOP #$70
__a1f6:     bmi __a1db         ; $a1f6: 30 e3     
            .hex a0            ; $a1f8: a0        Suspected data
__a1f9:     sbc ($e4),y        ; $a1f9: f1 e4     
            bcc __a1e0         ; $a1fb: 90 e3     
            jsr __f050         ; $a1fd: 20 50 f0  
            .hex 90            ; $a200: 90        Suspected data
__a201:     .hex e2 20         ; $a201: e2 20     Invalid Opcode - NOP #$20
__a203:     bvc __a1f6         ; $a203: 50 f1     
            bcc __a257         ; $a205: 90 50     
            jsr __e3f2         ; $a207: 20 f2 e3  
__a20a:     .hex 90            ; $a20a: 90        Suspected data
__a20b:     bvc __a1f3         ; $a20b: 50 e6     
            ora ($27,x)        ; $a20d: 01 27     
            inc $0c            ; $a20f: e6 0c     
            .hex eb 01         ; $a211: eb 01     Invalid Opcode - SBC #$01
            brk                ; $a213: 00        
            nop                ; $a214: ea        
            asl                ; $a215: 0a        
            sbc ($e4),y        ; $a216: f1 e4     
            bvc __a1ba         ; $a218: 50 a0     
            .hex e3 10         ; $a21a: e3 10     Invalid Opcode - ISC ($10,x)
            bvc __a1be         ; $a21c: 50 a0     
            .hex e2 10         ; $a21e: e2 10     Invalid Opcode - NOP #$10
            bvc __a232         ; $a220: 50 10     
            .hex e3 a0         ; $a222: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex e2 70         ; $a224: e2 70     Invalid Opcode - NOP #$70
            bmi __a20b         ; $a226: 30 e3     
            ldy #$fe           ; $a228: a0 fe     
            .hex ff 5d a1      ; $a22a: ff 5d a1  Invalid Opcode - ISC __a15d,x
__a22d:     nop                ; $a22d: ea        
            brk                ; $a22e: 00        
            .hex dc 90 fb      ; $a22f: dc 90 fb  Invalid Opcode - NOP __fb90,x
__a232:     cpx $25            ; $a232: e4 25     
__a234:     sta $a5,x          ; $a234: 95 a5     
__a236:     .hex e3 12         ; $a236: e3 12     Invalid Opcode - ISC ($12,x)
            .hex 32            ; $a238: 32        Invalid Opcode - KIL 
            .hex fe 02         ; $a239: fe 02     Suspected data
__a23b:     nop                ; $a23b: ea        
            .hex 03 dc         ; $a23c: 03 dc     Invalid Opcode - SLO ($dc,x)
__a23e:     jsr __c2e4         ; $a23e: 20 e4 c2  
            .hex 22            ; $a241: 22        Invalid Opcode - KIL 
            .hex c2            ; $a242: c2        Suspected data
__a243:     .hex 20            ; $a243: 20        Suspected data
__a244:     bvc __a1d6         ; $a244: 50 90     
            .hex c2 a0         ; $a246: c2 a0     Invalid Opcode - NOP #$a0
__a248:     .hex a0            ; $a248: a0        Suspected data
__a249:     .hex a0            ; $a249: a0        Suspected data
__a24a:     .hex e3 10         ; $a24a: e3 10     Invalid Opcode - ISC ($10,x)
            bpl __a25e         ; $a24c: 10 10     
            bmi __a280         ; $a24e: 30 30     
            bmi __a236         ; $a250: 30 e4     
            .hex c2 22         ; $a252: c2 22     Invalid Opcode - NOP #$22
            .hex c2 20         ; $a254: c2 20     Invalid Opcode - NOP #$20
            .hex 50            ; $a256: 50        Suspected data
__a257:     bcc __a1f9         ; $a257: 90 a0     
            ldy #$a0           ; $a259: a0 a0     
            .hex e3 52         ; $a25b: e3 52     Invalid Opcode - ISC ($52,x)
            .hex e4            ; $a25d: e4        Suspected data
__a25e:     bpl __a243         ; $a25e: 10 e3     
            bpl __a244         ; $a260: 10 e2     
            bpl __a248         ; $a262: 10 e4     
            bmi __a249         ; $a264: 30 e3     
            bmi __a24a         ; $a266: 30 e2     
__a268:     bmi __a268         ; $a268: 30 fe     
            .hex ff 2d a2      ; $a26a: ff 2d a2  Invalid Opcode - ISC __a22d,x
            .hex dc c2 b5      ; $a26d: dc c2 b5  Invalid Opcode - NOP __b5c2,x
            lda $b5,x          ; $a270: b5 b5     
            lda $b5            ; $a272: a5 b5     
            lda $b5,x          ; $a274: b5 b5     
            ldy #$a0           ; $a276: a0 a0     
            ldy #$c2           ; $a278: a0 c2     
            lda $a0,x          ; $a27a: b5 a0     
            ldy #$a3           ; $a27c: a0 a3     
            ldy #$a0           ; $a27e: a0 a0     
__a280:     ldy #$b0           ; $a280: a0 b0     
            bcs __a234         ; $a282: b0 b0     
            ldy #$a0           ; $a284: a0 a0     
            .hex a3 b5         ; $a286: a3 b5     Invalid Opcode - LAX ($b5,x)
            ldy #$a0           ; $a288: a0 a0     
            ldy #$b0           ; $a28a: a0 b0     
            bcs __a23e         ; $a28c: b0 b0     
            ldx #$b0           ; $a28e: a2 b0     
            ldy #$a0           ; $a290: a0 a0     
            .hex b0            ; $a292: b0        Suspected data
__a293:     ldy #$a0           ; $a293: a0 a0     
            inc $6dff,x        ; $a295: fe ff 6d  
            .hex a2            ; $a298: a2        Suspected data
__a299:     .hex 37            ; $a299: 37        Suspected data
__a29a:     .hex 81            ; $a29a: 81        Suspected data
__a29b:     sta $0169          ; $a29b: 8d 69 01  
            beq __a2af         ; $a29e: f0 0f     
            cmp #$5d           ; $a2a0: c9 5d     
            bcc __a2ab         ; $a2a2: 90 07     
            cmp #$60           ; $a2a4: c9 60     
            bcs __a2ab         ; $a2a6: b0 03     
            jmp __a3b9         ; $a2a8: 4c b9 a3  

;-------------------------------------------------------------------------------
__a2ab:     cmp #$61           ; $a2ab: c9 61     
            bne __a2cc         ; $a2ad: d0 1d     
__a2af:     lda #$00           ; $a2af: a9 00     
            ldx #$06           ; $a2b1: a2 06     
__a2b3:     dex                ; $a2b3: ca        
            sta $b1,x          ; $a2b4: 95 b1     
            sta $011a,x        ; $a2b6: 9d 1a 01  
            sta $c3,x          ; $a2b9: 95 c3     
            bne __a2b3         ; $a2bb: d0 f6     
            sta $aa            ; $a2bd: 85 aa     
            jmp __9e1f         ; $a2bf: 4c 1f 9e  

;-------------------------------------------------------------------------------
__a2c2:     sta $0134,x        ; $a2c2: 9d 34 01  
            sta $0146,x        ; $a2c5: 9d 46 01  
__a2c8:     sta $0131,x        ; $a2c8: 9d 31 01  
            rts                ; $a2cb: 60        

;-------------------------------------------------------------------------------
__a2cc:     ldx #$03           ; $a2cc: a2 03     
            lda __a299         ; $a2ce: ad 99 a2  
            sta $a3            ; $a2d1: 85 a3     
            lda __a29a         ; $a2d3: ad 9a a2  
            sta $a4            ; $a2d6: 85 a4     
__a2d8:     lda $0169          ; $a2d8: ad 69 01  
            clc                ; $a2db: 18        
            adc $a3            ; $a2dc: 65 a3     
            sta $a3            ; $a2de: 85 a3     
            lda #$00           ; $a2e0: a9 00     
__a2e2:     adc $a4            ; $a2e2: 65 a4     
            sta $a4            ; $a2e4: 85 a4     
            dex                ; $a2e6: ca        
            bne __a2d8         ; $a2e7: d0 ef     
            ldy #$00           ; $a2e9: a0 00     
            sty $0168          ; $a2eb: 8c 68 01  
            lda ($a3),y        ; $a2ee: b1 a3     
            rol                ; $a2f0: 2a        
            rol                ; $a2f1: 2a        
            rol                ; $a2f2: 2a        
            .hex 29            ; $a2f3: 29        Suspected data
__a2f4:     .hex 03 8d         ; $a2f4: 03 8d     Invalid Opcode - SLO ($8d,x)
            ror                ; $a2f6: 6a        
            ora ($4c,x)        ; $a2f7: 01 4c     
            ora ($a3,x)        ; $a2f9: 01 a3     
            jmp __a3a0         ; $a2fb: 4c a0 a3  

;-------------------------------------------------------------------------------
__a2fe:     jmp __a3b1         ; $a2fe: 4c b1 a3  

;-------------------------------------------------------------------------------
__a301:     ldy $0168          ; $a301: ac 68 01  
            lda ($a3),y        ; $a304: b1 a3     
            and #$1f           ; $a306: 29 1f     
            sta $016b          ; $a308: 8d 6b 01  
            tax                ; $a30b: aa        
            lda $0169          ; $a30c: ad 69 01  
            beq __a315         ; $a30f: f0 04     
            cmp $b1,x          ; $a311: d5 b1     
            bcc __a2fe         ; $a313: 90 e9     
__a315:     lda #$00           ; $a315: a9 00     
            sta $b1,x          ; $a317: 95 b1     
            cpx #$02           ; $a319: e0 02     
            beq __a325         ; $a31b: f0 08     
            bcs __a328         ; $a31d: b0 09     
            jsr __a2c2         ; $a31f: 20 c2 a2  
            jmp __a328         ; $a322: 4c 28 a3  

;-------------------------------------------------------------------------------
__a325:     jsr __a2c8         ; $a325: 20 c8 a2  
__a328:     ldy $0168          ; $a328: ac 68 01  
            iny                ; $a32b: c8        
            lda ($a3),y        ; $a32c: b1 a3     
            sta $b7,x          ; $a32e: 95 b7     
            sta $e1,x          ; $a330: 95 e1     
            sta $9d            ; $a332: 85 9d     
            iny                ; $a334: c8        
            lda ($a3),y        ; $a335: b1 a3     
            sta $bd,x          ; $a337: 95 bd     
            sta $e7,x          ; $a339: 95 e7     
            sta $9e            ; $a33b: 85 9e     
            lda #$01           ; $a33d: a9 01     
            sta $ab,x          ; $a33f: 95 ab     
            lda #$00           ; $a341: a9 00     
            sta $db,x          ; $a343: 95 db     
            cpx #$02           ; $a345: e0 02     
            beq __a350         ; $a347: f0 07     
            sta $011a,x        ; $a349: 9d 1a 01  
            cpx #$04           ; $a34c: e0 04     
            beq __a361         ; $a34e: f0 11     
__a350:     ldy #$00           ; $a350: a0 00     
            lda ($9d),y        ; $a352: b1 9d     
            bne __a35d         ; $a354: d0 07     
            sta $0169          ; $a356: 8d 69 01  
            cpx #$04           ; $a359: e0 04     
            beq __a361         ; $a35b: f0 04     
__a35d:     and #$f0           ; $a35d: 29 f0     
            bne __a365         ; $a35f: d0 04     
__a361:     lda #$01           ; $a361: a9 01     
            bne __a367         ; $a363: d0 02     
__a365:     lda #$00           ; $a365: a9 00     
__a367:     sta $c3,x          ; $a367: 95 c3     
            lda $016b          ; $a369: ad 6b 01  
            tay                ; $a36c: a8        
            lda __9e03,y       ; $a36d: b9 03 9e  
            tay                ; $a370: a8        
            cpx #$00           ; $a371: e0 00     
            bne __a379         ; $a373: d0 04     
            lda $b4            ; $a375: a5 b4     
            bne __a39b         ; $a377: d0 22     
__a379:     lda #$00           ; $a379: a9 00     
            cpx #$02           ; $a37b: e0 02     
            bne __a38b         ; $a37d: d0 0c     
            sta $4008          ; $a37f: 8d 08 40  
            jsr __9d93         ; $a382: 20 93 9d  
            sta $400b          ; $a385: 8d 0b 40  
            jmp __a39b         ; $a388: 4c 9b a3  

;-------------------------------------------------------------------------------
__a38b:     lda #$30           ; $a38b: a9 30     
            sta $4000,y        ; $a38d: 99 00 40  
            jsr __9d93         ; $a390: 20 93 9d  
            .hex a9            ; $a393: a9        Suspected data
__a394:     .hex 7f 99 01      ; $a394: 7f 99 01  Invalid Opcode - RRA $0199,x
            rti                ; $a397: 40        

;-------------------------------------------------------------------------------
            jsr __9d93         ; $a398: 20 93 9d  
__a39b:     lda $0169          ; $a39b: ad 69 01  
            sta $b1,x          ; $a39e: 95 b1     
__a3a0:     .hex ce 6a         ; $a3a0: ce 6a     Suspected data
__a3a2:     ora ($30,x)        ; $a3a2: 01 30     
            .hex 0c ac 68      ; $a3a4: 0c ac 68  Invalid Opcode - NOP $68ac
            ora ($c8,x)        ; $a3a7: 01 c8     
            iny                ; $a3a9: c8        
            iny                ; $a3aa: c8        
            sty $0168          ; $a3ab: 8c 68 01  
            jmp __a301         ; $a3ae: 4c 01 a3  

;-------------------------------------------------------------------------------
__a3b1:     lda #$00           ; $a3b1: a9 00     
            sta $a4            ; $a3b3: 85 a4     
            ldx $0164          ; $a3b5: ae 64 01  
            rts                ; $a3b8: 60        

;-------------------------------------------------------------------------------
__a3b9:     lda $0169          ; $a3b9: ad 69 01  
            cmp $016c          ; $a3bc: cd 6c 01  
            bcc __a3e7         ; $a3bf: 90 26     
            sta $016c          ; $a3c1: 8d 6c 01  
            sec                ; $a3c4: 38        
            sbc #$5d           ; $a3c5: e9 5d     
            asl                ; $a3c7: 0a        
            asl                ; $a3c8: 0a        
            clc                ; $a3c9: 18        
            adc #$03           ; $a3ca: 69 03     
            tax                ; $a3cc: aa        
            lda #$0f           ; $a3cd: a9 0f     
            sta $4015          ; $a3cf: 8d 15 40  
            sty $a5            ; $a3d2: 84 a5     
            ldy #$03           ; $a3d4: a0 03     
__a3d6:     lda __fbc4,x       ; $a3d6: bd c4 fb  
            sta $4010,y        ; $a3d9: 99 10 40  
            dex                ; $a3dc: ca        
            dey                ; $a3dd: 88        
            bpl __a3d6         ; $a3de: 10 f6     
            ldy $a5            ; $a3e0: a4 a5     
            lda #$1f           ; $a3e2: a9 1f     
__a3e4:     sta $4015          ; $a3e4: 8d 15 40  
__a3e7:     ldx $0164          ; $a3e7: ae 64 01  
            rts                ; $a3ea: 60        

;-------------------------------------------------------------------------------
            .hex ff e9 33      ; $a3eb: ff e9 33  Invalid Opcode - ISC $33e9,x
            .hex eb 0f         ; $a3ee: eb 0f     Invalid Opcode - SBC #$0f
            .hex 07 d7         ; $a3f0: 07 d7     Invalid Opcode - SLO $d7
            .hex 70            ; $a3f2: 70        Suspected data
__a3f3:     .hex 17 17         ; $a3f3: 17 17     Invalid Opcode - SLO $17,x
            sbc ($e3),y        ; $a3f5: f1 e3     
            and ($20,x)        ; $a3f7: 21 20     
            .hex eb            ; $a3f9: eb        Suspected data
__a3fa:     ora ($06,x)        ; $a3fa: 01 06     
            .hex f3 50         ; $a3fc: f3 50     Invalid Opcode - ISC ($50),y
            rti                ; $a3fe: 40        

;-------------------------------------------------------------------------------
            bvc __a3f3         ; $a3ff: 50 f2     
            .hex 51            ; $a401: 51        Suspected data
__a402:     bvc __a394         ; $a402: 50 90     
__a404:     .hex 80 90         ; $a404: 80 90     Invalid Opcode - NOP #$90
            sbc ($91),y        ; $a406: f1 91     
            bcc __a3fa         ; $a408: 90 f0     
            .hex e2 20         ; $a40a: e2 20     Invalid Opcode - NOP #$20
            bpl __a42e         ; $a40c: 10 20     
            .hex eb 0f         ; $a40e: eb 0f     Invalid Opcode - SBC #$0f
            .hex 07 f0         ; $a410: 07 f0     Invalid Opcode - SLO $f0
            .hex 22            ; $a412: 22        Invalid Opcode - KIL 
            .hex eb 2f         ; $a413: eb 2f     Invalid Opcode - SBC #$2f
            .hex 07 f2         ; $a415: 07 f2     Invalid Opcode - SLO $f2
            .hex 22            ; $a417: 22        Invalid Opcode - KIL 
            sbc ($e3),y        ; $a418: f1 e3     
            eor ($50),y        ; $a41a: 51 50     
            .hex eb            ; $a41c: eb        Suspected data
__a41d:     .hex 01            ; $a41d: 01        Suspected data
__a41e:     asl $f3            ; $a41e: 06 f3     
            bcc __a3a2         ; $a420: 90 80     
            .hex 90            ; $a422: 90        Suspected data
__a423:     .hex f2            ; $a423: f2        Invalid Opcode - KIL 
            sta ($90),y        ; $a424: 91 90     
            .hex e2 20         ; $a426: e2 20     Invalid Opcode - NOP #$20
            bpl __a44a         ; $a428: 10 20     
            .hex f1            ; $a42a: f1        Suspected data
__a42b:     and ($20,x)        ; $a42b: 21 20     
            .hex f0            ; $a42d: f0        Suspected data
__a42e:     .hex 50            ; $a42e: 50        Suspected data
__a42f:     rti                ; $a42f: 40        

;-------------------------------------------------------------------------------
            .hex 50            ; $a430: 50        Suspected data
__a431:     .hex f0            ; $a431: f0        Suspected data
__a432:     .hex eb 0f         ; $a432: eb 0f     Invalid Opcode - SBC #$0f
            .hex 07 51         ; $a434: 07 51     Invalid Opcode - SLO $51
            bvc __a423         ; $a436: 50 eb     
__a438:     .hex 1f 07 f3      ; $a438: 1f 07 f3  Invalid Opcode - SLO __f307,x
            eor ($50),y        ; $a43b: 51 50     
            .hex eb 00         ; $a43d: eb 00     Invalid Opcode - SBC #$00
__a43f:     brk                ; $a43f: 00        
__a440:     sbc #$31           ; $a440: e9 31     
            .hex e7 18         ; $a442: e7 18     Invalid Opcode - ISC $18
            sbc ($40),y        ; $a444: f1 40     
            bpl __a42b         ; $a446: 10 e3     
            bcc __a4ba         ; $a448: 90 70     
__a44a:     rti                ; $a44a: 40        

;-------------------------------------------------------------------------------
            bpl __a42f         ; $a44b: 10 e2     
            bpl __a432         ; $a44d: 10 e3     
            ldy #$70           ; $a44f: a0 70     
            rti                ; $a451: 40        

;-------------------------------------------------------------------------------
            bpl __a438         ; $a452: 10 e4     
            ldy #$f0           ; $a454: a0 f0     
            .hex e3 a0         ; $a456: e3 a0     Invalid Opcode - ISC ($a0,x)
            .hex 70            ; $a458: 70        Suspected data
__a459:     rti                ; $a459: 40        

;-------------------------------------------------------------------------------
            bpl __a440         ; $a45a: 10 e4     
            ldy #$70           ; $a45c: a0 70     
            .hex e3 40         ; $a45e: e3 40     Invalid Opcode - ISC ($40,x)
            bvs __a402         ; $a460: 70 a0     
            bvs __a404         ; $a462: 70 a0     
__a464:     .hex e2 10         ; $a464: e2 10     Invalid Opcode - NOP #$10
            .hex eb 01         ; $a466: eb 01     Invalid Opcode - SBC #$01
            asl $d7            ; $a468: 06 d7     
            bmi __a47e         ; $a46a: 30 12     
            .hex 17 fb         ; $a46c: 17 fb     Invalid Opcode - SLO $fb,x
__a46e:     beq __a459         ; $a46e: f0 e9     
            .hex 74 e7         ; $a470: 74 e7     Invalid Opcode - NOP $e7,x
            .hex 12            ; $a472: 12        Invalid Opcode - KIL 
            .hex e2 22         ; $a473: e2 22     Invalid Opcode - NOP #$22
            .hex e3            ; $a475: e3        Suspected data
__a476:     .hex 93 e9         ; $a476: 93 e9     Invalid Opcode - AHX ($e9),y
            adc ($e7),y        ; $a478: 71 e7     
            .hex 13 f3         ; $a47a: 13 f3     Invalid Opcode - SLO ($f3),y
            bvs __a41e         ; $a47c: 70 a0     
__a47e:     .hex e2            ; $a47e: e2        Suspected data
__a47f:     bpl __a464         ; $a47f: 10 e3     
            ldy #$e2           ; $a481: a0 e2     
__a483:     bpl __a46e         ; $a483: 10 e9     
            .hex 74 e7         ; $a485: 74 e7     Invalid Opcode - NOP $e7,x
            .hex 12            ; $a487: 12        Invalid Opcode - KIL 
            sbc ($22),y        ; $a488: f1 22     
            .hex e3 95         ; $a48a: e3 95     Invalid Opcode - ISC ($95,x)
            sbc #$71           ; $a48c: e9 71     
            .hex e7            ; $a48e: e7        Suspected data
__a48f:     .hex 13 f4         ; $a48f: 13 f4     Invalid Opcode - SLO ($f4),y
            .hex 70            ; $a491: 70        Suspected data
__a492:     .hex 50            ; $a492: 50        Suspected data
__a493:     rti                ; $a493: 40        

;-------------------------------------------------------------------------------
            .hex 22            ; $a494: 22        Invalid Opcode - KIL 
            .hex f3 50         ; $a495: f3 50     Invalid Opcode - ISC ($50),y
            rti                ; $a497: 40        

;-------------------------------------------------------------------------------
            .hex 50            ; $a498: 50        Suspected data
__a499:     .hex 52            ; $a499: 52        Invalid Opcode - KIL 
            .hex f2            ; $a49a: f2        Invalid Opcode - KIL 
            bcc __a41d         ; $a49b: 90 80     
            bcc __a431         ; $a49d: 90 92     
            beq __a483         ; $a49f: f0 e2     
            jsr $2010          ; $a4a1: 20 10 20  
            sbc $20,x          ; $a4a4: f5 20     
            bpl __a4c8         ; $a4a6: 10 20     
            sbc #$b1           ; $a4a8: e9 b1     
            beq __a493         ; $a4aa: f0 e7     
            .hex 15            ; $a4ac: 15        Suspected data
__a4ad:     inc $01            ; $a4ad: e6 01     
            cpx $70            ; $a4af: e4 70     
            .hex e3 75         ; $a4b1: e3 75     Invalid Opcode - ISC ($75,x)
            cpx $40            ; $a4b3: e4 40     
            .hex e3 45         ; $a4b5: e3 45     Invalid Opcode - ISC ($45,x)
            cpx $10            ; $a4b7: e4 10     
__a4b9:     .hex e3            ; $a4b9: e3        Suspected data
__a4ba:     ora $e6,x          ; $a4ba: 15 e6     
            .hex 07 fe         ; $a4bc: 07 fe     Invalid Opcode - SLO $fe
            .hex 02            ; $a4be: 02        Invalid Opcode - KIL 
            .hex eb            ; $a4bf: eb        Suspected data
__a4c0:     ora ($06,x)        ; $a4c0: 01 06     
            sbc #$32           ; $a4c2: e9 32     
            .hex d7 76         ; $a4c4: d7 76     Invalid Opcode - DCP $76,x
            .hex 82 18         ; $a4c6: 82 18     Invalid Opcode - NOP #$18
__a4c8:     beq __a4ad         ; $a4c8: f0 e3     
            ldy #$70           ; $a4ca: a0 70     
            rti                ; $a4cc: 40        

;-------------------------------------------------------------------------------
            bpl __a50f         ; $a4cd: 10 40     
            ldy #$90           ; $a4cf: a0 90     
            bvc __a4f3         ; $a4d1: 50 20     
            cpx $90            ; $a4d3: e4 90     
            .hex e3 20         ; $a4d5: e3 20     Invalid Opcode - ISC ($20,x)
            bcc __a549         ; $a4d7: 90 70     
__a4d9:     rti                ; $a4d9: 40        

;-------------------------------------------------------------------------------
            bpl __a4c0         ; $a4da: 10 e4     
            ldy #$e3           ; $a4dc: a0 e3     
            bpl __a550         ; $a4de: 10 70     
            bvc __a502         ; $a4e0: 50 20     
            cpx $90            ; $a4e2: e4 90     
            bvc __a476         ; $a4e4: 50 90     
__a4e6:     .hex e3 20         ; $a4e6: e3 20     Invalid Opcode - ISC ($20,x)
            .hex e7 14         ; $a4e8: e7 14     Invalid Opcode - ISC $14
            .hex e9            ; $a4ea: e9        Suspected data
__a4eb:     bvs __a48f         ; $a4eb: 70 a2     
            .hex e2 20         ; $a4ed: e2 20     Invalid Opcode - NOP #$20
__a4ef:     bpl __a511         ; $a4ef: 10 20     
            .hex e3 92         ; $a4f1: e3 92     Invalid Opcode - ISC ($92,x)
__a4f3:     .hex e2 20         ; $a4f3: e2 20     Invalid Opcode - NOP #$20
            brk                ; $a4f5: 00        
            jsr __b2e3         ; $a4f6: 20 e3 b2  
            .hex e2 22         ; $a4f9: e2 22     Invalid Opcode - NOP #$22
            sbc #$30           ; $a4fb: e9 30     
            .hex e7 16         ; $a4fd: e7 16     Invalid Opcode - ISC $16
            inc $01            ; $a4ff: e6 01     
            .hex e3            ; $a501: e3        Suspected data
__a502:     bpl __a4e6         ; $a502: 10 e2     
            ora $e4,x          ; $a504: 15 e4     
            bcc __a4eb         ; $a506: 90 e3     
            sta $e4,x          ; $a508: 95 e4     
            bcs __a4ef         ; $a50a: b0 e3     
            lda $e4,x          ; $a50c: b5 e4     
            .hex 10            ; $a50e: 10        Suspected data
__a50f:     .hex e3 15         ; $a50f: e3 15     Invalid Opcode - ISC ($15,x)
__a511:     cpx $20            ; $a511: e4 20     
            .hex e3 25         ; $a513: e3 25     Invalid Opcode - ISC ($25,x)
            .hex e4            ; $a515: e4        Suspected data
__a516:     rti                ; $a516: 40        

;-------------------------------------------------------------------------------
            .hex e3 45         ; $a517: e3 45     Invalid Opcode - ISC ($45,x)
            inc __ecff,x       ; $a519: fe ff ec  
            .hex a3 e9         ; $a51c: a3 e9     Invalid Opcode - LAX ($e9,x)
            .hex 33 eb         ; $a51e: 33 eb     Invalid Opcode - RLA ($eb),y
            .hex 0f 07 d7      ; $a520: 0f 07 d7  Invalid Opcode - SLO __d707
__a523:     bvs __a53c         ; $a523: 70 17     
            .hex 17 f0         ; $a525: 17 f0     Invalid Opcode - SLO $f0,x
            cpx $91            ; $a527: e4 91     
__a529:     bcc __a516         ; $a529: 90 eb     
            ora ($06,x)        ; $a52b: 01 06     
            .hex f2            ; $a52d: f2        Invalid Opcode - KIL 
            .hex e3 20         ; $a52e: e3 20     Invalid Opcode - ISC ($20,x)
            bpl __a552         ; $a530: 10 20     
            sbc ($21),y        ; $a532: f1 21     
            jsr $4050          ; $a534: 20 50 40  
            bvc __a529         ; $a537: 50 f0     
            eor ($50),y        ; $a539: 51 50     
            .hex 90            ; $a53b: 90        Suspected data
__a53c:     .hex 80 90         ; $a53c: 80 90     Invalid Opcode - NOP #$90
            .hex eb 0f         ; $a53e: eb 0f     Invalid Opcode - SBC #$0f
            .hex 07 f0         ; $a540: 07 f0     Invalid Opcode - SLO $f0
            .hex 92            ; $a542: 92        Invalid Opcode - KIL 
            .hex eb 2f         ; $a543: eb 2f     Invalid Opcode - SBC #$2f
            .hex 07 f2         ; $a545: 07 f2     Invalid Opcode - SLO $f2
            .hex 92            ; $a547: 92        Invalid Opcode - KIL 
            .hex f0            ; $a548: f0        Suspected data
__a549:     and ($20,x)        ; $a549: 21 20     
__a54b:     .hex eb 01         ; $a54b: eb 01     Invalid Opcode - SBC #$01
__a54d:     asl $f2            ; $a54d: 06 f2     
            .hex 50            ; $a54f: 50        Suspected data
__a550:     rti                ; $a550: 40        

;-------------------------------------------------------------------------------
            .hex 50            ; $a551: 50        Suspected data
__a552:     sbc ($51),y        ; $a552: f1 51     
            bvc __a4e6         ; $a554: 50 90     
            .hex 80 90         ; $a556: 80 90     Invalid Opcode - NOP #$90
            beq __a4eb         ; $a558: f0 91     
            .hex 90            ; $a55a: 90        Suspected data
__a55b:     .hex e2 20         ; $a55b: e2 20     Invalid Opcode - NOP #$20
            .hex 10            ; $a55d: 10        Suspected data
__a55e:     jsr __ebf0         ; $a55e: 20 f0 eb  
            .hex 0f 07 21      ; $a561: 0f 07 21  Invalid Opcode - SLO $2107
            .hex 20            ; $a564: 20        Suspected data
__a565:     .hex eb 1f         ; $a565: eb 1f     Invalid Opcode - SBC #$1f
            .hex 07            ; $a567: 07        Suspected data
__a568:     .hex f3 21         ; $a568: f3 21     Invalid Opcode - ISC ($21),y
            jsr $00eb          ; $a56a: 20 eb 00  
__a56d:     brk                ; $a56d: 00        
            sbc #$31           ; $a56e: e9 31     
            .hex e7 18         ; $a570: e7 18     Invalid Opcode - ISC $18
            sbc ($10),y        ; $a572: f1 10     
            .hex e3 a0         ; $a574: e3 a0     Invalid Opcode - ISC ($a0,x)
            bvs __a5b8         ; $a576: 70 40     
            bpl __a55e         ; $a578: 10 e4     
            ldy #$e3           ; $a57a: a0 e3     
            ldy #$70           ; $a57c: a0 70     
            rti                ; $a57e: 40        

;-------------------------------------------------------------------------------
            bpl __a565         ; $a57f: 10 e4     
            ldy #$70           ; $a581: a0 70     
            beq __a568         ; $a583: f0 e3     
            bvs __a5c7         ; $a585: 70 40     
            bpl __a56d         ; $a587: 10 e4     
            ldy #$70           ; $a589: a0 70     
            rti                ; $a58b: 40        

;-------------------------------------------------------------------------------
            .hex e3 10         ; $a58c: e3 10     Invalid Opcode - ISC ($10,x)
            rti                ; $a58e: 40        

;-------------------------------------------------------------------------------
            bvs __a5d1         ; $a58f: 70 40     
            bvs __a523         ; $a591: 70 90     
            .hex eb 01         ; $a593: eb 01     Invalid Opcode - SBC #$01
__a595:     asl $d7            ; $a595: 06 d7     
            bmi __a5ab         ; $a597: 30 12     
            .hex 17 fb         ; $a599: 17 fb     Invalid Opcode - SLO $fb,x
            sbc ($e9),y        ; $a59b: f1 e9     
            .hex 74 e7         ; $a59d: 74 e7     Invalid Opcode - NOP $e7,x
            .hex 12            ; $a59f: 12        Invalid Opcode - KIL 
            .hex e3 92         ; $a5a0: e3 92     Invalid Opcode - ISC ($92,x)
            .hex 23 e9         ; $a5a2: 23 e9     Invalid Opcode - RLA ($e9,x)
            adc ($e7),y        ; $a5a4: 71 e7     
            .hex 13 f3         ; $a5a6: 13 f3     Invalid Opcode - SLO ($f3),y
            rti                ; $a5a8: 40        

;-------------------------------------------------------------------------------
            bvs __a54b         ; $a5a9: 70 a0     
__a5ab:     bvs __a54d         ; $a5ab: 70 a0     
            sbc #$74           ; $a5ad: e9 74     
            .hex e7 12         ; $a5af: e7 12     Invalid Opcode - ISC $12
            sbc ($92),y        ; $a5b1: f1 92     
            eor $e9,x          ; $a5b3: 55 e9     
            adc ($e7),y        ; $a5b5: 71 e7     
            .hex 13            ; $a5b7: 13        Suspected data
__a5b8:     .hex f4 40         ; $a5b8: f4 40     Invalid Opcode - NOP $40,x
            jsr __e410         ; $a5ba: 20 10 e4  
            ldx #$f3           ; $a5bd: a2 f3     
__a5bf:     .hex e3            ; $a5bf: e3        Suspected data
__a5c0:     jsr $2010          ; $a5c0: 20 10 20  
            .hex 22            ; $a5c3: 22        Invalid Opcode - KIL 
            .hex f2            ; $a5c4: f2        Invalid Opcode - KIL 
            bvc __a607         ; $a5c5: 50 40     
__a5c7:     bvc __a61b         ; $a5c7: 50 52     
            beq __a55b         ; $a5c9: f0 90     
            .hex 80 90         ; $a5cb: 80 90     Invalid Opcode - NOP #$90
            .hex f4 90         ; $a5cd: f4 90     Invalid Opcode - NOP $90,x
            .hex 80 90         ; $a5cf: 80 90     Invalid Opcode - NOP #$90
__a5d1:     .hex eb 01         ; $a5d1: eb 01     Invalid Opcode - SBC #$01
            brk                ; $a5d3: 00        
            sbc #$71           ; $a5d4: e9 71     
            beq __a5bf         ; $a5d6: f0 e7     
            ora $e6,x          ; $a5d8: 15 e6     
__a5da:     ora ($e3,x)        ; $a5da: 01 e3     
            bvs __a5c0         ; $a5dc: 70 e2     
__a5de:     adc $e3,x          ; $a5de: 75 e3     
            rti                ; $a5e0: 40        

;-------------------------------------------------------------------------------
            .hex e2 45         ; $a5e1: e2 45     Invalid Opcode - NOP #$45
            .hex e3 10         ; $a5e3: e3 10     Invalid Opcode - ISC ($10,x)
            .hex e2 15         ; $a5e5: e2 15     Invalid Opcode - NOP #$15
            inc $07            ; $a5e7: e6 07     
            inc __eb02,x       ; $a5e9: fe 02 eb  
            ora ($00,x)        ; $a5ec: 01 00     
            sbc #$32           ; $a5ee: e9 32     
            cmp ($76),y        ; $a5f0: d1 76     
            .hex 82 18         ; $a5f2: 82 18     Invalid Opcode - NOP #$18
            beq __a5da         ; $a5f4: f0 e4     
            ldy #$e2           ; $a5f6: a0 e2     
            lda $e4            ; $a5f8: a5 e4     
            bvs __a5de         ; $a5fa: 70 e2     
            adc $e4,x          ; $a5fc: 75 e4     
            rti                ; $a5fe: 40        

;-------------------------------------------------------------------------------
__a5ff:     .hex e2 45         ; $a5ff: e2 45     Invalid Opcode - NOP #$45
            cpx $10            ; $a601: e4 10     
            .hex e2 15         ; $a603: e2 15     Invalid Opcode - NOP #$15
            cpx $40            ; $a605: e4 40     
__a607:     .hex e2 45         ; $a607: e2 45     Invalid Opcode - NOP #$45
            cpx $a0            ; $a609: e4 a0     
            .hex e2 a5         ; $a60b: e2 a5     Invalid Opcode - NOP #$a5
            cpx $90            ; $a60d: e4 90     
            .hex e2 95         ; $a60f: e2 95     Invalid Opcode - NOP #$95
            cpx $50            ; $a611: e4 50     
            .hex e2 55         ; $a613: e2 55     Invalid Opcode - NOP #$55
            cpx $20            ; $a615: e4 20     
            .hex e2 25         ; $a617: e2 25     Invalid Opcode - NOP #$25
            sbc $90            ; $a619: e5 90     
__a61b:     .hex e3 95         ; $a61b: e3 95     Invalid Opcode - ISC ($95,x)
            cpx $20            ; $a61d: e4 20     
            .hex e2 25         ; $a61f: e2 25     Invalid Opcode - NOP #$25
            cpx $90            ; $a621: e4 90     
            .hex e2 95         ; $a623: e2 95     Invalid Opcode - NOP #$95
            cpx $70            ; $a625: e4 70     
            .hex e2 75         ; $a627: e2 75     Invalid Opcode - NOP #$75
            cpx $40            ; $a629: e4 40     
            .hex e2 45         ; $a62b: e2 45     Invalid Opcode - NOP #$45
            cpx $10            ; $a62d: e4 10     
            .hex e2 15         ; $a62f: e2 15     Invalid Opcode - NOP #$15
            sbc $a0            ; $a631: e5 a0     
            .hex e3 a5         ; $a633: e3 a5     Invalid Opcode - ISC ($a5,x)
            cpx $10            ; $a635: e4 10     
            .hex e2 15         ; $a637: e2 15     Invalid Opcode - NOP #$15
__a639:     cpx $70            ; $a639: e4 70     
            .hex e2 75         ; $a63b: e2 75     Invalid Opcode - NOP #$75
            cpx $50            ; $a63d: e4 50     
            .hex e2 55         ; $a63f: e2 55     Invalid Opcode - NOP #$55
            .hex e4            ; $a641: e4        Suspected data
__a642:     jsr $25e2          ; $a642: 20 e2 25  
            sbc $90            ; $a645: e5 90     
            .hex e3 95         ; $a647: e3 95     Invalid Opcode - ISC ($95,x)
__a649:     sbc $50            ; $a649: e5 50     
            .hex e3 55         ; $a64b: e3 55     Invalid Opcode - ISC ($55,x)
            sbc $90            ; $a64d: e5 90     
            .hex e3 95         ; $a64f: e3 95     Invalid Opcode - ISC ($95,x)
            cpx $20            ; $a651: e4 20     
            .hex e2 25         ; $a653: e2 25     Invalid Opcode - NOP #$25
            inc $07            ; $a655: e6 07     
            sbc #$31           ; $a657: e9 31     
            .hex eb 01         ; $a659: eb 01     Invalid Opcode - SBC #$01
            asl $e4            ; $a65b: 06 e4     
__a65d:     bvs __a5ff         ; $a65d: 70 a0     
            .hex e3 20         ; $a65f: e3 20     Invalid Opcode - ISC ($20,x)
            .hex 52            ; $a661: 52        Invalid Opcode - KIL 
            cpx $50            ; $a662: e4 50     
__a664:     bcc __a649         ; $a664: 90 e3     
            jsr __e452         ; $a666: 20 52 e4  
            .hex 82 b2         ; $a669: 82 b2     Invalid Opcode - NOP #$b2
__a66b:     sbc #$30           ; $a66b: e9 30     
            inc $01            ; $a66d: e6 01     
            .hex e7 16         ; $a66f: e7 16     Invalid Opcode - ISC $16
            cpx $90            ; $a671: e4 90     
            .hex e3 95         ; $a673: e3 95     Invalid Opcode - ISC ($95,x)
            cpx $40            ; $a675: e4 40     
            .hex e3 45         ; $a677: e3 45     Invalid Opcode - ISC ($45,x)
            cpx $70            ; $a679: e4 70     
            .hex e3 75         ; $a67b: e3 75     Invalid Opcode - ISC ($75,x)
            cpx $40            ; $a67d: e4 40     
            .hex e3 45         ; $a67f: e3 45     Invalid Opcode - ISC ($45,x)
            cpx $70            ; $a681: e4 70     
            .hex e3 75         ; $a683: e3 75     Invalid Opcode - ISC ($75,x)
__a685:     .hex e4            ; $a685: e4        Suspected data
__a686:     bcc __a66b         ; $a686: 90 e3     
            sta $fe,x          ; $a688: 95 fe     
            .hex ff 1d a5      ; $a68a: ff 1d a5  Invalid Opcode - ISC __a51d,x
            .hex d7 15         ; $a68d: d7 15     Invalid Opcode - DCP $15,x
            .hex fb e3 21      ; $a68f: fb e3 21  Invalid Opcode - ISC $21e3,y
            jsr $2090          ; $a692: 20 90 20  
__a695:     bcc __a695         ; $a695: 90 fe     
            .hex 03 22         ; $a697: 03 22     Invalid Opcode - SLO ($22,x)
            .hex 02            ; $a699: 02        Invalid Opcode - KIL 
            .hex fb e4 a1      ; $a69a: fb e4 a1  Invalid Opcode - ISC __a1e4,y
__a69d:     ldy #$e3           ; $a69d: a0 e3     
            bvc __a685         ; $a69f: 50 e4     
            ldy #$e3           ; $a6a1: a0 e3     
__a6a3:     bvc __a6a3         ; $a6a3: 50 fe     
__a6a5:     .hex 03 e4         ; $a6a5: 03 e4     Invalid Opcode - SLO ($e4,x)
            ldx #$92           ; $a6a7: a2 92     
            adc ($c0),y        ; $a6a9: 71 c0     
            cmp ($10),y        ; $a6ab: d1 10     
            .hex e3 73         ; $a6ad: e3 73     Invalid Opcode - ISC ($73,x)
__a6af:     .hex 52            ; $a6af: 52        Invalid Opcode - KIL 
            .hex 32            ; $a6b0: 32        Invalid Opcode - KIL 
            .hex 12            ; $a6b1: 12        Invalid Opcode - KIL 
            .hex 02            ; $a6b2: 02        Invalid Opcode - KIL 
            cpx $b1            ; $a6b3: e4 b1     
__a6b5:     ldy #$90           ; $a6b5: a0 90     
            cpy #$d7           ; $a6b7: c0 d7     
            ora $71,x          ; $a6b9: 15 71     
            cpy #$70           ; $a6bb: c0 70     
            .hex e3 70         ; $a6bd: e3 70     Invalid Opcode - ISC ($70,x)
            bvs __a6a5         ; $a6bf: 70 e4     
            bvs __a733         ; $a6c1: 70 70     
            .hex e3 70         ; $a6c3: e3 70     Invalid Opcode - ISC ($70,x)
__a6c5:     cpx $70            ; $a6c5: e4 70     
            .hex e3 70         ; $a6c7: e3 70     Invalid Opcode - ISC ($70,x)
            bvs __a6af         ; $a6c9: 70 e4     
            bcc __a65d         ; $a6cb: 90 90     
            .hex e3 90         ; $a6cd: e3 90     Invalid Opcode - ISC ($90,x)
            .hex e4            ; $a6cf: e4        Suspected data
__a6d0:     bcc __a6b5         ; $a6d0: 90 e3     
            bcc __a664         ; $a6d2: 90 90     
            .hex fb e3 21      ; $a6d4: fb e3 21  Invalid Opcode - ISC $21e3,y
__a6d7:     .hex 20            ; $a6d7: 20        Suspected data
__a6d8:     .hex 20 40         ; $a6d8: 20 40     Suspected data
__a6da:     bvc __a6da         ; $a6da: 50 fe     
__a6dc:     .hex 03 20         ; $a6dc: 03 20     Invalid Opcode - SLO ($20,x)
            rti                ; $a6de: 40        

;-------------------------------------------------------------------------------
            bvc __a6c5         ; $a6df: 50 e4     
            .hex 92            ; $a6e1: 92        Invalid Opcode - KIL 
            .hex fb e4 a1      ; $a6e2: fb e4 a1  Invalid Opcode - ISC __a1e4,y
            ldy #$a0           ; $a6e5: a0 a0     
__a6e7:     .hex e3 00         ; $a6e7: e3 00     Invalid Opcode - ISC ($00,x)
            jsr $03fe          ; $a6e9: 20 fe 03  
            cpx $a0            ; $a6ec: e4 a0     
            .hex e3 00         ; $a6ee: e3 00     Invalid Opcode - ISC ($00,x)
            .hex 20 e4         ; $a6f0: 20 e4     Suspected data
__a6f2:     bcc __a6d7         ; $a6f2: 90 e3     
            bcc __a686         ; $a6f4: 90 90     
            .hex fb e3 21      ; $a6f6: fb e3 21  Invalid Opcode - ISC $21e3,y
            .hex 20 20         ; $a6f9: 20 20     Suspected data
__a6fb:     rti                ; $a6fb: 40        

;-------------------------------------------------------------------------------
__a6fc:     .hex 50            ; $a6fc: 50        Suspected data
__a6fd:     inc $2003,x        ; $a6fd: fe 03 20  
__a700:     rti                ; $a700: 40        

;-------------------------------------------------------------------------------
            bvc __a6e7         ; $a701: 50 e4     
            .hex 92            ; $a703: 92        Invalid Opcode - KIL 
            .hex fb e4 a1      ; $a704: fb e4 a1  Invalid Opcode - ISC __a1e4,y
            ldy #$a0           ; $a707: a0 a0     
            .hex e3 00         ; $a709: e3 00     Invalid Opcode - ISC ($00,x)
            jsr $03fe          ; $a70b: 20 fe 03  
__a70e:     cpx $a0            ; $a70e: e4 a0     
            .hex e3 00         ; $a710: e3 00     Invalid Opcode - ISC ($00,x)
__a712:     jsr __90e4         ; $a712: 20 e4 90  
            .hex e3 90         ; $a715: e3 90     Invalid Opcode - ISC ($90,x)
            bcc __a6fd         ; $a717: 90 e4     
            sta ($e3),y        ; $a719: 91 e3     
            sta ($c1),y        ; $a71b: 91 c1     
__a71d:     cpx $51            ; $a71d: e4 51     
            .hex e3            ; $a71f: e3        Suspected data
__a720:     .hex 51            ; $a720: 51        Suspected data
__a721:     cmp ($e4,x)        ; $a721: c1 e4     
            eor ($e3,x)        ; $a723: 41 e3     
            eor ($c1,x)        ; $a725: 41 c1     
            cpx $21            ; $a727: e4 21     
            .hex e3 21         ; $a729: e3 21     Invalid Opcode - ISC ($21,x)
__a72b:     rti                ; $a72b: 40        

;-------------------------------------------------------------------------------
            bvc __a712         ; $a72c: 50 e4     
            .hex 70            ; $a72e: 70        Suspected data
__a72f:     bvs __a7a1         ; $a72f: 70 70     
            .hex e3 70         ; $a731: e3 70     Invalid Opcode - ISC ($70,x)
__a733:     cpx $70            ; $a733: e4 70     
            bvs __a787         ; $a735: 70 50     
            .hex 50            ; $a737: 50        Suspected data
__a738:     bvc __a71d         ; $a738: 50 e3     
            bvc __a720         ; $a73a: 50 e4     
            bvc __a78e         ; $a73c: 50 50     
            rti                ; $a73e: 40        

;-------------------------------------------------------------------------------
            rti                ; $a73f: 40        

;-------------------------------------------------------------------------------
            rti                ; $a740: 40        

;-------------------------------------------------------------------------------
            .hex e3 40         ; $a741: e3 40     Invalid Opcode - ISC ($40,x)
__a743:     cpx $40            ; $a743: e4 40     
            rti                ; $a745: 40        

;-------------------------------------------------------------------------------
            bcc __a6d8         ; $a746: 90 90     
            bcc __a6da         ; $a748: 90 90     
            bcc __a6dc         ; $a74a: 90 90     
            inc __8dff,x       ; $a74c: fe ff 8d  
__a74f:     ldx $d7            ; $a74f: a6 d7     
            .hex fb b1 b0      ; $a751: fb b1 b0  Invalid Opcode - ISC __b0b1,y
            lda ($b0,x)        ; $a754: a1 b0     
            inc __b102,x       ; $a756: fe 02 b1  
            bcs __a6fb         ; $a759: b0 a0     
            ldy #$a0           ; $a75b: a0 a0     
            .hex b2            ; $a75d: b2        Invalid Opcode - KIL 
            bcs __a700         ; $a75e: b0 a0     
            ldy #$fb           ; $a760: a0 fb     
            lda ($b0),y        ; $a762: b1 b0     
            lda ($b0,x)        ; $a764: a1 b0     
            .hex fe            ; $a766: fe        Suspected data
__a767:     .hex 02            ; $a767: 02        Invalid Opcode - KIL 
            lda ($b0),y        ; $a768: b1 b0     
            lda ($a0,x)        ; $a76a: a1 a0     
            bcs __a70e         ; $a76c: b0 a0     
            ldy #$a0           ; $a76e: a0 a0     
            ldy #$a0           ; $a770: a0 a0     
            .hex b2            ; $a772: b2        Invalid Opcode - KIL 
            ldx #$b2           ; $a773: a2 b2     
            ldy #$a0           ; $a775: a0 a0     
            ldy #$b1           ; $a777: a0 b1     
            bcs __a72b         ; $a779: b0 b0     
            ldy #$a0           ; $a77b: a0 a0     
            bcs __a72f         ; $a77d: b0 b0     
            bcs __a721         ; $a77f: b0 a0     
            ldy #$a0           ; $a781: a0 a0     
            .hex fb b1 b0      ; $a783: fb b1 b0  Invalid Opcode - ISC __b0b1,y
            .hex a1            ; $a786: a1        Suspected data
__a787:     bcs __a787         ; $a787: b0 fe     
            .hex 03 b0         ; $a789: 03 b0     Invalid Opcode - SLO ($b0,x)
            ldy #$a0           ; $a78b: a0 a0     
            .hex b2            ; $a78d: b2        Invalid Opcode - KIL 
__a78e:     .hex fb b1 b0      ; $a78e: fb b1 b0  Invalid Opcode - ISC __b0b1,y
            lda ($b0,x)        ; $a791: a1 b0     
            inc __b103,x       ; $a793: fe 03 b1  
            bcs __a738         ; $a796: b0 a0     
            ldy #$a0           ; $a798: a0 a0     
            .hex fb b1 b0      ; $a79a: fb b1 b0  Invalid Opcode - ISC __b0b1,y
            lda ($b0,x)        ; $a79d: a1 b0     
            .hex fe 03         ; $a79f: fe 03     Suspected data
__a7a1:     bcs __a743         ; $a7a1: b0 a0     
            ldy #$b2           ; $a7a3: a0 b2     
            .hex fb b1 b0      ; $a7a5: fb b1 b0  Invalid Opcode - ISC __b0b1,y
            lda ($b0,x)        ; $a7a8: a1 b0     
            inc __b103,x       ; $a7aa: fe 03 b1  
            bcs __a74f         ; $a7ad: b0 a0     
            ldy #$a0           ; $a7af: a0 a0     
            .hex fb b1 a2      ; $a7b1: fb b1 a2  Invalid Opcode - ISC __a2b1,y
            ldy #$b1           ; $a7b4: a0 b1     
            ldy #$a0           ; $a7b6: a0 a0     
__a7b8:     ldy #$a0           ; $a7b8: a0 a0     
            inc __fb02,x       ; $a7ba: fe 02 fb  
            lda ($b0),y        ; $a7bd: b1 b0     
            lda ($b0,x)        ; $a7bf: a1 b0     
            inc __b102,x       ; $a7c1: fe 02 b1  
            .hex a0            ; $a7c4: a0        Suspected data
__a7c5:     bcs __a767         ; $a7c5: b0 a0     
            ldy #$b0           ; $a7c7: a0 b0     
            .hex a0            ; $a7c9: a0        Suspected data
__a7ca:     ldy #$a0           ; $a7ca: a0 a0     
            ldy #$a0           ; $a7cc: a0 a0     
            .hex fe            ; $a7ce: fe        Suspected data
__a7cf:     .hex ff 50 a7      ; $a7cf: ff 50 a7  Invalid Opcode - ISC __a750,x
            .hex eb 73         ; $a7d2: eb 73     Invalid Opcode - SBC #$73
            .hex 04 e9         ; $a7d4: 04 e9     Invalid Opcode - NOP $e9
            .hex 34 fb         ; $a7d6: 34 fb     Invalid Opcode - NOP $fb,x
            cmp ($b1),y        ; $a7d8: d1 b1     
            bpl __a7dc         ; $a7da: 10 00     
__a7dc:     .hex e3 40         ; $a7dc: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 46         ; $a7de: e2 46     Invalid Opcode - NOP #$46
            .hex e3 10         ; $a7e0: e3 10     Invalid Opcode - ISC ($10,x)
            .hex e2 16         ; $a7e2: e2 16     Invalid Opcode - NOP #$16
            .hex e3 20         ; $a7e4: e3 20     Invalid Opcode - ISC ($20,x)
            .hex e2 26         ; $a7e6: e2 26     Invalid Opcode - NOP #$26
            .hex e3 40         ; $a7e8: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 4e         ; $a7ea: e2 4e     Invalid Opcode - NOP #$4e
            .hex e3 00         ; $a7ec: e3 00     Invalid Opcode - ISC ($00,x)
            .hex e2 0e         ; $a7ee: e2 0e     Invalid Opcode - NOP #$0e
            inx                ; $a7f0: e8        
            .hex 42            ; $a7f1: 42        Invalid Opcode - KIL 
            inc $08            ; $a7f2: e6 08     
            .hex e3 a8         ; $a7f4: e3 a8     Invalid Opcode - ISC ($a8,x)
            .hex fe 02         ; $a7f6: fe 02     Suspected data
__a7f8:     .hex fb e9 31      ; $a7f8: fb e9 31  Invalid Opcode - ISC $31e9,y
            .hex eb 01         ; $a7fb: eb 01     Invalid Opcode - SBC #$01
            ora $d1            ; $a7fd: 05 d1     
            bvs __a80f         ; $a7ff: 70 0e     
            bit $e3            ; $a801: 24 e3     
            rti                ; $a803: 40        

;-------------------------------------------------------------------------------
            cpx $46            ; $a804: e4 46     
            .hex e3 70         ; $a806: e3 70     Invalid Opcode - ISC ($70,x)
            cpx $76            ; $a808: e4 76     
__a80a:     .hex e3 b0         ; $a80a: e3 b0     Invalid Opcode - ISC ($b0,x)
            cpx $b6            ; $a80c: e4 b6     
            .hex e6            ; $a80e: e6        Suspected data
__a80f:     php                ; $a80f: 08        
            .hex e3            ; $a810: e3        Suspected data
__a811:     .hex 22            ; $a811: 22        Invalid Opcode - KIL 
            inc $01            ; $a812: e6 01     
            cpx $40            ; $a814: e4 40     
            .hex e3 4e         ; $a816: e3 4e     Invalid Opcode - ISC ($4e,x)
            cpx $10            ; $a818: e4 10     
            .hex e3 16         ; $a81a: e3 16     Invalid Opcode - ISC ($16,x)
            inc $08            ; $a81c: e6 08     
            cpx $92            ; $a81e: e4 92     
            inc $01            ; $a820: e6 01     
            .hex e3 60         ; $a822: e3 60     Invalid Opcode - ISC ($60,x)
            cpx $66            ; $a824: e4 66     
            .hex e3 70         ; $a826: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e4            ; $a828: e4        Suspected data
__a829:     ror $e3,x          ; $a829: 76 e3     
            bcc __a811         ; $a82b: 90 e4     
            stx $e6,y          ; $a82d: 96 e6     
__a82f:     php                ; $a82f: 08        
            .hex b0            ; $a830: b0        Suspected data
__a831:     sbc ($60),y        ; $a831: f1 60     
            bvs __a7c5         ; $a833: 70 90     
            bcs __a829         ; $a835: b0 f2     
            rts                ; $a837: 60        

;-------------------------------------------------------------------------------
            bvs __a7ca         ; $a838: 70 90     
            bcs __a82f         ; $a83a: b0 f3     
            rts                ; $a83c: 60        

;-------------------------------------------------------------------------------
            bvs __a7cf         ; $a83d: 70 90     
            bcs __a831         ; $a83f: b0 f0     
            .hex e7 11         ; $a841: e7 11     Invalid Opcode - ISC $11
            .hex e2 30         ; $a843: e2 30     Invalid Opcode - NOP #$30
            rts                ; $a845: 60        

;-------------------------------------------------------------------------------
            bcc __a7f8         ; $a846: 90 b0     
            inc __eb02,x       ; $a848: fe 02 eb  
            eor ($04,x)        ; $a84b: 41 04     
            sbc #$31           ; $a84d: e9 31     
            .hex d4 77         ; $a84f: d4 77     Invalid Opcode - NOP $77,x
            .hex 82 15         ; $a851: 82 15     Invalid Opcode - NOP #$15
            sbc ($e2),y        ; $a853: f1 e2     
            ora ($41,x)        ; $a855: 01 41     
            sta ($e1),y        ; $a857: 91 e1     
            ora $43            ; $a859: 05 43     
            and $e2,x          ; $a85b: 35 e2     
            lda $25e1,y        ; $a85d: b9 e1 25  
            .hex e2 85         ; $a860: e2 85     Invalid Opcode - NOP #$85
            .hex b3 e7         ; $a862: b3 e7     Invalid Opcode - LAX ($e7),y
            .hex 0f e1 0f      ; $a864: 0f e1 0f  Invalid Opcode - SLO $0fe1
            .hex e7 82         ; $a867: e7 82     Invalid Opcode - ISC $82
            .hex e2 50         ; $a869: e2 50     Invalid Opcode - NOP #$50
            .hex 74 b5         ; $a86b: 74 b5     Invalid Opcode - NOP $b5,x
            .hex 73 55         ; $a86d: 73 55     Invalid Opcode - RRA ($55),y
            adc ($f0),y        ; $a86f: 71 f0     
            inc $01            ; $a871: e6 01     
            .hex e3 90         ; $a873: e3 90     Invalid Opcode - ISC ($90,x)
            .hex e2 96         ; $a875: e2 96     Invalid Opcode - NOP #$96
            .hex e3 70         ; $a877: e3 70     Invalid Opcode - ISC ($70,x)
            .hex e2 76         ; $a879: e2 76     Invalid Opcode - NOP #$76
            .hex e3 50         ; $a87b: e3 50     Invalid Opcode - ISC ($50,x)
            .hex e2 56         ; $a87d: e2 56     Invalid Opcode - NOP #$56
            .hex e3 40         ; $a87f: e3 40     Invalid Opcode - ISC ($40,x)
            .hex e2 46         ; $a881: e2 46     Invalid Opcode - NOP #$46
            sbc #$33           ; $a883: e9 33     
            cld                ; $a885: d8        
            bvs __a894         ; $a886: 70 0c     
            .hex 17 e2         ; $a888: 17 e2     Invalid Opcode - SLO $e2,x
            cpy #$f2           ; $a88a: c0 f2     
            bmi __a8be         ; $a88c: 30 30     
            .hex f4 30         ; $a88e: f4 30     Invalid Opcode - NOP $30,x
            .hex f2            ; $a890: f2        Invalid Opcode - KIL 
            rti                ; $a891: 40        

;-------------------------------------------------------------------------------
            rti                ; $a892: 40        

;-------------------------------------------------------------------------------
            .hex f4            ; $a893: f4        Suspected data
__a894:     rti                ; $a894: 40        

;-------------------------------------------------------------------------------
            .hex f2            ; $a895: f2        Invalid Opcode - KIL 
            rts                ; $a896: 60        

;-------------------------------------------------------------------------------
            rts                ; $a897: 60        

;-------------------------------------------------------------------------------
            .hex f4 60         ; $a898: f4 60     Invalid Opcode - NOP $60,x
            .hex f2            ; $a89a: f2        Invalid Opcode - KIL 
            bvs __a90d         ; $a89b: 70 70     
            .hex f4 70         ; $a89d: f4 70     Invalid Opcode - NOP $70,x
            .hex f2            ; $a89f: f2        Invalid Opcode - KIL 
            bvs __a902         ; $a8a0: 70 60     
            rti                ; $a8a2: 40        

;-------------------------------------------------------------------------------
            .hex f4 40         ; $a8a3: f4 40     Invalid Opcode - NOP $40,x
            .hex f2            ; $a8a5: f2        Invalid Opcode - KIL 
            bmi __a8d8         ; $a8a6: 30 30     
            .hex f4 30         ; $a8a8: f4 30     Invalid Opcode - NOP $30,x
            .hex f2            ; $a8aa: f2        Invalid Opcode - KIL 
            rti                ; $a8ab: 40        

;-------------------------------------------------------------------------------
            rti                ; $a8ac: 40        

;-------------------------------------------------------------------------------
            .hex f4 40         ; $a8ad: f4 40     Invalid Opcode - NOP $40,x
            cld                ; $a8af: d8        
            bvs __a8c1         ; $a8b0: 70 0f     
            brk                ; $a8b2: 00        
            .hex e3 b8         ; $a8b3: e3 b8     Invalid Opcode - ISC ($b8,x)
            inc __d2ff,x       ; $a8b5: fe ff d2  
            .hex a7 eb         ; $a8b8: a7 eb     Invalid Opcode - LAX $eb
            ora ($00,x)        ; $a8ba: 01 00     
            sbc #$b5           ; $a8bc: e9 b5     
__a8be:     cmp ($70),y        ; $a8be: d1 70     
            .hex 10            ; $a8c0: 10        Suspected data
__a8c1:     and $f1            ; $a8c1: 25 f1     
            cpx $40            ; $a8c3: e4 40     
            .hex e3 46         ; $a8c5: e3 46     Invalid Opcode - ISC ($46,x)
            cpx $10            ; $a8c7: e4 10     
            .hex e3 16         ; $a8c9: e3 16     Invalid Opcode - ISC ($16,x)
            cpx $20            ; $a8cb: e4 20     
            .hex e3 26         ; $a8cd: e3 26     Invalid Opcode - ISC ($26,x)
            cpx $40            ; $a8cf: e4 40     
            .hex e3 4e         ; $a8d1: e3 4e     Invalid Opcode - ISC ($4e,x)
            cpx $00            ; $a8d3: e4 00     
            .hex e3 0e         ; $a8d5: e3 0e     Invalid Opcode - ISC ($0e,x)
            .hex e5            ; $a8d7: e5        Suspected data
__a8d8:     ldy #$e4           ; $a8d8: a0 e4     
            ldx $11e7          ; $a8da: ae e7 11  
            sbc $e2,x          ; $a8dd: f5 e2     
            .hex 77 f4         ; $a8df: 77 f4     Invalid Opcode - RRA $f4,x
            .hex 47 f3         ; $a8e1: 47 f3     Invalid Opcode - SRE $f3
            .hex 17 f2         ; $a8e3: 17 f2     Invalid Opcode - SLO $f2,x
            .hex 77 47         ; $a8e5: 77 47     Invalid Opcode - RRA $47,x
            sbc ($17),y        ; $a8e7: f1 17     
            beq __a962         ; $a8e9: f0 77     
            .hex e7 10         ; $a8eb: e7 10     Invalid Opcode - ISC $10
            .hex f2            ; $a8ed: f2        Invalid Opcode - KIL 
            cpx $40            ; $a8ee: e4 40     
            .hex e3 46         ; $a8f0: e3 46     Invalid Opcode - ISC ($46,x)
            cpx $10            ; $a8f2: e4 10     
            .hex e3 16         ; $a8f4: e3 16     Invalid Opcode - ISC ($16,x)
            cpx $20            ; $a8f6: e4 20     
            .hex e3 26         ; $a8f8: e3 26     Invalid Opcode - ISC ($26,x)
            cpx $40            ; $a8fa: e4 40     
            .hex e3 4e         ; $a8fc: e3 4e     Invalid Opcode - ISC ($4e,x)
            cpx $00            ; $a8fe: e4 00     
            .hex e3 0e         ; $a900: e3 0e     Invalid Opcode - ISC ($0e,x)
__a902:     sbc $a0            ; $a902: e5 a0     
            cpx $ae            ; $a904: e4 ae     
            .hex e7 11         ; $a906: e7 11     Invalid Opcode - ISC $11
            sbc $e2,x          ; $a908: f5 e2     
            .hex 77 f4         ; $a90a: 77 f4     Invalid Opcode - RRA $f4,x
            .hex 47            ; $a90c: 47        Suspected data
__a90d:     .hex f3 17         ; $a90d: f3 17     Invalid Opcode - ISC ($17),y
            .hex f2            ; $a90f: f2        Invalid Opcode - KIL 
            .hex 77 47         ; $a910: 77 47     Invalid Opcode - RRA $47,x
            sbc ($17),y        ; $a912: f1 17     
            beq __a98d         ; $a914: f0 77     
            .hex fb e9 34      ; $a916: fb e9 34  Invalid Opcode - ISC $34e9,y
            .hex d4 b0         ; $a919: d4 b0     Invalid Opcode - NOP $b0,x
            ora __f525         ; $a91b: 0d 25 f5  
            .hex e3 b1         ; $a91e: e3 b1     Invalid Opcode - ISC ($b1,x)
            .hex e2 71         ; $a920: e2 71     Invalid Opcode - NOP #$71
            eor ($11,x)        ; $a922: 41 11     
            .hex f4 71         ; $a924: f4 71     Invalid Opcode - NOP $71,x
            eor ($11,x)        ; $a926: 41 11     
            adc ($f3),y        ; $a928: 71 f3     
            .hex e3 91         ; $a92a: e3 91     Invalid Opcode - ISC ($91,x)
            .hex e2 71         ; $a92c: e2 71     Invalid Opcode - NOP #$71
            eor ($11,x)        ; $a92e: 41 11     
            adc ($41),y        ; $a930: 71 41     
            ora ($71),y        ; $a932: 11 71     
            .hex f2            ; $a934: f2        Invalid Opcode - KIL 
            .hex e3 b1         ; $a935: e3 b1     Invalid Opcode - ISC ($b1,x)
            .hex e2 61         ; $a937: e2 61     Invalid Opcode - NOP #$61
            eor ($31,x)        ; $a939: 41 31     
            sbc ($41),y        ; $a93b: f1 41     
            and ($e3),y        ; $a93d: 31 e3     
            lda ($e2),y        ; $a93f: b1 e2     
            adc ($f0,x)        ; $a941: 61 f0     
            eor ($31,x)        ; $a943: 41 31     
            eor ($31,x)        ; $a945: 41 31     
            .hex e7 11         ; $a947: e7 11     Invalid Opcode - ISC $11
            .hex e2 b1         ; $a949: e2 b1     Invalid Opcode - NOP #$b1
            sbc ($31,x)        ; $a94b: e1 31     
            eor ($61,x)        ; $a94d: 41 61     
            inc __eb02,x       ; $a94f: fe 02 eb  
            eor ($04,x)        ; $a952: 41 04     
            sbc #$b1           ; $a954: e9 b1     
            .hex d4 37         ; $a956: d4 37     Invalid Opcode - NOP $37,x
            .hex 82 15         ; $a958: 82 15     Invalid Opcode - NOP #$15
            .hex f2            ; $a95a: f2        Invalid Opcode - KIL 
            .hex e3 91         ; $a95b: e3 91     Invalid Opcode - ISC ($91,x)
            .hex e2 01         ; $a95d: e2 01     Invalid Opcode - NOP #$01
            eor ($95,x)        ; $a95f: 41 95     
            .hex e1            ; $a961: e1        Suspected data
__a962:     .hex 03 e2         ; $a962: 03 e2     Invalid Opcode - SLO ($e2,x)
            adc $39            ; $a964: 65 39     
            eor $e3,x          ; $a966: 55 e3     
            lda $e2,x          ; $a968: b5 e2     
__a96a:     .hex 23            ; $a96a: 23        Suspected data
__a96b:     .hex e7 0f         ; $a96b: e7 0f     Invalid Opcode - ISC $0f
            sbc ($4f),y        ; $a96d: f1 4f     
            .hex e7 82         ; $a96f: e7 82     Invalid Opcode - ISC $82
            .hex f2            ; $a971: f2        Invalid Opcode - KIL 
            brk                ; $a972: 00        
            bit $75            ; $a973: 24 75     
            .hex 23 05         ; $a975: 23 05     Invalid Opcode - RLA ($05,x)
            ora ($e9,x)        ; $a977: 01 e9     
            bvs __a96b         ; $a979: 70 f0     
            inc $01            ; $a97b: e6 01     
            cpx $90            ; $a97d: e4 90     
            .hex e3 96         ; $a97f: e3 96     Invalid Opcode - ISC ($96,x)
            cpx $70            ; $a981: e4 70     
            .hex e3 76         ; $a983: e3 76     Invalid Opcode - ISC ($76,x)
            cpx $50            ; $a985: e4 50     
            .hex e3 56         ; $a987: e3 56     Invalid Opcode - ISC ($56,x)
            cpx $40            ; $a989: e4 40     
            .hex e3 46         ; $a98b: e3 46     Invalid Opcode - ISC ($46,x)
__a98d:     .hex eb 01         ; $a98d: eb 01     Invalid Opcode - SBC #$01
            brk                ; $a98f: 00        
            sbc #$00           ; $a990: e9 00     
            .hex d4 30         ; $a992: d4 30     Invalid Opcode - NOP $30,x
            .hex 0c 17 e3      ; $a994: 0c 17 e3  Invalid Opcode - NOP __e317
            cmp ($f2,x)        ; $a997: c1 f2     
            lda ($b1),y        ; $a999: b1 b1     
            .hex f4 b1         ; $a99b: f4 b1     Invalid Opcode - NOP $b1,x
            .hex f2            ; $a99d: f2        Invalid Opcode - KIL 
            .hex e2 01         ; $a99e: e2 01     Invalid Opcode - NOP #$01
            ora ($f4,x)        ; $a9a0: 01 f4     
            ora ($f2,x)        ; $a9a2: 01 f2     
            and ($21,x)        ; $a9a4: 21 21     
            .hex f4 21         ; $a9a6: f4 21     Invalid Opcode - NOP $21,x
            .hex f2            ; $a9a8: f2        Invalid Opcode - KIL 
            eor ($41,x)        ; $a9a9: 41 41     
            .hex f4 41         ; $a9ab: f4 41     Invalid Opcode - NOP $41,x
__a9ad:     .hex f2            ; $a9ad: f2        Invalid Opcode - KIL 
            .hex 41            ; $a9ae: 41        Suspected data
__a9af:     and ($01,x)        ; $a9af: 21 01     
            .hex f4 01         ; $a9b1: f4 01     Invalid Opcode - NOP $01,x
            .hex f2            ; $a9b3: f2        Invalid Opcode - KIL 
            .hex e3 b1         ; $a9b4: e3 b1     Invalid Opcode - ISC ($b1,x)
            lda ($f4),y        ; $a9b6: b1 f4     
            lda ($f2),y        ; $a9b8: b1 f2     
            .hex e2 01         ; $a9ba: e2 01     Invalid Opcode - NOP #$01
            ora ($f4,x)        ; $a9bc: 01 f4     
            ora ($f0,x)        ; $a9be: 01 f0     
            cld                ; $a9c0: d8        
            bvs __a9d2         ; $a9c1: 70 0f     
            brk                ; $a9c3: 00        
            .hex e2 b0         ; $a9c4: e2 b0     Invalid Opcode - NOP #$b0
            .hex e3 b7         ; $a9c6: e3 b7     Invalid Opcode - ISC ($b7,x)
            inc __b9ff,x       ; $a9c8: fe ff b9  
            tay                ; $a9cb: a8        
            .hex d4 90         ; $a9cc: d4 90     Invalid Opcode - NOP $90,x
            .hex e3 41         ; $a9ce: e3 41     Invalid Opcode - ISC ($41,x)
            ora ($21),y        ; $a9d0: 11 21     
__a9d2:     eor #$e4           ; $a9d2: 49 e4     
            inc $03            ; $a9d4: e6 03     
            bvc __aa48         ; $a9d6: 50 70     
            .hex 80 90         ; $a9d8: 80 90     Invalid Opcode - NOP #$90
            inc $04            ; $a9da: e6 04     
            ldy $e5            ; $a9dc: a4 e5     
            .hex a7 e3         ; $a9de: a7 e3     Invalid Opcode - LAX $e3
            eor ($11,x)        ; $a9e0: 41 11     
            and ($49,x)        ; $a9e2: 21 49     
            cpx $e6            ; $a9e4: e4 e6     
__a9e6:     .hex 03 50         ; $a9e6: 03 50     Invalid Opcode - SLO ($50,x)
            bvs __a96a         ; $a9e8: 70 80     
            bcc __a9d2         ; $a9ea: 90 e6     
            .hex 04 a4         ; $a9ec: 04 a4     Invalid Opcode - NOP $a4
            sbc $a7            ; $a9ee: e5 a7     
            .hex fb d4 0d      ; $a9f0: fb d4 0d  Invalid Opcode - ISC $0dd4,y
            cpx $41            ; $a9f3: e4 41     
            eor ($61,x)        ; $a9f5: 41 61     
            eor ($61,x)        ; $a9f7: 41 61     
            eor ($61,x)        ; $a9f9: 41 61     
            eor ($fe,x)        ; $a9fb: 41 fe     
            .hex 02            ; $a9fd: 02        Invalid Opcode - KIL 
            .hex fb e4 b1      ; $a9fe: fb e4 b1  Invalid Opcode - ISC __b1e4,y
            lda ($e3),y        ; $aa01: b1 e3     
            and ($e4),y        ; $aa03: 31 e4     
            lda ($e3),y        ; $aa05: b1 e3     
            eor ($e4,x)        ; $aa07: 41 e4     
            lda ($e3),y        ; $aa09: b1 e3     
            adc ($01,x)        ; $aa0b: 61 01     
            inc __fb02,x       ; $aa0d: fe 02 fb  
            cpx $41            ; $aa10: e4 41     
            eor ($61,x)        ; $aa12: 41 61     
            eor ($61,x)        ; $aa14: 41 61     
            eor ($61,x)        ; $aa16: 41 61     
            eor ($fe,x)        ; $aa18: 41 fe     
            .hex 02            ; $aa1a: 02        Invalid Opcode - KIL 
            .hex fb e4 b1      ; $aa1b: fb e4 b1  Invalid Opcode - ISC __b1e4,y
            lda ($e3),y        ; $aa1e: b1 e3     
            and ($e4),y        ; $aa20: 31 e4     
            lda ($e3),y        ; $aa22: b1 e3     
            eor ($e4,x)        ; $aa24: 41 e4     
            lda ($e3),y        ; $aa26: b1 e3     
            adc ($01,x)        ; $aa28: 61 01     
            inc __d402,x       ; $aa2a: fe 02 d4  
            ora $e4,x          ; $aa2d: 15 e4     
            sta $e3,x          ; $aa2f: 95 e3     
            eor $93            ; $aa31: 45 93     
            cpx $b1            ; $aa33: e4 b1     
            cmp ($b1,x)        ; $aa35: c1 b1     
            .hex e3 65         ; $aa37: e3 65     Invalid Opcode - ISC ($65,x)
            .hex b3 e4         ; $aa39: b3 e4     Invalid Opcode - LAX ($e4),y
            eor $b5,x          ; $aa3b: 55 b5     
            .hex e3 53         ; $aa3d: e3 53     Invalid Opcode - ISC ($53,x)
            .hex d4 0d         ; $aa3f: d4 0d     Invalid Opcode - NOP $0d,x
            sta ($91),y        ; $aa41: 91 91     
            cmp ($91,x)        ; $aa43: c1 91     
            adc ($51),y        ; $aa45: 71 51     
            .hex 41            ; $aa47: 41        Suspected data
__aa48:     and ($d4,x)        ; $aa48: 21 d4     
            ora $e4,x          ; $aa4a: 15 e4     
            adc $e3,x          ; $aa4c: 75 e3     
            and $73            ; $aa4e: 25 73     
            cpx $51            ; $aa50: e4 51     
            cmp ($51,x)        ; $aa52: c1 51     
            .hex d4 0d         ; $aa54: d4 0d     Invalid Opcode - NOP $0d,x
            .hex e3 71         ; $aa56: e3 71     Invalid Opcode - ISC ($71,x)
            sta ($71),y        ; $aa58: 91 71     
            eor ($41),y        ; $aa5a: 51 41     
            .hex fb c1 e4      ; $aa5c: fb c1 e4  Invalid Opcode - ISC __e4c1,y
            lda ($e3),y        ; $aa5f: b1 e3     
            and ($e4),y        ; $aa61: 31 e4     
            lda ($e3),y        ; $aa63: b1 e3     
            eor ($e4,x)        ; $aa65: 41 e4     
            lda ($e3),y        ; $aa67: b1 e3     
            adc ($e4,x)        ; $aa69: 61 e4     
            lda ($fe),y        ; $aa6b: b1 fe     
            .hex 03 b1         ; $aa6d: 03 b1     Invalid Opcode - SLO ($b1,x)
__aa6f:     lda ($91),y        ; $aa6f: b1 91     
            lda ($b1),y        ; $aa71: b1 b1     
            .hex e3 31         ; $aa73: e3 31     Invalid Opcode - ISC ($31,x)
            adc ($91,x)        ; $aa75: 61 91     
            inc __ccff,x       ; $aa77: fe ff cc  
            lda #$d4           ; $aa7a: a9 d4     
            .hex bf b7 b7      ; $aa7c: bf b7 b7  Invalid Opcode - LAX __b7b7,y
            lda ($bd),y        ; $aa7f: b1 bd     
            .hex b7 b3         ; $aa81: b7 b3     Invalid Opcode - LAX $b3,y
            .hex a3 fb         ; $aa83: a3 fb     Invalid Opcode - LAX ($fb,x)
            .hex b3 a1         ; $aa85: b3 a1     Invalid Opcode - LAX ($a1),y
            .hex b3 b1         ; $aa87: b3 b1     Invalid Opcode - LAX ($b1),y
            lda ($b1,x)        ; $aa89: a1 b1     
            inc __b307,x       ; $aa8b: fe 07 b3  
            lda ($b3,x)        ; $aa8e: a1 b3     
            lda ($a1),y        ; $aa90: b1 a1     
            ldy #$a0           ; $aa92: a0 a0     
            .hex fb b3 a1      ; $aa94: fb b3 a1  Invalid Opcode - ISC __a1b3,y
            lda $a3,x          ; $aa97: b5 a3     
            inc __a103,x       ; $aa99: fe 03 a1  
            .hex a3 a3         ; $aa9c: a3 a3     Invalid Opcode - LAX ($a3,x)
            lda ($a1),y        ; $aa9e: b1 a1     
            ldy #$a0           ; $aaa0: a0 a0     
            .hex b3 a1         ; $aaa2: b3 a1     Invalid Opcode - LAX ($a1),y
            lda $a3,x          ; $aaa4: b5 a3     
            .hex b3 a1         ; $aaa6: b3 a1     Invalid Opcode - LAX ($a1),y
            .hex b3 a1         ; $aaa8: b3 a1     Invalid Opcode - LAX ($a1),y
            lda ($a3,x)        ; $aaaa: a1 a3     
            lda ($a1),y        ; $aaac: b1 a1     
            lda ($b1,x)        ; $aaae: a1 b1     
            lda ($b1,x)        ; $aab0: a1 b1     
            .hex a3 b1         ; $aab2: a3 b1     Invalid Opcode - LAX ($b1,x)
            lda ($a1,x)        ; $aab4: a1 a1     
            lda ($b1),y        ; $aab6: b1 b1     
            lda ($a3,x)        ; $aab8: a1 a3     
            lda ($a1),y        ; $aaba: b1 a1     
            lda ($b1,x)        ; $aabc: a1 b1     
            lda ($a1,x)        ; $aabe: a1 a1     
            lda ($b1,x)        ; $aac0: a1 b1     
            lda ($a1),y        ; $aac2: b1 a1     
            lda ($b1,x)        ; $aac4: a1 b1     
            lda ($a1,x)        ; $aac6: a1 a1     
            ldy #$a0           ; $aac8: a0 a0     
            inc $7bff,x        ; $aaca: fe ff 7b  
            tax                ; $aacd: aa        
__aace:     clc                ; $aace: 18        
            adc $01            ; $aacf: 65 01     
            sta $0200,x        ; $aad1: 9d 00 02  
            jsr __ab7c         ; $aad4: 20 7c ab  
            lda $96            ; $aad7: a5 96     
            jmp __ab36         ; $aad9: 4c 36 ab  

;-------------------------------------------------------------------------------
__aadc:     ldy #$00           ; $aadc: a0 00     
            lda ($08),y        ; $aade: b1 08     
            bne __aae3         ; $aae0: d0 01     
            rts                ; $aae2: 60        

;-------------------------------------------------------------------------------
__aae3:     iny                ; $aae3: c8        
            sta $0f            ; $aae4: 85 0f     
            and #$7f           ; $aae6: 29 7f     
            sta $03            ; $aae8: 85 03     
            sta $15            ; $aaea: 85 15     
            ldx $04            ; $aaec: a6 04     
            lda $0f            ; $aaee: a5 0f     
            bpl __ab02         ; $aaf0: 10 10     
            lda ($08),y        ; $aaf2: b1 08     
            sta $0d            ; $aaf4: 85 0d     
            iny                ; $aaf6: c8        
            lda ($08),y        ; $aaf7: b1 08     
            sta $0e            ; $aaf9: 85 0e     
            iny                ; $aafb: c8        
            sty $0c            ; $aafc: 84 0c     
            ldy #$01           ; $aafe: a0 01     
            lda ($0d),y        ; $ab00: b1 0d     
__ab02:     jsr __ab72         ; $ab02: 20 72 ab  
            clc                ; $ab05: 18        
            bpl __ab09         ; $ab06: 10 01     
            sec                ; $ab08: 38        
__ab09:     iny                ; $ab09: c8        
            ror                ; $ab0a: 6a        
            bcs __aace         ; $ab0b: b0 c1     
            adc $01            ; $ab0d: 65 01     
            sta $0200,x        ; $ab0f: 9d 00 02  
            jsr __ab7c         ; $ab12: 20 7c ab  
            clc                ; $ab15: 18        
            lda $00            ; $ab16: a5 00     
            and #$03           ; $ab18: 29 03     
            beq __ab1d         ; $ab1a: f0 01     
            sec                ; $ab1c: 38        
__ab1d:     jsr __ab72         ; $ab1d: 20 72 ab  
            bcc __ab26         ; $ab20: 90 04     
            and #$dc           ; $ab22: 29 dc     
            ora $00            ; $ab24: 05 00     
__ab26:     sta $96            ; $ab26: 85 96     
            sta $0202,x        ; $ab28: 9d 02 02  
            iny                ; $ab2b: c8        
            lda $10            ; $ab2c: a5 10     
            beq __ab39         ; $ab2e: f0 09     
            lda $96            ; $ab30: a5 96     
            eor #$40           ; $ab32: 49 40     
            sta $96            ; $ab34: 85 96     
__ab36:     sta $0202,x        ; $ab36: 9d 02 02  
__ab39:     lda $10            ; $ab39: a5 10     
            bne __ab66         ; $ab3b: d0 29     
            jsr __ab72         ; $ab3d: 20 72 ab  
            clc                ; $ab40: 18        
            adc $02            ; $ab41: 65 02     
            sta $0203,x        ; $ab43: 9d 03 02  
            lda $17            ; $ab46: a5 17     
            bmi __ab60         ; $ab48: 30 16     
            txa                ; $ab4a: 8a        
__ab4b:     clc                ; $ab4b: 18        
            adc #$c4           ; $ab4c: 69 c4     
            cmp $16            ; $ab4e: c5 16     
            bcc __ab4b         ; $ab50: 90 f9     
            tax                ; $ab52: aa        
            dec $07            ; $ab53: c6 07     
__ab55:     iny                ; $ab55: c8        
            dec $03            ; $ab56: c6 03     
            beq __ab5d         ; $ab58: f0 03     
            jmp __ab02         ; $ab5a: 4c 02 ab  

;-------------------------------------------------------------------------------
__ab5d:     stx $04            ; $ab5d: 86 04     
            rts                ; $ab5f: 60        

;-------------------------------------------------------------------------------
__ab60:     inx                ; $ab60: e8        
            inx                ; $ab61: e8        
            inx                ; $ab62: e8        
            inx                ; $ab63: e8        
            bne __ab55         ; $ab64: d0 ef     
__ab66:     jsr __ab72         ; $ab66: 20 72 ab  
            clc                ; $ab69: 18        
            adc #$08           ; $ab6a: 69 08     
            jsr __deb7         ; $ab6c: 20 b7 de  
            .hex 4c 40         ; $ab6f: 4c 40     Suspected data
__ab71:     .hex ab            ; $ab71: ab        Suspected data
__ab72:     lda $0f            ; $ab72: a5 0f     
            bpl __ab79         ; $ab74: 10 03     
            lda ($0d),y        ; $ab76: b1 0d     
            rts                ; $ab78: 60        

;-------------------------------------------------------------------------------
__ab79:     lda ($08),y        ; $ab79: b1 08     
            rts                ; $ab7b: 60        

;-------------------------------------------------------------------------------
__ab7c:     lda $0f            ; $ab7c: a5 0f     
            asl                ; $ab7e: 0a        
            bcc __ab85         ; $ab7f: 90 04     
            sty $14            ; $ab81: 84 14     
            ldy $0c            ; $ab83: a4 0c     
__ab85:     lda ($08),y        ; $ab85: b1 08     
            sta $0201,x        ; $ab87: 9d 01 02  
            bcc __ab91         ; $ab8a: 90 05     
            iny                ; $ab8c: c8        
            sty $0c            ; $ab8d: 84 0c     
            ldy $14            ; $ab8f: a4 14     
__ab91:     iny                ; $ab91: c8        
            rts                ; $ab92: 60        

;-------------------------------------------------------------------------------
__ab93:     lda $0312,x        ; $ab93: bd 12 03  
            sta $00            ; $ab96: 85 00     
            lda $0324,x        ; $ab98: bd 24 03  
            sta $01            ; $ab9b: 85 01     
            lda $0348,x        ; $ab9d: bd 48 03  
            sta $02            ; $aba0: 85 02     
            lda $0420,x        ; $aba2: bd 20 04  
            sta $10            ; $aba5: 85 10     
            lda $0300,x        ; $aba7: bd 00 03  
            asl                ; $abaa: 0a        
            bcs __abb9         ; $abab: b0 0c     
            tay                ; $abad: a8        
            lda __ac30,y       ; $abae: b9 30 ac  
            sta $08            ; $abb1: 85 08     
            lda __ac31,y       ; $abb3: b9 31 ac  
            sta $09            ; $abb6: 85 09     
            rts                ; $abb8: 60        

;-------------------------------------------------------------------------------
__abb9:     tay                ; $abb9: a8        
            lda __ad30,y       ; $abba: b9 30 ad  
__abbd:     sta $08            ; $abbd: 85 08     
            lda __ad31,y       ; $abbf: b9 31 ad  
            sta $09            ; $abc2: 85 09     
            rts                ; $abc4: 60        

;-------------------------------------------------------------------------------
            lda #$00           ; $abc5: a9 00     
            sta $15            ; $abc7: 85 15     
            lda #$38           ; $abc9: a9 38     
            sta $16            ; $abcb: 85 16     
            lda $03c6          ; $abcd: ad c6 03  
            beq __abd5         ; $abd0: f0 03     
            jmp __abe9         ; $abd2: 4c e9 ab  

;-------------------------------------------------------------------------------
__abd5:     ldx #$00           ; $abd5: a2 00     
            jsr __ab93         ; $abd7: 20 93 ab  
            ldx #$38           ; $abda: a2 38     
            stx $04            ; $abdc: 86 04     
            lda #$ff           ; $abde: a9 ff     
            sta $17            ; $abe0: 85 17     
            jsr __aadc         ; $abe2: 20 dc aa  
            lda $04            ; $abe5: a5 04     
            sta $16            ; $abe7: 85 16     
__abe9:     lda #$01           ; $abe9: a9 01     
            sta $05            ; $abeb: 85 05     
            lda #$31           ; $abed: a9 31     
            sec                ; $abef: 38        
            sbc $15            ; $abf0: e5 15     
            sta $07            ; $abf2: 85 07     
            lda $2d            ; $abf4: a5 2d     
__abf6:     clc                ; $abf6: 18        
            adc #$44           ; $abf7: 69 44     
            cmp $16            ; $abf9: c5 16     
            bcc __abf6         ; $abfb: 90 f9     
            sta $2d            ; $abfd: 85 2d     
            sta $04            ; $abff: 85 04     
__ac01:     ldx $05            ; $ac01: a6 05     
            cpx #$12           ; $ac03: e0 12     
            bcs __ac1a         ; $ac05: b0 13     
            lda $03c6,x        ; $ac07: bd c6 03  
            bne __ac16         ; $ac0a: d0 0a     
            jsr __ab93         ; $ac0c: 20 93 ab  
            lda #$00           ; $ac0f: a9 00     
            sta $17            ; $ac11: 85 17     
            jsr __aadc         ; $ac13: 20 dc aa  
__ac16:     inc $05            ; $ac16: e6 05     
            bne __ac01         ; $ac18: d0 e7     
__ac1a:     ldx $04            ; $ac1a: a6 04     
            ldy $07            ; $ac1c: a4 07     
__ac1e:     lda #$f4           ; $ac1e: a9 f4     
            sta $0200,x        ; $ac20: 9d 00 02  
            txa                ; $ac23: 8a        
__ac24:     clc                ; $ac24: 18        
            adc #$c4           ; $ac25: 69 c4     
            cmp $16            ; $ac27: c5 16     
            bcc __ac24         ; $ac29: 90 f9     
            tax                ; $ac2b: aa        
            dey                ; $ac2c: 88        
            bpl __ac1e         ; $ac2d: 10 ef     
            rts                ; $ac2f: 60        

;-------------------------------------------------------------------------------
__ac30:     rts                ; $ac30: 60        

;-------------------------------------------------------------------------------
__ac31:     lda ($79),y        ; $ac31: b1 79     
            lda ($80),y        ; $ac33: b1 80     
            lda ($79),y        ; $ac35: b1 79     
            lda ($72),y        ; $ac37: b1 72     
            lda ($98),y        ; $ac39: b1 98     
            lda ($9f),y        ; $ac3b: b1 9f     
            lda ($79),y        ; $ac3d: b1 79     
            lda ($ad),y        ; $ac3f: b1 ad     
            lda ($79),y        ; $ac41: b1 79     
            lda ($e5),y        ; $ac43: b1 e5     
            lda ($eb),y        ; $ac45: b1 eb     
            lda ($f1),y        ; $ac47: b1 f1     
            lda ($80),y        ; $ac49: b1 80     
            lda ($1f),y        ; $ac4b: b1 1f     
            .hex b2            ; $ac4d: b2        Invalid Opcode - KIL 
            and __ebb2         ; $ac4e: 2d b2 eb  
            lda $f2,x          ; $ac51: b5 f2     
            lda $46,x          ; $ac53: b5 46     
            lda $4b,x          ; $ac55: b5 4b     
            lda $50,x          ; $ac57: b5 50     
            lda $d1,x          ; $ac59: b5 d1     
            .hex b3 d9         ; $ac5b: b3 d9     Invalid Opcode - LAX ($d9),y
            .hex b3 de         ; $ac5d: b3 de     Invalid Opcode - LAX ($de),y
            .hex b3 d9         ; $ac5f: b3 d9     Invalid Opcode - LAX ($d9),y
            .hex b3 5e         ; $ac61: b3 5e     Invalid Opcode - LAX ($5e),y
            ldy $6c,x          ; $ac63: b4 6c     
            ldy $92,x          ; $ac65: b4 92     
            .hex b3 fb         ; $ac67: b3 fb     Invalid Opcode - LAX ($fb),y
            .hex b3 06         ; $ac69: b3 06     Invalid Opcode - LAX ($06),y
            ldy $3b,x          ; $ac6b: b4 3b     
            .hex b2            ; $ac6d: b2        Invalid Opcode - KIL 
            .hex 42            ; $ac6e: 42        Invalid Opcode - KIL 
            .hex b2            ; $ac6f: b2        Invalid Opcode - KIL 
            ora ($b4),y        ; $ac70: 11 b4     
__ac72:     clc                ; $ac72: 18        
            ldy $1f,x          ; $ac73: b4 1f     
            ldy $2d,x          ; $ac75: b4 2d     
            ldy $34,x          ; $ac77: b4 34     
            ldy $3b,x          ; $ac79: b4 3b     
            ldy $42,x          ; $ac7b: b4 42     
            ldy $49,x          ; $ac7d: b4 49     
            ldy $50,x          ; $ac7f: b4 50     
            ldy $74,x          ; $ac81: b4 74     
            .hex b2            ; $ac83: b2        Invalid Opcode - KIL 
            .hex 02            ; $ac84: 02        Invalid Opcode - KIL 
            .hex b2            ; $ac85: b2        Invalid Opcode - KIL 
            php                ; $ac86: 08        
            .hex b2            ; $ac87: b2        Invalid Opcode - KIL 
            asl __98b2         ; $ac88: 0e b2 98  
            lda ($49),y        ; $ac8b: b1 49     
            .hex b2            ; $ac8d: b2        Invalid Opcode - KIL 
            .hex 52            ; $ac8e: 52        Invalid Opcode - KIL 
            .hex b2            ; $ac8f: b2        Invalid Opcode - KIL 
            lda $7ab3,y        ; $ac90: b9 b3 7a  
            ldy $8e,x          ; $ac93: b4 8e     
            ldy $7e,x          ; $ac95: b4 7e     
            .hex af dd af      ; $ac97: af dd af  Invalid Opcode - LAX __afdd
            .hex 9f b4 b0      ; $ac9a: 9f b4 b0  Invalid Opcode - AHX __b0b4,y
            ldy $2f,x          ; $ac9d: b4 2f     
            lda $38,x          ; $ac9f: b5 38     
            lda $3d,x          ; $aca1: b5 3d     
            lda $8a,x          ; $aca3: b5 8a     
            .hex b2            ; $aca5: b2        Invalid Opcode - KIL 
            cmp ($b4),y        ; $aca6: d1 b4     
            sbc $01b4,y        ; $aca8: f9 b4 01  
            lda $06,x          ; $acab: b5 06     
            lda $e6,x          ; $acad: b5 e6     
            .hex b3 ed         ; $acaf: b3 ed     Invalid Opcode - LAX ($ed),y
            .hex b3 81         ; $acb1: b3 81     Invalid Opcode - LAX ($81),y
            .hex b2            ; $acb3: b2        Invalid Opcode - KIL 
            cpy $b4            ; $acb4: c4 b4     
            ror $b3,x          ; $acb6: 76 b3     
            stx __b1b5         ; $acb8: 8e b5 b1  
            lda $db,x          ; $acbb: b5 db     
            .hex b7 e3         ; $acbd: b7 e3     Invalid Opcode - LAX $e3,y
            .hex b7 be         ; $acbf: b7 be     Invalid Opcode - LAX $be,y
            .hex b3 86         ; $acc1: b3 86     Invalid Opcode - LAX ($86),y
            .hex b7            ; $acc3: b7        Suspected data
__acc4:     stx $14b7          ; $acc4: 8e b7 14  
            ldx __ae49         ; $acc7: ae 49 ae  
            adc ($ae),y        ; $acca: 71 ae     
            txs                ; $accc: 9a        
            ldx __b6b6         ; $accd: ae b6 b6  
            ldx __84b6,y       ; $acd0: be b6 84  
            .hex b3 94         ; $acd3: b3 94     Invalid Opcode - LAX ($94),y
            .hex b2            ; $acd5: b2        Invalid Opcode - KIL 
__acd6:     .hex 9f            ; $acd6: 9f        Suspected data
__acd7:     .hex b2            ; $acd7: b2        Invalid Opcode - KIL 
            ldy $b2            ; $acd8: a4 b2     
            lda #$b2           ; $acda: a9 b2     
            .hex 93 b7         ; $acdc: 93 b7     Invalid Opcode - AHX ($b7),y
            .hex 9b            ; $acde: 9b        Invalid Opcode - TAS 
            .hex b7 60         ; $acdf: b7 60     Invalid Opcode - LAX $60,y
            lda ($0e),y        ; $ace1: b1 0e     
            ldx $16,y          ; $ace3: b6 16     
            ldx $1b,y          ; $ace5: b6 1b     
            ldx $85,y          ; $ace7: b6 85     
            .hex b2            ; $ace9: b2        Invalid Opcode - KIL 
            .hex 22            ; $acea: 22        Invalid Opcode - KIL 
            ldx $33,y          ; $aceb: b6 33     
            ldx $00,y          ; $aced: b6 00     
            brk                ; $acef: 00        
            brk                ; $acf0: 00        
            brk                ; $acf1: 00        
            .hex 3b b6 43      ; $acf2: 3b b6 43  Invalid Opcode - RLA $43b6,y
            ldx $48,y          ; $acf5: b6 48     
            ldx $56,y          ; $acf7: b6 56     
            ldx $5d,y          ; $acf9: b6 5d     
            ldx $64,y          ; $acfb: b6 64     
            ldx $00,y          ; $acfd: b6 00     
            ldx $a9,y          ; $acff: b6 a9     
            .hex b2            ; $ad01: b2        Invalid Opcode - KIL 
            stx __aeb2         ; $ad02: 8e b2 ae  
            .hex b2            ; $ad05: b2        Invalid Opcode - KIL 
            .hex b3 b2         ; $ad06: b3 b2     Invalid Opcode - LAX ($b2),y
            .hex b3 b2         ; $ad08: b3 b2     Invalid Opcode - LAX ($b2),y
            clv                ; $ad0a: b8        
            .hex b2            ; $ad0b: b2        Invalid Opcode - KIL 
            .hex c3 b2         ; $ad0c: c3 b2     Invalid Opcode - DCP ($b2,x)
            iny                ; $ad0e: c8        
            .hex b2            ; $ad0f: b2        Invalid Opcode - KIL 
            .hex b3 b2         ; $ad10: b3 b2     Invalid Opcode - LAX ($b2),y
            .hex d3 b2         ; $ad12: d3 b2     Invalid Opcode - DCP ($b2),y
            dec __e3b2,x       ; $ad14: de b2 e3  
            .hex b2            ; $ad17: b2        Invalid Opcode - KIL 
            nop                ; $ad18: ea        
            .hex b2            ; $ad19: b2        Invalid Opcode - KIL 
            .hex 57 b2         ; $ad1a: 57 b2     Invalid Opcode - SRE $b2,x
            .hex 5b b2 60      ; $ad1c: 5b b2 60  Invalid Opcode - SRE $60b2,y
            .hex b2            ; $ad1f: b2        Invalid Opcode - KIL 
            sed                ; $ad20: f8        
            .hex b2            ; $ad21: b2        Invalid Opcode - KIL 
            ora ($b3,x)        ; $ad22: 01 b3     
            bvc __acd6         ; $ad24: 50 b0     
            cli                ; $ad26: 58        
            bcs __ad89         ; $ad27: b0 60     
            bcs __ad93         ; $ad29: b0 68     
            bcs __acc4         ; $ad2b: b0 97     
            .hex b3 6b         ; $ad2d: b3 6b     Invalid Opcode - LAX ($6b),y
            .hex b6            ; $ad2f: b6        Suspected data
__ad30:     .hex 82            ; $ad30: 82        Suspected data
__ad31:     ldx $d6,y          ; $ad31: b6 d6     
            ldy $de,x          ; $ad33: b4 de     
            ldy $f0,x          ; $ad35: b4 f0     
            ldy $f5,x          ; $ad37: b4 f5     
            ldy $66,x          ; $ad39: b4 66     
            .hex b2            ; $ad3b: b2        Invalid Opcode - KIL 
            .hex 0f b5 14      ; $ad3c: 0f b5 14  Invalid Opcode - SLO $14b5
            lda $1c,x          ; $ad3f: b5 1c     
            lda $21,x          ; $ad41: b5 21     
            lda $2a,x          ; $ad43: b5 2a     
            lda $64,x          ; $ad45: b5 64     
            .hex b3 68         ; $ad47: b3 68     Invalid Opcode - LAX ($68),y
            .hex b3 6d         ; $ad49: b3 6d     Invalid Opcode - LAX ($6d),y
            .hex b3 fe         ; $ad4b: b3 fe     Invalid Opcode - LAX ($fe),y
            .hex b7 06         ; $ad4d: b7 06     Invalid Opcode - LAX $06,y
            clv                ; $ad4f: b8        
            .hex c3 b6         ; $ad50: c3 b6     Invalid Opcode - DCP ($b6,x)
            dex                ; $ad52: ca        
            ldx $cf,y          ; $ad53: b6 cf     
            ldx $0b,y          ; $ad55: b6 0b     
            clv                ; $ad57: b8        
            .hex 12            ; $ad58: 12        Invalid Opcode - KIL 
            clv                ; $ad59: b8        
            ora $2ab8,y        ; $ad5a: 19 b8 2a  
            clv                ; $ad5d: b8        
            dec $b6,x          ; $ad5e: d6 b6     
            .hex e7 b6         ; $ad60: e7 b6     Invalid Opcode - ISC $b6
            sed                ; $ad62: f8        
            ldx $e7,y          ; $ad63: b6 e7     
            ldx $60,y          ; $ad65: b6 60     
            lda ($a2),y        ; $ad67: b1 a2     
            .hex b6            ; $ad69: b6        Suspected data
__ad6a:     and ($b8),y        ; $ad6a: 31 b8     
            .hex 3f b8         ; $ad6c: 3f b8     Suspected data
__ad6e:     inc $b4            ; $ad6e: e6 b4     
            .hex eb b4         ; $ad70: eb b4     Invalid Opcode - SBC #$b4
            cmp #$b4           ; $ad72: c9 b4     
            adc ($b1,x)        ; $ad74: 61 b1     
            .hex 87            ; $ad76: 87        Suspected data
__ad77:     lda ($f8),y        ; $ad77: b1 f8     
            .hex b2            ; $ad79: b2        Invalid Opcode - KIL 
            asl                ; $ad7a: 0a        
            .hex b3 19         ; $ad7b: b3 19     Invalid Opcode - LAX ($19),y
            .hex b3 2e         ; $ad7d: b3 2e     Invalid Opcode - LAX ($2e),y
            .hex b3 43         ; $ad7f: b3 43     Invalid Opcode - LAX ($43),y
            .hex b3 2e         ; $ad81: b3 2e     Invalid Opcode - LAX ($2e),y
            .hex b3 19         ; $ad83: b3 19     Invalid Opcode - LAX ($19),y
            .hex b3 0a         ; $ad85: b3 0a     Invalid Opcode - LAX ($0a),y
            .hex b3 f8         ; $ad87: b3 f8     Invalid Opcode - LAX ($f8),y
__ad89:     .hex b2            ; $ad89: b2        Invalid Opcode - KIL 
__ad8a:     adc __c2b2,y       ; $ad8a: 79 b2 c2  
__ad8d:     ldx __aec2         ; $ad8d: ae c2 ae  
            ldy $b1,x          ; $ad90: b4 b1     
            tsx                ; $ad92: ba        
__ad93:     lda ($c0),y        ; $ad93: b1 c0     
            lda ($9f),y        ; $ad95: b1 9f     
            lda ($d1),y        ; $ad97: b1 d1     
            lda ($d7),y        ; $ad99: b1 d7     
            lda ($dd),y        ; $ad9b: b1 dd     
            lda ($ad),y        ; $ad9d: b1 ad     
            lda ($9c),y        ; $ad9f: b1 9c     
            .hex b3 a1         ; $ada1: b3 a1     Invalid Opcode - LAX ($a1),y
            .hex b3 a9         ; $ada3: b3 a9     Invalid Opcode - LAX ($a9),y
            .hex b3 b1         ; $ada5: b3 b1     Invalid Opcode - LAX ($b1),y
            .hex b3 17         ; $ada7: b3 17     Invalid Opcode - LAX ($17),y
__ada9:     .hex b7            ; $ada9: b7        Suspected data
__adaa:     .hex 2b b7         ; $adaa: 2b b7     Invalid Opcode - ANC #$b7
            .hex 3f b7 54      ; $adac: 3f b7 54  Invalid Opcode - RLA $54b7,x
            .hex b7 c3         ; $adaf: b7 c3     Invalid Opcode - LAX $c3,y
            .hex b7 c8         ; $adb1: b7 c8     Invalid Opcode - LAX $c8,y
            .hex b7 cd         ; $adb3: b7 cd     Invalid Opcode - LAX $cd,y
            .hex b7 e8         ; $adb5: b7 e8     Invalid Opcode - LAX $e8,y
            .hex b7 f0         ; $adb7: b7 f0     Invalid Opcode - LAX $f0,y
            .hex b7 f5         ; $adb9: b7 f5     Invalid Opcode - LAX $f5,y
            .hex b7 8e         ; $adbb: b7 8e     Invalid Opcode - LAX $8e,y
            ldx $93,y          ; $adbd: b6 93     
            ldx $98,y          ; $adbf: b6 98     
            ldx $9d,y          ; $adc1: b6 9d     
            ldx $61,y          ; $adc3: b6 61     
            .hex b5            ; $adc5: b5        Suspected data
__adc6:     lsr $83,x          ; $adc6: 56 83     
            lsr $83,x          ; $adc8: 56 83     
            lsr $83,x          ; $adca: 56 83     
            lsr $83,x          ; $adcc: 56 83     
            cmp ($b5),y        ; $adce: d1 b5     
            cmp __deb5,y       ; $add0: d9 b5 de  
            lda $e6,x          ; $add3: b5 e6     
            lda $70,x          ; $add5: b5 70     
            bcs __ad6a         ; $add7: b0 91     
            bcs __ad77         ; $add9: b0 9c     
            bcs __ad6e         ; $addb: b0 91     
            bcs __ada9         ; $addd: b0 ca     
            ldx __aed8         ; $addf: ae d8 ae  
            inc $ae            ; $ade2: e6 ae     
            .hex fb ae 10      ; $ade4: fb ae 10  Invalid Opcode - ISC $10ae,y
__ade7:     .hex af 25 af      ; $ade7: af 25 af  Invalid Opcode - LAX __af25
            rti                ; $adea: 40        

;-------------------------------------------------------------------------------
            .hex af 59 b5      ; $adeb: af 59 b5  Invalid Opcode - LAX __b559
            sta ($b5,x)        ; $adee: 81 b5     
            stx $b5            ; $adf0: 86 b5     
            stx $b5            ; $adf2: 86 b5     
            ldy #$b7           ; $adf4: a0 b7     
            ldx __bcb7         ; $adf6: ae b7 bc  
            .hex b7 ae         ; $adf9: b7 ae     Invalid Opcode - LAX $ae,y
            .hex b7 71         ; $adfb: b7 71     Invalid Opcode - LAX $71,y
            .hex b7 7f         ; $adfd: b7 7f     Invalid Opcode - LAX $7f,y
            .hex b7 be         ; $adff: b7 be     Invalid Opcode - LAX $be,y
            bcs __adc6         ; $ae01: b0 c3     
            bcs __ae09         ; $ae03: b0 04     
            lda ($17),y        ; $ae05: b1 17     
            lda ($04),y        ; $ae07: b1 04     
__ae09:     lda ($09),y        ; $ae09: b1 09     
            .hex b7 10         ; $ae0b: b7 10     Invalid Opcode - LAX $10,y
            .hex b7 c7         ; $ae0d: b7 c7     Invalid Opcode - LAX $c7,y
            .hex b3 cc         ; $ae0f: b3 cc     Invalid Opcode - LAX ($cc),y
            .hex b3            ; $ae11: b3        Suspected data
__ae12:     .hex 5b b1 10      ; $ae12: 5b b1 10  Invalid Opcode - SRE $10b1,y
            ldy #$03           ; $ae15: a0 03     
            .hex 03 f0         ; $ae17: 03 f0     Invalid Opcode - SLO ($f0,x)
            lda ($1b,x)        ; $ae19: a1 1b     
            .hex 07 c1         ; $ae1b: 07 c1     Invalid Opcode - SLO $c1
            ora __c1f8         ; $ae1d: 0d f8 c1  
            ora $ff,x          ; $ae20: 15 ff     
            sbc ($0f,x)        ; $ae22: e1 0f     
            sed                ; $ae24: f8        
            sbc ($17,x)        ; $ae25: e1 17     
            .hex ff a0 0b      ; $ae27: ff a0 0b  Invalid Opcode - ISC $0ba0,x
            .hex 02            ; $ae2a: 02        Invalid Opcode - KIL 
            sed                ; $ae2b: f8        
            lda ($13,x)        ; $ae2c: a1 13     
            .hex ff e0 07      ; $ae2e: ff e0 07  Invalid Opcode - ISC $07e0,x
            eor ($07,x)        ; $ae31: 41 07     
            cmp ($05,x)        ; $ae33: c1 05     
            .hex 07 01         ; $ae35: 07 01     Invalid Opcode - SLO $01
            ora #$07           ; $ae37: 09 07     
            cpy #$05           ; $ae39: c0 05     
            ora ($f0,x)        ; $ae3b: 01 f0     
            sbc ($07,x)        ; $ae3d: e1 07     
            beq __ae42         ; $ae3f: f0 01     
            .hex 09            ; $ae41: 09        Suspected data
__ae42:     beq __ae45         ; $ae42: f0 01     
            .hex 11            ; $ae44: 11        Suspected data
__ae45:     sed                ; $ae45: f8        
            ora ($19,x)        ; $ae46: 01 19     
            .hex ff            ; $ae48: ff        Suspected data
__ae49:     .hex 0c c0 03      ; $ae49: 0c c0 03  Invalid Opcode - NOP $03c0
            .hex 03 f0         ; $ae4c: 03 f0     Invalid Opcode - SLO ($f0,x)
            cmp ($1b,x)        ; $ae4e: c1 1b     
            .hex 07 e1         ; $ae50: 07 e1     Invalid Opcode - SLO $e1
            and ($f8,x)        ; $ae52: 21 f8     
            sbc ($25,x)        ; $ae54: e1 25     
            .hex ff c0 0b      ; $ae56: ff c0 0b  Invalid Opcode - ISC $0bc0,x
            .hex 02            ; $ae59: 02        Invalid Opcode - KIL 
            sed                ; $ae5a: f8        
            cmp ($13,x)        ; $ae5b: c1 13     
            .hex ff e0 1d      ; $ae5d: ff e0 1d  Invalid Opcode - ISC $1de0,x
            ora ($f0,x)        ; $ae60: 01 f0     
            sbc ($29,x)        ; $ae62: e1 29     
            .hex 07 01         ; $ae64: 07 01     Invalid Opcode - SLO $01
            .hex 1f f0 01      ; $ae66: 1f f0 01  Invalid Opcode - SLO $01f0,x
            .hex 23 f8         ; $ae69: 23 f8     Invalid Opcode - RLA ($f8,x)
            ora ($27,x)        ; $ae6b: 01 27     
            .hex ff 01 2b      ; $ae6d: ff 01 2b  Invalid Opcode - ISC $2b01,x
__ae70:     .hex 07 0c         ; $ae70: 07 0c     Invalid Opcode - SLO $0c
            cpy #$2d           ; $ae72: c0 2d     
            .hex 43 07         ; $ae74: 43 07     Invalid Opcode - SRE ($07,x)
            cpy #$0b           ; $ae76: c0 0b     
            .hex 02            ; $ae78: 02        Invalid Opcode - KIL 
            sed                ; $ae79: f8        
            cmp ($13,x)        ; $ae7a: c1 13     
            .hex ff c0 2d      ; $ae7c: ff c0 2d  Invalid Opcode - ISC $2dc0,x
            .hex 03 f0         ; $ae7f: 03 f0     Invalid Opcode - SLO ($f0,x)
            sbc ($31,x)        ; $ae81: e1 31     
            sed                ; $ae83: f8        
            sbc ($33,x)        ; $ae84: e1 33     
            .hex ff 00 1f      ; $ae86: ff 00 1f  Invalid Opcode - ISC $1f00,x
            ora ($f0,x)        ; $ae89: 01 f0     
            sbc ($2f,x)        ; $ae8b: e1 2f     
            beq __ae70         ; $ae8d: f0 e1     
__ae8f:     and $07,x          ; $ae8f: 35 07     
            ora ($23,x)        ; $ae91: 01 23     
            sed                ; $ae93: f8        
            .hex 01            ; $ae94: 01        Suspected data
__ae95:     .hex 27 ff         ; $ae95: 27 ff     Invalid Opcode - RLA $ff
            ora ($2b,x)        ; $ae97: 01 2b     
            .hex 07 0c         ; $ae99: 07 0c     Invalid Opcode - SLO $0c
            cpy #$3d           ; $ae9b: c0 3d     
            .hex 02            ; $ae9d: 02        Invalid Opcode - KIL 
            sed                ; $ae9e: f8        
            cmp ($43,x)        ; $ae9f: c1 43     
            .hex ff c0 37      ; $aea1: ff c0 37  Invalid Opcode - ISC $37c0,x
            .hex 03 f0         ; $aea4: 03 f0     Invalid Opcode - SLO ($f0,x)
            cmp ($49,x)        ; $aea6: c1 49     
            .hex 07 e1         ; $aea8: 07 e1     Invalid Opcode - SLO $e1
            .hex 3f f8 e1      ; $aeaa: 3f f8 e1  Invalid Opcode - RLA __e1f8,x
            eor $ff            ; $aead: 45 ff     
            cpx #$39           ; $aeaf: e0 39     
            .hex 01            ; $aeb1: 01        Suspected data
__aeb2:     beq __ae95         ; $aeb2: f0 e1     
            .hex 4b 07         ; $aeb4: 4b 07     Invalid Opcode - ALR #$07
            ora ($3b,x)        ; $aeb6: 01 3b     
            beq __aebb         ; $aeb8: f0 01     
            .hex 41            ; $aeba: 41        Suspected data
__aebb:     sed                ; $aebb: f8        
            ora ($47,x)        ; $aebc: 01 47     
            .hex ff 01 4d      ; $aebe: ff 01 4d  Invalid Opcode - ISC $4d01,x
            .hex 07            ; $aec1: 07        Suspected data
__aec2:     .hex 02            ; $aec2: 02        Invalid Opcode - KIL 
            ldy #$4f           ; $aec3: a0 4f     
            brk                ; $aec5: 00        
            sed                ; $aec6: f8        
            lda ($51,x)        ; $aec7: a1 51     
            brk                ; $aec9: 00        
            .hex 04 20         ; $aeca: 04 20     Invalid Opcode - NOP $20
            .hex 73 00         ; $aecc: 73 00     Invalid Opcode - RRA ($00),y
            beq __aef1         ; $aece: f0 21     
            adc $f8,x          ; $aed0: 75 f8     
            and ($77,x)        ; $aed2: 21 77     
            brk                ; $aed4: 00        
            and ($79,x)        ; $aed5: 21 79     
__aed7:     php                ; $aed7: 08        
__aed8:     .hex 04 20         ; $aed8: 04 20     Invalid Opcode - NOP $20
            .hex 7b 00 f0      ; $aeda: 7b 00 f0  Invalid Opcode - RRA __f000,y
            and ($7d,x)        ; $aedd: 21 7d     
            sed                ; $aedf: f8        
            and ($7f,x)        ; $aee0: 21 7f     
            brk                ; $aee2: 00        
            and ($81,x)        ; $aee3: 21 81     
            php                ; $aee5: 08        
            asl $10            ; $aee6: 06 10     
            .hex 8b 01         ; $aee8: 8b 01     Invalid Opcode - XAA #$01
            sed                ; $aeea: f8        
            ora ($8d),y        ; $aeeb: 11 8d     
            brk                ; $aeed: 00        
            jsr $0083          ; $aeee: 20 83 00  
__aef1:     beq __af14         ; $aef1: f0 21     
            sta $f8            ; $aef3: 85 f8     
            and ($87,x)        ; $aef5: 21 87     
            brk                ; $aef7: 00        
            and ($89,x)        ; $aef8: 21 89     
            php                ; $aefa: 08        
            asl $10            ; $aefb: 06 10     
            .hex 97 01         ; $aefd: 97 01     Invalid Opcode - SAX $01,y
            sed                ; $aeff: f8        
            ora ($99),y        ; $af00: 11 99     
            brk                ; $af02: 00        
            jsr $008f          ; $af03: 20 8f 00  
            beq __af29         ; $af06: f0 21     
            sta ($f8),y        ; $af08: 91 f8     
            and ($93,x)        ; $af0a: 21 93     
            brk                ; $af0c: 00        
__af0d:     and ($95,x)        ; $af0d: 21 95     
            php                ; $af0f: 08        
            asl $10            ; $af10: 06 10     
__af12:     .hex a3 01         ; $af12: a3 01     Invalid Opcode - LAX ($01,x)
__af14:     sed                ; $af14: f8        
            ora ($a5),y        ; $af15: 11 a5     
            brk                ; $af17: 00        
            jsr $009b          ; $af18: 20 9b 00  
            beq __af3e         ; $af1b: f0 21     
            sta $21f8,x        ; $af1d: 9d f8 21  
            .hex 9f 00         ; $af20: 9f 00     Suspected data
__af22:     and ($a1,x)        ; $af22: 21 a1     
            php                ; $af24: 08        
            php                ; $af25: 08        
            bpl __aed7         ; $af26: 10 af     
            .hex 01            ; $af28: 01        Suspected data
__af29:     sed                ; $af29: f8        
            ora ($b1),y        ; $af2a: 11 b1     
            brk                ; $af2c: 00        
            and ($b3),y        ; $af2d: 31 b3     
            sed                ; $af2f: f8        
            and ($b5),y        ; $af30: 31 b5     
            brk                ; $af32: 00        
            jsr $00a7          ; $af33: 20 a7 00  
            beq __af59         ; $af36: f0 21     
            lda #$f8           ; $af38: a9 f8     
            and ($ab,x)        ; $af3a: 21 ab     
__af3c:     brk                ; $af3c: 00        
            .hex 21            ; $af3d: 21        Suspected data
__af3e:     lda $1408          ; $af3e: ad 08 14  
            ldy #$4f           ; $af41: a0 4f     
            brk                ; $af43: 00        
            sed                ; $af44: f8        
            lda ($51,x)        ; $af45: a1 51     
            brk                ; $af47: 00        
            cmp ($53,x)        ; $af48: c1 53     
            beq __af0d         ; $af4a: f0 c1     
            .hex 5b f8         ; $af4c: 5b f8     Suspected data
__af4e:     cmp ($63,x)        ; $af4e: c1 63     
            brk                ; $af50: 00        
            cmp ($6b,x)        ; $af51: c1 6b     
            php                ; $af53: 08        
            sbc ($b7,x)        ; $af54: e1 b7     
            inx                ; $af56: e8        
            sbc ($55,x)        ; $af57: e1 55     
__af59:     beq __af3c         ; $af59: f0 e1     
            eor __e1f8,x       ; $af5b: 5d f8 e1  
            adc $00            ; $af5e: 65 00     
            sbc ($6d,x)        ; $af60: e1 6d     
            php                ; $af62: 08        
            sbc ($b9,x)        ; $af63: e1 b9     
            bpl __af68         ; $af65: 10 01     
            .hex 57            ; $af67: 57        Suspected data
__af68:     beq __af6b         ; $af68: f0 01     
            .hex 5f            ; $af6a: 5f        Suspected data
__af6b:     sed                ; $af6b: f8        
            ora ($67,x)        ; $af6c: 01 67     
            brk                ; $af6e: 00        
            ora ($6f,x)        ; $af6f: 01 6f     
            php                ; $af71: 08        
            and ($59,x)        ; $af72: 21 59     
            beq __af97         ; $af74: f0 21     
            adc ($f8,x)        ; $af76: 61 f8     
            and ($69,x)        ; $af78: 21 69     
            brk                ; $af7a: 00        
            and ($71,x)        ; $af7b: 21 71     
            php                ; $af7d: 08        
            .hex 1c a0 a1      ; $af7e: 1c a0 a1  Invalid Opcode - NOP __a1a0,x
            .hex 03            ; $af81: 03        Suspected data
__af82:     sed                ; $af82: f8        
            lda ($a3,x)        ; $af83: a1 a3     
            brk                ; $af85: 00        
            cmp ($a5,x)        ; $af86: c1 a5     
            inx                ; $af88: e8        
            cmp ($a7,x)        ; $af89: c1 a7     
            beq __af4e         ; $af8b: f0 c1     
__af8d:     lda #$f8           ; $af8d: a9 f8     
            cmp ($ab,x)        ; $af8f: c1 ab     
__af91:     brk                ; $af91: 00        
__af92:     cmp ($ad,x)        ; $af92: c1 ad     
            php                ; $af94: 08        
            cpy #$a5           ; $af95: c0 a5     
__af97:     .hex 43 10         ; $af97: 43 10     Invalid Opcode - SRE ($10,x)
            cpx #$af           ; $af99: e0 af     
            .hex 03 e8         ; $af9b: 03 e8     Invalid Opcode - SLO ($e8,x)
            sbc ($b1,x)        ; $af9d: e1 b1     
            beq __af82         ; $af9f: f0 e1     
            .hex b3 f8         ; $afa1: b3 f8     Invalid Opcode - LAX ($f8),y
            sbc ($b5,x)        ; $afa3: e1 b5     
            brk                ; $afa5: 00        
            sbc ($b7,x)        ; $afa6: e1 b7     
            php                ; $afa8: 08        
            cpx #$af           ; $afa9: e0 af     
            .hex 43 10         ; $afab: 43 10     Invalid Opcode - SRE ($10,x)
            brk                ; $afad: 00        
            lda __e803,y       ; $afae: b9 03 e8  
            ora ($bb,x)        ; $afb1: 01 bb     
            beq __afb6         ; $afb3: f0 01     
            .hex bd            ; $afb5: bd        Suspected data
__afb6:     sed                ; $afb6: f8        
            ora ($bf,x)        ; $afb7: 01 bf     
            brk                ; $afb9: 00        
            ora ($bb,x)        ; $afba: 01 bb     
            php                ; $afbc: 08        
__afbd:     brk                ; $afbd: 00        
            lda $1043,y        ; $afbe: b9 43 10  
            jsr $03c1          ; $afc1: 20 c1 03  
            beq __afe7         ; $afc4: f0 21     
            .hex bb f8 21      ; $afc6: bb f8 21  Invalid Opcode - LAS $21f8,y
            .hex bb 00         ; $afc9: bb 00     Suspected data
__afcb:     jsr $43c1          ; $afcb: 20 c1 43  
            php                ; $afce: 08        
            rti                ; $afcf: 40        

;-------------------------------------------------------------------------------
            .hex c3 03         ; $afd0: c3 03     Invalid Opcode - DCP ($03,x)
            beq __b015         ; $afd2: f0 41     
            cmp $f8            ; $afd4: c5 f8     
            rti                ; $afd6: 40        

;-------------------------------------------------------------------------------
            cmp $43            ; $afd7: c5 43     
            brk                ; $afd9: 00        
            eor ($c3,x)        ; $afda: 41 c3     
            php                ; $afdc: 08        
            .hex 22            ; $afdd: 22        Invalid Opcode - KIL 
            ldy #$c9           ; $afde: a0 c9     
            .hex 43 e0         ; $afe0: 43 e0     Invalid Opcode - SRE ($e0,x)
            lda ($c7,x)        ; $afe2: a1 c7     
            inx                ; $afe4: e8        
            ldy #$a1           ; $afe5: a0 a1     
__afe7:     .hex 03 f8         ; $afe7: 03 f8     Invalid Opcode - SLO ($f8,x)
            lda ($a3,x)        ; $afe9: a1 a3     
            brk                ; $afeb: 00        
            lda ($c7,x)        ; $afec: a1 c7     
            bpl __af91         ; $afee: 10 a1     
            cmp #$18           ; $aff0: c9 18     
            cpy #$cf           ; $aff2: c0 cf     
            .hex 43 e0         ; $aff4: 43 e0     Invalid Opcode - SRE ($e0,x)
            cmp ($cd,x)        ; $aff6: c1 cd     
            inx                ; $aff8: e8        
            cmp ($cb,x)        ; $aff9: c1 cb     
            beq __afbd         ; $affb: f0 c0     
            lda #$03           ; $affd: a9 03     
            sed                ; $afff: f8        
            cmp ($ab,x)        ; $b000: c1 ab     
            brk                ; $b002: 00        
__b003:     cmp ($cb,x)        ; $b003: c1 cb     
            php                ; $b005: 08        
            cmp ($cd,x)        ; $b006: c1 cd     
            bpl __afcb         ; $b008: 10 c1     
            .hex cf 18 e0      ; $b00a: cf 18 e0  Invalid Opcode - DCP __e018
            cmp ($43),y        ; $b00d: d1 43     
            inx                ; $b00f: e8        
            cpx #$b1           ; $b010: e0 b1     
            .hex 03 f0         ; $b012: 03 f0     Invalid Opcode - SLO ($f0,x)
            .hex e1            ; $b014: e1        Suspected data
__b015:     .hex b3 f8         ; $b015: b3 f8     Invalid Opcode - LAX ($f8),y
            sbc ($b5,x)        ; $b017: e1 b5     
            brk                ; $b019: 00        
__b01a:     sbc ($b7,x)        ; $b01a: e1 b7     
            php                ; $b01c: 08        
            sbc ($d1,x)        ; $b01d: e1 d1     
            bpl __b021         ; $b01f: 10 00     
__b021:     .hex d3 43         ; $b021: d3 43     Invalid Opcode - DCP ($43),y
            inx                ; $b023: e8        
            brk                ; $b024: 00        
            .hex bb 03 f0      ; $b025: bb 03 f0  Invalid Opcode - LAS __f003,y
            ora ($bd,x)        ; $b028: 01 bd     
            sed                ; $b02a: f8        
            ora ($bf,x)        ; $b02b: 01 bf     
            brk                ; $b02d: 00        
            ora ($bb,x)        ; $b02e: 01 bb     
            php                ; $b030: 08        
            ora ($d3,x)        ; $b031: 01 d3     
            bpl __b055         ; $b033: 10 20     
            cmp ($03,x)        ; $b035: c1 03     
            beq __b05a         ; $b037: f0 21     
            .hex bb f8 21      ; $b039: bb f8 21  Invalid Opcode - LAS $21f8,y
            .hex bb 00 20      ; $b03c: bb 00 20  Invalid Opcode - LAS $2000,y
            cmp ($43,x)        ; $b03f: c1 43     
            php                ; $b041: 08        
            rti                ; $b042: 40        

;-------------------------------------------------------------------------------
            .hex c3 03         ; $b043: c3 03     Invalid Opcode - DCP ($03,x)
            beq __b088         ; $b045: f0 41     
            cmp $f8            ; $b047: c5 f8     
            rti                ; $b049: 40        

;-------------------------------------------------------------------------------
            cmp $43            ; $b04a: c5 43     
            brk                ; $b04c: 00        
            eor ($c3,x)        ; $b04d: 41 c3     
            php                ; $b04f: 08        
            .hex 02            ; $b050: 02        Invalid Opcode - KIL 
            cpx #$d5           ; $b051: e0 d5     
            brk                ; $b053: 00        
            .hex f0            ; $b054: f0        Suspected data
__b055:     sbc ($d7,x)        ; $b055: e1 d7     
            sed                ; $b057: f8        
            .hex 02            ; $b058: 02        Invalid Opcode - KIL 
            brk                ; $b059: 00        
__b05a:     sta __f000,x       ; $b05a: 9d 00 f0  
            ora ($9f,x)        ; $b05d: 01 9f     
            sed                ; $b05f: f8        
            .hex 02            ; $b060: 02        Invalid Opcode - KIL 
            brk                ; $b061: 00        
            .hex d7 c0         ; $b062: d7 c0     Invalid Opcode - DCP $c0,x
            brk                ; $b064: 00        
            ora ($d5,x)        ; $b065: 01 d5     
            php                ; $b067: 08        
            .hex 02            ; $b068: 02        Invalid Opcode - KIL 
            cpx #$9f           ; $b069: e0 9f     
            cpy #$00           ; $b06b: c0 00     
            sbc ($9d,x)        ; $b06d: e1 9d     
            php                ; $b06f: 08        
            asl                ; $b070: 0a        
            cpx #$83           ; $b071: e0 83     
            ora ($f0,x)        ; $b073: 01 f0     
            sbc ($87,x)        ; $b075: e1 87     
            sed                ; $b077: f8        
            ora ($85,x)        ; $b078: 01 85     
            beq __b07d         ; $b07a: f0 01     
            .hex 89            ; $b07c: 89        Suspected data
__b07d:     sed                ; $b07d: f8        
            sbc $81,x          ; $b07e: f5 81     
            inx                ; $b080: e8        
            cpx #$87           ; $b081: e0 87     
__b083:     eor ($00,x)        ; $b083: 41 00     
            sbc ($83,x)        ; $b085: e1 83     
            php                ; $b087: 08        
__b088:     ora ($89,x)        ; $b088: 01 89     
__b08a:     brk                ; $b08a: 00        
            ora ($85,x)        ; $b08b: 01 85     
            php                ; $b08d: 08        
            sbc $81,x          ; $b08e: f5 81     
            bpl __b01a         ; $b090: 10 88     
            .hex 9c b0 8b      ; $b092: 9c b0 8b  Invalid Opcode - SHY __8bb0,x
            .hex 8f 8d 91      ; $b095: 8f 8d 91  Invalid Opcode - SAX __918d
            .hex 8f 8b 91      ; $b098: 8f 8b 91  Invalid Opcode - SAX __918b
            sta __e00a         ; $b09b: 8d 0a e0  
            sta $01,x          ; $b09e: 95 01     
            beq __b083         ; $b0a0: f0 e1     
            .hex 97 f8         ; $b0a2: 97 f8     Invalid Opcode - SAX $f8,y
            ora ($99,x)        ; $b0a4: 01 99     
            beq __b0a9         ; $b0a6: f0 01     
            .hex 9b            ; $b0a8: 9b        Invalid Opcode - TAS 
__b0a9:     sed                ; $b0a9: f8        
            cpx #$97           ; $b0aa: e0 97     
            eor ($00,x)        ; $b0ac: 41 00     
            sbc ($95,x)        ; $b0ae: e1 95     
__b0b0:     php                ; $b0b0: 08        
            ora ($9b,x)        ; $b0b1: 01 9b     
            brk                ; $b0b3: 00        
            ora ($99,x)        ; $b0b4: 01 99     
            php                ; $b0b6: 08        
            cmp ($93,x)        ; $b0b7: c1 93     
            brk                ; $b0b9: 00        
            cpy #$93           ; $b0ba: c0 93     
            ora ($f8,x)        ; $b0bc: 01 f8     
            .hex 82 79         ; $b0be: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b0c0: b2        Invalid Opcode - KIL 
            .hex 6b 6d         ; $b0c1: 6b 6d     Invalid Opcode - ARR #$6d
            .hex 14 c0         ; $b0c3: 14 c0     Invalid Opcode - NOP $c0,x
            .hex 83 01         ; $b0c5: 83 01     Invalid Opcode - SAX ($01,x)
            beq __b08a         ; $b0c7: f0 c1     
            .hex 87 f8         ; $b0c9: 87 f8     Invalid Opcode - SAX $f8
            sbc ($85,x)        ; $b0cb: e1 85     
            beq __b0b0         ; $b0cd: f0 e1     
            .hex 89 f8         ; $b0cf: 89 f8     Invalid Opcode - NOP #$f8
            cmp $81,x          ; $b0d1: d5 81     
            inx                ; $b0d3: e8        
            cpy #$87           ; $b0d4: c0 87     
            eor ($00,x)        ; $b0d6: 41 00     
            cmp ($83,x)        ; $b0d8: c1 83     
            php                ; $b0da: 08        
            sbc ($89,x)        ; $b0db: e1 89     
            brk                ; $b0dd: 00        
            sbc ($85,x)        ; $b0de: e1 85     
            php                ; $b0e0: 08        
            cmp $81,x          ; $b0e1: d5 81     
__b0e3:     .hex 10            ; $b0e3: 10        Suspected data
__b0e4:     brk                ; $b0e4: 00        
            sta $81            ; $b0e5: 85 81     
            beq __b0ea         ; $b0e7: f0 01     
            .hex 89            ; $b0e9: 89        Suspected data
__b0ea:     sed                ; $b0ea: f8        
            and ($83,x)        ; $b0eb: 21 83     
            beq __b110         ; $b0ed: f0 21     
            .hex 87 f8         ; $b0ef: 87 f8     Invalid Opcode - SAX $f8
            ora $81,x          ; $b0f1: 15 81     
            inx                ; $b0f3: e8        
            brk                ; $b0f4: 00        
            .hex 89 c1         ; $b0f5: 89 c1     Invalid Opcode - NOP #$c1
            brk                ; $b0f7: 00        
            ora ($85,x)        ; $b0f8: 01 85     
            php                ; $b0fa: 08        
            and ($87,x)        ; $b0fb: 21 87     
            brk                ; $b0fd: 00        
            and ($83,x)        ; $b0fe: 21 83     
            php                ; $b100: 08        
            .hex 15            ; $b101: 15        Suspected data
__b102:     .hex 81            ; $b102: 81        Suspected data
__b103:     .hex 10            ; $b103: 10        Suspected data
__b104:     bcc __b11d         ; $b104: 90 17     
            lda ($8b),y        ; $b106: b1 8b     
            .hex 8f 8d 91      ; $b108: 8f 8d 91  Invalid Opcode - SAX __918d
            .hex 8f 8b 91      ; $b10b: 8f 8b 91  Invalid Opcode - SAX __918b
            .hex 8d 8d         ; $b10e: 8d 8d     Suspected data
__b110:     sta ($8b),y        ; $b110: 91 8b     
            .hex 8f 91 8d      ; $b112: 8f 91 8d  Invalid Opcode - SAX __8d91
            .hex 8f 8b 14      ; $b115: 8f 8b 14  Invalid Opcode - SAX $148b
            cpy #$95           ; $b118: c0 95     
            ora ($f0,x)        ; $b11a: 01 f0     
            .hex c1            ; $b11c: c1        Suspected data
__b11d:     .hex 97 f8         ; $b11d: 97 f8     Invalid Opcode - SAX $f8,y
            sbc ($99,x)        ; $b11f: e1 99     
            beq __b104         ; $b121: f0 e1     
            .hex 9b            ; $b123: 9b        Invalid Opcode - TAS 
            sed                ; $b124: f8        
            cpy #$97           ; $b125: c0 97     
            eor ($00,x)        ; $b127: 41 00     
            cmp ($95,x)        ; $b129: c1 95     
            php                ; $b12b: 08        
            sbc ($9b,x)        ; $b12c: e1 9b     
            brk                ; $b12e: 00        
            sbc ($99,x)        ; $b12f: e1 99     
            php                ; $b131: 08        
            brk                ; $b132: 00        
            sta __f081,y       ; $b133: 99 81 f0  
            ora ($9b,x)        ; $b136: 01 9b     
            sed                ; $b138: f8        
            and ($95,x)        ; $b139: 21 95     
            beq __b15e         ; $b13b: f0 21     
            .hex 97 f8         ; $b13d: 97 f8     Invalid Opcode - SAX $f8,y
            brk                ; $b13f: 00        
            .hex 9b            ; $b140: 9b        Invalid Opcode - TAS 
            cmp ($00,x)        ; $b141: c1 00     
            ora ($99,x)        ; $b143: 01 99     
            php                ; $b145: 08        
            and ($97,x)        ; $b146: 21 97     
            brk                ; $b148: 00        
            and ($95,x)        ; $b149: 21 95     
            php                ; $b14b: 08        
            eor ($93,x)        ; $b14c: 41 93     
            brk                ; $b14e: 00        
            ldy #$93           ; $b14f: a0 93     
            ora ($f8,x)        ; $b151: 01 f8     
            ldy #$93           ; $b153: a0 93     
__b155:     eor ($00,x)        ; $b155: 41 00     
            rti                ; $b157: 40        

;-------------------------------------------------------------------------------
            .hex 93 81         ; $b158: 93 81     Invalid Opcode - AHX ($81),y
            sed                ; $b15a: f8        
            ora ($f0,x)        ; $b15b: 01 f0     
            .hex 9c            ; $b15d: 9c        Suspected data
__b15e:     brk                ; $b15e: 00        
            sed                ; $b15f: f8        
            brk                ; $b160: 00        
            ora $e2            ; $b161: 05 e2     
            .hex 03 00         ; $b163: 03 00     Invalid Opcode - SLO ($00,x)
            sed                ; $b165: f8        
            .hex e3 05         ; $b166: e3 05     Invalid Opcode - ISC ($05,x)
            brk                ; $b168: 00        
            .hex 03 07         ; $b169: 03 07     Invalid Opcode - SLO ($07,x)
            sed                ; $b16b: f8        
            .hex 03 09         ; $b16c: 03 09     Invalid Opcode - SLO ($09,x)
            brk                ; $b16e: 00        
            .hex eb 55         ; $b16f: eb 55     Invalid Opcode - SBC #$55
            .hex f2            ; $b171: f2        Invalid Opcode - KIL 
            sty $61            ; $b172: 84 61     
            lda ($03),y        ; $b174: b1 03     
            ora $07            ; $b176: 05 07     
            ora #$84           ; $b178: 09 84     
            adc ($b1,x)        ; $b17a: 61 b1     
            .hex 0b 0d         ; $b17c: 0b 0d     Invalid Opcode - ANC #$0d
            .hex 0f 11 84      ; $b17e: 0f 11 84  Invalid Opcode - SLO __8411
            adc ($b1,x)        ; $b181: 61 b1     
            .hex 13 15         ; $b183: 13 15     Invalid Opcode - SLO ($15),y
            .hex 17            ; $b185: 17        Suspected data
__b186:     ora __e805,y       ; $b186: 19 05 e8  
            .hex 03 00         ; $b189: 03 00     Invalid Opcode - SLO ($00,x)
            sed                ; $b18b: f8        
            sbc #$05           ; $b18c: e9 05     
            brk                ; $b18e: 00        
            ora #$1b           ; $b18f: 09 1b     
            sed                ; $b191: f8        
            ora #$1d           ; $b192: 09 1d     
            brk                ; $b194: 00        
            sbc ($55),y        ; $b195: f1 55     
            .hex f2            ; $b197: f2        Invalid Opcode - KIL 
            sty $87            ; $b198: 84 87     
            lda ($03),y        ; $b19a: b1 03     
            ora $1b            ; $b19c: 05 1b     
            ora __e004,x       ; $b19e: 1d 04 e0  
            .hex 13 00         ; $b1a1: 13 00     Invalid Opcode - SLO ($00),y
            sed                ; $b1a3: f8        
            sbc ($15,x)        ; $b1a4: e1 15     
            brk                ; $b1a6: 00        
            ora ($1f,x)        ; $b1a7: 01 1f     
            sed                ; $b1a9: f8        
            ora ($1d,x)        ; $b1aa: 01 1d     
            brk                ; $b1ac: 00        
            sty $9f            ; $b1ad: 84 9f     
            lda ($13),y        ; $b1af: b1 13     
            ora $21,x          ; $b1b1: 15 21     
            .hex 23 83         ; $b1b3: 23 83     Invalid Opcode - RLA ($83,x)
__b1b5:     cpy #$b1           ; $b1b5: c0 b1     
            and $1f            ; $b1b7: 25 1f     
            ora __c083,x       ; $b1b9: 1d 83 c0  
            lda ($2d),y        ; $b1bc: b1 2d     
            .hex 1f 1d 05      ; $b1be: 1f 1d 05  Invalid Opcode - SLO $051d,x
            cpx #$35           ; $b1c1: e0 35     
            brk                ; $b1c3: 00        
            brk                ; $b1c4: 00        
            ora ($1f,x)        ; $b1c5: 01 1f     
            sed                ; $b1c7: f8        
            ora ($1d,x)        ; $b1c8: 01 1d     
            brk                ; $b1ca: 00        
            sbc ($33,x)        ; $b1cb: e1 33     
            sed                ; $b1cd: f8        
            sbc ($37,x)        ; $b1ce: e1 37     
            beq __b155         ; $b1d0: f0 83     
            cpy #$b1           ; $b1d2: c0 b1     
            and $21            ; $b1d4: 25 21     
            .hex 23 83         ; $b1d6: 23 83     Invalid Opcode - RLA ($83,x)
            cpy #$b1           ; $b1d8: c0 b1     
            .hex 2d            ; $b1da: 2d        Suspected data
__b1db:     and ($23,x)        ; $b1db: 21 23     
            sta $c0            ; $b1dd: 85 c0     
            lda ($35),y        ; $b1df: b1 35     
            and ($23,x)        ; $b1e1: 21 23     
            .hex 33            ; $b1e3: 33        Suspected data
__b1e4:     .hex 37 83         ; $b1e4: 37 83     Invalid Opcode - RLA $83,x
            sbc ($b1),y        ; $b1e6: f1 b1     
            and $07            ; $b1e8: 25 07     
            ora #$83           ; $b1ea: 09 83     
            sbc ($b1),y        ; $b1ec: f1 b1     
            and $0907          ; $b1ee: 2d 07 09  
            ora $e2            ; $b1f1: 05 e2     
            and $00,x          ; $b1f3: 35 00     
            brk                ; $b1f5: 00        
            .hex 03 07         ; $b1f6: 03 07     Invalid Opcode - SLO ($07,x)
            sed                ; $b1f8: f8        
            .hex 03 09         ; $b1f9: 03 09     Invalid Opcode - SLO ($09,x)
            brk                ; $b1fb: 00        
            .hex e3 33         ; $b1fc: e3 33     Invalid Opcode - ISC ($33,x)
            sed                ; $b1fe: f8        
            .hex e3 37         ; $b1ff: e3 37     Invalid Opcode - ISC ($37,x)
            beq __b186         ; $b201: f0 83     
            asl $25b2          ; $b203: 0e b2 25  
            .hex 1b 1d 83      ; $b206: 1b 1d 83  Invalid Opcode - SLO __831d,y
            asl $2db2          ; $b209: 0e b2 2d  
            .hex 1b 1d 05      ; $b20c: 1b 1d 05  Invalid Opcode - SLO $051d,y
            inx                ; $b20f: e8        
            and $00,x          ; $b210: 35 00     
            brk                ; $b212: 00        
            ora #$1b           ; $b213: 09 1b     
            sed                ; $b215: f8        
            ora #$1d           ; $b216: 09 1d     
            brk                ; $b218: 00        
            sbc #$33           ; $b219: e9 33     
            sed                ; $b21b: f8        
            sbc #$37           ; $b21c: e9 37     
            beq __b224         ; $b21e: f0 04     
            .hex da            ; $b220: da        Invalid Opcode - NOP 
            lda ($03),y        ; $b221: b1 03     
            sed                ; $b223: f8        
__b224:     .hex db b3 00      ; $b224: db b3 00  Invalid Opcode - DCP $00b3,y
            .hex fb b5 f8      ; $b227: fb b5 f8  Invalid Opcode - ISC __f8b5,y
            .hex fb b7 00      ; $b22a: fb b7 00  Invalid Opcode - ISC $00b7,y
            .hex 04 dc         ; $b22d: 04 dc     Invalid Opcode - NOP $dc
            lda ($03),y        ; $b22f: b1 03     
            sed                ; $b231: f8        
            .hex dd b3 00      ; $b232: dd b3 00  Bad Addr Mode - CMP $00b3,x
            .hex fb b9 f8      ; $b235: fb b9 f8  Invalid Opcode - ISC __f8b9,y
            .hex fb bb 00      ; $b238: fb bb 00  Invalid Opcode - ISC $00bb,y
            sty $1f            ; $b23b: 84 1f     
            .hex b2            ; $b23d: b2        Invalid Opcode - KIL 
            .hex 6f 71 73      ; $b23e: 6f 71 73  Invalid Opcode - RRA $7371
            adc $84,x          ; $b241: 75 84     
            and $6fb2          ; $b243: 2d b2 6f  
            adc ($77),y        ; $b246: 71 77     
            adc __f002,y       ; $b248: 79 02 f0  
            .hex 8b 02         ; $b24b: 8b 02     Invalid Opcode - XAA #$02
            sed                ; $b24d: f8        
            beq __b1db         ; $b24e: f0 8b     
            .hex 42            ; $b250: 42        Invalid Opcode - KIL 
            brk                ; $b251: 00        
            .hex 82 49         ; $b252: 82 49     Invalid Opcode - NOP #$49
            .hex b2            ; $b254: b2        Invalid Opcode - KIL 
            .hex bf bf 81      ; $b255: bf bf 81  Invalid Opcode - LAX __81bf,y
            ror $b2            ; $b258: 66 b2     
            .hex 8f 82 66      ; $b25a: 8f 82 66  Invalid Opcode - SAX $6682
            .hex b2            ; $b25d: b2        Invalid Opcode - KIL 
            .hex 8f 8f 83      ; $b25e: 8f 8f 83  Invalid Opcode - SAX __838f
__b261:     ror $b2            ; $b261: 66 b2     
            .hex 8f 8f 8f      ; $b263: 8f 8f 8f  Invalid Opcode - SAX __8f8f
            .hex 04 f0         ; $b266: 04 f0     Invalid Opcode - NOP $f0
            .hex 8f 02 f8      ; $b268: 8f 02 f8  Invalid Opcode - SAX __f802
            ora ($8f),y        ; $b26b: 11 8f     
            sed                ; $b26d: f8        
            and ($8f),y        ; $b26e: 31 8f     
            sed                ; $b270: f8        
            eor ($8f),y        ; $b271: 51 8f     
            sed                ; $b273: f8        
            ora ($e8,x)        ; $b274: 01 e8     
            .hex 7b 01 fc      ; $b276: 7b 01 fc  Invalid Opcode - RRA __fc01,y
            .hex 02            ; $b279: 02        Invalid Opcode - KIL 
            beq __b2d5         ; $b27a: f0 59     
            brk                ; $b27c: 00        
            sed                ; $b27d: f8        
            sbc ($5b),y        ; $b27e: f1 5b     
            brk                ; $b280: 00        
            sta ($74,x)        ; $b281: 81 74     
            .hex b2            ; $b283: b2        Invalid Opcode - KIL 
            lsr $01,x          ; $b284: 56 01     
            inx                ; $b286: e8        
            adc __fc03,x       ; $b287: 7d 03 fc  
            sta ($74,x)        ; $b28a: 81 74     
            .hex b2            ; $b28c: b2        Invalid Opcode - KIL 
            jmp (__9483)       ; $b28d: 6c 83 94  

;-------------------------------------------------------------------------------
            .hex b2            ; $b290: b2        Invalid Opcode - KIL 
            eor #$27           ; $b291: 49 27     
            .hex 2b 03         ; $b293: 2b 03     Invalid Opcode - ANC #$03
            beq __b2c0         ; $b295: f0 29     
            brk                ; $b297: 00        
            brk                ; $b298: 00        
            sbc ($27,x)        ; $b299: e1 27     
            sed                ; $b29b: f8        
            ora ($2b),y        ; $b29c: 11 2b     
            brk                ; $b29e: 00        
            .hex 82 b8         ; $b29f: 82 b8     Invalid Opcode - NOP #$b8
            .hex b2            ; $b2a1: b2        Invalid Opcode - KIL 
            .hex 2f 31 82      ; $b2a2: 2f 31 82  Invalid Opcode - RLA __8231
            iny                ; $b2a5: c8        
            .hex b2            ; $b2a6: b2        Invalid Opcode - KIL 
            and __8239,y       ; $b2a7: 39 39 82  
            iny                ; $b2aa: c8        
            .hex b2            ; $b2ab: b2        Invalid Opcode - KIL 
            .hex 3b 39 82      ; $b2ac: 3b 39 82  Invalid Opcode - RLA __8239,y
            clv                ; $b2af: b8        
            .hex b2            ; $b2b0: b2        Invalid Opcode - KIL 
            .hex 2f 4d 82      ; $b2b1: 2f 4d 82  Invalid Opcode - RLA __824d
            iny                ; $b2b4: c8        
            .hex b2            ; $b2b5: b2        Invalid Opcode - KIL 
            .hex 53 53         ; $b2b6: 53 53     Invalid Opcode - SRE ($53),y
            .hex 03 e0         ; $b2b8: 03 e0     Invalid Opcode - SLO ($e0,x)
            .hex 27 00         ; $b2ba: 27 00     Invalid Opcode - RLA $00
            sed                ; $b2bc: f8        
            sbc ($49),y        ; $b2bd: f1 49     
            brk                ; $b2bf: 00        
__b2c0:     ora ($4b),y        ; $b2c0: 11 4b     
            brk                ; $b2c2: 00        
            .hex 82 b8         ; $b2c3: 82 b8     Invalid Opcode - NOP #$b8
            .hex b2            ; $b2c5: b2        Invalid Opcode - KIL 
            .hex 2f 4f 03      ; $b2c6: 2f 4f 03  Invalid Opcode - RLA $034f
            cpx #$53           ; $b2c9: e0 53     
            brk                ; $b2cb: 00        
            sed                ; $b2cc: f8        
            sbc ($53,x)        ; $b2cd: e1 53     
            brk                ; $b2cf: 00        
            sbc ($51,x)        ; $b2d0: e1 51     
            beq __b2d7         ; $b2d2: f0 03     
            .hex e0            ; $b2d4: e0        Suspected data
__b2d5:     .hex 5f 01         ; $b2d5: 5f 01     Suspected data
__b2d7:     brk                ; $b2d7: 00        
            sbc ($5f,x)        ; $b2d8: e1 5f     
            sed                ; $b2da: f8        
            sbc ($5d,x)        ; $b2db: e1 5d     
            beq __b261         ; $b2dd: f0 82     
            .hex d3 b2         ; $b2df: d3 b2     Invalid Opcode - DCP ($b2),y
__b2e1:     .hex 5f 5f         ; $b2e1: 5f 5f     Suspected data
__b2e3:     sty $9f            ; $b2e3: 84 9f     
            lda ($3d),y        ; $b2e5: b1 3d     
            .hex 3f 1f 1d      ; $b2e7: 3f 1f 1d  Invalid Opcode - RLA $1d1f,x
            .hex 04 f0         ; $b2ea: 04 f0     Invalid Opcode - NOP $f0
            eor ($00,x)        ; $b2ec: 41 00     
            beq __b2e1         ; $b2ee: f0 f1     
            .hex 43 f8         ; $b2f0: 43 f8     Invalid Opcode - SRE ($f8,x)
            sbc ($45),y        ; $b2f2: f1 45     
            brk                ; $b2f4: 00        
            sbc ($47),y        ; $b2f5: f1 47     
            php                ; $b2f7: 08        
            .hex 02            ; $b2f8: 02        Invalid Opcode - KIL 
            beq __b358         ; $b2f9: f0 5d     
            ora ($f9,x)        ; $b2fb: 01 f9     
            beq __b35c         ; $b2fd: f0 5d     
            eor ($fb,x)        ; $b2ff: 41 fb     
            .hex 02            ; $b301: 02        Invalid Opcode - KIL 
            beq __b363         ; $b302: f0 5f     
            eor ($f9,x)        ; $b304: 41 f9     
            .hex f0            ; $b306: f0        Suspected data
__b307:     .hex 5f 01 fb      ; $b307: 5f 01 fb  Invalid Opcode - SRE __fb01,x
            .hex 04 e8         ; $b30a: 04 e8     Invalid Opcode - NOP $e8
            eor __f941,x       ; $b30c: 5d 41 f9  
            sbc __f95d,y       ; $b30f: f9 5d f9  
            inx                ; $b312: e8        
            eor __fb01,x       ; $b313: 5d 01 fb  
            sbc __fb5d,y       ; $b316: f9 5d fb  
            asl $e0            ; $b319: 06 e0     
            eor __f901,x       ; $b31b: 5d 01 f9  
            sbc ($5d),y        ; $b31e: f1 5d     
            sbc $5d01,y        ; $b320: f9 01 5d  
            sbc $5de0,y        ; $b323: f9 e0 5d  
            eor ($fb,x)        ; $b326: 41 fb     
            sbc ($5d),y        ; $b328: f1 5d     
            .hex fb 01 5d      ; $b32a: fb 01 5d  Invalid Opcode - ISC $5d01,y
            .hex fb 06 d8      ; $b32d: fb 06 d8  Invalid Opcode - ISC __d806,y
            eor __f941,x       ; $b330: 5d 41 f9  
            sbc ($5d),y        ; $b333: f1 5d     
            sbc $5d09,y        ; $b335: f9 09 5d  
            sbc $5dd8,y        ; $b338: f9 d8 5d  
            ora ($fb,x)        ; $b33b: 01 fb     
            sbc ($5d),y        ; $b33d: f1 5d     
            .hex fb 09 5d      ; $b33f: fb 09 5d  Invalid Opcode - ISC $5d09,y
            .hex fb 0a d0      ; $b342: fb 0a d0  Invalid Opcode - ISC __d00a,y
            eor __f901,x       ; $b345: 5d 01 f9  
            sbc ($5d,x)        ; $b348: e1 5d     
            sbc $5df1,y        ; $b34a: f9 f1 5d  
            .hex f9            ; $b34d: f9        Suspected data
__b34e:     ora ($5d,x)        ; $b34e: 01 5d     
            .hex f9 09         ; $b350: f9 09     Suspected data
__b352:     eor __d0f9,x       ; $b352: 5d f9 d0  
__b355:     eor __fb41,x       ; $b355: 5d 41 fb  
__b358:     sbc ($5d,x)        ; $b358: e1 5d     
            .hex fb f1         ; $b35a: fb f1     Suspected data
__b35c:     eor $01fb,x        ; $b35c: 5d fb 01  
            eor $09fb,x        ; $b35f: 5d fb 09  
            .hex 5d            ; $b362: 5d        Suspected data
__b363:     .hex fb 81 74      ; $b363: fb 81 74  Invalid Opcode - ISC $7481,y
            .hex b2            ; $b366: b2        Invalid Opcode - KIL 
            rts                ; $b367: 60        

;-------------------------------------------------------------------------------
            ora ($e8,x)        ; $b368: 01 e8     
            .hex 57 00         ; $b36a: 57 00     Invalid Opcode - SRE $00,x
            .hex fc 02 f0      ; $b36c: fc 02 f0  Invalid Opcode - NOP __f002,x
            .hex 57 00         ; $b36f: 57 00     Invalid Opcode - SRE $00,x
            sed                ; $b371: f8        
            beq __b3cb         ; $b372: f0 57     
            rti                ; $b374: 40        

;-------------------------------------------------------------------------------
            brk                ; $b375: 00        
            .hex 04            ; $b376: 04        Suspected data
__b377:     .hex fa            ; $b377: fa        Invalid Opcode - NOP 
            inc $03,x          ; $b378: f6 03     
            beq __b377         ; $b37a: f0 fb     
            sed                ; $b37c: f8        
            sed                ; $b37d: f8        
            .hex fb f6 ff      ; $b37e: fb f6 ff  Invalid Opcode - ISC __fff6,y
            .hex fb f8 07      ; $b381: fb f8 07  Invalid Opcode - ISC $07f8,y
            .hex 04 fa         ; $b384: 04 fa     Invalid Opcode - NOP $fa
            inc $03,x          ; $b386: f6 03     
            sed                ; $b388: f8        
            .hex fb f8 00      ; $b389: fb f8 00  Invalid Opcode - ISC $00f8,y
            .hex 1b f6 f8      ; $b38c: 1b f6 f8  Invalid Opcode - SLO __f8f6,y
            .hex 1b f8 00      ; $b38f: 1b f8 00  Invalid Opcode - SLO $00f8,y
            .hex 82 84         ; $b392: 82 84     Invalid Opcode - NOP #$84
            .hex b3 f6         ; $b394: b3 f6     Invalid Opcode - LAX ($f6),y
            sed                ; $b396: f8        
            ora ($fa,x)        ; $b397: 01 fa     
            adc #$00           ; $b399: 69 00     
            brk                ; $b39b: 00        
            .hex 82 79         ; $b39c: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b39e: b2        Invalid Opcode - KIL 
            ror                ; $b39f: 6a        
            .hex 67 02         ; $b3a0: 67 02     Invalid Opcode - RRA $02
            inc __806a         ; $b3a2: ee 6a 80  
            sed                ; $b3a5: f8        
            .hex ef 67 00      ; $b3a6: ef 67 00  Bad Addr Mode - ISC $0067
            .hex 02            ; $b3a9: 02        Invalid Opcode - KIL 
            inc __c06a         ; $b3aa: ee 6a c0  
            ora ($ef,x)        ; $b3ad: 01 ef     
            .hex 67 f9         ; $b3af: 67 f9     Invalid Opcode - RRA $f9
            .hex 02            ; $b3b1: 02        Invalid Opcode - KIL 
            beq __b41e         ; $b3b2: f0 6a     
            rti                ; $b3b4: 40        

;-------------------------------------------------------------------------------
            ora ($f1,x)        ; $b3b5: 01 f1     
            .hex 67 f9         ; $b3b7: 67 f9     Invalid Opcode - RRA $f9
            .hex 82 79         ; $b3b9: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b3bb: b2        Invalid Opcode - KIL 
            .hex 42            ; $b3bc: 42        Invalid Opcode - KIL 
            .hex 44 02         ; $b3bd: 44 02     Invalid Opcode - NOP $02
            beq __b34e         ; $b3bf: f0 8d     
            .hex 03 f8         ; $b3c1: 03 f8     Invalid Opcode - SLO ($f8,x)
            beq __b352         ; $b3c3: f0 8d     
            .hex c3 00         ; $b3c5: c3 00     Invalid Opcode - DCP ($00,x)
            ora ($00,x)        ; $b3c7: 01 00     
            .hex 2b 00         ; $b3c9: 2b 00     Invalid Opcode - ANC #$00
__b3cb:     brk                ; $b3cb: 00        
            ora ($00,x)        ; $b3cc: 01 00     
            rol $01            ; $b3ce: 26 01     
            brk                ; $b3d0: 00        
            .hex 02            ; $b3d1: 02        Invalid Opcode - KIL 
            beq __b355         ; $b3d2: f0 81     
            .hex 03 f8         ; $b3d4: 03 f8     Invalid Opcode - SLO ($f8,x)
            sbc ($83),y        ; $b3d6: f1 83     
            brk                ; $b3d8: 00        
            .hex 82 d1         ; $b3d9: 82 d1     Invalid Opcode - NOP #$d1
            .hex b3 85         ; $b3db: b3 85     Invalid Opcode - LAX ($85),y
            .hex 87 02         ; $b3dd: 87 02     Invalid Opcode - SAX $02
            .hex fc 89 03      ; $b3df: fc 89 03  Invalid Opcode - NOP $0389,x
            sed                ; $b3e2: f8        
            .hex fd 8b 00      ; $b3e3: fd 8b 00  Bad Addr Mode - SBC $008b,x
            sty $1f            ; $b3e6: 84 1f     
            ldy $d1,x          ; $b3e8: b4 d1     
            .hex d3 d5         ; $b3ea: d3 d5     Invalid Opcode - DCP ($d5),y
            .hex d7 04         ; $b3ec: d7 04     Invalid Opcode - DCP $04,x
            .hex dc d9 02      ; $b3ee: dc d9 02  Invalid Opcode - NOP $02d9,x
            sed                ; $b3f1: f8        
            .hex dd db 00      ; $b3f2: dd db 00  Bad Addr Mode - CMP $00db,x
            .hex fb d5 f8      ; $b3f5: fb d5 f8  Invalid Opcode - ISC __f8d5,y
            .hex fb d7 00      ; $b3f8: fb d7 00  Invalid Opcode - ISC $00d7,y
            .hex 03 da         ; $b3fb: 03 da     Invalid Opcode - SLO ($da,x)
            sbc ($00,x)        ; $b3fd: e1 00     
            .hex fc fb e3      ; $b3ff: fc fb e3  Invalid Opcode - NOP __e3fb,x
            .hex fc fb e5      ; $b402: fc fb e5  Invalid Opcode - NOP __e5fb,x
            .hex 04 03         ; $b405: 04 03     Invalid Opcode - NOP $03
            .hex dc e1 00      ; $b407: dc e1 00  Bad Addr Mode - NOP $00e1,x
            .hex fc fb e7      ; $b40a: fc fb e7  Invalid Opcode - NOP __e7fb,x
            .hex fc fb e9      ; $b40d: fc fb e9  Invalid Opcode - NOP __e9fb,x
            .hex 04 84         ; $b410: 04 84     Invalid Opcode - NOP $84
            .hex 1f b2 91      ; $b412: 1f b2 91  Invalid Opcode - SLO __91b2,x
            .hex 93 95         ; $b415: 93 95     Invalid Opcode - AHX ($95),y
            .hex 97 84         ; $b417: 97 84     Invalid Opcode - SAX $84,y
            .hex 1f b2 99      ; $b419: 1f b2 99  Invalid Opcode - SLO __99b2,x
            .hex 9b            ; $b41c: 9b        Invalid Opcode - TAS 
            .hex 9d            ; $b41d: 9d        Suspected data
__b41e:     .hex 9f 04 da      ; $b41e: 9f 04 da  Invalid Opcode - AHX __da04,y
            cmp ($02,x)        ; $b421: c1 02     
            sed                ; $b423: f8        
            .hex db c3 00      ; $b424: db c3 00  Invalid Opcode - DCP $00c3,y
            .hex fb c5 f8      ; $b427: fb c5 f8  Invalid Opcode - ISC __f8c5,y
            .hex fb c7 00      ; $b42a: fb c7 00  Invalid Opcode - ISC $00c7,y
            sty $1f            ; $b42d: 84 1f     
            ldy $c9,x          ; $b42f: b4 c9     
            .hex cb cd         ; $b431: cb cd     Invalid Opcode - AXS #$cd
            .hex cf 84 1f      ; $b433: cf 84 1f  Invalid Opcode - DCP $1f84
            ldy $a1,x          ; $b436: b4 a1     
            .hex a3 a5         ; $b438: a3 a5     Invalid Opcode - LAX ($a5,x)
            .hex a7 84         ; $b43a: a7 84     Invalid Opcode - LAX $84
            .hex 1f b4 a9      ; $b43c: 1f b4 a9  Invalid Opcode - SLO __a9b4,x
            .hex ab ad         ; $b43f: ab ad     Invalid Opcode - LAX #$ad
            .hex af 84 1f      ; $b441: af 84 1f  Invalid Opcode - LAX $1f84
            .hex b2            ; $b444: b2        Invalid Opcode - KIL 
            lda ($b3),y        ; $b445: b1 b3     
            lda $b7,x          ; $b447: b5 b7     
            sty $1f            ; $b449: 84 1f     
            .hex b2            ; $b44b: b2        Invalid Opcode - KIL 
            lda __bdbb,y       ; $b44c: b9 bb bd  
            .hex bf 04 da      ; $b44f: bf 04 da  Invalid Opcode - LAX __da04,y
            sta __f800         ; $b452: 8d 00 f8  
            .hex db 8f 00      ; $b455: db 8f 00  Invalid Opcode - DCP $008f,y
            .hex fb dd f8      ; $b458: fb dd f8  Invalid Opcode - ISC __f8dd,y
            .hex fb df 00      ; $b45b: fb df 00  Invalid Opcode - ISC $00df,y
            .hex 04 e0         ; $b45e: 04 e0     Invalid Opcode - NOP $e0
            cmp ($02),y        ; $b460: d1 02     
            sed                ; $b462: f8        
            sbc ($d3,x)        ; $b463: e1 d3     
            brk                ; $b465: 00        
            ora ($d5,x)        ; $b466: 01 d5     
            sed                ; $b468: f8        
            ora ($d7,x)        ; $b469: 01 d7     
            brk                ; $b46b: 00        
            .hex 04 e2         ; $b46c: 04 e2     Invalid Opcode - NOP $e2
            cmp ($02),y        ; $b46e: d1 02     
            sed                ; $b470: f8        
            .hex e3 d3         ; $b471: e3 d3     Invalid Opcode - ISC ($d3,x)
            brk                ; $b473: 00        
            ora ($d9,x)        ; $b474: 01 d9     
            sed                ; $b476: f8        
            ora ($db,x)        ; $b477: 01 db     
            brk                ; $b479: 00        
            asl $da            ; $b47a: 06 da     
            cmp ($02,x)        ; $b47c: c1 02     
            .hex f4 db         ; $b47e: f4 db     Invalid Opcode - NOP $db,x
            .hex c3 fc         ; $b480: c3 fc     Invalid Opcode - DCP ($fc,x)
            .hex db c5 04      ; $b482: db c5 04  Invalid Opcode - DCP $04c5,y
            .hex fb c7 f4      ; $b485: fb c7 f4  Invalid Opcode - ISC __f4c7,y
            .hex fb c9 fc      ; $b488: fb c9 fc  Invalid Opcode - ISC __fcc9,y
            .hex fb cb         ; $b48b: fb cb     Suspected data
__b48d:     .hex 04 05         ; $b48d: 04 05     Invalid Opcode - NOP $05
            .hex dc c1 02      ; $b48f: dc c1 02  Invalid Opcode - NOP $02c1,x
            .hex f4 dd         ; $b492: f4 dd     Invalid Opcode - NOP $dd,x
            .hex c3 fc         ; $b494: c3 fc     Invalid Opcode - DCP ($fc,x)
            .hex dd            ; $b496: dd        Suspected data
__b497:     cmp $04            ; $b497: c5 04     
            .hex fb cd f9      ; $b499: fb cd f9  Invalid Opcode - ISC __f9cd,y
            .hex fb cf ff      ; $b49c: fb cf ff  Invalid Opcode - ISC __ffcf,y
            ora $de            ; $b49f: 05 de     
            .hex ab            ; $b4a1: ab        Suspected data
__b4a2:     .hex 03 ec         ; $b4a2: 03 ec     Invalid Opcode - SLO ($ec,x)
            .hex df ad         ; $b4a4: df ad     Suspected data
__b4a6:     .hex f4 db         ; $b4a6: f4 db     Invalid Opcode - NOP $db,x
            lda ($fc,x)        ; $b4a8: a1 fc     
            .hex db a3 04      ; $b4aa: db a3 04  Invalid Opcode - DCP $04a3,y
            .hex fb a5 01      ; $b4ad: fb a5 01  Invalid Opcode - ISC $01a5,y
            asl $e0            ; $b4b0: 06 e0     
            .hex ab 03         ; $b4b2: ab 03     Invalid Opcode - LAX #$03
            beq __b497         ; $b4b4: f0 e1     
            lda __ddf4         ; $b4b6: ad f4 dd  
            lda ($fc,x)        ; $b4b9: a1 fc     
            .hex dd a3         ; $b4bb: dd a3     Suspected data
__b4bd:     .hex 04 fb         ; $b4bd: 04 fb     Invalid Opcode - NOP $fb
            .hex a7 fc         ; $b4bf: a7 fc     Invalid Opcode - LAX $fc
__b4c1:     .hex fb a9 04      ; $b4c1: fb a9 04  Invalid Opcode - ISC $04a9,y
            .hex 82 79         ; $b4c4: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b4c6: b2        Invalid Opcode - KIL 
            cmp $02df,x        ; $b4c7: dd df 02  
            .hex fa            ; $b4ca: fa        Invalid Opcode - NOP 
            .hex 6b 00         ; $b4cb: 6b 00     Invalid Opcode - ARR #$00
            sed                ; $b4cd: f8        
            .hex fb 6d 00      ; $b4ce: fb 6d 00  Invalid Opcode - ISC $006d,y
__b4d1:     .hex 82 c9         ; $b4d1: 82 c9     Invalid Opcode - NOP #$c9
            ldy $ec,x          ; $b4d3: b4 ec     
__b4d5:     inc __f002         ; $b4d5: ee 02 f0  
            .hex d2            ; $b4d8: d2        Invalid Opcode - KIL 
            .hex 03 f8         ; $b4d9: 03 f8     Invalid Opcode - SLO ($f8,x)
            .hex f1            ; $b4db: f1        Suspected data
__b4dc:     .hex d4 00         ; $b4dc: d4 00     Invalid Opcode - NOP $00,x
            .hex 02            ; $b4de: 02        Invalid Opcode - KIL 
            .hex f0            ; $b4df: f0        Suspected data
__b4e0:     .hex d2            ; $b4e0: d2        Invalid Opcode - KIL 
            .hex 83 f8         ; $b4e1: 83 f8     Invalid Opcode - SAX ($f8,x)
__b4e3:     sbc ($d4),y        ; $b4e3: f1 d4     
            brk                ; $b4e5: 00        
            ora ($f0,x)        ; $b4e6: 01 f0     
            cpx $00            ; $b4e8: e4 00     
            .hex fc 01 f0      ; $b4ea: fc 01 f0  Invalid Opcode - NOP __f001,x
            cpx $80            ; $b4ed: e4 80     
            .hex fc 01 e8      ; $b4ef: fc 01 e8  Invalid Opcode - NOP __e801,x
            .hex af 00 04      ; $b4f2: af 00 04  Invalid Opcode - LAX $0400
            sta ($f0,x)        ; $b4f5: 81 f0     
            ldy $d1,x          ; $b4f7: b4 d1     
            .hex 02            ; $b4f9: 02        Invalid Opcode - KIL 
            beq __b48d         ; $b4fa: f0 91     
            .hex 02            ; $b4fc: 02        Invalid Opcode - KIL 
            sed                ; $b4fd: f8        
            sbc ($93),y        ; $b4fe: f1 93     
            brk                ; $b500: 00        
            .hex 82 f9         ; $b501: 82 f9     Invalid Opcode - NOP #$f9
            ldy $95,x          ; $b503: b4 95     
            .hex 97 02         ; $b505: 97 02     Invalid Opcode - SAX $02,y
            beq __b4a2         ; $b507: f0 99     
            .hex 02            ; $b509: 02        Invalid Opcode - KIL 
            sed                ; $b50a: f8        
            beq __b4a6         ; $b50b: f0 99     
            .hex 42            ; $b50d: 42        Invalid Opcode - KIL 
            brk                ; $b50e: 00        
            ora ($f0,x)        ; $b50f: 01 f0     
            .hex 9b            ; $b511: 9b        Invalid Opcode - TAS 
            .hex 02            ; $b512: 02        Invalid Opcode - KIL 
            .hex fc 02 f0      ; $b513: fc 02 f0  Invalid Opcode - NOP __f002,x
            sta ($82),y        ; $b516: 91 82     
            sed                ; $b518: f8        
            sbc ($93),y        ; $b519: f1 93     
            brk                ; $b51b: 00        
            .hex 82 14         ; $b51c: 82 14     Invalid Opcode - NOP #$14
            lda $95,x          ; $b51e: b5 95     
            .hex 97 02         ; $b520: 97 02     Invalid Opcode - SAX $02,y
            beq __b4bd         ; $b522: f0 99     
            .hex 82 f8         ; $b524: 82 f8     Invalid Opcode - NOP #$f8
            beq __b4c1         ; $b526: f0 99     
            .hex c2 00         ; $b528: c2 00     Invalid Opcode - NOP #$00
            ora ($f0,x)        ; $b52a: 01 f0     
            .hex 9b            ; $b52c: 9b        Invalid Opcode - TAS 
            .hex 82 fc         ; $b52d: 82 fc     Invalid Opcode - NOP #$fc
            .hex 02            ; $b52f: 02        Invalid Opcode - KIL 
            beq __b4d1         ; $b530: f0 9f     
            .hex 03 f8         ; $b532: 03 f8     Invalid Opcode - SLO ($f8,x)
            beq __b4d5         ; $b534: f0 9f     
            .hex c3 00         ; $b536: c3 00     Invalid Opcode - DCP ($00,x)
            .hex 82 2f         ; $b538: 82 2f     Invalid Opcode - NOP #$2f
            lda $af,x          ; $b53a: b5 af     
            .hex af 02 f0      ; $b53c: af 02 f0  Invalid Opcode - LAX __f002
            .hex 9f 83 f8      ; $b53f: 9f 83 f8  Invalid Opcode - AHX __f883,y
            beq __b4e3         ; $b542: f0 9f     
            .hex 43 00         ; $b544: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 82 79         ; $b546: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b548: b2        Invalid Opcode - KIL 
            sta ($83,x)        ; $b549: 81 83     
            .hex 82 79         ; $b54b: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b54d: b2        Invalid Opcode - KIL 
            sta $87            ; $b54e: 85 87     
            .hex 02            ; $b550: 02        Invalid Opcode - KIL 
            beq __b4dc         ; $b551: f0 89     
            brk                ; $b553: 00        
            sed                ; $b554: f8        
            beq __b4e0         ; $b555: f0 89     
            rti                ; $b557: 40        

;-------------------------------------------------------------------------------
            brk                ; $b558: 00        
            .hex 02            ; $b559: 02        Invalid Opcode - KIL 
            .hex fa            ; $b55a: fa        Invalid Opcode - NOP 
            .hex 7f 02 f8      ; $b55b: 7f 02 f8  Invalid Opcode - RRA __f802,x
            .hex fb bd 00      ; $b55e: fb bd 00  Invalid Opcode - ISC $00bd,y
            asl                ; $b561: 0a        
            cpx #$e1           ; $b562: e0 e1     
            .hex 03 f0         ; $b564: 03 f0     Invalid Opcode - SLO ($f0,x)
            sbc ($e3,x)        ; $b566: e1 e3     
            sed                ; $b568: f8        
            sbc ($e5,x)        ; $b569: e1 e5     
            brk                ; $b56b: 00        
            sbc ($e7,x)        ; $b56c: e1 e7     
            php                ; $b56e: 08        
            ora ($e9,x)        ; $b56f: 01 e9     
            beq __b574         ; $b571: f0 01     
            .hex eb            ; $b573: eb        Suspected data
__b574:     sed                ; $b574: f8        
            ora ($ed,x)        ; $b575: 01 ed     
            brk                ; $b577: 00        
            ora ($ef,x)        ; $b578: 01 ef     
            php                ; $b57a: 08        
            and ($f1,x)        ; $b57b: 21 f1     
            sed                ; $b57d: f8        
            and ($f3,x)        ; $b57e: 21 f3     
            brk                ; $b580: 00        
            ora ($f0,x)        ; $b581: 01 f0     
            sbc $00,x          ; $b583: f5 00     
            .hex fc 02 f0      ; $b585: fc 02 f0  Invalid Opcode - NOP __f002,x
            .hex eb 02         ; $b588: eb 02     Invalid Opcode - SBC #$02
            sed                ; $b58a: f8        
            sbc ($ed),y        ; $b58b: f1 ed     
__b58d:     brk                ; $b58d: 00        
            .hex 0b d0         ; $b58e: 0b d0     Invalid Opcode - ANC #$d0
            .hex d3 03         ; $b590: d3 03     Invalid Opcode - DCP ($03),y
            .hex f4 d1         ; $b592: f4 d1     Invalid Opcode - NOP $d1,x
            cmp $fc,x          ; $b594: d5 fc     
            cmp ($d7),y        ; $b596: d1 d7     
            .hex 04 f1         ; $b598: 04 f1     Invalid Opcode - NOP $f1
            cmp __f1ec,y       ; $b59a: d9 ec f1  
            .hex db f4         ; $b59d: db f4     Suspected data
__b59f:     sbc ($e1),y        ; $b59f: f1 e1     
            .hex fc f1 e3      ; $b5a1: fc f1 e3  Invalid Opcode - NOP __e3f1,x
            .hex 04 11         ; $b5a4: 04 11     Invalid Opcode - NOP $11
            sbc $f4            ; $b5a6: e5 f4     
            ora ($e7),y        ; $b5a8: 11 e7     
            .hex fc 11 e9      ; $b5aa: fc 11 e9  Invalid Opcode - NOP __e911,x
            .hex 04 d1         ; $b5ad: 04 d1     Invalid Opcode - NOP $d1
            cmp ($ec),y        ; $b5af: d1 ec     
            asl                ; $b5b1: 0a        
            bne __b59f         ; $b5b2: d0 eb     
            .hex 03 f4         ; $b5b4: 03 f4     Invalid Opcode - SLO ($f4,x)
            cmp ($ed),y        ; $b5b6: d1 ed     
            .hex fc d1 ef      ; $b5b8: fc d1 ef  Invalid Opcode - NOP __efd1,x
            .hex 04 f1         ; $b5bb: 04 f1     Invalid Opcode - NOP $f1
            sbc ($f4),y        ; $b5bd: f1 f4     
            sbc ($f3),y        ; $b5bf: f1 f3     
            .hex fc f1 f5      ; $b5c1: fc f1 f5  Invalid Opcode - NOP __f5f1,x
            .hex 04 f1         ; $b5c4: 04 f1     Invalid Opcode - NOP $f1
            .hex f7 0c         ; $b5c6: f7 0c     Invalid Opcode - ISC $0c,x
            ora ($e5),y        ; $b5c8: 11 e5     
            .hex f4 11         ; $b5ca: f4 11     Invalid Opcode - NOP $11,x
            .hex e7            ; $b5cc: e7        Suspected data
__b5cd:     .hex fc 11 e9      ; $b5cd: fc 11 e9  Invalid Opcode - NOP __e911,x
            .hex 04 02         ; $b5d0: 04 02     Invalid Opcode - NOP $02
            beq __b5cd         ; $b5d2: f0 f9     
            .hex 02            ; $b5d4: 02        Invalid Opcode - KIL 
            sed                ; $b5d5: f8        
            sbc ($fb),y        ; $b5d6: f1 fb     
            brk                ; $b5d8: 00        
            .hex 82 d1         ; $b5d9: 82 d1     Invalid Opcode - NOP #$d1
            lda $fd,x          ; $b5db: b5 fd     
            .hex ff 02 f0      ; $b5dd: ff 02 f0  Invalid Opcode - ISC __f002,x
            .hex fb c2 f8      ; $b5e0: fb c2 f8  Invalid Opcode - ISC __f8c2,y
            sbc ($f9),y        ; $b5e3: f1 f9     
            brk                ; $b5e5: 00        
            .hex 82 de         ; $b5e6: 82 de     Invalid Opcode - NOP #$de
            lda $ff,x          ; $b5e8: b5 ff     
            .hex fd 84 00      ; $b5ea: fd 84 00  Bad Addr Mode - SBC $0084,x
            ldx $d1,y          ; $b5ed: b6 d1     
            .hex d3 d5         ; $b5ef: d3 d5     Invalid Opcode - DCP ($d5),y
            .hex d7 04         ; $b5f1: d7 04     Invalid Opcode - DCP $04,x
            .hex e2 d1         ; $b5f3: e2 d1     Invalid Opcode - NOP #$d1
            .hex 02            ; $b5f5: 02        Invalid Opcode - KIL 
            sed                ; $b5f6: f8        
            .hex e3 d3         ; $b5f7: e3 d3     Invalid Opcode - ISC ($d3,x)
            brk                ; $b5f9: 00        
            ora ($d9,x)        ; $b5fa: 01 d9     
            sed                ; $b5fc: f8        
            ora ($db,x)        ; $b5fd: 01 db     
            brk                ; $b5ff: 00        
            .hex 04 e0         ; $b600: 04 e0     Invalid Opcode - NOP $e0
            .hex dd            ; $b602: dd        Suspected data
__b603:     .hex 02            ; $b603: 02        Invalid Opcode - KIL 
            sed                ; $b604: f8        
            sbc ($df,x)        ; $b605: e1 df     
            brk                ; $b607: 00        
            ora ($d5,x)        ; $b608: 01 d5     
            sed                ; $b60a: f8        
            ora ($d7,x)        ; $b60b: 01 d7     
            brk                ; $b60d: 00        
            .hex 02            ; $b60e: 02        Invalid Opcode - KIL 
            .hex fa            ; $b60f: fa        Invalid Opcode - NOP 
            cmp ($03,x)        ; $b610: c1 03     
            sed                ; $b612: f8        
            .hex fb c3 00      ; $b613: fb c3 00  Invalid Opcode - ISC $00c3,y
            .hex 82 0e         ; $b616: 82 0e     Invalid Opcode - NOP #$0e
            ldx $c5,y          ; $b618: b6 c5     
            .hex c7 84         ; $b61a: c7 84     Invalid Opcode - DCP $84
            .hex 1f b2 c9      ; $b61c: 1f b2 c9  Invalid Opcode - SLO __c9b2,x
            .hex cb cd         ; $b61f: cb cd     Invalid Opcode - AXS #$cd
            .hex cf 05 da      ; $b621: cf 05 da  Invalid Opcode - DCP __da05
            sbc ($02,x)        ; $b624: e1 02     
            beq __b603         ; $b626: f0 db     
            .hex e3 f8         ; $b628: e3 f8     Invalid Opcode - ISC ($f8,x)
            .hex db e5 00      ; $b62a: db e5 00  Invalid Opcode - DCP $00e5,y
            .hex fb e7 f8      ; $b62d: fb e7 f8  Invalid Opcode - ISC __f8e7,y
            .hex fb e9 00      ; $b630: fb e9 00  Invalid Opcode - ISC $00e9,y
            sta $22            ; $b633: 85 22     
            ldx $eb,y          ; $b635: b6 eb     
            sbc __efe5         ; $b637: ed e5 ef  
            sbc ($02),y        ; $b63a: f1 02     
            cpx #$bd           ; $b63c: e0 bd     
            brk                ; $b63e: 00        
            brk                ; $b63f: 00        
            ora ($9a,x)        ; $b640: 01 9a     
            brk                ; $b642: 00        
            .hex 82 3b         ; $b643: 82 3b     Invalid Opcode - NOP #$3b
            ldx $9c,y          ; $b645: b6 9c     
            .hex 9e 04         ; $b647: 9e 04     Suspected data
__b649:     .hex fa            ; $b649: fa        Invalid Opcode - NOP 
            sta ($03),y        ; $b64a: 91 03     
            beq __b649         ; $b64c: f0 fb     
            .hex 93 f8         ; $b64e: 93 f8     Invalid Opcode - AHX ($f8),y
            .hex fb 95 00      ; $b650: fb 95 00  Invalid Opcode - ISC $0095,y
            .hex fb 97 08      ; $b653: fb 97 08  Invalid Opcode - ISC $0897,y
            sty $48            ; $b656: 84 48     
            ldx $99,y          ; $b658: b6 99     
            .hex 9b            ; $b65a: 9b        Invalid Opcode - TAS 
            .hex 9d 9f         ; $b65b: 9d 9f     Suspected data
__b65d:     sty $1f            ; $b65d: 84 1f     
            .hex b2            ; $b65f: b2        Invalid Opcode - KIL 
            lda ($a3,x)        ; $b660: a1 a3     
            lda $a7            ; $b662: a5 a7     
            sty $1f            ; $b664: 84 1f     
            .hex b2            ; $b666: b2        Invalid Opcode - KIL 
            lda #$ab           ; $b667: a9 ab     
            lda $07af          ; $b669: ad af 07  
            cpx #$6f           ; $b66c: e0 6f     
            .hex 03 f8         ; $b66e: 03 f8     Invalid Opcode - SLO ($f8,x)
            sbc ($71,x)        ; $b670: e1 71     
            brk                ; $b672: 00        
            ora ($73,x)        ; $b673: 01 73     
            sed                ; $b675: f8        
            ora ($75,x)        ; $b676: 01 75     
            brk                ; $b678: 00        
            ora ($fb),y        ; $b679: 11 fb     
            .hex f4 21         ; $b67b: f4 21     Invalid Opcode - NOP $21,x
            sbc $21fc,x        ; $b67d: fd fc 21  
            sbc $0304,x        ; $b680: fd 04 03  
            brk                ; $b683: 00        
            sbc __f403,x       ; $b684: fd 03 f4  
            ora ($fd,x)        ; $b687: 01 fd     
__b689:     .hex fc f0 fb      ; $b689: fc f0 fb  Invalid Opcode - NOP __fbf0,x
            .hex 43 04         ; $b68c: 43 04     Invalid Opcode - SRE ($04,x)
            .hex 82 79         ; $b68e: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b690: b2        Invalid Opcode - KIL 
            .hex f3 f5         ; $b691: f3 f5     Invalid Opcode - ISC ($f5),y
            .hex 82 79         ; $b693: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b695: b2        Invalid Opcode - KIL 
            .hex f7 f9         ; $b696: f7 f9     Invalid Opcode - ISC $f9,x
            .hex 82 79         ; $b698: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b69a: b2        Invalid Opcode - KIL 
            sta ($83,x)        ; $b69b: 81 83     
            .hex 82 79         ; $b69d: 82 79     Invalid Opcode - NOP #$79
            .hex b2            ; $b69f: b2        Invalid Opcode - KIL 
            sta $87            ; $b6a0: 85 87     
            asl $e0            ; $b6a2: 06 e0     
            cmp $00            ; $b6a4: c5 00     
            beq __b689         ; $b6a6: f0 e1     
            .hex c7 f8         ; $b6a8: c7 f8     Invalid Opcode - DCP $f8
            sbc ($c9,x)        ; $b6aa: e1 c9     
__b6ac:     brk                ; $b6ac: 00        
            sbc ($cb,x)        ; $b6ad: e1 cb     
            php                ; $b6af: 08        
            ora ($cd,x)        ; $b6b0: 01 cd     
            sed                ; $b6b2: f8        
            ora ($cf,x)        ; $b6b3: 01 cf     
            brk                ; $b6b5: 00        
__b6b6:     .hex 02            ; $b6b6: 02        Invalid Opcode - KIL 
            beq __b6ac         ; $b6b7: f0 f3     
            .hex 03 f8         ; $b6b9: 03 f8     Invalid Opcode - SLO ($f8,x)
            sbc ($f5),y        ; $b6bb: f1 f5     
            brk                ; $b6bd: 00        
            .hex 82 b6         ; $b6be: 82 b6     Invalid Opcode - NOP #$b6
            ldx $f7,y          ; $b6c0: b6 f7     
            sbc __d684,y       ; $b6c2: f9 84 d6  
            ldx $85,y          ; $b6c5: b6 85     
            .hex 87 81         ; $b6c7: 87 81     Invalid Opcode - SAX $81
            .hex 83 82         ; $b6c9: 83 82     Invalid Opcode - SAX ($82,x)
            dec $b6,x          ; $b6cb: d6 b6     
            .hex 89 8b         ; $b6cd: 89 8b     Invalid Opcode - NOP #$8b
            sty $d6            ; $b6cf: 84 d6     
            ldx $fb,y          ; $b6d1: b6 fb     
            sbc __8f8d,x       ; $b6d3: fd 8d 8f  
            ora $00            ; $b6d6: 05 00     
            .hex a7            ; $b6d8: a7        Suspected data
__b6d9:     .hex 03            ; $b6d9: 03        Suspected data
__b6da:     sed                ; $b6da: f8        
            ora ($a9,x)        ; $b6db: 01 a9     
            brk                ; $b6dd: 00        
            sbc ($a1,x)        ; $b6de: e1 a1     
            sed                ; $b6e0: f8        
            sbc ($a3,x)        ; $b6e1: e1 a3     
            brk                ; $b6e3: 00        
            sbc ($a5,x)        ; $b6e4: e1 a5     
            php                ; $b6e6: 08        
            ora $d0            ; $b6e7: 05 d0     
            .hex ab 03         ; $b6e9: ab 03     Invalid Opcode - LAX #$03
            sed                ; $b6eb: f8        
            cmp ($ad),y        ; $b6ec: d1 ad     
            brk                ; $b6ee: 00        
            sbc ($af,x)        ; $b6ef: e1 af     
            php                ; $b6f1: 08        
            sbc ($a7),y        ; $b6f2: f1 a7     
            sed                ; $b6f4: f8        
            sbc ($a9),y        ; $b6f5: f1 a9     
            brk                ; $b6f7: 00        
            ora $e0            ; $b6f8: 05 e0     
            .hex a7 03         ; $b6fa: a7 03     Invalid Opcode - LAX $03
            sed                ; $b6fc: f8        
            sbc ($b1,x)        ; $b6fd: e1 b1     
            brk                ; $b6ff: 00        
            sbc ($b3,x)        ; $b700: e1 b3     
            php                ; $b702: 08        
__b703:     ora ($b5,x)        ; $b703: 01 b5     
            brk                ; $b705: 00        
            ora ($b7,x)        ; $b706: 01 b7     
            php                ; $b708: 08        
            sty $17            ; $b709: 84 17     
            .hex b7 b9         ; $b70b: b7 b9     Invalid Opcode - LAX $b9,y
            .hex bb bd bf      ; $b70d: bb bd bf  Invalid Opcode - LAS __bfbd,y
            sty $1f            ; $b710: 84 1f     
            .hex b2            ; $b712: b2        Invalid Opcode - KIL 
            lda __c1bb,y       ; $b713: b9 bb c1  
            .hex c3 06         ; $b716: c3 06     Invalid Opcode - DCP ($06,x)
            .hex da            ; $b718: da        Invalid Opcode - NOP 
            sbc $03            ; $b719: e5 03     
            sed                ; $b71b: f8        
            .hex db e7 00      ; $b71c: db e7 00  Invalid Opcode - DCP $00e7,y
            .hex fb e9 f8      ; $b71f: fb e9 f8  Invalid Opcode - ISC __f8e9,y
            .hex fb eb 00      ; $b722: fb eb 00  Invalid Opcode - ISC $00eb,y
            .hex bb e1 fd      ; $b725: bb e1 fd  Invalid Opcode - LAS __fde1,y
            .hex db e3 f0      ; $b728: db e3 f0  Invalid Opcode - DCP __f0e3,y
            asl $dc            ; $b72b: 06 dc     
            sbc $03            ; $b72d: e5 03     
            .hex f7 dd         ; $b72f: f7 dd     Invalid Opcode - ISC $dd,x
            .hex e7 ff         ; $b731: e7 ff     Invalid Opcode - ISC $ff
            .hex fb ed f8      ; $b733: fb ed f8  Invalid Opcode - ISC __f8ed,y
            .hex fb ef 00      ; $b736: fb ef 00  Invalid Opcode - ISC $00ef,y
            lda __fce1,x       ; $b739: bd e1 fc  
            cmp __efe3,x       ; $b73c: dd e3 ef  
            asl $da            ; $b73f: 06 da     
            cmp ($00),y        ; $b741: d1 00     
            .hex f4 db         ; $b743: f4 db     Invalid Opcode - NOP $db,x
            .hex d3 fc         ; $b745: d3 fc     Invalid Opcode - DCP ($fc),y
            .hex da            ; $b747: da        Invalid Opcode - NOP 
            cmp $02,x          ; $b748: d5 02     
            .hex 04 fb         ; $b74a: 04 fb     Invalid Opcode - NOP $fb
            .hex d7 f4         ; $b74c: d7 f4     Invalid Opcode - DCP $f4,x
            .hex fb d9 fc      ; $b74e: fb d9 fc  Invalid Opcode - ISC __fcd9,y
            .hex fb db 04      ; $b751: fb db 04  Invalid Opcode - ISC $04db,y
            php                ; $b754: 08        
            .hex da            ; $b755: da        Invalid Opcode - NOP 
            cmp __ec00,x       ; $b756: dd 00 ec  
            .hex db 9c f4      ; $b759: db 9c f4  Invalid Opcode - DCP __f49c,y
            .hex da            ; $b75c: da        Invalid Opcode - NOP 
            .hex 9e 02 fc      ; $b75d: 9e 02 fc  Invalid Opcode - SHX __fc02,y
            .hex db a0 04      ; $b760: db a0 04  Invalid Opcode - DCP $04a0,y
            .hex fa            ; $b763: fa        Invalid Opcode - NOP 
            .hex df 00 ec      ; $b764: df 00 ec  Invalid Opcode - DCP __ec00,x
            .hex fa            ; $b767: fa        Invalid Opcode - NOP 
            .hex d7 02         ; $b768: d7 02     Invalid Opcode - DCP $02,x
            .hex f4 fb         ; $b76a: f4 fb     Invalid Opcode - NOP $fb,x
            cmp __fbfc,y       ; $b76c: d9 fc fb  
            .hex db 04 04      ; $b76f: db 04 04  Invalid Opcode - DCP $0404,y
            cpx #$91           ; $b772: e0 91     
            .hex 02            ; $b774: 02        Invalid Opcode - KIL 
            sed                ; $b775: f8        
            sbc ($93,x)        ; $b776: e1 93     
            brk                ; $b778: 00        
            ora ($95,x)        ; $b779: 01 95     
            sed                ; $b77b: f8        
__b77c:     ora ($97,x)        ; $b77c: 01 97     
            brk                ; $b77e: 00        
            sty $71            ; $b77f: 84 71     
__b781:     .hex b7 99         ; $b781: b7 99     Invalid Opcode - LAX $99,y
            .hex 9b            ; $b783: 9b        Invalid Opcode - TAS 
            sta $029f,x        ; $b784: 9d 9f 02  
            beq __b77c         ; $b787: f0 f3     
            .hex 03 f8         ; $b789: 03 f8     Invalid Opcode - SLO ($f8,x)
            sbc ($f5),y        ; $b78b: f1 f5     
            brk                ; $b78d: 00        
            .hex 82 86         ; $b78e: 82 86     Invalid Opcode - NOP #$86
            .hex b7 f7         ; $b790: b7 f7     Invalid Opcode - LAX $f7,y
            sbc __e002,y       ; $b792: f9 02 e0  
            cmp ($03),y        ; $b795: d1 03     
            sed                ; $b797: f8        
            sbc ($d3,x)        ; $b798: e1 d3     
            brk                ; $b79a: 00        
            .hex 82 93         ; $b79b: 82 93     Invalid Opcode - NOP #$93
            .hex b7 d5         ; $b79d: b7 d5     Invalid Opcode - LAX $d5,y
            .hex d7 04         ; $b79f: d7 04     Invalid Opcode - DCP $04,x
            .hex da            ; $b7a1: da        Invalid Opcode - NOP 
            adc #$03           ; $b7a2: 69 03     
            beq __b781         ; $b7a4: f0 db     
            .hex 7f f8 fb      ; $b7a6: 7f f8 fb  Invalid Opcode - RRA __fbf8,x
            cmp __fbf8,y       ; $b7a9: d9 f8 fb  
            .hex db 00 04      ; $b7ac: db 00 04  Invalid Opcode - DCP $0400,y
            .hex da            ; $b7af: da        Invalid Opcode - NOP 
            cmp __f403,y       ; $b7b0: d9 03 f4  
            .hex db db fc      ; $b7b3: db db fc  Invalid Opcode - DCP __fcdb,y
            .hex fb 69 f8      ; $b7b6: fb 69 f8  Invalid Opcode - ISC __f869,y
            .hex fb 7f 00      ; $b7b9: fb 7f 00  Invalid Opcode - ISC $007f,y
            sty $1f            ; $b7bc: 84 1f     
            .hex b2            ; $b7be: b2        Invalid Opcode - KIL 
            adc #$7f           ; $b7bf: 69 7f     
            adc #$7f           ; $b7c1: 69 7f     
            .hex 82 cd         ; $b7c3: 82 cd     Invalid Opcode - NOP #$cd
            .hex b7 c1         ; $b7c5: b7 c1     Invalid Opcode - LAX $c1,y
            .hex c3 82         ; $b7c7: c3 82     Invalid Opcode - DCP ($82,x)
            cmp __c5b7         ; $b7c9: cd b7 c5  
            .hex c7 04         ; $b7cc: c7 04     Invalid Opcode - DCP $04
            brk                ; $b7ce: 00        
            cmp __f803         ; $b7cf: cd 03 f8  
            ora ($cf,x)        ; $b7d2: 01 cf     
            brk                ; $b7d4: 00        
            sbc ($c9,x)        ; $b7d5: e1 c9     
            sed                ; $b7d7: f8        
            sbc ($cb,x)        ; $b7d8: e1 cb     
            brk                ; $b7da: 00        
            .hex 02            ; $b7db: 02        Invalid Opcode - KIL 
            cpx #$bd           ; $b7dc: e0 bd     
            brk                ; $b7de: 00        
            brk                ; $b7df: 00        
            ora ($9a,x)        ; $b7e0: 01 9a     
            brk                ; $b7e2: 00        
            .hex 82 db         ; $b7e3: 82 db     Invalid Opcode - NOP #$db
            .hex b7 9c         ; $b7e5: b7 9c     Invalid Opcode - LAX $9c,y
            .hex 9e 02 f8      ; $b7e7: 9e 02 f8  Invalid Opcode - SHX __f802,y
            sta ($02),y        ; $b7ea: 91 02     
            sed                ; $b7ec: f8        
            sbc $0093,y        ; $b7ed: f9 93 00  
            .hex 82 e8         ; $b7f0: 82 e8     Invalid Opcode - NOP #$e8
            .hex b7 95         ; $b7f2: b7 95     Invalid Opcode - LAX $95,y
            .hex 97 02         ; $b7f4: 97 02     Invalid Opcode - SAX $02,y
            sed                ; $b7f6: f8        
            sta __f802,y       ; $b7f7: 99 02 f8  
            sed                ; $b7fa: f8        
            sta $0042,y        ; $b7fb: 99 42 00  
            .hex 02            ; $b7fe: 02        Invalid Opcode - KIL 
            jsr $0289          ; $b7ff: 20 89 02  
            sed                ; $b802: f8        
            and ($9f,x)        ; $b803: 21 9f     
            brk                ; $b805: 00        
            .hex 82 fe         ; $b806: 82 fe     Invalid Opcode - NOP #$fe
            .hex b7 fb         ; $b808: b7 fb     Invalid Opcode - LAX $fb,y
            sbc $1f84,x        ; $b80a: fd 84 1f  
            .hex b2            ; $b80d: b2        Invalid Opcode - KIL 
            sbc ($e3,x)        ; $b80e: e1 e3     
            sbc $e7            ; $b810: e5 e7     
            sty $19            ; $b812: 84 19     
            clv                ; $b814: b8        
            sbc ($e3,x)        ; $b815: e1 e3     
            sbc #$eb           ; $b817: e9 eb     
            ora $dc            ; $b819: 05 dc     
            .hex ef 03 f8      ; $b81b: ef 03 f8  Invalid Opcode - ISC __f803
            .hex dd e3 00      ; $b81e: dd e3 00  Bad Addr Mode - CMP $00e3,x
            .hex fb e9 f8      ; $b821: fb e9 f8  Invalid Opcode - ISC __f8e9,y
            .hex fb eb 00      ; $b824: fb eb 00  Invalid Opcode - ISC $00eb,y
            cmp __f0ed,x       ; $b827: dd ed f0  
            sty $1f            ; $b82a: 84 1f     
            .hex b2            ; $b82c: b2        Invalid Opcode - KIL 
            sbc ($e3),y        ; $b82d: f1 e3     
            sbc $e7            ; $b82f: e5 e7     
            .hex 04 da         ; $b831: 04 da     Invalid Opcode - NOP $da
            lda ($01,x)        ; $b833: a1 01     
            sed                ; $b835: f8        
            .hex db a3 00      ; $b836: db a3 00  Invalid Opcode - DCP $00a3,y
            .hex fb a5 f8      ; $b839: fb a5 f8  Invalid Opcode - ISC __f8a5,y
            .hex fb a7 00      ; $b83c: fb a7 00  Invalid Opcode - ISC $00a7,y
            sty $31            ; $b83f: 84 31     
            clv                ; $b841: b8        
            lda #$ab           ; $b842: a9 ab     
            lda __ffaf         ; $b844: ad af ff  
            .hex ff ff ff      ; $b847: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b84a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b84d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b850: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b853: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b856: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b859: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b85c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b85f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b862: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b865: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b868: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b86b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b86e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b871: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b874: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b877: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b87a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b87d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b880: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b883: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b886: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b889: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b88c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b88f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b892: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b895: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b898: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b89b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b89e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8a1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8a4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8a7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8aa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8ad: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8b0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8b3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8b6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8b9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8bc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8bf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8c2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8c5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8c8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8cb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8ce: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8d1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8d4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8d7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8da: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8dd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8e0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8e3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8e6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8e9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8ec: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8ef: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8f2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8f5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8f8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8fb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b8fe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b901: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b904: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b907: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b90a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b90d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b910: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b913: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b916: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b919: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b91c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b91f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b922: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b925: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b928: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b92b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b92e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b931: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b934: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b937: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b93a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b93d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b940: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b943: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b946: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b949: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b94c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b94f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b952: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b955: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b958: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b95b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b95e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b961: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b964: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b967: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b96a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b96d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b970: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b973: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b976: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b979: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b97c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b97f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b982: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b985: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b988: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b98b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b98e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b991: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b994: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b997: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b99a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b99d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9a0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9a3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9a6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9a9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9ac: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9af: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9b2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9b5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9b8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9bb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9be: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9c1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9c4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9c7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9ca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9cd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9d0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9d3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9d6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9d9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9dc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9df: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9e2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9e5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9e8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9eb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9ee: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9f1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9f4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9f7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $b9fa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $b9fd: ff ff     Suspected data
__b9ff:     .hex ff            ; $b9ff: ff        Suspected data
__ba00:     .hex ff ff ff      ; $ba00: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba03: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba06: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba09: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba0c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba0f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba12: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba15: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba18: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba1b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba1e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba21: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba24: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba27: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba2a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba2d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba30: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba33: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba36: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba39: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba3c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba3f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba42: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba45: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba48: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba4b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba4e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba51: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba54: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba57: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba5a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba5d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba60: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba63: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba66: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba69: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba6c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba6f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba72: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba75: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba96: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba99: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba9c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ba9f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baa2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baa5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baa8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bab1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bab4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bab7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $babd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bac0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bac3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bac6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bac9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bacc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bacf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bad2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bad5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bad8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $badb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bade: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bae1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bae4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bae7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baf0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baf3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baf6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baf9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bafc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $baff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb14: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb3e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb5f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb62: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb65: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb68: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb6b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb6e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb71: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb74: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb77: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb7a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb7d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb80: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb83: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb86: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb89: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb8c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb8f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb92: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb95: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb98: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb9b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bb9e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bba1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bba4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bba7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbaa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbad: ff ff ff  Invalid Opcode - ISC $ffff,x
__bbb0:     .hex ff ff ff      ; $bbb0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbb3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbb6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbb9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbbc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbbf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbc2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbc5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbc8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $bbcb: ff        Suspected data
__bbcc:     .hex ff ff ff      ; $bbcc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbcf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbd2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbd5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbd8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $bbdb: ff ff     Suspected data
__bbdd:     .hex ff ff ff      ; $bbdd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbe0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbe3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbe6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbe9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbec: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbef: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbf2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbf5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbf8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbfb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bbfe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc01: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc04: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc07: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $bc0a: ff ff     Suspected data
__bc0c:     .hex ff ff ff      ; $bc0c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc0f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc12: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc15: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc18: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc1b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc1e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc21: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc24: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc27: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc2a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc2d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc30: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc33: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc36: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc39: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc3c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc3f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc42: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc45: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc48: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc4b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc4e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc51: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc54: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc57: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc5a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc5d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc60: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc63: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc66: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc69: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc6c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc6f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc72: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc75: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc96: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc99: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc9c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bc9f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bca2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bca5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bca8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcb1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcb4: ff ff ff  Invalid Opcode - ISC $ffff,x
__bcb7:     .hex ff ff ff      ; $bcb7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcbd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcc0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcc3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcc6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcc9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bccc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bccf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcd2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcd5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcd8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcdb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcde: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bce1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bce4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bce7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bced: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcf0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcf3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcf6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcf9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcfc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bcff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd14: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd3e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd5f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd62: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd65: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd68: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd6b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd6e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd71: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd74: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd77: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd7a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd7d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd80: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd83: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd86: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd89: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $bd8c: ff        Suspected data
__bd8d:     .hex ff ff ff      ; $bd8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $bd96: ff        Suspected data
__bd97:     .hex ff ff ff      ; $bd97: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd9a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bd9d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bda0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bda3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bda6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bda9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdac: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdaf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdb2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdb5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdb8: ff ff ff  Invalid Opcode - ISC $ffff,x
__bdbb:     .hex ff ff ff      ; $bdbb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdbe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdc1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdc4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdc7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdcd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdd0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdd3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdd6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdd9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bddc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bddf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bde2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bde5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bde8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdeb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdee: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdf1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdf4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdf7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdfa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bdfd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be00: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be03: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be06: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be09: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be0c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be0f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be12: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be15: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be18: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be1b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be1e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be21: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be24: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be27: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be2a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be2d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be30: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be33: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be36: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be39: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be3c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be3f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be42: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be45: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be48: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be4b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be4e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be51: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be54: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be57: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be5a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be5d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be60: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be63: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be66: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be69: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be6c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be6f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be72: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be75: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be96: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be99: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $be9c: ff ff ff  Invalid Opcode - ISC $ffff,x
__be9f:     .hex ff ff ff      ; $be9f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bea2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bea5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bea8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beb1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beb4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beb7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bebd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bec0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bec3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bec6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bec9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $becc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $becf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bed2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bed5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bed8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bedb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bede: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bee1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bee4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bee7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bef0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bef3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bef6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bef9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $befc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $beff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf14: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf3e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf5f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf62: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf65: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf68: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf6b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf6e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf71: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf74: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf77: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf7a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf7d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf80: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf83: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf86: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf89: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf8c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf8f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf92: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf95: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bf98: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $bf9b: ff ff     Suspected data
__bf9d:     .hex ff ff ff      ; $bf9d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfa0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfa3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfa6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfa9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfac: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfaf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfb2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfb5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfb8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfbb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfbe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfc1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfc4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfc7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfcd: ff ff ff  Invalid Opcode - ISC $ffff,x
            cld                ; $bfd0: d8        
            sei                ; $bfd1: 78        
            inc $ffff          ; $bfd2: ee ff ff  
            jmp __c000         ; $bfd5: 4c 00 c0  

;-------------------------------------------------------------------------------
            .hex ff ff ff      ; $bfd8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfdb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfde: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfe1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfe4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfe7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bfed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bff0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bff3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $bff6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff 46 c0      ; $bff9: ff 46 c0  Invalid Opcode - ISC nmi,x
            .hex d0            ; $bffc: d0        Suspected data
__bffd:     .hex ff 96 c0      ; $bffd: ff 96 c0  Invalid Opcode - ISC irq,x
__c000:     lda $30            ; $c000: a5 30     
            asl                ; $c002: 0a        
            tay                ; $c003: a8        
            lda __8192,y       ; $c004: b9 92 81  
            sta $00            ; $c007: 85 00     
            lda __8193,y       ; $c009: b9 93 81  
            sta $01            ; $c00c: 85 01     
            lda $50            ; $c00e: a5 50     
            asl                ; $c010: 0a        
            tay                ; $c011: a8        
            lda ($00),y        ; $c012: b1 00     
            sta $08            ; $c014: 85 08     
            iny                ; $c016: c8        
            lda ($00),y        ; $c017: b1 00     
            sta $09            ; $c019: 85 09     
            lda $51            ; $c01b: a5 51     
            asl                ; $c01d: 0a        
            tay                ; $c01e: a8        
            lda ($08),y        ; $c01f: b1 08     
            sta $3d            ; $c021: 85 3d     
            iny                ; $c023: c8        
            lda ($08),y        ; $c024: b1 08     
            sta $3e            ; $c026: 85 3e     
            rts                ; $c028: 60        

;-------------------------------------------------------------------------------
            lda $37            ; $c029: a5 37     
            bne __c036         ; $c02b: d0 09     
            lda $3a            ; $c02d: a5 3a     
            bne __c036         ; $c02f: d0 05     
            lda $3c            ; $c031: a5 3c     
            bne __c036         ; $c033: d0 01     
            rts                ; $c035: 60        

;-------------------------------------------------------------------------------
__c036:     ldx #$00           ; $c036: a2 00     
            ldy #$fc           ; $c038: a0 fc     
__c03a:     iny                ; $c03a: c8        
            iny                ; $c03b: c8        
            iny                ; $c03c: c8        
            iny                ; $c03d: c8        
            inx                ; $c03e: e8        
            lda ($3d),y        ; $c03f: b1 3d     
            cmp #$ff           ; $c041: c9 ff     
            beq __c07a         ; $c043: f0 35     
            .hex c5            ; $c045: c5        Suspected data

;-------------------------------------------------------------------------------
; nmi vector
;-------------------------------------------------------------------------------
nmi:        and __f190,y       ; $c046: 39 90 f1  
            iny                ; $c049: c8        
            lda ($3d),y        ; $c04a: b1 3d     
            dey                ; $c04c: 88        
            cmp #$ff           ; $c04d: c9 ff     
            beq __c07a         ; $c04f: f0 29     
            cmp $3b            ; $c051: c5 3b     
            bcc __c03a         ; $c053: 90 e5     
            lda #$00           ; $c055: a9 00     
            sta $00            ; $c057: 85 00     
            sta $08            ; $c059: 85 08     
            lda ($3d),y        ; $c05b: b1 3d     
            cmp #$ff           ; $c05d: c9 ff     
            beq __c07a         ; $c05f: f0 19     
            asl                ; $c061: 0a        
            rol $00            ; $c062: 26 00     
            asl                ; $c064: 0a        
            rol $00            ; $c065: 26 00     
            asl                ; $c067: 0a        
            rol $00            ; $c068: 26 00     
__c06a:     asl                ; $c06a: 0a        
            rol $00            ; $c06b: 26 00     
            sec                ; $c06d: 38        
            sbc $53            ; $c06e: e5 53     
            sta $01            ; $c070: 85 01     
            lda $00            ; $c072: a5 00     
            sbc $54            ; $c074: e5 54     
            beq __c082         ; $c076: f0 0a     
            bmi __c07f         ; $c078: 30 05     
__c07a:     lda #$00           ; $c07a: a9 00     
            sta $3c            ; $c07c: 85 3c     
            rts                ; $c07e: 60        

;-------------------------------------------------------------------------------
__c07f:     jmp __8185         ; $c07f: 4c 85 81  

;-------------------------------------------------------------------------------
__c082:     iny                ; $c082: c8        
__c083:     lda ($3d),y        ; $c083: b1 3d     
            dey                ; $c085: 88        
            cmp #$ff           ; $c086: c9 ff     
            beq __c07a         ; $c088: f0 f0     
            asl                ; $c08a: 0a        
            rol $08            ; $c08b: 26 08     
            asl                ; $c08d: 0a        
            rol $08            ; $c08e: 26 08     
            asl                ; $c090: 0a        
            rol $08            ; $c091: 26 08     
            asl                ; $c093: 0a        
            rol $08            ; $c094: 26 08     

;-------------------------------------------------------------------------------
; irq/brk vector
;-------------------------------------------------------------------------------
irq:        sec                ; $c096: 38        
            sbc $8c            ; $c097: e5 8c     
            sta $09            ; $c099: 85 09     
            lda $08            ; $c09b: a5 08     
            sbc $8d            ; $c09d: e5 8d     
            beq __c0a4         ; $c09f: f0 03     
            jmp __8185         ; $c0a1: 4c 85 81  

;-------------------------------------------------------------------------------
__c0a4:     lda $01            ; $c0a4: a5 01     
            cmp #$fc           ; $c0a6: c9 fc     
            bcs __c0bf         ; $c0a8: b0 15     
            cmp #$04           ; $c0aa: c9 04     
            bcc __c0bf         ; $c0ac: 90 11     
            lda $09            ; $c0ae: a5 09     
            cmp #$fc           ; $c0b0: c9 fc     
            bcs __c0bf         ; $c0b2: b0 0b     
            cmp #$04           ; $c0b4: c9 04     
            bcc __c0bf         ; $c0b6: 90 07     
            lda $3c            ; $c0b8: a5 3c     
            bne __c0bf         ; $c0ba: d0 03     
            jmp __8185         ; $c0bc: 4c 85 81  

;-------------------------------------------------------------------------------
__c0bf:     stx $02            ; $c0bf: 86 02     
            ldx #$11           ; $c0c1: a2 11     
            lda #$80           ; $c0c3: a9 80     
            sta $00            ; $c0c5: 85 00     
__c0c7:     lda $03b4,x        ; $c0c7: bd b4 03  
            bne __c0cf         ; $c0ca: d0 03     
            jmp __818d         ; $c0cc: 4c 8d 81  

;-------------------------------------------------------------------------------
__c0cf:     lda $0432,x        ; $c0cf: bd 32 04  
            cmp $02            ; $c0d2: c5 02     
            bne __c0d9         ; $c0d4: d0 03     
            jmp __8183         ; $c0d6: 4c 83 81  

;-------------------------------------------------------------------------------
__c0d9:     dex                ; $c0d9: ca        
            cpx #$05           ; $c0da: e0 05     
            bne __c0c7         ; $c0dc: d0 e9     
            ldx $00            ; $c0de: a6 00     
            bpl __c0e5         ; $c0e0: 10 03     
            jmp __8183         ; $c0e2: 4c 83 81  

;-------------------------------------------------------------------------------
__c0e5:     .hex 20 42         ; $c0e5: 20 42     Suspected data
__c0e7:     .hex df c8 c8      ; $c0e7: df c8 c8  Invalid Opcode - DCP __c8c8,x
            lda ($3d),y        ; $c0ea: b1 3d     
            sta $17            ; $c0ec: 85 17     
            cmp #$bc           ; $c0ee: c9 bc     
            bne __c0f6         ; $c0f0: d0 04     
            lda $42            ; $c0f2: a5 42     
            bne __c108         ; $c0f4: d0 12     
__c0f6:     lda $17            ; $c0f6: a5 17     
            bmi __c14d         ; $c0f8: 30 53     
            lda $30            ; $c0fa: a5 30     
            bne __c10d         ; $c0fc: d0 0f     
            lda $17            ; $c0fe: a5 17     
            cmp #$27           ; $c100: c9 27     
            beq __c10d         ; $c102: f0 09     
            lda $82            ; $c104: a5 82     
            bne __c10d         ; $c106: d0 05     
__c108:     ldx $02            ; $c108: a6 02     
            jmp __8187         ; $c10a: 4c 87 81  

;-------------------------------------------------------------------------------
__c10d:     lda $17            ; $c10d: a5 17     
            sta $03b4,x        ; $c10f: 9d b4 03  
            iny                ; $c112: c8        
            lda ($3d),y        ; $c113: b1 3d     
            sta $93            ; $c115: 85 93     
            .hex a5            ; $c117: a5        Suspected data
__c118:     .hex 82 f0         ; $c118: 82 f0     Invalid Opcode - NOP #$f0
            rol                ; $c11a: 2a        
            lda $03b4,x        ; $c11b: bd b4 03  
            cmp #$21           ; $c11e: c9 21     
            beq __c145         ; $c120: f0 23     
            cmp #$22           ; $c122: c9 22     
            beq __c145         ; $c124: f0 1f     
            cmp #$25           ; $c126: c9 25     
            bcc __c13a         ; $c128: 90 10     
            cmp #$28           ; $c12a: c9 28     
            bcc __c145         ; $c12c: 90 17     
            cmp #$2d           ; $c12e: c9 2d     
            bcc __c13a         ; $c130: 90 08     
            cmp #$30           ; $c132: c9 30     
            bcc __c145         ; $c134: 90 0f     
            .hex c9            ; $c136: c9        Suspected data
__c137:     .hex 34 f0         ; $c137: 34 f0     Invalid Opcode - NOP $f0,x
            .hex 0b            ; $c139: 0b        Suspected data
__c13a:     lda $30            ; $c13a: a5 30     
            cmp #$01           ; $c13c: c9 01     
            beq __c145         ; $c13e: f0 05     
            lda $93            ; $c140: a5 93     
            asl                ; $c142: 0a        
            sta $93            ; $c143: 85 93     
__c145:     lda $93            ; $c145: a5 93     
            sta $04c2,x        ; $c147: 9d c2 04  
            jmp __8168         ; $c14a: 4c 68 81  

;-------------------------------------------------------------------------------
__c14d:     lda $30            ; $c14d: a5 30     
            bne __c15b         ; $c14f: d0 0a     
            lda $17            ; $c151: a5 17     
            cmp #$a4           ; $c153: c9 a4     
            beq __c15b         ; $c155: f0 04     
            lda $82            ; $c157: a5 82     
            bne __c108         ; $c159: d0 ad     
__c15b:     lda $17            ; $c15b: a5 17     
            and #$7f           ; $c15d: 29 7f     
            sta $03b4,x        ; $c15f: 9d b4 03  
            iny                ; $c162: c8        
            lda ($3d),y        ; $c163: b1 3d     
            sta $04d4,x        ; $c165: 9d d4 04  
            lda $01            ; $c168: a5 01     
            sta $0348,x        ; $c16a: 9d 48 03  
            lda $09            ; $c16d: a5 09     
            sta $0324,x        ; $c16f: 9d 24 03  
            lda $03d8,x        ; $c172: bd d8 03  
            ora #$08           ; $c175: 09 08     
            sta $03d8,x        ; $c177: 9d d8 03  
            lda $02            ; $c17a: a5 02     
            sta $0432,x        ; $c17c: 9d 32 04  
            tax                ; $c17f: aa        
            jmp __8188         ; $c180: 4c 88 81  

;-------------------------------------------------------------------------------
            ldx $02            ; $c183: a6 02     
            iny                ; $c185: c8        
            iny                ; $c186: c8        
            iny                ; $c187: c8        
            iny                ; $c188: c8        
            inx                ; $c189: e8        
            jmp __8055         ; $c18a: 4c 55 80  

;-------------------------------------------------------------------------------
            .hex 86            ; $c18d: 86        Suspected data
__c18e:     brk                ; $c18e: 00        
            jmp __80d9         ; $c18f: 4c d9 80  

;-------------------------------------------------------------------------------
            .hex ab 8e         ; $c192: ab 8e     Invalid Opcode - LAX #$8e
            lda $92,x          ; $c194: b5 92     
            bcs __c137         ; $c196: b0 9f     
            sbc $29ad,y        ; $c198: f9 ad 29  
            tay                ; $c19b: a8        
            sed                ; $c19c: f8        
            .hex b3 a2         ; $c19d: b3 a2     Invalid Opcode - LAX ($a2),y
            .hex 06            ; $c19f: 06        Suspected data
__c1a0:     .hex bd b4         ; $c1a0: bd b4     Suspected data
__c1a2:     .hex 03 f0         ; $c1a2: 03 f0     Invalid Opcode - SLO ($f0,x)
            .hex 22            ; $c1a4: 22        Invalid Opcode - KIL 
            bmi __c1c7         ; $c1a5: 30 20     
            jsr __e08c         ; $c1a7: 20 8c e0  
            lda $03c6,x        ; $c1aa: bd c6 03  
            and #$42           ; $c1ad: 29 42     
            bne __c1c7         ; $c1af: d0 16     
            lda $04f8,x        ; $c1b1: bd f8 04  
            bne __c1c1         ; $c1b4: d0 0b     
            .hex a9            ; $c1b6: a9        Suspected data
__c1b7:     brk                ; $c1b7: 00        
            .hex 9d 12         ; $c1b8: 9d 12     Suspected data
__c1ba:     .hex 03            ; $c1ba: 03        Suspected data
__c1bb:     jsr __81cd         ; $c1bb: 20 cd 81  
            jmp __81c7         ; $c1be: 4c c7 81  

;-------------------------------------------------------------------------------
__c1c1:     dec $04f8,x        ; $c1c1: de f8 04  
            jsr __d9cf         ; $c1c4: 20 cf d9  
__c1c7:     inx                ; $c1c7: e8        
            cpx #$12           ; $c1c8: e0 12     
            bne __c1a0         ; $c1ca: d0 d4     
            rts                ; $c1cc: 60        

;-------------------------------------------------------------------------------
            lda $03b4,x        ; $c1cd: bd b4 03  
            jsr __c5bb         ; $c1d0: 20 bb c5  
            txs                ; $c1d3: 9a        
            .hex 82 aa         ; $c1d4: 82 aa     Invalid Opcode - NOP #$aa
            .hex 8f 13 a5      ; $c1d6: 8f 13 a5  Invalid Opcode - SAX __a513
            ldy $83,x          ; $c1d9: b4 83     
            .hex 7e a2         ; $c1db: 7e a2     Suspected data
__c1dd:     sbc ($93,x)        ; $c1dd: e1 93     
            inx                ; $c1df: e8        
            .hex a3 0f         ; $c1e0: a3 0f     Invalid Opcode - LAX ($0f,x)
            sty $ca            ; $c1e2: 84 ca     
            .hex a7 f2         ; $c1e4: a7 f2     Invalid Opcode - LAX $f2
            .hex a7 45         ; $c1e6: a7 45     Invalid Opcode - LAX $45
            tax                ; $c1e8: aa        
            brk                ; $c1e9: 00        
            brk                ; $c1ea: 00        
            .hex 62            ; $c1eb: 62        Invalid Opcode - KIL 
            sta $22,x          ; $c1ec: 95 22     
            stx $25,y          ; $c1ee: 96 25     
            sty $5b            ; $c1f0: 84 5b     
            sty $e2,x          ; $c1f2: 94 e2     
            .hex b2            ; $c1f4: b2        Invalid Opcode - KIL 
            .hex 34 99         ; $c1f5: 34 99     Invalid Opcode - NOP $99,x
            .hex 85            ; $c1f7: 85        Suspected data
__c1f8:     lda ($10,x)        ; $c1f8: a1 10     
            ldx #$62           ; $c1fa: a2 62     
            .hex 93 67         ; $c1fc: 93 67     Invalid Opcode - AHX ($67),y
            .hex a3 92         ; $c1fe: a3 92     Invalid Opcode - LAX ($92,x)
            bcs __c18e         ; $c200: b0 8c     
            .hex 8f 95 ae      ; $c202: 8f 95 ae  Invalid Opcode - SAX __ae95
            bvs __c1b7         ; $c205: 70 b0     
            nop                ; $c207: ea        
            sty $0c            ; $c208: 84 0c     
            .hex ab f4         ; $c20a: ab f4     Invalid Opcode - LAX #$f4
            lda #$0a           ; $c20c: a9 0a     
            .hex b3 bd         ; $c20e: b3 bd     Invalid Opcode - LAX ($bd),y
            lda ($d3),y        ; $c210: b1 d3     
            .hex 97 62         ; $c212: 97 62     Invalid Opcode - SAX $62,y
            .hex 97 4b         ; $c214: 97 4b     Invalid Opcode - SAX $4b,y
            sta $4b            ; $c216: 85 4b     
            sta $9a            ; $c218: 85 9a     
            .hex 82 5a         ; $c21a: 82 5a     Invalid Opcode - NOP #$5a
            bcc __c1dd         ; $c21c: 90 bf     
            .hex 93 35         ; $c21e: 93 35     Invalid Opcode - AHX ($35),y
            .hex 83 35         ; $c220: 83 35     Invalid Opcode - SAX ($35,x)
            .hex 83 e2         ; $c222: 83 e2     Invalid Opcode - SAX ($e2,x)
            stx __8f50         ; $c224: 8e 50 8f  
            .hex 0b 8f         ; $c227: 0b 8f     Invalid Opcode - ANC #$8f
            bvc __c1ba         ; $c229: 50 8f     
            adc __cc8f,x       ; $c22b: 7d 8f cc  
            .hex 83 cc         ; $c22e: 83 cc     Invalid Opcode - SAX ($cc,x)
            .hex 83 cc         ; $c230: 83 cc     Invalid Opcode - SAX ($cc,x)
            .hex 83 8f         ; $c232: 83 8f     Invalid Opcode - SAX ($8f,x)
            .hex 83 8f         ; $c234: 83 8f     Invalid Opcode - SAX ($8f,x)
            .hex 83 86         ; $c236: 83 86     Invalid Opcode - SAX ($86,x)
            .hex b3 8f         ; $c238: b3 8f     Invalid Opcode - LAX ($8f),y
            .hex 83 4b         ; $c23a: 83 4b     Invalid Opcode - SAX ($4b,x)
            sta $50            ; $c23c: 85 50     
            .hex 8f 6f 82      ; $c23e: 8f 6f 82  Invalid Opcode - SAX __826f
            .hex 9b            ; $c241: 9b        Invalid Opcode - TAS 
            .hex 82 66         ; $c242: 82 66     Invalid Opcode - NOP #$66
            ldx __aa6f         ; $c244: ae 6f aa  
            ora ($ad),y        ; $c247: 11 ad     
            asl $31ac,x        ; $c249: 1e ac 31  
            ldy $dc            ; $c24c: a4 dc     
            ldy $e1            ; $c24e: a4 e1     
            stx $a0,y          ; $c250: 96 a0     
            tax                ; $c252: aa        
            and ($ae,x)        ; $c253: 21 ae     
            ora __d8b1,y       ; $c255: 19 b1 d8  
            .hex 9c 6c 83      ; $c258: 9c 6c 83  Invalid Opcode - SHY __836c,x
            .hex 1b 9e d2      ; $c25b: 1b 9e d2  Invalid Opcode - SLO __d29e,y
            sta __9edd,x       ; $c25e: 9d dd 9e  
            sty $b5,x          ; $c261: 94 b5     
            txa                ; $c263: 8a        
            ldx $fd,y          ; $c264: b6 fd     
            .hex 92            ; $c266: 92        Invalid Opcode - KIL 
            .hex f4 af         ; $c267: f4 af     Invalid Opcode - NOP $af,x
            asl                ; $c269: 0a        
            lda $77,x          ; $c26a: b5 77     
            lda $9f,x          ; $c26c: b5 9f     
            ldx $bd,y          ; $c26e: b6 bd     
            cld                ; $c270: d8        
            .hex 03 d0         ; $c271: 03 d0     Invalid Opcode - SLO ($d0,x)
            php                ; $c273: 08        
            jsr __dec2         ; $c274: 20 c2 de  
            lda #$20           ; $c277: a9 20     
            jmp __ded8         ; $c279: 4c d8 de  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $c27c: 20 2a dd  
            lda $0444,x        ; $c27f: bd 44 04  
            cmp #$18           ; $c282: c9 18     
            bne __c297         ; $c284: d0 11     
            jsr __df82         ; $c286: 20 82 df  
            jsr __dfad         ; $c289: 20 ad df  
            sta $03d8,x        ; $c28c: 9d d8 03  
            lda #$37           ; $c28f: a9 37     
            sta $03b4,x        ; $c291: 9d b4 03  
            jmp __82a0         ; $c294: 4c a0 82  

;-------------------------------------------------------------------------------
__c297:     inc $0444,x        ; $c297: fe 44 04  
            rts                ; $c29a: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c29b: bd d8 03  
            bne __c2e0         ; $c29e: d0 40     
            lda #$04           ; $c2a0: a9 04     
            sta $03d8,x        ; $c2a2: 9d d8 03  
            lda $2e            ; $c2a5: a5 2e     
            and #$01           ; $c2a7: 29 01     
            bne __c2ae         ; $c2a9: d0 03     
            .hex 4c            ; $c2ab: 4c        Suspected data
__c2ac:     .hex 42            ; $c2ac: 42        Invalid Opcode - KIL 
            .hex df            ; $c2ad: df        Suspected data
__c2ae:     lda $0456,x        ; $c2ae: bd 56 04  
            lsr                ; $c2b1: 4a        
__c2b2:     php                ; $c2b2: 08        
            tay                ; $c2b3: a8        
            lda $30            ; $c2b4: a5 30     
            cmp #$01           ; $c2b6: c9 01     
            beq __c2c3         ; $c2b8: f0 09     
            lda $82            ; $c2ba: a5 82     
            bne __c2c3         ; $c2bc: d0 05     
            lda __82e9,y       ; $c2be: b9 e9 82  
            bne __c2c6         ; $c2c1: d0 03     
__c2c3:     lda __830f,y       ; $c2c3: b9 0f 83  
__c2c6:     plp                ; $c2c6: 28        
            bcs __c2ce         ; $c2c7: b0 05     
            jsr __e373         ; $c2c9: 20 73 e3  
            bne __c2d0         ; $c2cc: d0 02     
__c2ce:     and #$0f           ; $c2ce: 29 0f     
__c2d0:     ora #$80           ; $c2d0: 09 80     
            sta $0300,x        ; $c2d2: 9d 00 03  
            lda #$f0           ; $c2d5: a9 f0     
            sta $0444,x        ; $c2d7: 9d 44 04  
            lda #$00           ; $c2da: a9 00     
            sta $0420,x        ; $c2dc: 9d 20 04  
            rts                ; $c2df: 60        

;-------------------------------------------------------------------------------
__c2e0:     lda $0444,x        ; $c2e0: bd 44 04  
            .hex f0            ; $c2e3: f0        Suspected data
__c2e4:     dec $de            ; $c2e4: c6 de     
            .hex 44 04         ; $c2e6: 44 04     Invalid Opcode - NOP $04
            rts                ; $c2e8: 60        

;-------------------------------------------------------------------------------
            .hex bb bb bc      ; $c2e9: bb bb bc  Invalid Opcode - LAS __bcbb,y
            .hex cb bb         ; $c2ec: cb bb     Invalid Opcode - AXS #$bb
            .hex bb bb bc      ; $c2ee: bb bb bc  Invalid Opcode - LAS __bcbb,y
            .hex bb bb cc      ; $c2f1: bb bb cc  Invalid Opcode - LAS __ccbb,y
            .hex cb cb         ; $c2f4: cb cb     Invalid Opcode - AXS #$cb
            .hex bb bc bb      ; $c2f6: bb bc bb  Invalid Opcode - LAS __bbbc,y
            .hex bb bb bb      ; $c2f9: bb bb bb  Invalid Opcode - LAS __bbbb,y
            .hex bb bb bb      ; $c2fc: bb bb bb  Invalid Opcode - LAS __bbbb,y
            .hex bb bb bb      ; $c2ff: bb bb bb  Invalid Opcode - LAS __bbbb,y
            .hex bb bb bb      ; $c302: bb bb bb  Invalid Opcode - LAS __bbbb,y
            ldy __bbdd,x       ; $c305: bc dd bb  
            lda __bbcc,x       ; $c308: bd cc bb  
            .hex bb bb bb      ; $c30b: bb bb bb  Invalid Opcode - LAS __bbbb,y
            cpy #$bc           ; $c30e: c0 bc     
            cpy __cbcc         ; $c310: cc cc cb  
            cpy __cccc         ; $c313: cc cc cc  
            cmp __cccc         ; $c316: cd cc cc  
            cmp __dbdc         ; $c319: cd dc db  
            cpy __cbcd         ; $c31c: cc cd cb  
            cpy __cccc         ; $c31f: cc cc cc  
            cpy __cccc         ; $c322: cc cc cc  
            cpy __cccc         ; $c325: cc cc cc  
            cpy __cccc         ; $c328: cc cc cc  
            cmp __ccdd         ; $c32b: cd dd cc  
            cmp __cccc         ; $c32e: cd cc cc  
            cpy __cccc         ; $c331: cc cc cc  
            cpy #$bd           ; $c334: c0 bd     
            cld                ; $c336: d8        
            .hex 03 d0         ; $c337: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 1a            ; $c339: 1a        Invalid Opcode - NOP 
            lda #$04           ; $c33a: a9 04     
            sta $03d8,x        ; $c33c: 9d d8 03  
            lda #$08           ; $c33f: a9 08     
            sta $03c6,x        ; $c341: 9d c6 03  
            lda $03b4,x        ; $c344: bd b4 03  
            cmp #$27           ; $c347: c9 27     
            beq __c34f         ; $c349: f0 04     
            lda #$20           ; $c34b: a9 20     
            bne __c351         ; $c34d: d0 02     
__c34f:     lda #$3b           ; $c34f: a9 3b     
__c351:     jmp __ded8         ; $c351: 4c d8 de  

;-------------------------------------------------------------------------------
            lda $0444,x        ; $c354: bd 44 04  
            bne __c369         ; $c357: d0 10     
            lda $03c6,x        ; $c359: bd c6 03  
            and #$f7           ; $c35c: 29 f7     
            ldy $4f            ; $c35e: a4 4f     
            cpy #$03           ; $c360: c0 03     
            beq __c366         ; $c362: f0 02     
            ora #$08           ; $c364: 09 08     
__c366:     sta $03c6,x        ; $c366: 9d c6 03  
__c369:     jmp __dd2a         ; $c369: 4c 2a dd  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c36c: bd d8 03  
            bne __c378         ; $c36f: d0 07     
            lda #$82           ; $c371: a9 82     
            ldy #$00           ; $c373: a0 00     
            jmp __ded0         ; $c375: 4c d0 de  

;-------------------------------------------------------------------------------
__c378:     ldy #$18           ; $c378: a0 18     
__c37a:     lda $0324,x        ; $c37a: bd 24 03  
            sta $0200,y        ; $c37d: 99 00 02  
            lda $0348,x        ; $c380: bd 48 03  
            sta $0203,y        ; $c383: 99 03 02  
            iny                ; $c386: c8        
            iny                ; $c387: c8        
            iny                ; $c388: c8        
            iny                ; $c389: c8        
            cpy #$38           ; $c38a: c0 38     
            bcc __c37a         ; $c38c: 90 ec     
            rts                ; $c38e: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c38f: bd d8 03  
            bne __c3b1         ; $c392: d0 1d     
            lda #$02           ; $c394: a9 02     
            sta $03d8,x        ; $c396: 9d d8 03  
            lda $03b4,x        ; $c399: bd b4 03  
            cmp #$33           ; $c39c: c9 33     
            bne __c3a9         ; $c39e: d0 09     
            lda #$01           ; $c3a0: a9 01     
            sta $04c2,x        ; $c3a2: 9d c2 04  
            lda #$48           ; $c3a5: a9 48     
            bne __c3ab         ; $c3a7: d0 02     
__c3a9:     lda #$29           ; $c3a9: a9 29     
__c3ab:     sta $0300,x        ; $c3ab: 9d 00 03  
            jmp __e010         ; $c3ae: 4c 10 e0  

;-------------------------------------------------------------------------------
__c3b1:     jmp __e0f4         ; $c3b1: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c3b4: bd d8 03  
            bne __c3c6         ; $c3b7: d0 0d     
            jsr __deca         ; $c3b9: 20 ca de  
            lda #$05           ; $c3bc: a9 05     
            jsr __ded8         ; $c3be: 20 d8 de  
            lda #$80           ; $c3c1: a9 80     
            jmp __de6f         ; $c3c3: 4c 6f de  

;-------------------------------------------------------------------------------
__c3c6:     jsr __dd2a         ; $c3c6: 20 2a dd  
            jmp __8629         ; $c3c9: 4c 29 86  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c3cc: bd d8 03  
            bne __c3f6         ; $c3cf: d0 25     
            lda #$40           ; $c3d1: a9 40     
            sta $03d8,x        ; $c3d3: 9d d8 03  
            lda $03b4,x        ; $c3d6: bd b4 03  
            sec                ; $c3d9: 38        
            sbc #$2d           ; $c3da: e9 2d     
            tay                ; $c3dc: a8        
            lda __83f3,y       ; $c3dd: b9 f3 83  
            sta $93            ; $c3e0: 85 93     
            cmp #$0f           ; $c3e2: c9 0f     
            bne __c3ee         ; $c3e4: d0 08     
            lda $30            ; $c3e6: a5 30     
            beq __c3ee         ; $c3e8: f0 04     
            lda #$0b           ; $c3ea: a9 0b     
            sta $93            ; $c3ec: 85 93     
__c3ee:     lda $93            ; $c3ee: a5 93     
            jmp __ded8         ; $c3f0: 4c d8 de  

;-------------------------------------------------------------------------------
            .hex 0c 0b 0f      ; $c3f3: 0c 0b 0f  Invalid Opcode - NOP $0f0b
__c3f6:     jsr __dd2a         ; $c3f6: 20 2a dd  
            lda $0444,x        ; $c3f9: bd 44 04  
            cmp #$50           ; $c3fc: c9 50     
            bne __c408         ; $c3fe: d0 08     
            jsr __dfad         ; $c400: 20 ad df  
            lda #$80           ; $c403: a9 80     
            jsr __de6f         ; $c405: 20 6f de  
__c408:     jsr __8629         ; $c408: 20 29 86  
            inc $0444,x        ; $c40b: fe 44 04  
            rts                ; $c40e: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c40f: bd d8 03  
            bne __c41b         ; $c412: d0 07     
            lda #$82           ; $c414: a9 82     
            ldy #$5c           ; $c416: a0 5c     
            jmp __ded0         ; $c418: 4c d0 de  

;-------------------------------------------------------------------------------
__c41b:     lda #$18           ; $c41b: a9 18     
            sta $08            ; $c41d: 85 08     
            jsr __dfe4         ; $c41f: 20 e4 df  
            jmp __e0f4         ; $c422: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c425: bd d8 03  
            bne __c432         ; $c428: d0 08     
            jsr __deca         ; $c42a: 20 ca de  
            lda #$23           ; $c42d: a9 23     
            jmp __ded8         ; $c42f: 4c d8 de  

;-------------------------------------------------------------------------------
__c432:     jsr __dd2a         ; $c432: 20 2a dd  
            lda $04d4,x        ; $c435: bd d4 04  
            cmp #$80           ; $c438: c9 80     
            bne __c452         ; $c43a: d0 16     
            asl                ; $c43c: 0a        
            sta $04d4,x        ; $c43d: 9d d4 04  
            lda $03c6,x        ; $c440: bd c6 03  
            bne __c452         ; $c443: d0 0d     
            lda #$1c           ; $c445: a9 1c     
            jsr __c118         ; $c447: 20 18 c1  
            jsr __8c8a         ; $c44a: 20 8a 8c  
            lda #$33           ; $c44d: a9 33     
            jmp __8e26         ; $c44f: 4c 26 8e  

;-------------------------------------------------------------------------------
__c452:     inc $04d4,x        ; $c452: fe d4 04  
            lda $0444,x        ; $c455: bd 44 04  
            jsr __c5bb         ; $c458: 20 bb c5  
            .hex 63 84         ; $c45b: 63 84     Invalid Opcode - RRA ($84,x)
            jmp ($7f84)        ; $c45d: 6c 84 7f  

;-------------------------------------------------------------------------------
            sty $b9            ; $c460: 84 b9     
            sty $a9            ; $c462: 84 a9     
            cpy #$20           ; $c464: c0 20     
            .hex 6f de         ; $c466: 6f de     Suspected data
__c468:     inc $0444,x        ; $c468: fe 44 04  
            rts                ; $c46b: 60        

;-------------------------------------------------------------------------------
            inc $0456,x        ; $c46c: fe 56 04  
            lda $0456,x        ; $c46f: bd 56 04  
            cmp #$30           ; $c472: c9 30     
            beq __c468         ; $c474: f0 f2     
            lda $30            ; $c476: a5 30     
            cmp #$01           ; $c478: c9 01     
            bne __c4d7         ; $c47a: d0 5b     
            jmp __8629         ; $c47c: 4c 29 86  

;-------------------------------------------------------------------------------
            stx $10            ; $c47f: 86 10     
            lda #$00           ; $c481: a9 00     
            sta $0456,x        ; $c483: 9d 56 04  
            sta $0390,x        ; $c486: 9d 90 03  
            sta $03a2,x        ; $c489: 9d a2 03  
            jsr __dfb3         ; $c48c: 20 b3 df  
            bcs __c4b1         ; $c48f: b0 20     
            ldy $10            ; $c491: a4 10     
            lda $03c6,y        ; $c493: b9 c6 03  
            bne __c4b1         ; $c496: d0 19     
            lda #$1a           ; $c498: a9 1a     
            jsr __de7b         ; $c49a: 20 7b de  
            lda $10            ; $c49d: a5 10     
            sta $0444,x        ; $c49f: 9d 44 04  
            lda #$01           ; $c4a2: a9 01     
            sta $036c,y        ; $c4a4: 99 6c 03  
            txa                ; $c4a7: 8a        
            sta $048c,y        ; $c4a8: 99 8c 04  
            ldx $10            ; $c4ab: a6 10     
            inc $0444,x        ; $c4ad: fe 44 04  
            rts                ; $c4b0: 60        

;-------------------------------------------------------------------------------
__c4b1:     ldx $10            ; $c4b1: a6 10     
            lda #$00           ; $c4b3: a9 00     
            sta $0444,x        ; $c4b5: 9d 44 04  
            rts                ; $c4b8: 60        

;-------------------------------------------------------------------------------
            inc $0468,x        ; $c4b9: fe 68 04  
            lda $0468,x        ; $c4bc: bd 68 04  
            cmp #$40           ; $c4bf: c9 40     
            bne __c4d7         ; $c4c1: d0 14     
            inc $047a,x        ; $c4c3: fe 7a 04  
            lda $047a,x        ; $c4c6: bd 7a 04  
            cmp #$02           ; $c4c9: c9 02     
            beq __c4da         ; $c4cb: f0 0d     
            lda #$00           ; $c4cd: a9 00     
            sta $0468,x        ; $c4cf: 9d 68 04  
            lda #$ff           ; $c4d2: a9 ff     
            sta $036c,x        ; $c4d4: 9d 6c 03  
__c4d7:     jmp __e0f4         ; $c4d7: 4c f4 e0  

;-------------------------------------------------------------------------------
__c4da:     jsr __dfa3         ; $c4da: 20 a3 df  
            sta $047a,x        ; $c4dd: 9d 7a 04  
            sta $048c,x        ; $c4e0: 9d 8c 04  
            sta $036c,x        ; $c4e3: 9d 6c 03  
            inc $0324,x        ; $c4e6: fe 24 03  
__c4e9:     rts                ; $c4e9: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $c4ea: bd d8 03  
            bne __c4f6         ; $c4ed: d0 07     
            lda #$80           ; $c4ef: a9 80     
            ldy #$75           ; $c4f1: a0 75     
            jmp __ded0         ; $c4f3: 4c d0 de  

;-------------------------------------------------------------------------------
__c4f6:     stx $10            ; $c4f6: 86 10     
            ldy $10            ; $c4f8: a4 10     
            lda $0444,x        ; $c4fa: bd 44 04  
            tax                ; $c4fd: aa        
            lda $03b4,x        ; $c4fe: bd b4 03  
            beq __c53e         ; $c501: f0 3b     
            lda $03b4,x        ; $c503: bd b4 03  
__c506:     cmp #$36           ; $c506: c9 36     
            beq __c53e         ; $c508: f0 34     
            lda $03c6,x        ; $c50a: bd c6 03  
            sta $03c6,y        ; $c50d: 99 c6 03  
            lda $04f8,x        ; $c510: bd f8 04  
            sta $04f8,y        ; $c513: 99 f8 04  
            ldx $10            ; $c516: a6 10     
            inc $0468,x        ; $c518: fe 68 04  
            lda $0468,x        ; $c51b: bd 68 04  
            cmp #$10           ; $c51e: c9 10     
            bne __c4e9         ; $c520: d0 c7     
            lda #$00           ; $c522: a9 00     
            sta $0468,x        ; $c524: 9d 68 04  
            lda $0456,x        ; $c527: bd 56 04  
            tay                ; $c52a: a8        
            lda __8543,y       ; $c52b: b9 43 85  
            sta $0300,x        ; $c52e: 9d 00 03  
            inc $0456,x        ; $c531: fe 56 04  
            lda $0456,x        ; $c534: bd 56 04  
            cmp #$08           ; $c537: c9 08     
            bne __c4e9         ; $c539: d0 ae     
            jmp __df7f         ; $c53b: 4c 7f df  

;-------------------------------------------------------------------------------
__c53e:     ldx $10            ; $c53e: a6 10     
            jmp __df42         ; $c540: 4c 42 df  

;-------------------------------------------------------------------------------
            ror $77,x          ; $c543: 76 77     
            sta $85            ; $c545: 85 85     
            .hex 77 76         ; $c547: 77 76     Invalid Opcode - RRA $76,x
            adc $00,x          ; $c549: 75 00     
            lda $048c,x        ; $c54b: bd 8c 04  
            beq __c553         ; $c54e: f0 03     
            dec $048c,x        ; $c550: de 8c 04  
__c553:     lda $03d8,x        ; $c553: bd d8 03  
            bne __c5a5         ; $c556: d0 4d     
            jsr __dec2         ; $c558: 20 c2 de  
            lda $03b4,x        ; $c55b: bd b4 03  
            cmp #$22           ; $c55e: c9 22     
            beq __c56e         ; $c560: f0 0c     
            cmp #$34           ; $c562: c9 34     
            beq __c56a         ; $c564: f0 04     
            lda #$51           ; $c566: a9 51     
            bne __c570         ; $c568: d0 06     
__c56a:     lda #$1b           ; $c56a: a9 1b     
            bne __c570         ; $c56c: d0 02     
__c56e:     lda #$43           ; $c56e: a9 43     
__c570:     sta $0300,x        ; $c570: 9d 00 03  
            lda $04c2,x        ; $c573: bd c2 04  
            and #$0f           ; $c576: 29 0f     
            jsr __c5bb         ; $c578: 20 bb c5  
            .hex 89 85         ; $c57b: 89 85     Invalid Opcode - NOP #$85
            .hex 89 85         ; $c57d: 89 85     Invalid Opcode - NOP #$85
            bcc __c506         ; $c57f: 90 85     
            sty $85,x          ; $c581: 94 85     
            .hex 89 85         ; $c583: 89 85     Invalid Opcode - NOP #$85
            txs                ; $c585: 9a        
            sta $9e            ; $c586: 85 9e     
            sta $a9            ; $c588: 85 a9     
            brk                ; $c58a: 00        
            ldy #$80           ; $c58b: a0 80     
            jmp __e076         ; $c58d: 4c 76 e0  

;-------------------------------------------------------------------------------
            lda #$00           ; $c590: a9 00     
            beq __c596         ; $c592: f0 02     
            lda #$ff           ; $c594: a9 ff     
__c596:     ldy #$80           ; $c596: a0 80     
            bne __c5a2         ; $c598: d0 08     
            lda #$01           ; $c59a: a9 01     
            bne __c5a0         ; $c59c: d0 02     
            lda #$ff           ; $c59e: a9 ff     
__c5a0:     ldy #$00           ; $c5a0: a0 00     
__c5a2:     jmp __e04f         ; $c5a2: 4c 4f e0  

;-------------------------------------------------------------------------------
__c5a5:     lda $04c2,x        ; $c5a5: bd c2 04  
            and #$0f           ; $c5a8: 29 0f     
            jsr __c5bb         ; $c5aa: 20 bb c5  
            .hex bb 85 bb      ; $c5ad: bb 85 bb  Invalid Opcode - LAS __bb85,y
            sta $d1            ; $c5b0: 85 d1     
            sta $d1            ; $c5b2: 85 d1     
            sta $fe            ; $c5b4: 85 fe     
            .hex 85            ; $c5b6: 85        Suspected data
__c5b7:     asl $86,x          ; $c5b7: 16 86     
            asl $86,x          ; $c5b9: 16 86     
__c5bb:     lda $0456,x        ; $c5bb: bd 56 04  
            bne __c5cb         ; $c5be: d0 0b     
            lda $04c2,x        ; $c5c0: bd c2 04  
            and #$f0           ; $c5c3: 29 f0     
            sta $0456,x        ; $c5c5: 9d 56 04  
            jmp __e03b         ; $c5c8: 4c 3b e0  

;-------------------------------------------------------------------------------
__c5cb:     dec $0456,x        ; $c5cb: de 56 04  
            jmp __e0f4         ; $c5ce: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $4f            ; $c5d1: a5 4f     
            cmp #$06           ; $c5d3: c9 06     
            beq __c5de         ; $c5d5: f0 07     
            lda $03c6,x        ; $c5d7: bd c6 03  
            ora #$20           ; $c5da: 09 20     
            bne __c5e3         ; $c5dc: d0 05     
__c5de:     lda $03c6,x        ; $c5de: bd c6 03  
            and #$df           ; $c5e1: 29 df     
__c5e3:     sta $03c6,x        ; $c5e3: 9d c6 03  
            lda $0390,x        ; $c5e6: bd 90 03  
            bmi __c5ef         ; $c5e9: 30 04     
            lda #$0d           ; $c5eb: a9 0d     
            bne __c5f1         ; $c5ed: d0 02     
__c5ef:     lda #$f3           ; $c5ef: a9 f3     
__c5f1:     ldy #$00           ; $c5f1: a0 00     
            jsr __e2a2         ; $c5f3: 20 a2 e2  
            bcs __c5fb         ; $c5f6: b0 03     
            jsr __e027         ; $c5f8: 20 27 e0  
__c5fb:     jmp __e0f4         ; $c5fb: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $4f            ; $c5fe: a5 4f     
            cmp #$06           ; $c600: c9 06     
            beq __c60b         ; $c602: f0 07     
            lda $03c6,x        ; $c604: bd c6 03  
            ora #$20           ; $c607: 09 20     
            bne __c610         ; $c609: d0 05     
__c60b:     lda $03c6,x        ; $c60b: bd c6 03  
            and #$df           ; $c60e: 29 df     
__c610:     sta $03c6,x        ; $c610: 9d c6 03  
            jmp __85bb         ; $c613: 4c bb 85  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $c616: bd 56 04  
            bne __c5cb         ; $c619: d0 b0     
            lda $04c2,x        ; $c61b: bd c2 04  
            and #$f0           ; $c61e: 29 f0     
            sta $0456,x        ; $c620: 9d 56 04  
            jsr __e027         ; $c623: 20 27 e0  
            jmp __85cb         ; $c626: 4c cb 85  

;-------------------------------------------------------------------------------
            jsr __de8b         ; $c629: 20 8b de  
            jsr __dea1         ; $c62c: 20 a1 de  
            jmp __e0f4         ; $c62f: 4c f4 e0  

;-------------------------------------------------------------------------------
            ora ($02,x)        ; $c632: 01 02     
            .hex 04 08         ; $c634: 04 08     Invalid Opcode - NOP $08
            bpl __c658         ; $c636: 10 20     
            rti                ; $c638: 40        

;-------------------------------------------------------------------------------
            .hex 80 20         ; $c639: 80 20     Invalid Opcode - NOP #$20
            .hex 7f 89 20      ; $c63b: 7f 89 20  Invalid Opcode - RRA $2089,x
            .hex 43 86         ; $c63e: 43 86     Invalid Opcode - SRE ($86,x)
            jmp __888d         ; $c640: 4c 8d 88  

;-------------------------------------------------------------------------------
            lda $34            ; $c643: a5 34     
            beq __c648         ; $c645: f0 01     
            rts                ; $c647: 60        

;-------------------------------------------------------------------------------
__c648:     lda $04f8          ; $c648: ad f8 04  
            beq __c650         ; $c64b: f0 03     
            dec $04f8          ; $c64d: ce f8 04  
__c650:     lda $1d            ; $c650: a5 1d     
            and #$01           ; $c652: 29 01     
            bne __c65a         ; $c654: d0 04     
            lda #$06           ; $c656: a9 06     
__c658:     bne __c65c         ; $c658: d0 02     
__c65a:     lda #$07           ; $c65a: a9 07     
__c65c:     tax                ; $c65c: aa        
            lda $03b4,x        ; $c65d: bd b4 03  
            bmi __c664         ; $c660: 30 02     
            bne __c667         ; $c662: d0 03     
__c664:     jmp __8855         ; $c664: 4c 55 88  

;-------------------------------------------------------------------------------
__c667:     lda $03c6,x        ; $c667: bd c6 03  
            bne __c664         ; $c66a: d0 f8     
            lda #$00           ; $c66c: a9 00     
            sta $02            ; $c66e: 85 02     
            jsr __8c45         ; $c670: 20 45 8c  
            lda $0348          ; $c673: ad 48 03  
            sec                ; $c676: 38        
            sbc $0348,x        ; $c677: fd 48 03  
            bpl __c681         ; $c67a: 10 05     
            jsr __deb7         ; $c67c: 20 b7 de  
            inc $02            ; $c67f: e6 02     
__c681:     sec                ; $c681: 38        
            sbc $0a            ; $c682: e5 0a     
            sec                ; $c684: 38        
            sbc #$06           ; $c685: e9 06     
            bmi __c68c         ; $c687: 30 03     
            jmp __8855         ; $c689: 4c 55 88  

;-------------------------------------------------------------------------------
__c68c:     lda $0324,x        ; $c68c: bd 24 03  
            clc                ; $c68f: 18        
            adc $08            ; $c690: 65 08     
            sta $00            ; $c692: 85 00     
            lda $0324          ; $c694: ad 24 03  
            clc                ; $c697: 18        
            adc #$03           ; $c698: 69 03     
            sec                ; $c69a: 38        
            sbc $00            ; $c69b: e5 00     
            bpl __c6a2         ; $c69d: 10 03     
            jsr __deb7         ; $c69f: 20 b7 de  
__c6a2:     sec                ; $c6a2: 38        
            sbc $09            ; $c6a3: e5 09     
            sec                ; $c6a5: 38        
            sbc #$0a           ; $c6a6: e9 0a     
            bmi __c6ad         ; $c6a8: 30 03     
            jmp __8855         ; $c6aa: 4c 55 88  

;-------------------------------------------------------------------------------
__c6ad:     lda $03d8,x        ; $c6ad: bd d8 03  
            and #$80           ; $c6b0: 29 80     
            bne __c72c         ; $c6b2: d0 78     
            lda $03d8,x        ; $c6b4: bd d8 03  
            and #$40           ; $c6b7: 29 40     
            beq __c72d         ; $c6b9: f0 72     
            lda $43            ; $c6bb: a5 43     
            beq __c6c3         ; $c6bd: f0 04     
            lda $41            ; $c6bf: a5 41     
            bne __c72c         ; $c6c1: d0 69     
__c6c3:     lda #$80           ; $c6c3: a9 80     
            sta $3f            ; $c6c5: 85 3f     
            lda $03b4,x        ; $c6c7: bd b4 03  
            cmp #$2e           ; $c6ca: c9 2e     
            beq __c719         ; $c6cc: f0 4b     
            cmp #$2f           ; $c6ce: c9 2f     
            beq __c713         ; $c6d0: f0 41     
            cmp #$1e           ; $c6d2: c9 1e     
            beq __c713         ; $c6d4: f0 3d     
            cmp #$3c           ; $c6d6: c9 3c     
            beq __c6ee         ; $c6d8: f0 14     
            lda $04d4,x        ; $c6da: bd d4 04  
            sta $7f            ; $c6dd: 85 7f     
            lda $03b4,x        ; $c6df: bd b4 03  
            cmp #$2d           ; $c6e2: c9 2d     
            beq __c6ea         ; $c6e4: f0 04     
            lda #$00           ; $c6e6: a9 00     
            beq __c72a         ; $c6e8: f0 40     
__c6ea:     lda #$a0           ; $c6ea: a9 a0     
            bne __c72a         ; $c6ec: d0 3c     
__c6ee:     ldy #$00           ; $c6ee: a0 00     
            lda $4f            ; $c6f0: a5 4f     
            cmp #$02           ; $c6f2: c9 02     
            bne __c708         ; $c6f4: d0 12     
            lda $50            ; $c6f6: a5 50     
            cmp #$07           ; $c6f8: c9 07     
            bne __c708         ; $c6fa: d0 0c     
            lda $51            ; $c6fc: a5 51     
            and #$01           ; $c6fe: 29 01     
            beq __c708         ; $c700: f0 06     
            lda #$0c           ; $c702: a9 0c     
            ldy #$01           ; $c704: a0 01     
            bne __c70a         ; $c706: d0 02     
__c708:     lda #$0b           ; $c708: a9 0b     
__c70a:     sta $7f            ; $c70a: 85 7f     
            sty $04ec          ; $c70c: 8c ec 04  
            lda #$c0           ; $c70f: a9 c0     
            bne __c72a         ; $c711: d0 17     
__c713:     lda #$40           ; $c713: a9 40     
            sta $08            ; $c715: 85 08     
            bne __c725         ; $c717: d0 0c     
__c719:     ldy $04d4,x        ; $c719: bc d4 04  
            lda __8871,y       ; $c71c: b9 71 88  
            sta $7f            ; $c71f: 85 7f     
            lda #$20           ; $c721: a9 20     
            sta $08            ; $c723: 85 08     
__c725:     lda $04d4,x        ; $c725: bd d4 04  
            ora $08            ; $c728: 05 08     
__c72a:     sta $40            ; $c72a: 85 40     
__c72c:     rts                ; $c72c: 60        

;-------------------------------------------------------------------------------
__c72d:     lda $03d8,x        ; $c72d: bd d8 03  
            and #$04           ; $c730: 29 04     
            bne __c737         ; $c732: d0 03     
            jmp __87de         ; $c734: 4c de 87  

;-------------------------------------------------------------------------------
__c737:     lda $0300,x        ; $c737: bd 00 03  
            cmp #$8b           ; $c73a: c9 8b     
            bne __c744         ; $c73c: d0 06     
            lda #$02           ; $c73e: a9 02     
            ldy #$01           ; $c740: a0 01     
            bne __c75c         ; $c742: d0 18     
__c744:     lda $0300,x        ; $c744: bd 00 03  
            cmp #$8c           ; $c747: c9 8c     
            bne __c751         ; $c749: d0 06     
            lda #$04           ; $c74b: a9 04     
            ldy #$03           ; $c74d: a0 03     
            bne __c75c         ; $c74f: d0 0b     
__c751:     lda $0300,x        ; $c751: bd 00 03  
            cmp #$8d           ; $c754: c9 8d     
            bne __c784         ; $c756: d0 2c     
            lda #$06           ; $c758: a9 06     
            ldy #$05           ; $c75a: a0 05     
__c75c:     sta $08            ; $c75c: 85 08     
            lda $48            ; $c75e: a5 48     
            sta $09            ; $c760: 85 09     
            jsr __dede         ; $c762: 20 de de  
            sta $48            ; $c765: 85 48     
            bcc __c776         ; $c767: 90 0d     
            lda #$01           ; $c769: a9 01     
            sta $08            ; $c76b: 85 08     
            lda $49            ; $c76d: a5 49     
            sta $09            ; $c76f: 85 09     
            jsr __dede         ; $c771: 20 de de  
            sta $49            ; $c774: 85 49     
__c776:     jsr __8860         ; $c776: 20 60 88  
            jsr __d4f7         ; $c779: 20 f7 d4  
            lda #$1f           ; $c77c: a9 1f     
            jsr __c118         ; $c77e: 20 18 c1  
            jmp __df42         ; $c781: 4c 42 df  

;-------------------------------------------------------------------------------
__c784:     lda $03b4,x        ; $c784: bd b4 03  
            cmp #$25           ; $c787: c9 25     
            bne __c79b         ; $c789: d0 10     
            lda $04c2,x        ; $c78b: bd c2 04  
            and #$0f           ; $c78e: 29 0f     
            sec                ; $c790: 38        
            sbc #$08           ; $c791: e9 08     
            tay                ; $c793: a8        
            lda __8632,y       ; $c794: b9 32 86  
            ora $91            ; $c797: 05 91     
            sta $91            ; $c799: 85 91     
__c79b:     lda #$22           ; $c79b: a9 22     
            jsr __c118         ; $c79d: 20 18 c1  
            lda #$80           ; $c7a0: a9 80     
            sta $3f            ; $c7a2: 85 3f     
            lda $04c2,x        ; $c7a4: bd c2 04  
            sta $7f            ; $c7a7: 85 7f     
            lda $03b4,x        ; $c7a9: bd b4 03  
            cmp #$27           ; $c7ac: c9 27     
            beq __c7d7         ; $c7ae: f0 27     
            cmp #$26           ; $c7b0: c9 26     
            beq __c7cd         ; $c7b2: f0 19     
            cmp #$49           ; $c7b4: c9 49     
            bne __c7d3         ; $c7b6: d0 1b     
            lda $04c2,x        ; $c7b8: bd c2 04  
            cmp #$26           ; $c7bb: c9 26     
            bne __c7c7         ; $c7bd: d0 08     
            lda $92            ; $c7bf: a5 92     
            ora #$02           ; $c7c1: 09 02     
            sta $92            ; $c7c3: 85 92     
            bne __c7d3         ; $c7c5: d0 0c     
__c7c7:     lda $4a            ; $c7c7: a5 4a     
            ora #$04           ; $c7c9: 09 04     
            bne __c7d1         ; $c7cb: d0 04     
__c7cd:     lda $4a            ; $c7cd: a5 4a     
            ora #$20           ; $c7cf: 09 20     
__c7d1:     sta $4a            ; $c7d1: 85 4a     
__c7d3:     lda #$60           ; $c7d3: a9 60     
            bne __c7d9         ; $c7d5: d0 02     
__c7d7:     lda #$80           ; $c7d7: a9 80     
__c7d9:     sta $40            ; $c7d9: 85 40     
            jmp __df42         ; $c7db: 4c 42 df  

;-------------------------------------------------------------------------------
            lda $04d6          ; $c7de: ad d6 04  
            beq __c80d         ; $c7e1: f0 2a     
            lda $03d8,x        ; $c7e3: bd d8 03  
            and #$02           ; $c7e6: 29 02     
            beq __c80d         ; $c7e8: f0 23     
            lda $03b4,x        ; $c7ea: bd b4 03  
            cmp #$30           ; $c7ed: c9 30     
            beq __c7f5         ; $c7ef: f0 04     
            cmp #$31           ; $c7f1: c9 31     
            bne __c80d         ; $c7f3: d0 18     
__c7f5:     lda $0420          ; $c7f5: ad 20 04  
            cmp $0420,x        ; $c7f8: dd 20 04  
            beq __c80d         ; $c7fb: f0 10     
            lda #$14           ; $c7fd: a9 14     
            jsr __c118         ; $c7ff: 20 18 c1  
            lda $03d8,x        ; $c802: bd d8 03  
            ora #$80           ; $c805: 09 80     
            sta $03d8,x        ; $c807: 9d d8 03  
            jmp __e027         ; $c80a: 4c 27 e0  

;-------------------------------------------------------------------------------
__c80d:     lda $0197          ; $c80d: ad 97 01  
            bne __c817         ; $c810: d0 05     
            lda $04f8          ; $c812: ad f8 04  
            beq __c818         ; $c815: f0 01     
__c817:     rts                ; $c817: 60        

;-------------------------------------------------------------------------------
__c818:     lda $8b            ; $c818: a5 8b     
            asl                ; $c81a: 0a        
            tay                ; $c81b: a8        
            lda __8bf1,y       ; $c81c: b9 f1 8b  
            sta $08            ; $c81f: 85 08     
            lda __8bf2,y       ; $c821: b9 f2 8b  
            sta $09            ; $c824: 85 09     
            lda $03b4,x        ; $c826: bd b4 03  
            lsr                ; $c829: 4a        
            tay                ; $c82a: a8        
            lda __8bb7,y       ; $c82b: b9 b7 8b  
            bcs __c835         ; $c82e: b0 05     
            jsr __e373         ; $c830: 20 73 e3  
            bne __c837         ; $c833: d0 02     
__c835:     and #$0f           ; $c835: 29 0f     
__c837:     tay                ; $c837: a8        
            lda ($08),y        ; $c838: b1 08     
            sta $08            ; $c83a: 85 08     
            jsr __d356         ; $c83c: 20 56 d3  
            lda #$40           ; $c83f: a9 40     
            sta $04f8          ; $c841: 8d f8 04  
            ldy #$00           ; $c844: a0 00     
            lda $0348,x        ; $c846: bd 48 03  
            cmp $0348          ; $c849: cd 48 03  
            bcc __c84f         ; $c84c: 90 01     
            iny                ; $c84e: c8        
__c84f:     sty $0420          ; $c84f: 8c 20 04  
            jmp __d36f         ; $c852: 4c 6f d3  

;-------------------------------------------------------------------------------
            inx                ; $c855: e8        
            inx                ; $c856: e8        
            cpx #$12           ; $c857: e0 12     
            bcs __c85e         ; $c859: b0 03     
            jmp __865d         ; $c85b: 4c 5d 86  

;-------------------------------------------------------------------------------
__c85e:     clc                ; $c85e: 18        
            rts                ; $c85f: 60        

;-------------------------------------------------------------------------------
            lda $49            ; $c860: a5 49     
            cmp #$02           ; $c862: c9 02     
            bcc __c870         ; $c864: 90 0a     
            lda $48            ; $c866: a5 48     
            cmp #$56           ; $c868: c9 56     
            bcc __c870         ; $c86a: 90 04     
            lda #$56           ; $c86c: a9 56     
            sta $48            ; $c86e: 85 48     
__c870:     rts                ; $c870: 60        

;-------------------------------------------------------------------------------
            bmi __c874         ; $c871: 30 01     
            .hex 2f            ; $c873: 2f        Suspected data
__c874:     .hex 37 36         ; $c874: 37 36     Invalid Opcode - RLA $36,x
            bpl __c895         ; $c876: 10 1d     
            .hex 32            ; $c878: 32        Invalid Opcode - KIL 
            .hex 33 34         ; $c879: 33 34     Invalid Opcode - RLA ($34),y
            and $20,x          ; $c87b: 35 20     
            .hex bb c5 3a      ; $c87d: bb c5 3a  Invalid Opcode - LAS $3ac5,y
            tax                ; $c880: aa        
            .hex 47 93         ; $c881: 47 93     Invalid Opcode - SRE $93
            .hex 03 ae         ; $c883: 03 ae     Invalid Opcode - SLO ($ae,x)
            .hex 6f 90 88      ; $c885: 6f 90 88  Invalid Opcode - RRA __8890
            bcc __c8fc         ; $c888: 90 72     
            sty __ae12         ; $c88a: 8c 12 ae  
            lda $0445          ; $c88d: ad 45 04  
            cmp #$03           ; $c890: c9 03     
            beq __c895         ; $c892: f0 01     
            rts                ; $c894: 60        

;-------------------------------------------------------------------------------
__c895:     lda $0420          ; $c895: ad 20 04  
            bne __c89e         ; $c898: d0 04     
            lda #$ea           ; $c89a: a9 ea     
            bne __c8a0         ; $c89c: d0 02     
__c89e:     lda #$16           ; $c89e: a9 16     
__c8a0:     sta $11            ; $c8a0: 85 11     
            lda $0324          ; $c8a2: ad 24 03  
            clc                ; $c8a5: 18        
            adc #$fc           ; $c8a6: 69 fc     
            sta $10            ; $c8a8: 85 10     
            lda $0348          ; $c8aa: ad 48 03  
            clc                ; $c8ad: 18        
            adc $11            ; $c8ae: 65 11     
            sta $11            ; $c8b0: 85 11     
            ldy $0434          ; $c8b2: ac 34 04  
            lda __8bdd,y       ; $c8b5: b9 dd 8b  
            sta $12            ; $c8b8: 85 12     
            lda __8be2,y       ; $c8ba: b9 e2 8b  
            sta $13            ; $c8bd: 85 13     
            ldx #$06           ; $c8bf: a2 06     
            lda $03b4,x        ; $c8c1: bd b4 03  
            bpl __c8c9         ; $c8c4: 10 03     
            jmp __895f         ; $c8c6: 4c 5f 89  

;-------------------------------------------------------------------------------
__c8c9:     lda $04f8,x        ; $c8c9: bd f8 04  
            bne __c8d9         ; $c8cc: d0 0b     
            lda $03b4,x        ; $c8ce: bd b4 03  
            cmp #$36           ; $c8d1: c9 36     
            beq __c8d9         ; $c8d3: f0 04     
            cmp #$37           ; $c8d5: c9 37     
            bne __c8dc         ; $c8d7: d0 03     
__c8d9:     jmp __895f         ; $c8d9: 4c 5f 89  

;-------------------------------------------------------------------------------
__c8dc:     lda $03d8,x        ; $c8dc: bd d8 03  
            and #$c4           ; $c8df: 29 c4     
            bne __c8d9         ; $c8e1: d0 f6     
            lda $03c6,x        ; $c8e3: bd c6 03  
            bne __c8d9         ; $c8e6: d0 f1     
            jsr __8c45         ; $c8e8: 20 45 8c  
            lda $11            ; $c8eb: a5 11     
            sec                ; $c8ed: 38        
            sbc $0348,x        ; $c8ee: fd 48 03  
            bpl __c8f6         ; $c8f1: 10 03     
            jsr __deb7         ; $c8f3: 20 b7 de  
__c8f6:     sec                ; $c8f6: 38        
            sbc $0a            ; $c8f7: e5 0a     
            sec                ; $c8f9: 38        
            sbc $12            ; $c8fa: e5 12     
__c8fc:     bpl __c95f         ; $c8fc: 10 61     
            lda $0324,x        ; $c8fe: bd 24 03  
            clc                ; $c901: 18        
            adc $08            ; $c902: 65 08     
            sta $14            ; $c904: 85 14     
            lda $10            ; $c906: a5 10     
            sec                ; $c908: 38        
            sbc $14            ; $c909: e5 14     
            bpl __c910         ; $c90b: 10 03     
            jsr __deb7         ; $c90d: 20 b7 de  
__c910:     sec                ; $c910: 38        
            sbc $09            ; $c911: e5 09     
            sec                ; $c913: 38        
            sbc #$04           ; $c914: e9 04     
            bpl __c95f         ; $c916: 10 47     
            lda $04c2,x        ; $c918: bd c2 04  
            beq __c971         ; $c91b: f0 54     
            sec                ; $c91d: 38        
            sbc $13            ; $c91e: e5 13     
            sta $04c2,x        ; $c920: 9d c2 04  
            bcc __c927         ; $c923: 90 02     
            bne __c967         ; $c925: d0 40     
__c927:     lda $03b4,x        ; $c927: bd b4 03  
            cmp #$42           ; $c92a: c9 42     
            beq __c972         ; $c92c: f0 44     
            cmp #$44           ; $c92e: c9 44     
            beq __c972         ; $c930: f0 40     
            cmp #$47           ; $c932: c9 47     
            bne __c939         ; $c934: d0 03     
            jmp __8aa6         ; $c936: 4c a6 8a  

;-------------------------------------------------------------------------------
__c939:     lda #$1a           ; $c939: a9 1a     
            jsr __c118         ; $c93b: 20 18 c1  
            lda $03d8,x        ; $c93e: bd d8 03  
            and #$02           ; $c941: 29 02     
            bne __c95c         ; $c943: d0 17     
            lda $03b4,x        ; $c945: bd b4 03  
            sta $0456,x        ; $c948: 9d 56 04  
            jsr __df82         ; $c94b: 20 82 df  
            lda #$00           ; $c94e: a9 00     
            sta $03d8,x        ; $c950: 9d d8 03  
            sta $0444,x        ; $c953: 9d 44 04  
            lda #$36           ; $c956: a9 36     
            sta $03b4,x        ; $c958: 9d b4 03  
            rts                ; $c95b: 60        

;-------------------------------------------------------------------------------
__c95c:     jmp __df42         ; $c95c: 4c 42 df  

;-------------------------------------------------------------------------------
__c95f:     inx                ; $c95f: e8        
            cpx #$12           ; $c960: e0 12     
            beq __c971         ; $c962: f0 0d     
            jmp __88c1         ; $c964: 4c c1 88  

;-------------------------------------------------------------------------------
__c967:     lda #$18           ; $c967: a9 18     
            jsr __c118         ; $c969: 20 18 c1  
            lda #$10           ; $c96c: a9 10     
            sta $04f8,x        ; $c96e: 9d f8 04  
__c971:     rts                ; $c971: 60        

;-------------------------------------------------------------------------------
__c972:     jsr __df42         ; $c972: 20 42 df  
            lda #$49           ; $c975: a9 49     
            sta $03b4,x        ; $c977: 9d b4 03  
            lda #$21           ; $c97a: a9 21     
            jmp __c118         ; $c97c: 4c 18 c1  

;-------------------------------------------------------------------------------
            ldx #$03           ; $c97f: a2 03     
            lda $03b4,x        ; $c981: bd b4 03  
            beq __c98b         ; $c984: f0 05     
            lda $03c6,x        ; $c986: bd c6 03  
            beq __c98e         ; $c989: f0 03     
__c98b:     jmp __8a89         ; $c98b: 4c 89 8a  

;-------------------------------------------------------------------------------
__c98e:     lda $03b4,x        ; $c98e: bd b4 03  
            cmp #$02           ; $c991: c9 02     
            beq __c9aa         ; $c993: f0 15     
            cmp #$03           ; $c995: c9 03     
            beq __c9aa         ; $c997: f0 11     
            cmp #$05           ; $c999: c9 05     
            beq __c9aa         ; $c99b: f0 0d     
            cmp #$06           ; $c99d: c9 06     
            beq __c9aa         ; $c99f: f0 09     
            tay                ; $c9a1: a8        
            lda __8be7,y       ; $c9a2: b9 e7 8b  
            sta $0b            ; $c9a5: 85 0b     
            jmp __89be         ; $c9a7: 4c be 89  

;-------------------------------------------------------------------------------
__c9aa:     ldy $0434          ; $c9aa: ac 34 04  
            lda __8be2,y       ; $c9ad: b9 e2 8b  
            sta $0b            ; $c9b0: 85 0b     
            lda $03b4,x        ; $c9b2: bd b4 03  
            cmp #$03           ; $c9b5: c9 03     
            beq __c9be         ; $c9b7: f0 05     
            lda $0b            ; $c9b9: a5 0b     
            lsr                ; $c9bb: 4a        
            sta $0b            ; $c9bc: 85 0b     
__c9be:     ldy #$06           ; $c9be: a0 06     
            lda $03b4,y        ; $c9c0: b9 b4 03  
            bne __c9c8         ; $c9c3: d0 03     
__c9c5:     jmp __8a81         ; $c9c5: 4c 81 8a  

;-------------------------------------------------------------------------------
__c9c8:     cmp #$36           ; $c9c8: c9 36     
            beq __c9c5         ; $c9ca: f0 f9     
            cmp #$37           ; $c9cc: c9 37     
            beq __c9c5         ; $c9ce: f0 f5     
            cmp #$25           ; $c9d0: c9 25     
            beq __c9e0         ; $c9d2: f0 0c     
            lda $03c6,y        ; $c9d4: b9 c6 03  
            bne __c9c5         ; $c9d7: d0 ec     
            lda $03d8,y        ; $c9d9: b9 d8 03  
            and #$c2           ; $c9dc: 29 c2     
            bne __c9c5         ; $c9de: d0 e5     
__c9e0:     lda $04f8,y        ; $c9e0: b9 f8 04  
            beq __c9e8         ; $c9e3: f0 03     
            jmp __8a81         ; $c9e5: 4c 81 8a  

;-------------------------------------------------------------------------------
__c9e8:     sty $97            ; $c9e8: 84 97     
            stx $93            ; $c9ea: 86 93     
            tya                ; $c9ec: 98        
            tax                ; $c9ed: aa        
            jsr __8c45         ; $c9ee: 20 45 8c  
            ldx $93            ; $c9f1: a6 93     
            ldy $97            ; $c9f3: a4 97     
            lda $0348,x        ; $c9f5: bd 48 03  
            sec                ; $c9f8: 38        
            sbc $0348,y        ; $c9f9: f9 48 03  
            bpl __ca03         ; $c9fc: 10 05     
            jsr __deb7         ; $c9fe: 20 b7 de  
            inc $02            ; $ca01: e6 02     
__ca03:     sec                ; $ca03: 38        
            sbc $0a            ; $ca04: e5 0a     
            sec                ; $ca06: 38        
            sbc #$04           ; $ca07: e9 04     
            bmi __ca0e         ; $ca09: 30 03     
            jmp __8a81         ; $ca0b: 4c 81 8a  

;-------------------------------------------------------------------------------
__ca0e:     lda $0324,y        ; $ca0e: b9 24 03  
            clc                ; $ca11: 18        
            adc $08            ; $ca12: 65 08     
            sta $00            ; $ca14: 85 00     
            lda $0324,x        ; $ca16: bd 24 03  
            sec                ; $ca19: 38        
            sbc $00            ; $ca1a: e5 00     
            bpl __ca21         ; $ca1c: 10 03     
            jsr __deb7         ; $ca1e: 20 b7 de  
__ca21:     sec                ; $ca21: 38        
            sbc $09            ; $ca22: e5 09     
            sec                ; $ca24: 38        
            sbc #$04           ; $ca25: e9 04     
            bmi __ca2b         ; $ca27: 30 02     
            bne __ca81         ; $ca29: d0 56     
__ca2b:     lda $03b4,x        ; $ca2b: bd b4 03  
            cmp #$03           ; $ca2e: c9 03     
            bne __ca44         ; $ca30: d0 12     
            lda $03d8,y        ; $ca32: b9 d8 03  
            and #$04           ; $ca35: 29 04     
            bne __ca81         ; $ca37: d0 48     
            lda $04c2,x        ; $ca39: bd c2 04  
            bne __ca41         ; $ca3c: d0 03     
            inc $04c2,x        ; $ca3e: fe c2 04  
__ca41:     jmp __8a52         ; $ca41: 4c 52 8a  

;-------------------------------------------------------------------------------
__ca44:     cmp #$07           ; $ca44: c9 07     
            beq __ca9c         ; $ca46: f0 54     
            lda $03b4,y        ; $ca48: b9 b4 03  
            cmp #$42           ; $ca4b: c9 42     
            bne __ca52         ; $ca4d: d0 03     
            jmp __8a81         ; $ca4f: 4c 81 8a  

;-------------------------------------------------------------------------------
__ca52:     lda $03d8,y        ; $ca52: b9 d8 03  
            and #$04           ; $ca55: 29 04     
            bne __ca81         ; $ca57: d0 28     
            lda $04c2,y        ; $ca59: b9 c2 04  
            beq __ca81         ; $ca5c: f0 23     
            sec                ; $ca5e: 38        
            sbc $0b            ; $ca5f: e5 0b     
            sta $04c2,y        ; $ca61: 99 c2 04  
            bcc __ca68         ; $ca64: 90 02     
            bne __ca91         ; $ca66: d0 29     
__ca68:     lda $03b4,y        ; $ca68: b9 b4 03  
            cmp #$42           ; $ca6b: c9 42     
            beq __ca9f         ; $ca6d: f0 30     
            cmp #$44           ; $ca6f: c9 44     
            beq __ca9f         ; $ca71: f0 2c     
            cmp #$47           ; $ca73: c9 47     
            beq __caa4         ; $ca75: f0 2d     
            lda #$1a           ; $ca77: a9 1a     
            jsr __c118         ; $ca79: 20 18 c1  
            tya                ; $ca7c: 98        
            tax                ; $ca7d: aa        
            jmp __8945         ; $ca7e: 4c 45 89  

;-------------------------------------------------------------------------------
__ca81:     iny                ; $ca81: c8        
            cpy #$12           ; $ca82: c0 12     
            beq __ca89         ; $ca84: f0 03     
            jmp __89c0         ; $ca86: 4c c0 89  

;-------------------------------------------------------------------------------
__ca89:     inx                ; $ca89: e8        
            cpx #$06           ; $ca8a: e0 06     
            beq __ca9b         ; $ca8c: f0 0d     
            jmp __8981         ; $ca8e: 4c 81 89  

;-------------------------------------------------------------------------------
__ca91:     lda #$18           ; $ca91: a9 18     
            jsr __c118         ; $ca93: 20 18 c1  
            lda #$20           ; $ca96: a9 20     
            sta $04f8,y        ; $ca98: 99 f8 04  
__ca9b:     rts                ; $ca9b: 60        

;-------------------------------------------------------------------------------
__ca9c:     jmp __92cd         ; $ca9c: 4c cd 92  

;-------------------------------------------------------------------------------
__ca9f:     tya                ; $ca9f: 98        
            tax                ; $caa0: aa        
            jmp __8972         ; $caa1: 4c 72 89  

;-------------------------------------------------------------------------------
__caa4:     tya                ; $caa4: 98        
            tax                ; $caa5: aa        
            stx $96            ; $caa6: 86 96     
            jsr __c0e7         ; $caa8: 20 e7 c0  
            lda #$21           ; $caab: a9 21     
            jsr __c118         ; $caad: 20 18 c1  
            ldx $96            ; $cab0: a6 96     
            lda #$4d           ; $cab2: a9 4d     
            sta $03b4,x        ; $cab4: 9d b4 03  
            lda #$00           ; $cab7: a9 00     
            sta $03d8,x        ; $cab9: 9d d8 03  
            sta $04c2,x        ; $cabc: 9d c2 04  
            rts                ; $cabf: 60        

;-------------------------------------------------------------------------------
            lsr $8b,x          ; $cac0: 56 8b     
            lsr $5c8b,x        ; $cac2: 5e 8b 5c  
            .hex 8b 57         ; $cac5: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 77         ; $cac7: 8b 77     Invalid Opcode - XAA #$77
            .hex 8b 61         ; $cac9: 8b 61     Invalid Opcode - XAA #$61
            .hex 8b 61         ; $cacb: 8b 61     Invalid Opcode - XAA #$61
            .hex 8b 57         ; $cacd: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 5e         ; $cacf: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 5e         ; $cad1: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 5e         ; $cad3: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cad5: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 5e         ; $cad7: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cad9: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 5e         ; $cadb: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cadd: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cadf: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 61         ; $cae1: 8b 61     Invalid Opcode - XAA #$61
            .hex 8b 5e         ; $cae3: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cae5: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cae7: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 64         ; $cae9: 8b 64     Invalid Opcode - XAA #$64
            .hex 8b 57         ; $caeb: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $caed: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 64         ; $caef: 8b 64     Invalid Opcode - XAA #$64
            .hex 8b 6f         ; $caf1: 8b 6f     Invalid Opcode - XAA #$6f
            .hex 8b 5e         ; $caf3: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 67         ; $caf5: 8b 67     Invalid Opcode - XAA #$67
            .hex 8b 57         ; $caf7: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $caf9: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cafb: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 65         ; $cafd: 8b 65     Invalid Opcode - XAA #$65
__caff:     .hex 8b 5e         ; $caff: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cb01: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb03: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb05: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb07: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 6a         ; $cb09: 8b 6a     Invalid Opcode - XAA #$6a
            .hex 8b 6c         ; $cb0b: 8b 6c     Invalid Opcode - XAA #$6c
            .hex 8b 6c         ; $cb0d: 8b 6c     Invalid Opcode - XAA #$6c
            .hex 8b 57         ; $cb0f: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb11: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb13: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb15: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb17: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb19: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb1b: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb1d: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 6f         ; $cb1f: 8b 6f     Invalid Opcode - XAA #$6f
            .hex 8b 6f         ; $cb21: 8b 6f     Invalid Opcode - XAA #$6f
            .hex 8b 65         ; $cb23: 8b 65     Invalid Opcode - XAA #$65
            .hex 8b 5e         ; $cb25: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 57         ; $cb27: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb29: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb2b: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb2d: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 7a         ; $cb2f: 8b 7a     Invalid Opcode - XAA #$7a
            .hex 8b 57         ; $cb31: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 74         ; $cb33: 8b 74     Invalid Opcode - XAA #$74
            .hex 8b 57         ; $cb35: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb37: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 57         ; $cb39: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 5e         ; $cb3b: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 73         ; $cb3d: 8b 73     Invalid Opcode - XAA #$73
            .hex 8b 5c         ; $cb3f: 8b 5c     Invalid Opcode - XAA #$5c
            .hex 8b 65         ; $cb41: 8b 65     Invalid Opcode - XAA #$65
            .hex 8b 6e         ; $cb43: 8b 6e     Invalid Opcode - XAA #$6e
            .hex 8b 57         ; $cb45: 8b 57     Invalid Opcode - XAA #$57
            .hex 8b 6e         ; $cb47: 8b 6e     Invalid Opcode - XAA #$6e
            .hex 8b 5e         ; $cb49: 8b 5e     Invalid Opcode - XAA #$5e
            .hex 8b 6f         ; $cb4b: 8b 6f     Invalid Opcode - XAA #$6f
            .hex 8b 56         ; $cb4d: 8b 56     Invalid Opcode - XAA #$56
            .hex 8b 65         ; $cb4f: 8b 65     Invalid Opcode - XAA #$65
            .hex 8b 6c         ; $cb51: 8b 6c     Invalid Opcode - XAA #$6c
            .hex 8b 7c         ; $cb53: 8b 7c     Invalid Opcode - XAA #$7c
            .hex 8b 0b         ; $cb55: 8b 0b     Invalid Opcode - XAA #$0b
            brk                ; $cb57: 00        
            brk                ; $cb58: 00        
            brk                ; $cb59: 00        
            brk                ; $cb5a: 00        
            brk                ; $cb5b: 00        
            ora $05            ; $cb5c: 05 05     
            .hex 04 04         ; $cb5e: 04 04     Invalid Opcode - NOP $04
            .hex 04 08         ; $cb60: 04 08     Invalid Opcode - NOP $08
            php                ; $cb62: 08        
            php                ; $cb63: 08        
            .hex 12            ; $cb64: 12        Invalid Opcode - KIL 
            asl $06            ; $cb65: 06 06     
            bpl __cb72         ; $cb67: 10 09     
            bpl __cb7a         ; $cb69: 10 0f     
            .hex 0f 01 01      ; $cb6b: 0f 01 01  Invalid Opcode - SLO $0101
            .hex 07 03         ; $cb6e: 07 03     Invalid Opcode - SLO $03
            .hex 03 03         ; $cb70: 03 03     Invalid Opcode - SLO ($03,x)
__cb72:     .hex 03 0c         ; $cb72: 03 0c     Invalid Opcode - SLO ($0c,x)
            asl $0e0e          ; $cb74: 0e 0e 0e  
            ora ($11),y        ; $cb77: 11 11     
            .hex 11            ; $cb79: 11        Suspected data
__cb7a:     asl                ; $cb7a: 0a        
            asl                ; $cb7b: 0a        
            ora __fc0d         ; $cb7c: 0d 0d fc  
            .hex 0c 06 fc      ; $cb7f: 0c 06 fc  Invalid Opcode - NOP __fc06
            .hex 04 04         ; $cb82: 04 04     Invalid Opcode - NOP $04
            .hex fc 02 02      ; $cb84: fc 02 02  Invalid Opcode - NOP $0202,x
            .hex 02            ; $cb87: 02        Invalid Opcode - KIL 
            .hex 02            ; $cb88: 02        Invalid Opcode - KIL 
            .hex 02            ; $cb89: 02        Invalid Opcode - KIL 
            brk                ; $cb8a: 00        
            .hex 04 04         ; $cb8b: 04 04     Invalid Opcode - NOP $04
            brk                ; $cb8d: 00        
            .hex 0f 04 00      ; $cb8e: 0f 04 00  Bad Addr Mode - SLO $0004
            asl $06            ; $cb91: 06 06     
            brk                ; $cb93: 00        
            .hex 14 0c         ; $cb94: 14 0c     Invalid Opcode - NOP $0c,x
            .hex fc 0c 08      ; $cb96: fc 0c 08  Invalid Opcode - NOP $080c,x
            ora $06            ; $cb99: 05 06     
            asl $0d            ; $cb9b: 06 0d     
            .hex 04 04         ; $cb9d: 04 04     Invalid Opcode - NOP $04
            beq __cbc1         ; $cb9f: f0 20     
            jsr $0cfc          ; $cba1: 20 fc 0c  
            asl $04f2          ; $cba4: 0e f2 04  
            .hex 04 f4         ; $cba7: 04 f4     Invalid Opcode - NOP $f4
            .hex 13 07         ; $cba9: 13 07     Invalid Opcode - SLO ($07),y
            .hex 04 06         ; $cbab: 04 06     Invalid Opcode - NOP $06
            asl $05            ; $cbad: 06 05     
            .hex 0c 06 fd      ; $cbaf: 0c 06 fd  Invalid Opcode - NOP __fd06
            .hex 0c 06 00      ; $cbb2: 0c 06 00  Bad Addr Mode - NOP $0006
            bpl __cbbd         ; $cbb5: 10 06     
            brk                ; $cbb7: 00        
            ora ($12),y        ; $cbb8: 11 12     
            and ($00,x)        ; $cbba: 21 00     
            .hex 10            ; $cbbc: 10        Suspected data
__cbbd:     ora ($13),y        ; $cbbd: 11 13     
            ora ($11),y        ; $cbbf: 11 11     
__cbc1:     .hex 43 31         ; $cbc1: 43 31     Invalid Opcode - SRE ($31,x)
            ora ($12),y        ; $cbc3: 11 12     
            .hex 12            ; $cbc5: 12        Invalid Opcode - KIL 
            ora ($31),y        ; $cbc6: 11 31     
            ora ($14),y        ; $cbc8: 11 14     
            bpl __cbed         ; $cbca: 10 21     
__cbcc:     .hex 11            ; $cbcc: 11        Suspected data
__cbcd:     ora ($11),y        ; $cbcd: 11 11     
            ora ($21),y        ; $cbcf: 11 21     
            ora ($11),y        ; $cbd1: 11 11     
            .hex 13 44         ; $cbd3: 13 44     Invalid Opcode - SLO ($44),y
            ora ($34),y        ; $cbd5: 11 34     
            .hex 23 51         ; $cbd7: 23 51     Invalid Opcode - RLA ($51,x)
            .hex 53 27         ; $cbd9: 53 27     Invalid Opcode - SRE ($27),y
            eor ($20),y        ; $cbdb: 51 20     
            bpl __cbf7         ; $cbdd: 10 18     
            clc                ; $cbdf: 18        
            jsr $0120          ; $cbe0: 20 20 01  
            .hex 02            ; $cbe3: 02        Invalid Opcode - KIL 
            .hex 04 08         ; $cbe4: 04 08     Invalid Opcode - NOP $08
            .hex 0f 01 02      ; $cbe6: 0f 01 02  Invalid Opcode - SLO $0201
            .hex 04 08         ; $cbe9: 04 08     Invalid Opcode - NOP $08
            ora ($04,x)        ; $cbeb: 01 04     
__cbed:     .hex 04 01         ; $cbed: 04 01     Invalid Opcode - NOP $01
            ora ($01,x)        ; $cbef: 01 01     
            .hex ff 8b 09      ; $cbf1: ff 8b 09  Invalid Opcode - ISC $098b,x
            sty __8c13         ; $cbf4: 8c 13 8c  
__cbf7:     ora $278c,x        ; $cbf7: 1d 8c 27  
            sty __8c31         ; $cbfa: 8c 31 8c  
            .hex 3b 8c 04      ; $cbfd: 3b 8c 04  Invalid Opcode - RLA $048c,y
            php                ; $cc00: 08        
            .hex 0c 10 20      ; $cc01: 0c 10 20  Invalid Opcode - NOP $2010
            bmi __cc46         ; $cc04: 30 40     
            bvc __cc68         ; $cc06: 50 60     
            .hex 80 03         ; $cc08: 80 03     Invalid Opcode - NOP #$03
            asl $09            ; $cc0a: 06 09     
            .hex 0c 18 24      ; $cc0c: 0c 18 24  Invalid Opcode - NOP $2418
            bmi __cc4d         ; $cc0f: 30 3c     
            pha                ; $cc11: 48        
            rts                ; $cc12: 60        

;-------------------------------------------------------------------------------
            .hex 02            ; $cc13: 02        Invalid Opcode - KIL 
            .hex 04 06         ; $cc14: 04 06     Invalid Opcode - NOP $06
            php                ; $cc16: 08        
            bpl __cc31         ; $cc17: 10 18     
            jsr $3028          ; $cc19: 20 28 30  
            rti                ; $cc1c: 40        

;-------------------------------------------------------------------------------
            ora ($02,x)        ; $cc1d: 01 02     
            .hex 03 04         ; $cc1f: 03 04     Invalid Opcode - SLO ($04,x)
            php                ; $cc21: 08        
            .hex 0c 10 14      ; $cc22: 0c 10 14  Invalid Opcode - NOP $1410
            clc                ; $cc25: 18        
            jsr $0101          ; $cc26: 20 01 01  
            .hex 02            ; $cc29: 02        Invalid Opcode - KIL 
            .hex 02            ; $cc2a: 02        Invalid Opcode - KIL 
            .hex 04 06         ; $cc2b: 04 06     Invalid Opcode - NOP $06
            php                ; $cc2d: 08        
            asl                ; $cc2e: 0a        
            .hex 0c 10         ; $cc2f: 0c 10     Suspected data
__cc31:     ora ($01,x)        ; $cc31: 01 01     
            ora ($02,x)        ; $cc33: 01 02     
            .hex 02            ; $cc35: 02        Invalid Opcode - KIL 
            .hex 04 05         ; $cc36: 04 05     Invalid Opcode - NOP $05
            asl $08            ; $cc38: 06 08     
            asl                ; $cc3a: 0a        
            ora ($01,x)        ; $cc3b: 01 01     
            ora ($01,x)        ; $cc3d: 01 01     
            .hex 02            ; $cc3f: 02        Invalid Opcode - KIL 
            .hex 03 04         ; $cc40: 03 04     Invalid Opcode - SLO ($04,x)
            ora $06            ; $cc42: 05 06     
            php                ; $cc44: 08        
            .hex bd            ; $cc45: bd        Suspected data
__cc46:     ldy $03,x          ; $cc46: b4 03     
            asl                ; $cc48: 0a        
            tay                ; $cc49: a8        
            lda __8ac0,y       ; $cc4a: b9 c0 8a  
__cc4d:     sta $00            ; $cc4d: 85 00     
            lda __8ac1,y       ; $cc4f: b9 c1 8a  
            sta $01            ; $cc52: 85 01     
            ldy $03fc,x        ; $cc54: bc fc 03  
            beq __cc5a         ; $cc57: f0 01     
            dey                ; $cc59: 88        
__cc5a:     lda ($00),y        ; $cc5a: b1 00     
            sta $00            ; $cc5c: 85 00     
            asl                ; $cc5e: 0a        
            adc $00            ; $cc5f: 65 00     
            tay                ; $cc61: a8        
            lda __8b7e,y       ; $cc62: b9 7e 8b  
            sta $08            ; $cc65: 85 08     
            .hex b9            ; $cc67: b9        Suspected data
__cc68:     .hex 7f 8b 85      ; $cc68: 7f 8b 85  Invalid Opcode - RRA __858b,x
            ora #$b9           ; $cc6b: 09 b9     
            .hex 80 8b         ; $cc6d: 80 8b     Invalid Opcode - NOP #$8b
            sta $0a            ; $cc6f: 85 0a     
            rts                ; $cc71: 60        

;-------------------------------------------------------------------------------
            lda $0434          ; $cc72: ad 34 04  
            cmp #$03           ; $cc75: c9 03     
            bne __cc85         ; $cc77: d0 0c     
            inc $0434          ; $cc79: ee 34 04  
            lda #$22           ; $cc7c: a9 22     
            jsr __c118         ; $cc7e: 20 18 c1  
            lda #$0e           ; $cc81: a9 0e     
            bne __cc87         ; $cc83: d0 02     
__cc85:     lda #$75           ; $cc85: a9 75     
__cc87:     sta $7f            ; $cc87: 85 7f     
            rts                ; $cc89: 60        

;-------------------------------------------------------------------------------
            lda $0348,x        ; $cc8a: bd 48 03  
            sta $04            ; $cc8d: 85 04     
__cc8f:     lda $0324,x        ; $cc8f: bd 24 03  
            sta $05            ; $cc92: 85 05     
            ldy #$00           ; $cc94: a0 00     
            lda $0348          ; $cc96: ad 48 03  
            sta $00            ; $cc99: 85 00     
            lda $0324          ; $cc9b: ad 24 03  
            sta $01            ; $cc9e: 85 01     
            lda $04            ; $cca0: a5 04     
            cmp $00            ; $cca2: c5 00     
            bcs __ccb2         ; $cca4: b0 0c     
            sta $00            ; $cca6: 85 00     
            lda $0348          ; $cca8: ad 48 03  
            sta $04            ; $ccab: 85 04     
            lda #$03           ; $ccad: a9 03     
            jmp __8cb6         ; $ccaf: 4c b6 8c  

;-------------------------------------------------------------------------------
__ccb2:     ldy #$01           ; $ccb2: a0 01     
            lda #$02           ; $ccb4: a9 02     
            sta $02            ; $ccb6: 85 02     
            lda $04            ; $ccb8: a5 04     
            sec                ; $ccba: 38        
            sbc $00            ; $ccbb: e5 00     
            sta $00            ; $ccbd: 85 00     
            lda $05            ; $ccbf: a5 05     
            sta $04            ; $ccc1: 85 04     
            cmp $01            ; $ccc3: c5 01     
            bcs __ccd5         ; $ccc5: b0 0e     
            sta $01            ; $ccc7: 85 01     
            lda $0324          ; $ccc9: ad 24 03  
__cccc:     adc #$08           ; $cccc: 69 08     
            sta $04            ; $ccce: 85 04     
            lda #$01           ; $ccd0: a9 01     
            jmp __8cdb         ; $ccd2: 4c db 8c  

;-------------------------------------------------------------------------------
__ccd5:     tya                ; $ccd5: 98        
            ora #$02           ; $ccd6: 09 02     
            tay                ; $ccd8: a8        
            lda #$00           ; $ccd9: a9 00     
            sta $03            ; $ccdb: 85 03     
__ccdd:     lda $04            ; $ccdd: a5 04     
            sec                ; $ccdf: 38        
            sbc $01            ; $cce0: e5 01     
            sta $01            ; $cce2: 85 01     
            lda $00            ; $cce4: a5 00     
            cmp $01            ; $cce6: c5 01     
            bcc __ccf1         ; $cce8: 90 07     
            lda $03            ; $ccea: a5 03     
            sta $04            ; $ccec: 85 04     
            lda $02            ; $ccee: a5 02     
            rts                ; $ccf0: 60        

;-------------------------------------------------------------------------------
__ccf1:     lda $02            ; $ccf1: a5 02     
            sta $04            ; $ccf3: 85 04     
            lda $03            ; $ccf5: a5 03     
            rts                ; $ccf7: 60        

;-------------------------------------------------------------------------------
            lda $0348,x        ; $ccf8: bd 48 03  
            cmp $0348          ; $ccfb: cd 48 03  
            .hex 90            ; $ccfe: 90        Suspected data
__ccff:     ora #$bd           ; $ccff: 09 bd     
            dec $03            ; $cd01: c6 03     
            and #$01           ; $cd03: 29 01     
            bne __cd10         ; $cd05: d0 09     
__cd07:     sec                ; $cd07: 38        
            rts                ; $cd08: 60        

;-------------------------------------------------------------------------------
            lda $03c6,x        ; $cd09: bd c6 03  
            and #$01           ; $cd0c: 29 01     
            bne __cd07         ; $cd0e: d0 f7     
__cd10:     clc                ; $cd10: 18        
            rts                ; $cd11: 60        

;-------------------------------------------------------------------------------
            lda $0324,x        ; $cd12: bd 24 03  
            cmp $0324          ; $cd15: cd 24 03  
            rts                ; $cd18: 60        

;-------------------------------------------------------------------------------
            sty $02            ; $cd19: 84 02     
            pha                ; $cd1b: 48        
            jsr __8d32         ; $cd1c: 20 32 8d  
            jsr __e05b         ; $cd1f: 20 5b e0  
            pla                ; $cd22: 68        
            sec                ; $cd23: 38        
            sbc #$10           ; $cd24: e9 10     
            and #$3f           ; $cd26: 29 3f     
            jsr __8d32         ; $cd28: 20 32 8d  
            ldy $00            ; $cd2b: a4 00     
            lda $01            ; $cd2d: a5 01     
            jmp __e076         ; $cd2f: 4c 76 e0  

;-------------------------------------------------------------------------------
            tay                ; $cd32: a8        
            and #$0f           ; $cd33: 29 0f     
            sta $00            ; $cd35: 85 00     
            tya                ; $cd37: 98        
            jsr __e373         ; $cd38: 20 73 e3  
            sta $07            ; $cd3b: 85 07     
            and #$01           ; $cd3d: 29 01     
            bne __cd46         ; $cd3f: d0 05     
            lda $00            ; $cd41: a5 00     
            jmp __8d4b         ; $cd43: 4c 4b 8d  

;-------------------------------------------------------------------------------
__cd46:     lda #$10           ; $cd46: a9 10     
            sec                ; $cd48: 38        
            sbc $00            ; $cd49: e5 00     
            tay                ; $cd4b: a8        
            lda __8d65,y       ; $cd4c: b9 65 8d  
            sta $00            ; $cd4f: 85 00     
            lda #$00           ; $cd51: a9 00     
            sta $01            ; $cd53: 85 01     
            lda $02            ; $cd55: a5 02     
            jsr __8dee         ; $cd57: 20 ee 8d  
            lda $07            ; $cd5a: a5 07     
            beq __cda9         ; $cd5c: f0 4b     
            cmp #$03           ; $cd5e: c9 03     
            beq __cda9         ; $cd60: f0 47     
            jmp __e066         ; $cd62: 4c 66 e0  

;-------------------------------------------------------------------------------
            .hex ff fe fa      ; $cd65: ff fe fa  Invalid Opcode - ISC __fafe,x
            .hex f4 ec         ; $cd68: f4 ec     Invalid Opcode - NOP $ec,x
            sbc ($d4,x)        ; $cd6a: e1 d4     
            cmp $b4            ; $cd6c: c5 b4     
            ldx #$8e           ; $cd6e: a2 8e     
            sei                ; $cd70: 78        
            .hex 62            ; $cd71: 62        Invalid Opcode - KIL 
            lsr                ; $cd72: 4a        
            .hex 32            ; $cd73: 32        Invalid Opcode - KIL 
            ora __9800,y       ; $cd74: 19 00 98  
            sec                ; $cd77: 38        
            sbc #$01           ; $cd78: e9 01     
            cmp #$02           ; $cd7a: c9 02     
            bcs __cd8a         ; $cd7c: b0 0c     
            lda $00            ; $cd7e: a5 00     
            sta $02            ; $cd80: 85 02     
            lda $01            ; $cd82: a5 01     
            sta $00            ; $cd84: 85 00     
            lda $02            ; $cd86: a5 02     
            sta $01            ; $cd88: 85 01     
__cd8a:     lda __8dea,y       ; $cd8a: b9 ea 8d  
            sta $02            ; $cd8d: 85 02     
            lda $00            ; $cd8f: a5 00     
            jsr __e373         ; $cd91: 20 73 e3  
            lsr                ; $cd94: 4a        
            sta $00            ; $cd95: 85 00     
            lda $01            ; $cd97: a5 01     
            lsr                ; $cd99: 4a        
            lsr                ; $cd9a: 4a        
            and #$f8           ; $cd9b: 29 f8     
            clc                ; $cd9d: 18        
            adc $00            ; $cd9e: 65 00     
            tay                ; $cda0: a8        
            lda __8daa,y       ; $cda1: b9 aa 8d  
            clc                ; $cda4: 18        
            adc $02            ; $cda5: 65 02     
            and #$3f           ; $cda7: 29 3f     
__cda9:     rts                ; $cda9: 60        

;-------------------------------------------------------------------------------
            php                ; $cdaa: 08        
            ora ($01,x)        ; $cdab: 01 01     
            brk                ; $cdad: 00        
            brk                ; $cdae: 00        
            brk                ; $cdaf: 00        
            brk                ; $cdb0: 00        
            brk                ; $cdb1: 00        
            .hex 0f 08 05      ; $cdb2: 0f 08 05  Invalid Opcode - SLO $0508
            .hex 03 03         ; $cdb5: 03 03     Invalid Opcode - SLO ($03,x)
            .hex 02            ; $cdb7: 02        Invalid Opcode - KIL 
            .hex 02            ; $cdb8: 02        Invalid Opcode - KIL 
            .hex 02            ; $cdb9: 02        Invalid Opcode - KIL 
            .hex 0f 0b 08      ; $cdba: 0f 0b 08  Invalid Opcode - SLO $080b
            asl $05            ; $cdbd: 06 05     
            .hex 04 03         ; $cdbf: 04 03     Invalid Opcode - NOP $03
            .hex 03 10         ; $cdc1: 03 10     Invalid Opcode - SLO ($10,x)
            ora $080a          ; $cdc3: 0d 0a 08  
            .hex 07 06         ; $cdc6: 07 06     Invalid Opcode - SLO $06
            ora $04            ; $cdc8: 05 04     
            bpl __cdd9         ; $cdca: 10 0d     
            .hex 0b            ; $cdcc: 0b        Suspected data
__cdcd:     ora #$08           ; $cdcd: 09 08     
            .hex 07 06         ; $cdcf: 07 06     Invalid Opcode - SLO $06
            ora $10            ; $cdd1: 05 10     
            asl $0a0c          ; $cdd3: 0e 0c 0a  
            ora #$08           ; $cdd6: 09 08     
            .hex 07            ; $cdd8: 07        Suspected data
__cdd9:     asl $10            ; $cdd9: 06 10     
            asl $0b0d          ; $cddb: 0e 0d 0b  
            asl                ; $cdde: 0a        
            ora #$08           ; $cddf: 09 08     
            .hex 07 10         ; $cde1: 07 10     Invalid Opcode - SLO $10
            asl $0c0d          ; $cde3: 0e 0d 0c  
            .hex 0b 0a         ; $cde6: 0b 0a     Invalid Opcode - ANC #$0a
            ora #$08           ; $cde8: 09 08     
            brk                ; $cdea: 00        
            bpl __ce1d         ; $cdeb: 10 30     
            jsr __a80a         ; $cded: 20 0a a8  
            lda __8dfd,y       ; $cdf0: b9 fd 8d  
            sta $08            ; $cdf3: 85 08     
            lda __8dfe,y       ; $cdf5: b9 fe 8d  
            sta $09            ; $cdf8: 85 09     
            jmp ($0008)        ; $cdfa: 6c 08 00  

;-------------------------------------------------------------------------------
            ora $098e          ; $cdfd: 0d 8e 09  
            stx __8e0b         ; $ce00: 8e 0b 8e  
            asl $1c8e          ; $ce03: 0e 8e 1c  
            stx __8e18         ; $ce06: 8e 18 8e  
            lsr $00            ; $ce09: 46 00     
            lsr $00            ; $ce0b: 46 00     
            rts                ; $ce0d: 60        

;-------------------------------------------------------------------------------
            lda $00            ; $ce0e: a5 00     
            lsr                ; $ce10: 4a        
            adc $00            ; $ce11: 65 00     
            sta $00            ; $ce13: 85 00     
            rol $01            ; $ce15: 26 01     
            rts                ; $ce17: 60        

;-------------------------------------------------------------------------------
            asl $00            ; $ce18: 06 00     
            rol $01            ; $ce1a: 26 01     
            .hex 06            ; $ce1c: 06        Suspected data
__ce1d:     brk                ; $ce1d: 00        
            rol $01            ; $ce1e: 26 01     
            rts                ; $ce20: 60        

;-------------------------------------------------------------------------------
            stx $17            ; $ce21: 86 17     
            jmp __8e2d         ; $ce23: 4c 2d 8e  

;-------------------------------------------------------------------------------
            stx $17            ; $ce26: 86 17     
            sta $05            ; $ce28: 85 05     
            jsr __8d76         ; $ce2a: 20 76 8d  
            sta $06            ; $ce2d: 85 06     
            asl                ; $ce2f: 0a        
            tay                ; $ce30: a8        
            lda $0348,x        ; $ce31: bd 48 03  
            sta $00            ; $ce34: 85 00     
            lda $0324,x        ; $ce36: bd 24 03  
            sta $01            ; $ce39: 85 01     
            jsr __dfb3         ; $ce3b: 20 b3 df  
            bcs __ce76         ; $ce3e: b0 36     
            lda $05            ; $ce40: a5 05     
            sta $03b4,x        ; $ce42: 9d b4 03  
            lda $30            ; $ce45: a5 30     
            asl                ; $ce47: 0a        
            tay                ; $ce48: a8        
            lda __8e8a,y       ; $ce49: b9 8a 8e  
            sta $08            ; $ce4c: 85 08     
            iny                ; $ce4e: c8        
            lda __8e8a,y       ; $ce4f: b9 8a 8e  
            sta $09            ; $ce52: 85 09     
            lda $50            ; $ce54: a5 50     
            lsr                ; $ce56: 4a        
            tay                ; $ce57: a8        
            lda ($08),y        ; $ce58: b1 08     
            bcs __ce61         ; $ce5a: b0 05     
            jsr __e373         ; $ce5c: 20 73 e3  
            bne __ce63         ; $ce5f: d0 02     
__ce61:     and #$0f           ; $ce61: 29 0f     
__ce63:     tay                ; $ce63: a8        
            lda $00            ; $ce64: a5 00     
            sta $0348,x        ; $ce66: 9d 48 03  
            lda $01            ; $ce69: a5 01     
            sec                ; $ce6b: 38        
            sbc #$08           ; $ce6c: e9 08     
            sta $0324,x        ; $ce6e: 9d 24 03  
            lda $06            ; $ce71: a5 06     
            .hex 20            ; $ce73: 20        Suspected data
__ce74:     .hex 19 8d         ; $ce74: 19 8d     Suspected data
__ce76:     ldx $17            ; $ce76: a6 17     
            rts                ; $ce78: 60        

;-------------------------------------------------------------------------------
            sta $08            ; $ce79: 85 08     
            jmp __dfe8         ; $ce7b: 4c e8 df  

;-------------------------------------------------------------------------------
            lda $0324,x        ; $ce7e: bd 24 03  
            cmp #$40           ; $ce81: c9 40     
            bcc __ce88         ; $ce83: 90 03     
            cmp #$e0           ; $ce85: c9 e0     
            rts                ; $ce87: 60        

;-------------------------------------------------------------------------------
__ce88:     sec                ; $ce88: 38        
            rts                ; $ce89: 60        

;-------------------------------------------------------------------------------
            stx $8e,y          ; $ce8a: 96 8e     
            txs                ; $ce8c: 9a        
            stx __8e9d         ; $ce8d: 8e 9d 8e  
            ldx #$8e           ; $ce90: a2 8e     
            lda $8e            ; $ce92: a5 8e     
            .hex a7 8e         ; $ce94: a7 8e     Invalid Opcode - LAX $8e
            .hex 43 33         ; $ce96: 43 33     Invalid Opcode - SRE ($33,x)
            .hex 34 40         ; $ce98: 34 40     Invalid Opcode - NOP $40,x
            .hex 33 34         ; $ce9a: 33 34     Invalid Opcode - RLA ($34),y
            rti                ; $ce9c: 40        

;-------------------------------------------------------------------------------
            .hex 33 33         ; $ce9d: 33 33     Invalid Opcode - RLA ($33),y
            .hex 33 34         ; $ce9f: 33 34     Invalid Opcode - RLA ($34),y
            eor $44,x          ; $cea1: 55 44     
            eor $40            ; $cea3: 45 40     
            .hex 44 55         ; $cea5: 44 55     Invalid Opcode - NOP $55
            .hex 44 44         ; $cea7: 44 44     Invalid Opcode - NOP $44
            .hex 44 40         ; $cea9: 44 40     Invalid Opcode - NOP $40
            .hex 9c 90 04      ; $ceab: 9c 90 04  Invalid Opcode - SHY $0490,x
            .hex 92            ; $ceae: 92        Invalid Opcode - KIL 
__ceaf:     .hex 54 91         ; $ceaf: 54 91     Invalid Opcode - NOP $91,x
            .hex 9e 90 06      ; $ceb1: 9e 90 06  Invalid Opcode - SHX $0690,y
            .hex 92            ; $ceb4: 92        Invalid Opcode - KIL 
            lsr $91,x          ; $ceb5: 56 91     
            cli                ; $ceb7: 58        
            sta ($db),y        ; $ceb8: 91 db     
            stx __90a0         ; $ceba: 8e a0 90  
            ldx #$90           ; $cebd: a2 90     
            php                ; $cebf: 08        
            .hex 92            ; $cec0: 92        Invalid Opcode - KIL 
            .hex 0c 92 5a      ; $cec1: 0c 92 5a  Invalid Opcode - NOP $5a92
            sta ($5c),y        ; $cec4: 91 5c     
            sta ($60),y        ; $cec6: 91 60     
            sta ($a4),y        ; $cec8: 91 a4     
            bcc __ce74         ; $ceca: 90 a8     
            bcc __cedc         ; $cecc: 90 0e     
            .hex 92            ; $cece: 92        Invalid Opcode - KIL 
            .hex 12            ; $cecf: 12        Invalid Opcode - KIL 
            .hex 92            ; $ced0: 92        Invalid Opcode - KIL 
            .hex 14 92         ; $ced1: 14 92     Invalid Opcode - NOP $92,x
            .hex 64 91         ; $ced3: 64 91     Invalid Opcode - NOP $91
            ror $91            ; $ced5: 66 91     
            pla                ; $ced7: 68        
            sta ($6a),y        ; $ced8: 91 6a     
            sta ($dd),y        ; $ceda: 91 dd     
__cedc:     stx $0808          ; $cedc: 8e 08 08  
__cedf:     lda __ff31         ; $cedf: ad 31 ff  
            lda $03d8,x        ; $cee2: bd d8 03  
            bne __cef1         ; $cee5: d0 0a     
            lda #$40           ; $cee7: a9 40     
            sta $03d8,x        ; $cee9: 9d d8 03  
            lda #$0d           ; $ceec: a9 0d     
            jmp __ded8         ; $ceee: 4c d8 de  

;-------------------------------------------------------------------------------
__cef1:     jsr __dd2a         ; $cef1: 20 2a dd  
            lda $0444,x        ; $cef4: bd 44 04  
            cmp #$50           ; $cef7: c9 50     
            bne __cf05         ; $cef9: d0 0a     
            lda #$00           ; $cefb: a9 00     
            sta $0444,x        ; $cefd: 9d 44 04  
            lda #$80           ; $cf00: a9 80     
            jsr __de6f         ; $cf02: 20 6f de  
__cf05:     inc $0444,x        ; $cf05: fe 44 04  
            jmp __9066         ; $cf08: 4c 66 90  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $cf0b: bd d8 03  
            bne __cf1e         ; $cf0e: d0 0e     
            lda #$40           ; $cf10: a9 40     
            sta $03d8,x        ; $cf12: 9d d8 03  
            asl                ; $cf15: 0a        
            jsr __de6f         ; $cf16: 20 6f de  
            lda #$0d           ; $cf19: a9 0d     
            jmp __ded8         ; $cf1b: 4c d8 de  

;-------------------------------------------------------------------------------
__cf1e:     lda $0456,x        ; $cf1e: bd 56 04  
            bne __cf39         ; $cf21: d0 16     
            inc $0444,x        ; $cf23: fe 44 04  
            lda $0444,x        ; $cf26: bd 44 04  
            cmp #$50           ; $cf29: c9 50     
            bne __cf33         ; $cf2b: d0 06     
            jsr __dfa8         ; $cf2d: 20 a8 df  
            inc $0456,x        ; $cf30: fe 56 04  
__cf33:     jsr __dd2a         ; $cf33: 20 2a dd  
            jmp __9066         ; $cf36: 4c 66 90  

;-------------------------------------------------------------------------------
__cf39:     .hex fe 44         ; $cf39: fe 44     Suspected data
__cf3b:     .hex 04 bd         ; $cf3b: 04 bd     Invalid Opcode - NOP $bd
            .hex 44 04         ; $cf3d: 44 04     Invalid Opcode - NOP $04
            cmp #$40           ; $cf3f: c9 40     
            bne __cf46         ; $cf41: d0 03     
            jmp __dfa8         ; $cf43: 4c a8 df  

;-------------------------------------------------------------------------------
__cf46:     lda $1d            ; $cf46: a5 1d     
            and #$0f           ; $cf48: 29 0f     
            bne __cf4f         ; $cf4a: d0 03     
            jmp __e01f         ; $cf4c: 4c 1f e0  

;-------------------------------------------------------------------------------
__cf4f:     rts                ; $cf4f: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $cf50: bd d8 03  
            bne __cf77         ; $cf53: d0 22     
            lda #$40           ; $cf55: a9 40     
            sta $03d8,x        ; $cf57: 9d d8 03  
            lda #$80           ; $cf5a: a9 80     
            jsr __de6f         ; $cf5c: 20 6f de  
            lda $03b4,x        ; $cf5f: bd b4 03  
            cmp #$35           ; $cf62: c9 35     
            beq __cf72         ; $cf64: f0 0c     
            cmp #$29           ; $cf66: c9 29     
            beq __cf6e         ; $cf68: f0 04     
            lda #$0f           ; $cf6a: a9 0f     
            bne __cf74         ; $cf6c: d0 06     
__cf6e:     lda #$0a           ; $cf6e: a9 0a     
            bne __cf74         ; $cf70: d0 02     
__cf72:     lda #$0e           ; $cf72: a9 0e     
__cf74:     jmp __ded8         ; $cf74: 4c d8 de  

;-------------------------------------------------------------------------------
__cf77:     .hex 20            ; $cf77: 20        Suspected data
__cf78:     rol                ; $cf78: 2a        
            cmp $664c,x        ; $cf79: dd 4c 66  
            bcc __cf3b         ; $cf7c: 90 bd     
            cld                ; $cf7e: d8        
            .hex 03 d0         ; $cf7f: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 07 a9         ; $cf81: 07 a9     Invalid Opcode - SLO $a9
            rti                ; $cf83: 40        

;-------------------------------------------------------------------------------
            ldy #$28           ; $cf84: a0 28     
            jmp __ded0         ; $cf86: 4c d0 de  

;-------------------------------------------------------------------------------
            jmp __e010         ; $cf89: 4c 10 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $cf8c: bd d8 03  
            bne __cf9e         ; $cf8f: d0 0d     
            jsr __deca         ; $cf91: 20 ca de  
            lda #$c0           ; $cf94: a9 c0     
            jsr __de6f         ; $cf96: 20 6f de  
            lda #$37           ; $cf99: a9 37     
            jsr __ded8         ; $cf9b: 20 d8 de  
__cf9e:     jsr __dd2a         ; $cf9e: 20 2a dd  
            jsr __e0f4         ; $cfa1: 20 f4 e0  
            jsr __de8b         ; $cfa4: 20 8b de  
            jmp __dea1         ; $cfa7: 4c a1 de  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $cfaa: bd d8 03  
__cfad:     bne __cfbc         ; $cfad: d0 0d     
            jsr __deca         ; $cfaf: 20 ca de  
            lda #$08           ; $cfb2: a9 08     
            jsr __ded8         ; $cfb4: 20 d8 de  
            lda #$05           ; $cfb7: a9 05     
            sta $0324,x        ; $cfb9: 9d 24 03  
__cfbc:     lda $0444,x        ; $cfbc: bd 44 04  
            jsr __c5bb         ; $cfbf: 20 bb c5  
            dex                ; $cfc2: ca        
            .hex 8f e8 8f      ; $cfc3: 8f e8 8f  Invalid Opcode - SAX __8fe8
            ora $5490,x        ; $cfc6: 1d 90 54  
            bcc __cf78         ; $cfc9: 90 ad     
            pha                ; $cfcb: 48        
            .hex 03 38         ; $cfcc: 03 38     Invalid Opcode - SLO ($38,x)
            sbc $0348,x        ; $cfce: fd 48 03  
            bcs __cfd6         ; $cfd1: b0 03     
            jsr __deb7         ; $cfd3: 20 b7 de  
__cfd6:     cmp #$70           ; $cfd6: c9 70     
            bcs __cfe7         ; $cfd8: b0 0d     
            inc $0444,x        ; $cfda: fe 44 04  
            lda #$40           ; $cfdd: a9 40     
            jsr __de6f         ; $cfdf: 20 6f de  
            lda #$03           ; $cfe2: a9 03     
            sta $036c,x        ; $cfe4: 9d 6c 03  
__cfe7:     rts                ; $cfe7: 60        

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $cfe8: 20 f4 e0  
            jsr __dd2a         ; $cfeb: 20 2a dd  
            lda #$06           ; $cfee: a9 06     
            sta $08            ; $cff0: 85 08     
            jsr __dffa         ; $cff2: 20 fa df  
            lda $036c,x        ; $cff5: bd 6c 03  
            cmp #$fd           ; $cff8: c9 fd     
            beq __d00f         ; $cffa: f0 13     
            lda $036c,x        ; $cffc: bd 6c 03  
            bmi __d00e         ; $cfff: 30 0d     
            lda $0324,x        ; $d001: bd 24 03  
__d004:     cmp $0324          ; $d004: cd 24 03  
            bcc __d00e         ; $d007: 90 05     
            lda #$00           ; $d009: a9 00     
            sta $036c,x        ; $d00b: 9d 6c 03  
__d00e:     rts                ; $d00e: 60        

;-------------------------------------------------------------------------------
__d00f:     inc $0444,x        ; $d00f: fe 44 04  
            lda #$40           ; $d012: a9 40     
            jsr __de6f         ; $d014: 20 6f de  
            lda #$fd           ; $d017: a9 fd     
            sta $036c,x        ; $d019: 9d 6c 03  
__d01c:     rts                ; $d01c: 60        

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $d01d: 20 f4 e0  
            jsr __dd2a         ; $d020: 20 2a dd  
            lda #$06           ; $d023: a9 06     
            sta $08            ; $d025: 85 08     
            jsr __dfe4         ; $d027: 20 e4 df  
            lda $036c,x        ; $d02a: bd 6c 03  
            bpl __d039         ; $d02d: 10 0a     
            lda $0324,x        ; $d02f: bd 24 03  
            cmp #$10           ; $d032: c9 10     
            bcs __d00e         ; $d034: b0 d8     
            jmp __9009         ; $d036: 4c 09 90  

;-------------------------------------------------------------------------------
__d039:     lda $0324          ; $d039: ad 24 03  
            cmp $0324,x        ; $d03c: dd 24 03  
            bcs __d01c         ; $d03f: b0 db     
            inc $0444,x        ; $d041: fe 44 04  
            jsr __e010         ; $d044: 20 10 e0  
            lda #$03           ; $d047: a9 03     
            ldy #$00           ; $d049: a0 00     
            jsr __e04f         ; $d04b: 20 4f e0  
            lda #$00           ; $d04e: a9 00     
            tay                ; $d050: a8        
            jmp __e076         ; $d051: 4c 76 e0  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $d054: 20 2a dd  
            jmp __e0f4         ; $d057: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d05a: bd d8 03  
            bne __d01c         ; $d05d: d0 bd     
            lda #$40           ; $d05f: a9 40     
            ldy #$00           ; $d061: a0 00     
            jmp __ded0         ; $d063: 4c d0 de  

;-------------------------------------------------------------------------------
            jsr __de8b         ; $d066: 20 8b de  
            jsr __dea1         ; $d069: 20 a1 de  
            jmp __e0f4         ; $d06c: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda #$20           ; $d06f: a9 20     
            bit $91            ; $d071: 24 91     
            beq __d083         ; $d073: f0 0e     
            bvs __d083         ; $d075: 70 0c     
            lda $91            ; $d077: a5 91     
            and #$9f           ; $d079: 29 9f     
            ora #$40           ; $d07b: 09 40     
            sta $91            ; $d07d: 85 91     
            lda #$55           ; $d07f: a9 55     
            bne __d085         ; $d081: d0 02     
__d083:     lda #$6b           ; $d083: a9 6b     
__d085:     sta $7f            ; $d085: 85 7f     
            rts                ; $d087: 60        

;-------------------------------------------------------------------------------
            lda #$20           ; $d088: a9 20     
            bit $91            ; $d08a: 24 91     
            bvc __d083         ; $d08c: 50 f5     
            bne __d083         ; $d08e: d0 f3     
            lda $91            ; $d090: a5 91     
            and #$9f           ; $d092: 29 9f     
            ora #$60           ; $d094: 09 60     
            sta $91            ; $d096: 85 91     
            lda #$56           ; $d098: a9 56     
            bne __d085         ; $d09a: d0 e9     
            ldy __f590         ; $d09c: ac 90 f5  
            bcc __d0df         ; $d09f: 90 3e     
            sta ($43),y        ; $d0a1: 91 43     
            sta ($48),y        ; $d0a3: 91 48     
            sta ($49),y        ; $d0a5: 91 49     
            sta ($4e),y        ; $d0a7: 91 4e     
            sta ($4f),y        ; $d0a9: 91 4f     
            sta ($04),y        ; $d0ab: 91 04     
            .hex 0c b5 38      ; $d0ad: 0c b5 38  Invalid Opcode - NOP $38b5
            .hex 04 1a         ; $d0b0: 04 1a     Invalid Opcode - NOP $1a
            lda $3d,x          ; $d0b2: b5 3d     
            php                ; $d0b4: 08        
            .hex 12            ; $d0b5: 12        Invalid Opcode - KIL 
            lda $3e,x          ; $d0b6: b5 3e     
            .hex 0c 1a a4      ; $d0b8: 0c 1a a4  Invalid Opcode - NOP __a41a
            .hex 3a            ; $d0bb: 3a        Invalid Opcode - NOP 
            .hex 0c 0c 17      ; $d0bc: 0c 0c 17  Invalid Opcode - NOP $170c
            ora ($14,x)        ; $d0bf: 01 14     
            .hex 1a            ; $d0c1: 1a        Invalid Opcode - NOP 
            lda $41,x          ; $d0c2: b5 41     
            .hex 14 14         ; $d0c4: 14 14     Invalid Opcode - NOP $14,x
            .hex 17 01         ; $d0c6: 17 01     Invalid Opcode - SLO $01,x
            clc                ; $d0c8: 18        
            .hex 14 aa         ; $d0c9: 14 aa     Invalid Opcode - NOP $aa,x
            .hex 44 18         ; $d0cb: 44 18     Invalid Opcode - NOP $18
            .hex 0c 17 01      ; $d0cd: 0c 17 01  Invalid Opcode - NOP $0117
            .hex 1c 1a 17      ; $d0d0: 1c 1a 17  Invalid Opcode - NOP $171a,x
            ora ($24,x)        ; $d0d3: 01 24     
            .hex 0c b5 4c      ; $d0d5: 0c b5 4c  Invalid Opcode - NOP $4cb5
            plp                ; $d0d8: 28        
            .hex 14 aa         ; $d0d9: 14 aa     Invalid Opcode - NOP $aa,x
            eor $1a2c          ; $d0db: 4d 2c 1a  
            tay                ; $d0de: a8        
__d0df:     lsr $1428          ; $d0df: 4e 28 14  
            .hex 17 01         ; $d0e2: 17 01     Invalid Opcode - SLO $01,x
            bit $170c          ; $d0e4: 2c 0c 17  
            ora ($34,x)        ; $d0e7: 01 34     
            .hex 12            ; $d0e9: 12        Invalid Opcode - KIL 
            ldx $3407          ; $d0ea: ae 07 34  
            .hex 12            ; $d0ed: 12        Invalid Opcode - KIL 
            .hex 17 01         ; $d0ee: 17 01     Invalid Opcode - SLO $01,x
            sec                ; $d0f0: 38        
            .hex 0c 17 01      ; $d0f1: 0c 17 01  Invalid Opcode - NOP $0117
            .hex ff 08 0c      ; $d0f4: ff 08 0c  Invalid Opcode - ISC $0c08,x
            lda #$5f           ; $d0f7: a9 5f     
__d0f9:     php                ; $d0f9: 08        
            .hex 1a            ; $d0fa: 1a        Invalid Opcode - NOP 
            lda #$61           ; $d0fb: a9 61     
            .hex 0c 20 a9      ; $d0fd: 0c 20 a9  Invalid Opcode - NOP __a920
            .hex 62            ; $d100: 62        Invalid Opcode - KIL 
            .hex 0c 28 a4      ; $d101: 0c 28 a4  Invalid Opcode - NOP __a428
            .hex 52            ; $d104: 52        Invalid Opcode - KIL 
            .hex 0c 0c 17      ; $d105: 0c 0c 17  Invalid Opcode - NOP $170c
            .hex 04 14         ; $d108: 04 14     Invalid Opcode - NOP $14
            .hex 0c a9 63      ; $d10a: 0c a9 63  Invalid Opcode - NOP $63a9
            .hex 14 0c         ; $d10d: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 17 04         ; $d10f: 17 04     Invalid Opcode - SLO $04,x
            .hex 14 1a         ; $d111: 14 1a     Invalid Opcode - NOP $1a,x
            .hex 17 04         ; $d113: 17 04     Invalid Opcode - SLO $04,x
            clc                ; $d115: 18        
            .hex 1a            ; $d116: 1a        Invalid Opcode - NOP 
            lda #$66           ; $d117: a9 66     
            .hex 1c 28 17      ; $d119: 1c 28 17  Invalid Opcode - NOP $1728,x
            .hex 04 24         ; $d11c: 04 24     Invalid Opcode - NOP $24
            .hex 0c a9 5d      ; $d11e: 0c a9 5d  Invalid Opcode - NOP $5da9
            plp                ; $d121: 28        
            .hex 1a            ; $d122: 1a        Invalid Opcode - NOP 
            .hex 17 04         ; $d123: 17 04     Invalid Opcode - SLO $04,x
            bit __af22         ; $d125: 2c 22 af  
            .hex 04 2c         ; $d128: 04 2c     Invalid Opcode - NOP $2c
            .hex 0c 17 04      ; $d12a: 0c 17 04  Invalid Opcode - NOP $0417
            bit $1722          ; $d12d: 2c 22 17  
            .hex 04 2c         ; $d130: 04 2c     Invalid Opcode - NOP $2c
            plp                ; $d132: 28        
            .hex 17 04         ; $d133: 17 04     Invalid Opcode - SLO $04,x
            .hex 34 0c         ; $d135: 34 0c     Invalid Opcode - NOP $0c,x
            .hex 17 04         ; $d137: 17 04     Invalid Opcode - SLO $04,x
            sec                ; $d139: 38        
            .hex 0c a9 68      ; $d13a: 0c a9 68  Invalid Opcode - NOP $68a9
            .hex ff 0c 0c      ; $d13d: ff 0c 0c  Invalid Opcode - ISC $0c0c,x
            ldx __ff08         ; $d140: ae 08 ff  
            .hex 0c 0c ae      ; $d143: 0c 0c ae  Invalid Opcode - NOP __ae0c
            .hex 03 ff         ; $d146: 03 ff     Invalid Opcode - SLO ($ff,x)
            .hex ff 0c 1a      ; $d148: ff 0c 1a  Invalid Opcode - ISC $1a0c,x
            ldx __ff02         ; $d14b: ae 02 ff  
            .hex ff 0c 0c      ; $d14e: ff 0c 0c  Invalid Opcode - ISC $0c0c,x
            ldx __ff00         ; $d151: ae 00 ff  
            jmp (__a191)       ; $d154: 6c 91 a1  

;-------------------------------------------------------------------------------
            sta ($c6),y        ; $d157: 91 c6     
            sta ($df),y        ; $d159: 91 df     
            sta ($e4),y        ; $d15b: 91 e4     
            sta ($e9),y        ; $d15d: 91 e9     
            sta ($ee),y        ; $d15f: 91 ee     
            sta ($ef),y        ; $d161: 91 ef     
            sta ($f4),y        ; $d163: 91 f4     
            sta ($f9),y        ; $d165: 91 f9     
            sta ($fe),y        ; $d167: 91 fe     
            sta ($ff),y        ; $d169: 91 ff     
            sta ($08),y        ; $d16b: 91 08     
            .hex 0c af 03      ; $d16d: 0c af 03  Invalid Opcode - NOP $03af
            php                ; $d170: 08        
            .hex 0c 17 02      ; $d171: 0c 17 02  Invalid Opcode - NOP $0217
            .hex 0c 0c aa      ; $d174: 0c 0c aa  Invalid Opcode - NOP __aa0c
            .hex 57 0c         ; $d177: 57 0c     Invalid Opcode - SRE $0c,x
            .hex 1a            ; $d179: 1a        Invalid Opcode - NOP 
            ldy $51            ; $d17a: a4 51     
            .hex 14 0c         ; $d17c: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 17 02         ; $d17e: 17 02     Invalid Opcode - SLO $02,x
            clc                ; $d180: 18        
            .hex 0c a9 58      ; $d181: 0c a9 58  Invalid Opcode - NOP $58a9
            .hex 1c 0c b5      ; $d184: 1c 0c b5  Invalid Opcode - NOP __b50c,x
            .hex 5b 24 1a      ; $d187: 5b 24 1a  Invalid Opcode - SRE $1a24,y
            .hex 17 05         ; $d18a: 17 05     Invalid Opcode - SLO $05,x
            plp                ; $d18c: 28        
            .hex 1a            ; $d18d: 1a        Invalid Opcode - NOP 
            tax                ; $d18e: aa        
            rts                ; $d18f: 60        

;-------------------------------------------------------------------------------
            bit $170c          ; $d190: 2c 0c 17  
            .hex 02            ; $d193: 02        Invalid Opcode - KIL 
            .hex 34 0c         ; $d194: 34 0c     Invalid Opcode - NOP $0c,x
            lda $69,x          ; $d196: b5 69     
            .hex 34 12         ; $d198: 34 12     Invalid Opcode - NOP $12,x
            tax                ; $d19a: aa        
            .hex 67 38         ; $d19b: 67 38     Invalid Opcode - RRA $38
            .hex 0c 17 02      ; $d19d: 0c 17 02  Invalid Opcode - NOP $0217
            .hex ff 04 0c      ; $d1a0: ff 04 0c  Invalid Opcode - ISC $0c04,x
            lda $5e,x          ; $d1a3: b5 5e     
            .hex 0c 0c a4      ; $d1a5: 0c 0c a4  Invalid Opcode - NOP __a40c
            .hex 53 14         ; $d1a8: 53 14     Invalid Opcode - SRE ($14),y
            .hex 0c 17         ; $d1aa: 0c 17     Suspected data
__d1ac:     php                ; $d1ac: 08        
            .hex 1c 06 b5      ; $d1ad: 1c 06 b5  Invalid Opcode - NOP __b506,x
            adc $1c            ; $d1b0: 65 1c     
            .hex 0c 17 08      ; $d1b2: 0c 17 08  Invalid Opcode - NOP $0817
            bit $0c            ; $d1b5: 24 0c     
            .hex 17 08         ; $d1b7: 17 08     Invalid Opcode - SLO $08,x
            plp                ; $d1b9: 28        
            .hex 0c b5 6a      ; $d1ba: 0c b5 6a  Invalid Opcode - NOP $6ab5
            bit $170c          ; $d1bd: 2c 0c 17  
            php                ; $d1c0: 08        
            .hex 34 0c         ; $d1c1: 34 0c     Invalid Opcode - NOP $0c,x
            .hex 17 08         ; $d1c3: 17 08     Invalid Opcode - SLO $08,x
            .hex ff 0c 0c      ; $d1c5: ff 0c 0c  Invalid Opcode - ISC $0c0c,x
            ldy $54            ; $d1c8: a4 54     
            .hex 14 0c         ; $d1ca: 14 0c     Invalid Opcode - NOP $0c,x
            ora ($08,x)        ; $d1cc: 01 08     
            clc                ; $d1ce: 18        
            asl $01            ; $d1cf: 06 01     
            php                ; $d1d1: 08        
            bit $0c            ; $d1d2: 24 0c     
            ora ($08,x)        ; $d1d4: 01 08     
            bit $010c          ; $d1d6: 2c 0c 01  
            php                ; $d1d9: 08        
            sec                ; $d1da: 38        
            .hex 0c 01 08      ; $d1db: 0c 01 08  Invalid Opcode - NOP $0801
            .hex ff 0c 1a      ; $d1de: ff 0c 1a  Invalid Opcode - ISC $1a0c,x
            ldx __ff02         ; $d1e1: ae 02 ff  
            .hex 03 15         ; $d1e4: 03 15     Invalid Opcode - SLO ($15,x)
            .hex 27 5c         ; $d1e6: 27 5c     Invalid Opcode - RLA $5c
            .hex ff 0c 1a      ; $d1e8: ff 0c 1a  Invalid Opcode - ISC $1a0c,x
            ldy __ff59         ; $d1eb: ac 59 ff  
            .hex ff 0c 1a      ; $d1ee: ff 0c 1a  Invalid Opcode - ISC $1a0c,x
            ldx __ff00         ; $d1f1: ae 00 ff  
            .hex 0c 0c ac      ; $d1f4: 0c 0c ac  Invalid Opcode - NOP __ac0c
            .hex 64 ff         ; $d1f7: 64 ff     Invalid Opcode - NOP $ff
            .hex 0c 1a ae      ; $d1f9: 0c 1a ae  Invalid Opcode - NOP __ae1a
            brk                ; $d1fc: 00        
            .hex ff ff 0c      ; $d1fd: ff ff 0c  Invalid Opcode - ISC $0cff,x
            .hex 0c ac 5a      ; $d200: 0c ac 5a  Invalid Opcode - NOP $5aac
            .hex ff 1a 92      ; $d203: ff 1a 92  Invalid Opcode - ISC __921a,x
            .hex 4f 92 94      ; $d206: 4f 92 94  Invalid Opcode - SRE __9492
            .hex 92            ; $d209: 92        Invalid Opcode - KIL 
            sta $92,x          ; $d20a: 95 92     
            txs                ; $d20c: 9a        
            .hex 92            ; $d20d: 92        Invalid Opcode - KIL 
            .hex a3 92         ; $d20e: a3 92     Invalid Opcode - LAX ($92,x)
            ldy $92            ; $d210: a4 92     
            lda #$92           ; $d212: a9 92     
            ldx __af92         ; $d214: ae 92 af  
            .hex 92            ; $d217: 92        Invalid Opcode - KIL 
            bcs __d1ac         ; $d218: b0 92     
            .hex 04 0c         ; $d21a: 04 0c     Invalid Opcode - NOP $0c
            tax                ; $d21c: aa        
            rti                ; $d21d: 40        

;-------------------------------------------------------------------------------
            .hex 04 08         ; $d21e: 04 08     Invalid Opcode - NOP $08
            ora ($02,x)        ; $d220: 01 02     
            .hex 0c 0c aa      ; $d222: 0c 0c aa  Invalid Opcode - NOP __aa0c
            .hex 43 0d         ; $d225: 43 0d     Invalid Opcode - SRE ($0d,x)
            .hex 0c a4 3b      ; $d227: 0c a4 3b  Invalid Opcode - NOP $3ba4
            .hex 14 0c         ; $d22a: 14 0c     Invalid Opcode - NOP $0c,x
            tax                ; $d22c: aa        
            pha                ; $d22d: 48        
            .hex 1a            ; $d22e: 1a        Invalid Opcode - NOP 
            .hex 0c a9 4f      ; $d22f: 0c a9 4f  Invalid Opcode - NOP $4fa9
            clc                ; $d232: 18        
            .hex 0c 17 02      ; $d233: 0c 17 02  Invalid Opcode - NOP $0217
            .hex 1c 0c b5      ; $d236: 1c 0c b5  Invalid Opcode - NOP __b50c,x
            bvc __d25f         ; $d239: 50 24     
            .hex 0c b5 39      ; $d23b: 0c b5 39  Invalid Opcode - NOP $39b5
            plp                ; $d23e: 28        
            .hex 0c 17 02      ; $d23f: 0c 17 02  Invalid Opcode - NOP $0217
            bit $170c          ; $d242: 2c 0c 17  
            .hex 02            ; $d245: 02        Invalid Opcode - KIL 
            .hex 34 08         ; $d246: 34 08     Invalid Opcode - NOP $08,x
            .hex 17 02         ; $d248: 17 02     Invalid Opcode - SLO $02,x
            .hex 34 0c         ; $d24a: 34 0c     Invalid Opcode - NOP $0c,x
            ora ($02,x)        ; $d24c: 01 02     
            .hex ff 08 0c      ; $d24e: ff 08 0c  Invalid Opcode - ISC $0c08,x
            lda $3f,x          ; $d251: b5 3f     
            .hex 0c 28 a4      ; $d253: 0c 28 a4  Invalid Opcode - NOP __a428
            .hex 3c 0c 0c      ; $d256: 3c 0c 0c  Invalid Opcode - NOP $0c0c,x
            .hex 17 04         ; $d259: 17 04     Invalid Opcode - SLO $04,x
            .hex 14 0c         ; $d25b: 14 0c     Invalid Opcode - NOP $0c,x
            tax                ; $d25d: aa        
            .hex 45            ; $d25e: 45        Suspected data
__d25f:     .hex 14 1a         ; $d25f: 14 1a     Invalid Opcode - NOP $1a,x
            tax                ; $d261: aa        
            lsr $18            ; $d262: 46 18     
            .hex 0c 17 04      ; $d264: 0c 17 04  Invalid Opcode - NOP $0417
            clc                ; $d267: 18        
            clc                ; $d268: 18        
            .hex 17 04         ; $d269: 17 04     Invalid Opcode - SLO $04,x
            .hex 1c 28 17      ; $d26b: 1c 28 17  Invalid Opcode - NOP $1728,x
            .hex 04 24         ; $d26e: 04 24     Invalid Opcode - NOP $24
            .hex 0c 17 04      ; $d270: 0c 17 04  Invalid Opcode - NOP $0417
            bit $14            ; $d273: 24 14     
            .hex 17 04         ; $d275: 17 04     Invalid Opcode - SLO $04,x
            plp                ; $d277: 28        
            .hex 14 b5         ; $d278: 14 b5     Invalid Opcode - NOP $b5,x
            .hex 47 28         ; $d27a: 47 28     Invalid Opcode - SRE $28
            bit $b5            ; $d27c: 24 b5     
            lsr                ; $d27e: 4a        
            bit $171a          ; $d27f: 2c 1a 17  
            .hex 04 34         ; $d282: 04 34     Invalid Opcode - NOP $34
            .hex 0c b5 4b      ; $d284: 0c b5 4b  Invalid Opcode - NOP $4bb5
            .hex 34 12         ; $d287: 34 12     Invalid Opcode - NOP $12,x
            .hex 17 04         ; $d289: 17 04     Invalid Opcode - SLO $04,x
            sec                ; $d28b: 38        
            .hex 0c 17 04      ; $d28c: 0c 17 04  Invalid Opcode - NOP $0417
            sec                ; $d28f: 38        
            .hex 1a            ; $d290: 1a        Invalid Opcode - NOP 
            .hex 17 04         ; $d291: 17 04     Invalid Opcode - SLO $04,x
            .hex ff ff 0c      ; $d293: ff ff 0c  Invalid Opcode - ISC $0cff,x
            .hex 0c ae 04      ; $d296: 0c ae 04  Invalid Opcode - NOP $04ae
            .hex ff 0a 1a      ; $d299: ff 0a 1a  Invalid Opcode - ISC $1a0a,x
            ldx $0d09          ; $d29c: ae 09 0d  
            .hex 17 27         ; $d29f: 17 27     Invalid Opcode - SLO $27,x
            .hex 42            ; $d2a1: 42        Invalid Opcode - KIL 
            .hex ff ff 0c      ; $d2a2: ff ff 0c  Invalid Opcode - ISC $0cff,x
            .hex 1a            ; $d2a5: 1a        Invalid Opcode - NOP 
            ldx __ff0a         ; $d2a6: ae 0a ff  
            .hex 0c 0c ac      ; $d2a9: 0c 0c ac  Invalid Opcode - NOP __ac0c
            eor #$ff           ; $d2ac: 49 ff     
            .hex ff ff 0c      ; $d2ae: ff ff 0c  Invalid Opcode - ISC $0cff,x
            .hex 0c ae 00      ; $d2b1: 0c ae 00  Bad Addr Mode - NOP $00ae
            .hex ff 44 93      ; $d2b4: ff 44 93  Invalid Opcode - ISC __9344,x
            .hex 44 93         ; $d2b7: 44 93     Invalid Opcode - NOP $93
            .hex 44 93         ; $d2b9: 44 93     Invalid Opcode - NOP $93
            .hex 44 93         ; $d2bb: 44 93     Invalid Opcode - NOP $93
            .hex 44 93         ; $d2bd: 44 93     Invalid Opcode - NOP $93
            .hex 44 93         ; $d2bf: 44 93     Invalid Opcode - NOP $93
            brk                ; $d2c1: 00        
            txs                ; $d2c2: 9a        
            cpy #$9a           ; $d2c3: c0 9a     
            stx $489b          ; $d2c5: 8e 9b 48  
            .hex 9c fa 9e      ; $d2c8: 9c fa 9e  Invalid Opcode - SHY __9efa,x
            brk                ; $d2cb: 00        
            brk                ; $d2cc: 00        
            lda $03b4,y        ; $d2cd: b9 b4 03  
            cmp #$25           ; $d2d0: c9 25     
            bne __d2f3         ; $d2d2: d0 1f     
            jsr __df42         ; $d2d4: 20 42 df  
            lda #$01           ; $d2d7: a9 01     
            sta $0444,y        ; $d2d9: 99 44 04  
            sta $0312,y        ; $d2dc: 99 12 03  
            jsr __c0e7         ; $d2df: 20 e7 c0  
            lda #$2f           ; $d2e2: a9 2f     
            jsr __c118         ; $d2e4: 20 18 c1  
            lda #$0c           ; $d2e7: a9 0c     
            sta $2c            ; $d2e9: 85 2c     
            lda #$00           ; $d2eb: a9 00     
            sta $2b            ; $d2ed: 85 2b     
            lda #$80           ; $d2ef: a9 80     
            sta $2a            ; $d2f1: 85 2a     
__d2f3:     rts                ; $d2f3: 60        

;-------------------------------------------------------------------------------
            jsr __df42         ; $d2f4: 20 42 df  
            lda #$4d           ; $d2f7: a9 4d     
            sta $03b4,x        ; $d2f9: 9d b4 03  
            rts                ; $d2fc: 60        

;-------------------------------------------------------------------------------
            .hex bd d8         ; $d2fd: bd d8     Suspected data
__d2ff:     .hex 03 d0         ; $d2ff: 03 d0     Invalid Opcode - SLO ($d0,x)
            rol                ; $d301: 2a        
            lda #$04           ; $d302: a9 04     
            sta $03d8,x        ; $d304: 9d d8 03  
            lda $50            ; $d307: a5 50     
            cmp #$06           ; $d309: c9 06     
            beq __d313         ; $d30b: f0 06     
            lda #$ad           ; $d30d: a9 ad     
            ldy #$77           ; $d30f: a0 77     
            bne __d317         ; $d311: d0 04     
__d313:     ldy #$26           ; $d313: a0 26     
            lda #$de           ; $d315: a9 de     
__d317:     sta $0300,x        ; $d317: 9d 00 03  
            tya                ; $d31a: 98        
            sta $04c2,x        ; $d31b: 9d c2 04  
            lda #$01           ; $d31e: a9 01     
            sta $036c,x        ; $d320: 9d 6c 03  
            lda #$80           ; $d323: a9 80     
            sta $0324,x        ; $d325: 9d 24 03  
            sta $0348,x        ; $d328: 9d 48 03  
            rts                ; $d32b: 60        

;-------------------------------------------------------------------------------
            jsr __d9cf         ; $d32c: 20 cf d9  
            lda $0444,x        ; $d32f: bd 44 04  
            bne __d343         ; $d332: d0 0f     
            lda #$00           ; $d334: a9 00     
            ldy #$10           ; $d336: a0 10     
            jsr __e2a2         ; $d338: 20 a2 e2  
            bcs __d340         ; $d33b: b0 03     
            inc $0444,x        ; $d33d: fe 44 04  
__d340:     jmp __e0f4         ; $d340: 4c f4 e0  

;-------------------------------------------------------------------------------
__d343:     rts                ; $d343: 60        

;-------------------------------------------------------------------------------
            lsr $93            ; $d344: 46 93     
            .hex ff a9 78      ; $d346: ff a9 78  Invalid Opcode - ISC $78a9,x
            sta $7f            ; $d349: 85 7f     
            lda $92            ; $d34b: a5 92     
            ora #$04           ; $d34d: 09 04     
            sta $92            ; $d34f: 85 92     
            and #$01           ; $d351: 29 01     
            beq __d359         ; $d353: f0 04     
            .hex a9            ; $d355: a9        Suspected data
__d356:     php                ; $d356: 08        
            bne __d35b         ; $d357: d0 02     
__d359:     lda #$04           ; $d359: a9 04     
__d35b:     sta $4c            ; $d35b: 85 4c     
            lda #$22           ; $d35d: a9 22     
            jmp __c118         ; $d35f: 4c 18 c1  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d362: bd d8 03  
            bne __d374         ; $d365: d0 0d     
            jsr __deca         ; $d367: 20 ca de  
            lda #$80           ; $d36a: a9 80     
            jsr __de6f         ; $d36c: 20 6f de  
__d36f:     lda #$09           ; $d36f: a9 09     
            jmp __ded8         ; $d371: 4c d8 de  

;-------------------------------------------------------------------------------
__d374:     jsr __dd2a         ; $d374: 20 2a dd  
            lda $0444,x        ; $d377: bd 44 04  
            jsr __c5bb         ; $d37a: 20 bb c5  
            .hex 83 93         ; $d37d: 83 93     Invalid Opcode - SAX ($93,x)
            sta __a293         ; $d37f: 8d 93 a2  
            .hex 93 fe         ; $d382: 93 fe     Invalid Opcode - AHX ($fe),y
            .hex 44 04         ; $d384: 44 04     Invalid Opcode - NOP $04
            lda #$fc           ; $d386: a9 fc     
            ldy #$00           ; $d388: a0 00     
            jmp __e076         ; $d38a: 4c 76 e0  

;-------------------------------------------------------------------------------
            lda #$20           ; $d38d: a9 20     
            sta $08            ; $d38f: 85 08     
            jsr __dfe4         ; $d391: 20 e4 df  
            lda $036c,x        ; $d394: bd 6c 03  
            bpl __d39c         ; $d397: 10 03     
            jsr __de8b         ; $d399: 20 8b de  
__d39c:     inc $0444,x        ; $d39c: fe 44 04  
            jmp __e0f4         ; $d39f: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda #$28           ; $d3a2: a9 28     
            sta $08            ; $d3a4: 85 08     
            jsr __dfe4         ; $d3a6: 20 e4 df  
            jsr __e0f4         ; $d3a9: 20 f4 e0  
            jsr __de8b         ; $d3ac: 20 8b de  
            lda #$00           ; $d3af: a9 00     
            ldy #$10           ; $d3b1: a0 10     
            jsr __e2a2         ; $d3b3: 20 a2 e2  
            bcs __d3be         ; $d3b6: b0 06     
            jsr __d3f6         ; $d3b8: 20 f6 d3  
            jmp __dfad         ; $d3bb: 4c ad df  

;-------------------------------------------------------------------------------
__d3be:     rts                ; $d3be: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d3bf: bd d8 03  
            bne __d3cb         ; $d3c2: d0 07     
            lda #$84           ; $d3c4: a9 84     
            ldy #$3b           ; $d3c6: a0 3b     
            jmp __ded0         ; $d3c8: 4c d0 de  

;-------------------------------------------------------------------------------
__d3cb:     ldy $0444,x        ; $d3cb: bc 44 04  
            beq __d3d4         ; $d3ce: f0 04     
            dey                ; $d3d0: 88        
            beq __d3d7         ; $d3d1: f0 04     
            rts                ; $d3d3: 60        

;-------------------------------------------------------------------------------
__d3d4:     jmp __d9cf         ; $d3d4: 4c cf d9  

;-------------------------------------------------------------------------------
__d3d7:     lda #$04           ; $d3d7: a9 04     
            ldy #$a1           ; $d3d9: a0 a1     
            jsr __ded0         ; $d3db: 20 d0 de  
            jmp __d9cf         ; $d3de: 4c cf d9  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d3e1: bd d8 03  
            bne __d3ee         ; $d3e4: d0 08     
            jsr __deca         ; $d3e6: 20 ca de  
            lda #$13           ; $d3e9: a9 13     
            jmp __ded8         ; $d3eb: 4c d8 de  

;-------------------------------------------------------------------------------
__d3ee:     jsr __dd2a         ; $d3ee: 20 2a dd  
            jsr __e010         ; $d3f1: 20 10 e0  
            .hex fe 44         ; $d3f4: fe 44     Suspected data
__d3f6:     .hex 04 bd         ; $d3f6: 04 bd     Invalid Opcode - NOP $bd
            .hex 44 04         ; $d3f8: 44 04     Invalid Opcode - NOP $04
            cmp #$20           ; $d3fa: c9 20     
            bne __d42e         ; $d3fc: d0 30     
            jsr __dfad         ; $d3fe: 20 ad df  
            .hex a5            ; $d401: a5        Suspected data
__d402:     rol $0129          ; $d402: 2e 29 01  
            bne __d418         ; $d405: d0 11     
            lda $0420,x        ; $d407: bd 20 04  
            bne __d412         ; $d40a: d0 06     
            lda #$ff           ; $d40c: a9 ff     
            ldy #$20           ; $d40e: a0 20     
            bne __d427         ; $d410: d0 15     
__d412:     lda #$00           ; $d412: a9 00     
            ldy #$e0           ; $d414: a0 e0     
            bne __d427         ; $d416: d0 0f     
__d418:     lda $0420,x        ; $d418: bd 20 04  
            bne __d423         ; $d41b: d0 06     
            lda #$00           ; $d41d: a9 00     
            ldy #$40           ; $d41f: a0 40     
            bne __d427         ; $d421: d0 04     
__d423:     lda #$ff           ; $d423: a9 ff     
            ldy #$c0           ; $d425: a0 c0     
__d427:     sta $0390,x        ; $d427: 9d 90 03  
            tya                ; $d42a: 98        
            sta $03a2,x        ; $d42b: 9d a2 03  
__d42e:     lda $0390,x        ; $d42e: bd 90 03  
            bmi __d437         ; $d431: 30 04     
            lda #$06           ; $d433: a9 06     
            bne __d439         ; $d435: d0 02     
__d437:     lda #$fa           ; $d437: a9 fa     
__d439:     ldy #$00           ; $d439: a0 00     
            jsr __e2a2         ; $d43b: 20 a2 e2  
            bcs __d443         ; $d43e: b0 03     
            jsr __e027         ; $d440: 20 27 e0  
__d443:     lda $0390,x        ; $d443: bd 90 03  
            bmi __d44c         ; $d446: 30 04     
            lda #$06           ; $d448: a9 06     
            bne __d44e         ; $d44a: d0 02     
__d44c:     lda #$fa           ; $d44c: a9 fa     
__d44e:     ldy #$13           ; $d44e: a0 13     
            jsr __e2af         ; $d450: 20 af e2  
            bcc __d458         ; $d453: 90 03     
            jsr __e027         ; $d455: 20 27 e0  
__d458:     jmp __e0f4         ; $d458: 4c f4 e0  

;-------------------------------------------------------------------------------
            stx $10            ; $d45b: 86 10     
            lda $03d8,x        ; $d45d: bd d8 03  
            bne __d46a         ; $d460: d0 08     
            jsr __deca         ; $d462: 20 ca de  
            lda #$12           ; $d465: a9 12     
            jmp __ded8         ; $d467: 4c d8 de  

;-------------------------------------------------------------------------------
__d46a:     inc $04d4,x        ; $d46a: fe d4 04  
            lda $04d4,x        ; $d46d: bd d4 04  
            cmp #$80           ; $d470: c9 80     
            bne __d4a5         ; $d472: d0 31     
            lda $03c6,x        ; $d474: bd c6 03  
            bne __d4a5         ; $d477: d0 2c     
            lda #$00           ; $d479: a9 00     
            sta $04d4,x        ; $d47b: 9d d4 04  
            lda #$30           ; $d47e: a9 30     
            sta $05            ; $d480: 85 05     
            lda $0420,x        ; $d482: bd 20 04  
            beq __d48b         ; $d485: f0 04     
            lda #$02           ; $d487: a9 02     
            bne __d48d         ; $d489: d0 02     
__d48b:     lda #$1e           ; $d48b: a9 1e     
__d48d:     jsr __8e21         ; $d48d: 20 21 8e  
            lda #$30           ; $d490: a9 30     
            sta $05            ; $d492: 85 05     
            lda $0420,x        ; $d494: bd 20 04  
            beq __d49d         ; $d497: f0 04     
            lda #$3e           ; $d499: a9 3e     
            bne __d49f         ; $d49b: d0 02     
__d49d:     lda #$22           ; $d49d: a9 22     
__d49f:     jsr __8e21         ; $d49f: 20 21 8e  
            ldx $10            ; $d4a2: a6 10     
            rts                ; $d4a4: 60        

;-------------------------------------------------------------------------------
__d4a5:     jsr __dd2a         ; $d4a5: 20 2a dd  
            jsr __e0f4         ; $d4a8: 20 f4 e0  
            lda $0444,x        ; $d4ab: bd 44 04  
            jsr __c5bb         ; $d4ae: 20 bb c5  
            .hex b7 94         ; $d4b1: b7 94     Invalid Opcode - LAX $94,y
            .hex d7 94         ; $d4b3: d7 94     Invalid Opcode - DCP $94,x
            rol __a595,x       ; $d4b5: 3e 95 a5  
            rol $0129          ; $d4b8: 2e 29 01  
            bne __d4c8         ; $d4bb: d0 0b     
            lda #$fd           ; $d4bd: a9 fd     
            ldy #$00           ; $d4bf: a0 00     
            jsr __e076         ; $d4c1: 20 76 e0  
            lda #$01           ; $d4c4: a9 01     
            bne __d4cf         ; $d4c6: d0 07     
__d4c8:     lda #$40           ; $d4c8: a9 40     
            sta $0456,x        ; $d4ca: 9d 56 04  
            lda #$02           ; $d4cd: a9 02     
__d4cf:     sta $0444,x        ; $d4cf: 9d 44 04  
            lda #$c0           ; $d4d2: a9 c0     
            jmp __de6f         ; $d4d4: 4c 6f de  

;-------------------------------------------------------------------------------
            lda #$31           ; $d4d7: a9 31     
            sta $0300,x        ; $d4d9: 9d 00 03  
            lda #$20           ; $d4dc: a9 20     
            sta $08            ; $d4de: 85 08     
            jsr __dfe4         ; $d4e0: 20 e4 df  
            lda $036c,x        ; $d4e3: bd 6c 03  
            beq __d51f         ; $d4e6: f0 37     
            bpl __d51f         ; $d4e8: 10 35     
            lda #$f4           ; $d4ea: a9 f4     
            ldy #$f0           ; $d4ec: a0 f0     
            jsr __e2a2         ; $d4ee: 20 a2 e2  
            bcs __d4f6         ; $d4f1: b0 03     
            jmp __94ff         ; $d4f3: 4c ff 94  

;-------------------------------------------------------------------------------
__d4f6:     .hex a9            ; $d4f6: a9        Suspected data
__d4f7:     .hex 0c a0 f0      ; $d4f7: 0c a0 f0  Invalid Opcode - NOP __f0a0
            jsr __e2a2         ; $d4fa: 20 a2 e2  
            bcs __d506         ; $d4fd: b0 07     
            lda #$01           ; $d4ff: a9 01     
            ldy #$00           ; $d501: a0 00     
            jsr __e076         ; $d503: 20 76 e0  
__d506:     lda #$0c           ; $d506: a9 0c     
            ldy #$00           ; $d508: a0 00     
            jsr __e2a2         ; $d50a: 20 a2 e2  
            bcs __d512         ; $d50d: b0 03     
            jsr __e01f         ; $d50f: 20 1f e0  
__d512:     lda #$f4           ; $d512: a9 f4     
            ldy #$00           ; $d514: a0 00     
            jsr __e2a2         ; $d516: 20 a2 e2  
            bcs __d51e         ; $d519: b0 03     
            jsr __e01f         ; $d51b: 20 1f e0  
__d51e:     rts                ; $d51e: 60        

;-------------------------------------------------------------------------------
__d51f:     jsr __9506         ; $d51f: 20 06 95  
            lda #$f4           ; $d522: a9 f4     
            ldy #$10           ; $d524: a0 10     
            jsr __e2a2         ; $d526: 20 a2 e2  
            bcc __d535         ; $d529: 90 0a     
            lda #$0c           ; $d52b: a9 0c     
            ldy #$10           ; $d52d: a0 10     
            jsr __e2a2         ; $d52f: 20 a2 e2  
            bcc __d535         ; $d532: 90 01     
            rts                ; $d534: 60        

;-------------------------------------------------------------------------------
__d535:     jsr __de62         ; $d535: 20 62 de  
            jsr __dfa3         ; $d538: 20 a3 df  
            jmp __df82         ; $d53b: 4c 82 df  

;-------------------------------------------------------------------------------
            jsr __9506         ; $d53e: 20 06 95  
            lda $0420,x        ; $d541: bd 20 04  
            bne __d54a         ; $d544: d0 04     
            lda #$f4           ; $d546: a9 f4     
            bne __d54c         ; $d548: d0 02     
__d54a:     lda #$0c           ; $d54a: a9 0c     
__d54c:     ldy #$13           ; $d54c: a0 13     
            jsr __e2af         ; $d54e: 20 af e2  
            bcc __d556         ; $d551: 90 03     
            jsr __e01f         ; $d553: 20 1f e0  
__d556:     lda $0456,x        ; $d556: bd 56 04  
            beq __d55f         ; $d559: f0 04     
            dec $0456,x        ; $d55b: de 56 04  
            rts                ; $d55e: 60        

;-------------------------------------------------------------------------------
__d55f:     jmp __dfad         ; $d55f: 4c ad df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d562: bd d8 03  
            bne __d57c         ; $d565: d0 15     
            jsr __dec6         ; $d567: 20 c6 de  
            lda #$14           ; $d56a: a9 14     
            jsr __ded8         ; $d56c: 20 d8 de  
            lda #$fc           ; $d56f: a9 fc     
            ldy #$00           ; $d571: a0 00     
            jsr __e076         ; $d573: 20 76 e0  
            lda #$01           ; $d576: a9 01     
            sta $04c2,x        ; $d578: 9d c2 04  
            rts                ; $d57b: 60        

;-------------------------------------------------------------------------------
__d57c:     jsr __dd2a         ; $d57c: 20 2a dd  
            lda $0444,x        ; $d57f: bd 44 04  
            jsr __c5bb         ; $d582: 20 bb c5  
            .hex 8b 95         ; $d585: 8b 95     Invalid Opcode - XAA #$95
            .hex e3 95         ; $d587: e3 95     Invalid Opcode - ISC ($95,x)
            ora ($96,x)        ; $d589: 01 96     
            lda $0348          ; $d58b: ad 48 03  
            sec                ; $d58e: 38        
            sbc $0348,x        ; $d58f: fd 48 03  
            bmi __d5b6         ; $d592: 30 22     
            and #$f0           ; $d594: 29 f0     
            jsr __e373         ; $d596: 20 73 e3  
            cmp #$c0           ; $d599: c9 c0     
            bcc __d5a4         ; $d59b: 90 07     
            lda #$01           ; $d59d: a9 01     
            ldy #$00           ; $d59f: a0 00     
            jmp __95d8         ; $d5a1: 4c d8 95  

;-------------------------------------------------------------------------------
__d5a4:     cmp #$80           ; $d5a4: c9 80     
            bcc __d5af         ; $d5a6: 90 07     
            lda #$00           ; $d5a8: a9 00     
            ldy #$c0           ; $d5aa: a0 c0     
            jmp __95d8         ; $d5ac: 4c d8 95  

;-------------------------------------------------------------------------------
__d5af:     lda #$00           ; $d5af: a9 00     
            ldy #$80           ; $d5b1: a0 80     
            jmp __95d8         ; $d5b3: 4c d8 95  

;-------------------------------------------------------------------------------
__d5b6:     jsr __deb7         ; $d5b6: 20 b7 de  
            and #$f0           ; $d5b9: 29 f0     
            jsr __e373         ; $d5bb: 20 73 e3  
            cmp #$c0           ; $d5be: c9 c0     
            bcc __d5c9         ; $d5c0: 90 07     
            lda #$ff           ; $d5c2: a9 ff     
            ldy #$00           ; $d5c4: a0 00     
            jmp __95d8         ; $d5c6: 4c d8 95  

;-------------------------------------------------------------------------------
__d5c9:     cmp #$80           ; $d5c9: c9 80     
            bcc __d5d4         ; $d5cb: 90 07     
            lda #$ff           ; $d5cd: a9 ff     
            ldy #$20           ; $d5cf: a0 20     
            jmp __95d8         ; $d5d1: 4c d8 95  

;-------------------------------------------------------------------------------
__d5d4:     lda #$ff           ; $d5d4: a9 ff     
            ldy #$80           ; $d5d6: a0 80     
            sta $0390,x        ; $d5d8: 9d 90 03  
            tya                ; $d5db: 98        
            sta $03a2,x        ; $d5dc: 9d a2 03  
            inc $0444,x        ; $d5df: fe 44 04  
            rts                ; $d5e2: 60        

;-------------------------------------------------------------------------------
            lda #$20           ; $d5e3: a9 20     
            sta $08            ; $d5e5: 85 08     
            jsr __dfe4         ; $d5e7: 20 e4 df  
            lda $036c,x        ; $d5ea: bd 6c 03  
            bmi __d5fe         ; $d5ed: 30 0f     
            lda #$00           ; $d5ef: a9 00     
            ldy #$04           ; $d5f1: a0 04     
            jsr __e2a2         ; $d5f3: 20 a2 e2  
            bcs __d5fe         ; $d5f6: b0 06     
            jsr __de62         ; $d5f8: 20 62 de  
            inc $0444,x        ; $d5fb: fe 44 04  
__d5fe:     jmp __e0f4         ; $d5fe: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $d601: bd 56 04  
            bne __d614         ; $d604: d0 0e     
            lda #$20           ; $d606: a9 20     
            jsr __dd8b         ; $d608: 20 8b dd  
            lda $0324,x        ; $d60b: bd 24 03  
            sec                ; $d60e: 38        
            sbc #$08           ; $d60f: e9 08     
            sta $0324,x        ; $d611: 9d 24 03  
__d614:     inc $0456,x        ; $d614: fe 56 04  
            lda $0456,x        ; $d617: bd 56 04  
            cmp #$30           ; $d61a: c9 30     
            bne __d621         ; $d61c: d0 03     
            jmp __df42         ; $d61e: 4c 42 df  

;-------------------------------------------------------------------------------
__d621:     rts                ; $d621: 60        

;-------------------------------------------------------------------------------
            stx $10            ; $d622: 86 10     
            lda $03d8,x        ; $d624: bd d8 03  
            bne __d636         ; $d627: d0 0d     
            lda #$01           ; $d629: a9 01     
            sta $0312,x        ; $d62b: 9d 12 03  
            jsr __deca         ; $d62e: 20 ca de  
            lda #$05           ; $d631: a9 05     
            jmp __ded8         ; $d633: 4c d8 de  

;-------------------------------------------------------------------------------
__d636:     inc $04d4,x        ; $d636: fe d4 04  
            lda $04d4,x        ; $d639: bd d4 04  
            cmp #$40           ; $d63c: c9 40     
            bne __d656         ; $d63e: d0 16     
            lda #$00           ; $d640: a9 00     
            sta $04d4,x        ; $d642: 9d d4 04  
            lda $03c6,x        ; $d645: bd c6 03  
            bne __d656         ; $d648: d0 0c     
            jsr __dfb3         ; $d64a: 20 b3 df  
            bcs __d656         ; $d64d: b0 07     
            ldy $10            ; $d64f: a4 10     
            lda #$0c           ; $d651: a9 0c     
            jmp __de7b         ; $d653: 4c 7b de  

;-------------------------------------------------------------------------------
__d656:     ldx $10            ; $d656: a6 10     
            jsr __dd2a         ; $d658: 20 2a dd  
            lda $0444,x        ; $d65b: bd 44 04  
            jsr __c5bb         ; $d65e: 20 bb c5  
            .hex 67 96         ; $d661: 67 96     Invalid Opcode - RRA $96
            .hex 72            ; $d663: 72        Invalid Opcode - KIL 
            stx $aa,y          ; $d664: 96 aa     
            stx $a9,y          ; $d666: 96 a9     
            cpy #$20           ; $d668: c0 20     
            .hex 6f de fe      ; $d66a: 6f de fe  Invalid Opcode - RRA __fede
            .hex 44 04         ; $d66d: 44 04     Invalid Opcode - NOP $04
            jmp __df8a         ; $d66f: 4c 8a df  

;-------------------------------------------------------------------------------
__d672:     jsr __e0f4         ; $d672: 20 f4 e0  
            lda $0456,x        ; $d675: bd 56 04  
            cmp #$40           ; $d678: c9 40     
            bne __d67f         ; $d67a: d0 03     
            jmp __dfad         ; $d67c: 4c ad df  

;-------------------------------------------------------------------------------
__d67f:     lda $0348,x        ; $d67f: bd 48 03  
            sec                ; $d682: 38        
            .hex ed            ; $d683: ed        Suspected data
__d684:     pha                ; $d684: 48        
            .hex 03 b0         ; $d685: 03 b0     Invalid Opcode - SLO ($b0,x)
            .hex 03 20         ; $d687: 03 20     Invalid Opcode - SLO ($20,x)
            .hex b7 de         ; $d689: b7 de     Invalid Opcode - LAX $de,y
            cmp #$28           ; $d68b: c9 28     
            bcs __d6a4         ; $d68d: b0 15     
            jsr __e010         ; $d68f: 20 10 e0  
            lda #$ff           ; $d692: a9 ff     
            ldy #$00           ; $d694: a0 00     
            jsr __e04f         ; $d696: 20 4f e0  
            lda #$fe           ; $d699: a9 fe     
            ldy #$00           ; $d69b: a0 00     
            jsr __e076         ; $d69d: 20 76 e0  
            inc $0444,x        ; $d6a0: fe 44 04  
            rts                ; $d6a3: 60        

;-------------------------------------------------------------------------------
__d6a4:     jsr __de8b         ; $d6a4: 20 8b de  
            jmp __dea1         ; $d6a7: 4c a1 de  

;-------------------------------------------------------------------------------
            lda #$10           ; $d6aa: a9 10     
            sta $08            ; $d6ac: 85 08     
            jsr __dfe4         ; $d6ae: 20 e4 df  
            lda $0390,x        ; $d6b1: bd 90 03  
            bmi __d6ba         ; $d6b4: 30 04     
            lda #$06           ; $d6b6: a9 06     
            bne __d6bc         ; $d6b8: d0 02     
__d6ba:     lda #$fa           ; $d6ba: a9 fa     
__d6bc:     ldy #$00           ; $d6bc: a0 00     
            jsr __e2a2         ; $d6be: 20 a2 e2  
            bcs __d6c6         ; $d6c1: b0 03     
            jsr __e027         ; $d6c3: 20 27 e0  
__d6c6:     lda $036c,x        ; $d6c6: bd 6c 03  
            bmi __d6d4         ; $d6c9: 30 09     
            lda #$00           ; $d6cb: a9 00     
            ldy #$10           ; $d6cd: a0 10     
            jsr __e2a2         ; $d6cf: 20 a2 e2  
            bcc __d6d7         ; $d6d2: 90 03     
__d6d4:     jmp __e0f4         ; $d6d4: 4c f4 e0  

;-------------------------------------------------------------------------------
__d6d7:     jsr __de62         ; $d6d7: 20 62 de  
            jsr __dfa8         ; $d6da: 20 a8 df  
            jmp __df82         ; $d6dd: 4c 82 df  

;-------------------------------------------------------------------------------
            rts                ; $d6e0: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d6e1: bd d8 03  
            bne __d6f3         ; $d6e4: d0 0d     
            jsr __dec2         ; $d6e6: 20 c2 de  
            lda #$10           ; $d6e9: a9 10     
            sta $0324,x        ; $d6eb: 9d 24 03  
            lda #$2f           ; $d6ee: a9 2f     
            jmp __ded8         ; $d6f0: 4c d8 de  

;-------------------------------------------------------------------------------
__d6f3:     jsr __e0f4         ; $d6f3: 20 f4 e0  
            lda $0444,x        ; $d6f6: bd 44 04  
            jsr __c5bb         ; $d6f9: 20 bb c5  
            .hex 02            ; $d6fc: 02        Invalid Opcode - KIL 
            .hex 97 20         ; $d6fd: 97 20     Invalid Opcode - SAX $20,y
            .hex 97 4a         ; $d6ff: 97 4a     Invalid Opcode - SAX $4a,y
            .hex 97            ; $d701: 97        Suspected data
__d702:     lda $0348,x        ; $d702: bd 48 03  
            sec                ; $d705: 38        
            sbc $0348          ; $d706: ed 48 03  
            bcs __d70e         ; $d709: b0 03     
            jsr __deb7         ; $d70b: 20 b7 de  
__d70e:     cmp #$10           ; $d70e: c9 10     
            bcc __d713         ; $d710: 90 01     
            rts                ; $d712: 60        

;-------------------------------------------------------------------------------
__d713:     inc $0444,x        ; $d713: fe 44 04  
            jsr __deca         ; $d716: 20 ca de  
            lda #$ff           ; $d719: a9 ff     
            ldy #$00           ; $d71b: a0 00     
            jmp __e076         ; $d71d: 4c 76 e0  

;-------------------------------------------------------------------------------
            .hex 20            ; $d720: 20        Suspected data
__d721:     rol                ; $d721: 2a        
            cmp $20a9,x        ; $d722: dd a9 20  
            sta $08            ; $d725: 85 08     
            jsr __dfe4         ; $d727: 20 e4 df  
            lda #$00           ; $d72a: a9 00     
            ldy #$08           ; $d72c: a0 08     
            jsr __e2af         ; $d72e: 20 af e2  
            bcc __d734         ; $d731: 90 01     
            rts                ; $d733: 60        

;-------------------------------------------------------------------------------
__d734:     lda #$02           ; $d734: a9 02     
            sta $0444,x        ; $d736: 9d 44 04  
            lda #$ff           ; $d739: a9 ff     
            ldy #$00           ; $d73b: a0 00     
            jsr __e076         ; $d73d: 20 76 e0  
            lda #$00           ; $d740: a9 00     
            sta $048c,x        ; $d742: 9d 8c 04  
            lda #$80           ; $d745: a9 80     
            jmp __de6f         ; $d747: 4c 6f de  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $d74a: 20 2a dd  
            lda #$20           ; $d74d: a9 20     
            sta $08            ; $d74f: 85 08     
            jsr __dfe4         ; $d751: 20 e4 df  
            lda $048c,x        ; $d754: bd 8c 04  
            cmp #$38           ; $d757: c9 38     
            bne __d75e         ; $d759: d0 03     
            jsr __dea1         ; $d75b: 20 a1 de  
__d75e:     inc $048c,x        ; $d75e: fe 8c 04  
            rts                ; $d761: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d762: bd d8 03  
            bne __d780         ; $d765: d0 19     
            lda #$82           ; $d767: a9 82     
            sta $03d8,x        ; $d769: 9d d8 03  
            lda $04c2,x        ; $d76c: bd c2 04  
            bne __d775         ; $d76f: d0 04     
            lda #$9f           ; $d771: a9 9f     
            bne __d777         ; $d773: d0 02     
__d775:     lda #$9f           ; $d775: a9 9f     
__d777:     sta $0300,x        ; $d777: 9d 00 03  
            lda #$10           ; $d77a: a9 10     
            sta $03c6,x        ; $d77c: 9d c6 03  
            rts                ; $d77f: 60        

;-------------------------------------------------------------------------------
__d780:     lda $0444,x        ; $d780: bd 44 04  
            jsr __c5bb         ; $d783: 20 bb c5  
            .hex 8c 97         ; $d786: 8c 97     Suspected data
__d788:     bcs __d721         ; $d788: b0 97     
            cmp __bd97         ; $d78a: cd 97 bd  
            pha                ; $d78d: 48        
            .hex 03 38         ; $d78e: 03 38     Invalid Opcode - SLO ($38,x)
            sbc $0348          ; $d790: ed 48 03  
            bcs __d798         ; $d793: b0 03     
            jsr __deb7         ; $d795: 20 b7 de  
__d798:     .hex c9            ; $d798: c9        Suspected data
__d799:     jsr $0190          ; $d799: 20 90 01  
            rts                ; $d79c: 60        

;-------------------------------------------------------------------------------
            inc $0444,x        ; $d79d: fe 44 04  
            lda $03c6,x        ; $d7a0: bd c6 03  
            and #$ef           ; $d7a3: 29 ef     
            sta $03c6,x        ; $d7a5: 9d c6 03  
            lda $03d8,x        ; $d7a8: bd d8 03  
            and #$7f           ; $d7ab: 29 7f     
            jmp __decc         ; $d7ad: 4c cc de  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $d7b0: bd 56 04  
            cmp #$20           ; $d7b3: c9 20     
            bne __d7ca         ; $d7b5: d0 13     
            inc $0444,x        ; $d7b7: fe 44 04  
            lda $04c2,x        ; $d7ba: bd c2 04  
            beq __d7c3         ; $d7bd: f0 04     
            lda #$02           ; $d7bf: a9 02     
            bne __d7c5         ; $d7c1: d0 02     
__d7c3:     lda #$fe           ; $d7c3: a9 fe     
__d7c5:     ldy #$80           ; $d7c5: a0 80     
            jmp __e076         ; $d7c7: 4c 76 e0  

;-------------------------------------------------------------------------------
__d7ca:     inc $0456,x        ; $d7ca: fe 56 04  
            jsr __d9cf         ; $d7cd: 20 cf d9  
            jmp __e0f4         ; $d7d0: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d7d3: bd d8 03  
            bne __d7e4         ; $d7d6: d0 0c     
            lda #$00           ; $d7d8: a9 00     
            sta $03fc,x        ; $d7da: 9d fc 03  
            lda #$01           ; $d7dd: a9 01     
            ldy #$3c           ; $d7df: a0 3c     
            jmp __ded0         ; $d7e1: 4c d0 de  

;-------------------------------------------------------------------------------
__d7e4:     lda $0444,x        ; $d7e4: bd 44 04  
            jsr __c5bb         ; $d7e7: 20 bb c5  
            inc $97,x          ; $d7ea: f6 97     
            .hex 04 98         ; $d7ec: 04 98     Invalid Opcode - NOP $98
            bvs __d788         ; $d7ee: 70 98     
            eor #$98           ; $d7f0: 49 98     
            php                ; $d7f2: 08        
            sta __98bc,y       ; $d7f3: 99 bc 98  
            inc $0444,x        ; $d7f6: fe 44 04  
            lda $2e            ; $d7f9: a5 2e     
            and #$1f           ; $d7fb: 29 1f     
            clc                ; $d7fd: 18        
            adc #$03           ; $d7fe: 69 03     
            sta $0468,x        ; $d800: 9d 68 04  
            rts                ; $d803: 60        

;-------------------------------------------------------------------------------
            lda $0456,x        ; $d804: bd 56 04  
            cmp $0468,x        ; $d807: dd 68 04  
            beq __d829         ; $d80a: f0 1d     
            inc $0456,x        ; $d80c: fe 56 04  
            lda $0456,x        ; $d80f: bd 56 04  
            and #$03           ; $d812: 29 03     
            bne __d824         ; $d814: d0 0e     
            lda $0300,x        ; $d816: bd 00 03  
            cmp #$88           ; $d819: c9 88     
            beq __d825         ; $d81b: f0 08     
            cmp #$3d           ; $d81d: c9 3d     
            beq __d825         ; $d81f: f0 04     
            inc $0300,x        ; $d821: fe 00 03  
__d824:     rts                ; $d824: 60        

;-------------------------------------------------------------------------------
__d825:     dec $0300,x        ; $d825: de 00 03  
            rts                ; $d828: 60        

;-------------------------------------------------------------------------------
__d829:     lda #$00           ; $d829: a9 00     
            sta $0456,x        ; $d82b: 9d 56 04  
            sta $0468,x        ; $d82e: 9d 68 04  
            lda $2e            ; $d831: a5 2e     
            bmi __d8a0         ; $d833: 30 6b     
            lda $0300,x        ; $d835: bd 00 03  
            bmi __d861         ; $d838: 30 27     
            lda #$8a           ; $d83a: a9 8a     
            sta $0300,x        ; $d83c: 9d 00 03  
            lda #$00           ; $d83f: a9 00     
            sta $03fc,x        ; $d841: 9d fc 03  
            lda #$03           ; $d844: a9 03     
            sta $0444,x        ; $d846: 9d 44 04  
            jsr __e0f4         ; $d849: 20 f4 e0  
            inc $0456,x        ; $d84c: fe 56 04  
            lda #$10           ; $d84f: a9 10     
            sta $08            ; $d851: 85 08     
            jsr __dffa         ; $d853: 20 fa df  
            lda $0456,x        ; $d856: bd 56 04  
            cmp #$08           ; $d859: c9 08     
            bmi __d860         ; $d85b: 30 03     
            jmp __9924         ; $d85d: 4c 24 99  

;-------------------------------------------------------------------------------
__d860:     rts                ; $d860: 60        

;-------------------------------------------------------------------------------
__d861:     lda #$8a           ; $d861: a9 8a     
            sta $0300,x        ; $d863: 9d 00 03  
            lda #$00           ; $d866: a9 00     
            sta $03fc,x        ; $d868: 9d fc 03  
            lda #$02           ; $d86b: a9 02     
            sta $0444,x        ; $d86d: 9d 44 04  
            jsr __e0f4         ; $d870: 20 f4 e0  
__d873:     inc $0456,x        ; $d873: fe 56 04  
            lda #$10           ; $d876: a9 10     
            sta $08            ; $d878: 85 08     
            jsr __dfe4         ; $d87a: 20 e4 df  
            lda $0456,x        ; $d87d: bd 56 04  
            cmp #$08           ; $d880: c9 08     
            bmi __d860         ; $d882: 30 dc     
            jmp __98cf         ; $d884: 4c cf 98  

;-------------------------------------------------------------------------------
            lda #$88           ; $d887: a9 88     
            bne __d88d         ; $d889: d0 02     
__d88b:     lda #$3c           ; $d88b: a9 3c     
__d88d:     sta $0300,x        ; $d88d: 9d 00 03  
            lda #$00           ; $d890: a9 00     
            sta $03fc,x        ; $d892: 9d fc 03  
            jsr __d3f6         ; $d895: 20 f6 d3  
            lda #$0b           ; $d898: a9 0b     
            jsr __c118         ; $d89a: 20 18 c1  
            jmp __9931         ; $d89d: 4c 31 99  

;-------------------------------------------------------------------------------
__d8a0:     lda $0300,x        ; $d8a0: bd 00 03  
            bmi __d8e2         ; $d8a3: 30 3d     
            lda #$05           ; $d8a5: a9 05     
            sta $0444,x        ; $d8a7: 9d 44 04  
            lda #$3e           ; $d8aa: a9 3e     
            sta $0300,x        ; $d8ac: 9d 00 03  
            lda #$00           ; $d8af: a9 00     
__d8b1:     sta $03fc,x        ; $d8b1: 9d fc 03  
            lda #$fd           ; $d8b4: a9 fd     
            sta $036c,x        ; $d8b6: 9d 6c 03  
            jmp __98f4         ; $d8b9: 4c f4 98  

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $d8bc: 20 f4 e0  
            lda $047a,x        ; $d8bf: bd 7a 04  
            sta $08            ; $d8c2: 85 08     
            jsr __dfe4         ; $d8c4: 20 e4 df  
            jsr __de8b         ; $d8c7: 20 8b de  
            lda $036c,x        ; $d8ca: bd 6c 03  
            bmi __d860         ; $d8cd: 30 91     
            lda $0420,x        ; $d8cf: bd 20 04  
            bne __d8d8         ; $d8d2: d0 04     
            lda #$fa           ; $d8d4: a9 fa     
            bne __d8da         ; $d8d6: d0 02     
__d8d8:     lda #$06           ; $d8d8: a9 06     
__d8da:     ldy #$00           ; $d8da: a0 00     
            jsr __e2a2         ; $d8dc: 20 a2 e2  
            bcc __d88b         ; $d8df: 90 aa     
            rts                ; $d8e1: 60        

;-------------------------------------------------------------------------------
__d8e2:     lda #$04           ; $d8e2: a9 04     
            .hex 9d            ; $d8e4: 9d        Suspected data
__d8e5:     jmp (__9d03)       ; $d8e5: 6c 03 9d  

;-------------------------------------------------------------------------------
            .hex 44 04         ; $d8e8: 44 04     Invalid Opcode - NOP $04
            lda #$89           ; $d8ea: a9 89     
            sta $0300,x        ; $d8ec: 9d 00 03  
            lda #$01           ; $d8ef: a9 01     
            sta $03fc,x        ; $d8f1: 9d fc 03  
            lda $2e            ; $d8f4: a5 2e     
            and #$1f           ; $d8f6: 29 1f     
            clc                ; $d8f8: 18        
            adc #$30           ; $d8f9: 69 30     
            sta $047a,x        ; $d8fb: 9d 7a 04  
            jsr __e010         ; $d8fe: 20 10 e0  
            .hex a9            ; $d901: a9        Suspected data
__d902:     ora ($a0,x)        ; $d902: 01 a0     
            rti                ; $d904: 40        

;-------------------------------------------------------------------------------
            jmp __e04f         ; $d905: 4c 4f e0  

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $d908: 20 f4 e0  
            lda $047a,x        ; $d90b: bd 7a 04  
            sta $08            ; $d90e: 85 08     
            jsr __dffa         ; $d910: 20 fa df  
            jsr __de8b         ; $d913: 20 8b de  
            lda $036c,x        ; $d916: bd 6c 03  
            bpl __d930         ; $d919: 10 15     
            lda $0420,x        ; $d91b: bd 20 04  
            bne __d924         ; $d91e: d0 04     
            lda #$fa           ; $d920: a9 fa     
            bne __d926         ; $d922: d0 02     
__d924:     lda #$06           ; $d924: a9 06     
__d926:     ldy #$f8           ; $d926: a0 f8     
            jsr __e2a2         ; $d928: 20 a2 e2  
            bcs __d930         ; $d92b: b0 03     
            jmp __9887         ; $d92d: 4c 87 98  

;-------------------------------------------------------------------------------
__d930:     rts                ; $d930: 60        

;-------------------------------------------------------------------------------
            jmp __df7f         ; $d931: 4c 7f df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $d934: bd d8 03  
            bne __d941         ; $d937: d0 08     
            jsr __deca         ; $d939: 20 ca de  
            lda #$07           ; $d93c: a9 07     
            jmp __ded8         ; $d93e: 4c d8 de  

;-------------------------------------------------------------------------------
__d941:     jsr __e010         ; $d941: 20 10 e0  
            lda $0444,x        ; $d944: bd 44 04  
            jsr __c5bb         ; $d947: 20 bb c5  
            bvc __d8e5         ; $d94a: 50 99     
            adc __8999         ; $d94c: 6d 99 89  
            sta $56fe,y        ; $d94f: 99 fe 56  
            .hex 04 bd         ; $d952: 04 bd     Invalid Opcode - NOP $bd
            lsr $04,x          ; $d954: 56 04     
            cmp #$50           ; $d956: c9 50     
            bne __d967         ; $d958: d0 0d     
            inc $0444,x        ; $d95a: fe 44 04  
            lda #$00           ; $d95d: a9 00     
            sta $0456,x        ; $d95f: 9d 56 04  
            lda #$80           ; $d962: a9 80     
            sta $037e,x        ; $d964: 9d 7e 03  
__d967:     lda #$14           ; $d967: a9 14     
            sta $0300,x        ; $d969: 9d 00 03  
            rts                ; $d96c: 60        

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $d96d: 20 2a dd  
            inc $0456,x        ; $d970: fe 56 04  
            lda $0456,x        ; $d973: bd 56 04  
            cmp #$30           ; $d976: c9 30     
            bne __d986         ; $d978: d0 0c     
            inc $0444,x        ; $d97a: fe 44 04  
            lda #$00           ; $d97d: a9 00     
            sta $037e,x        ; $d97f: 9d 7e 03  
            sta $0456,x        ; $d982: 9d 56 04  
            rts                ; $d985: 60        

;-------------------------------------------------------------------------------
__d986:     jmp __e0f4         ; $d986: 4c f4 e0  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $d989: 20 2a dd  
            inc $0456,x        ; $d98c: fe 56 04  
            lda $0456,x        ; $d98f: bd 56 04  
            cmp #$18           ; $d992: c9 18     
            bne __d9b8         ; $d994: d0 22     
            lda #$00           ; $d996: a9 00     
            sta $0456,x        ; $d998: 9d 56 04  
            lda $048c,x        ; $d99b: bd 8c 04  
            beq __d9e3         ; $d99e: f0 43     
            lda $2e            ; $d9a0: a5 2e     
            and #$3f           ; $d9a2: 29 3f     
            ldy #$02           ; $d9a4: a0 02     
            jsr __8d19         ; $d9a6: 20 19 8d  
            inc $048c,x        ; $d9a9: fe 8c 04  
            lda $048c,x        ; $d9ac: bd 8c 04  
            cmp #$03           ; $d9af: c9 03     
            bne __d9b8         ; $d9b1: d0 05     
            lda #$00           ; $d9b3: a9 00     
            sta $048c,x        ; $d9b5: 9d 8c 04  
__d9b8:     lda $047a,x        ; $d9b8: bd 7a 04  
            beq __d9c8         ; $d9bb: f0 0b     
            lda #$fa           ; $d9bd: a9 fa     
            ldy #$f0           ; $d9bf: a0 f0     
            jsr __e2a2         ; $d9c1: 20 a2 e2  
            bcc __d9da         ; $d9c4: 90 14     
            bcs __d9d7         ; $d9c6: b0 0f     
__d9c8:     inc $0468,x        ; $d9c8: fe 68 04  
            lda $0468,x        ; $d9cb: bd 68 04  
            .hex c9            ; $d9ce: c9        Suspected data
__d9cf:     rts                ; $d9cf: 60        

;-------------------------------------------------------------------------------
            bne __d9d7         ; $d9d0: d0 05     
            lda #$01           ; $d9d2: a9 01     
            sta $047a,x        ; $d9d4: 9d 7a 04  
__d9d7:     jmp __e0f4         ; $d9d7: 4c f4 e0  

;-------------------------------------------------------------------------------
__d9da:     jsr __dfa3         ; $d9da: 20 a3 df  
            sta $047a,x        ; $d9dd: 9d 7a 04  
            jmp __df82         ; $d9e0: 4c 82 df  

;-------------------------------------------------------------------------------
__d9e3:     lda #$c0           ; $d9e3: a9 c0     
            jsr __de6f         ; $d9e5: 20 6f de  
            jsr __8d12         ; $d9e8: 20 12 8d  
            bcs __d9f3         ; $d9eb: b0 06     
            lda #$00           ; $d9ed: a9 00     
            ldy #$c0           ; $d9ef: a0 c0     
            bne __d9f7         ; $d9f1: d0 04     
__d9f3:     lda #$ff           ; $d9f3: a9 ff     
            ldy #$40           ; $d9f5: a0 40     
__d9f7:     jsr __e076         ; $d9f7: 20 76 e0  
            inc $048c,x        ; $d9fa: fe 8c 04  
            jmp __99b8         ; $d9fd: 4c b8 99  

;-------------------------------------------------------------------------------
            php                ; $da00: 08        
            txs                ; $da01: 9a        
            eor $9a,x          ; $da02: 55 9a     
            ldx $9a,y          ; $da04: b6 9a     
            .hex bb 9a 04      ; $da06: bb 9a 04  Invalid Opcode - LAS $049a,y
            .hex 04 03         ; $da09: 04 03     Invalid Opcode - NOP $03
            asl $0e04,x        ; $da0b: 1e 04 0e  
            .hex 03 1e         ; $da0e: 03 1e     Invalid Opcode - SLO ($1e,x)
            php                ; $da10: 08        
            .hex 1a            ; $da11: 1a        Invalid Opcode - NOP 
            .hex 03 1e         ; $da12: 03 1e     Invalid Opcode - SLO ($1e,x)
            .hex 0c 0c 03      ; $da14: 0c 0c 03  Invalid Opcode - NOP $030c
            asl $1a0c,x        ; $da17: 1e 0c 1a  
            .hex 03 1e         ; $da1a: 03 1e     Invalid Opcode - SLO ($1e,x)
            .hex 14 04         ; $da1c: 14 04     Invalid Opcode - NOP $04,x
            .hex 03 1e         ; $da1e: 03 1e     Invalid Opcode - SLO ($1e,x)
            .hex 14 0c         ; $da20: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 03 1e         ; $da22: 03 1e     Invalid Opcode - SLO ($1e,x)
            clc                ; $da24: 18        
            .hex 12            ; $da25: 12        Invalid Opcode - KIL 
            ora $1e            ; $da26: 05 1e     
            clc                ; $da28: 18        
            .hex 1a            ; $da29: 1a        Invalid Opcode - NOP 
            ora $1e            ; $da2a: 05 1e     
            .hex 1c 0c 03      ; $da2c: 1c 0c 03  Invalid Opcode - NOP $030c,x
            asl $1a1c,x        ; $da2f: 1e 1c 1a  
            ora $241e          ; $da32: 0d 1e 24  
            php                ; $da35: 08        
            .hex 03 1e         ; $da36: 03 1e     Invalid Opcode - SLO ($1e,x)
            bit $12            ; $da38: 24 12     
            ora $1e            ; $da3a: 05 1e     
            plp                ; $da3c: 28        
            clc                ; $da3d: 18        
            .hex 03 1e         ; $da3e: 03 1e     Invalid Opcode - SLO ($1e,x)
            bit $0308          ; $da40: 2c 08 03  
            asl $0434,x        ; $da43: 1e 34 04  
            ora $341e          ; $da46: 0d 1e 34  
            .hex 14 03         ; $da49: 14 03     Invalid Opcode - NOP $03,x
            asl $0e38,x        ; $da4b: 1e 38 0e  
            ora $3c1e          ; $da4e: 0d 1e 3c  
            .hex 14 05         ; $da51: 14 05     Invalid Opcode - NOP $05,x
            asl $02ff,x        ; $da53: 1e ff 02  
            .hex 34 af         ; $da56: 34 af     Invalid Opcode - NOP $af,x
            ora ($03,x)        ; $da58: 01 03     
            .hex 12            ; $da5a: 12        Invalid Opcode - KIL 
            .hex 03 1e         ; $da5b: 03 1e     Invalid Opcode - SLO ($1e,x)
            .hex 03 1a         ; $da5d: 03 1a     Invalid Opcode - SLO ($1a,x)
            .hex 03 1e         ; $da5f: 03 1e     Invalid Opcode - SLO ($1e,x)
            .hex 03 22         ; $da61: 03 22     Invalid Opcode - SLO ($22,x)
            .hex 03 1e         ; $da63: 03 1e     Invalid Opcode - SLO ($1e,x)
            php                ; $da65: 08        
            asl $1e03          ; $da66: 0e 03 1e  
            php                ; $da69: 08        
            asl $1e0d,x        ; $da6a: 1e 0d 1e  
            php                ; $da6d: 08        
            plp                ; $da6e: 28        
            .hex 03 1e         ; $da6f: 03 1e     Invalid Opcode - SLO ($1e,x)
            ora #$36           ; $da71: 09 36     
            .hex 22            ; $da73: 22        Invalid Opcode - KIL 
            adc $0a            ; $da74: 65 0a     
            .hex 37 20         ; $da76: 37 20     Invalid Opcode - RLA $20,x
            brk                ; $da78: 00        
            ora $2037          ; $da79: 0d 37 20  
            brk                ; $da7c: 00        
            .hex 13 37         ; $da7d: 13 37     Invalid Opcode - SLO ($37),y
            jsr $1400          ; $da7f: 20 00 14  
            .hex 0c 03 1e      ; $da82: 0c 03 1e  Invalid Opcode - NOP $1e03
            .hex 14 2b         ; $da85: 14 2b     Invalid Opcode - NOP $2b,x
            asl $151e          ; $da87: 0e 1e 15  
            rol $22,x          ; $da8a: 36 22     
            ror $1c            ; $da8c: 66 1c     
            .hex 2b 0e         ; $da8e: 2b 0e     Invalid Opcode - ANC #$0e
            asl $0c1d,x        ; $da90: 1e 1d 0c  
            ldx $2406          ; $da93: ae 06 24  
            .hex 12            ; $da96: 12        Invalid Opcode - KIL 
            .hex 03 1e         ; $da97: 03 1e     Invalid Opcode - SLO ($1e,x)
            bit $26            ; $da99: 24 26     
            ora $281e          ; $da9b: 0d 1e 28  
            .hex 0c 0d 1e      ; $da9e: 0c 0d 1e  Invalid Opcode - NOP $1e0d
            plp                ; $daa1: 28        
            asl $0d,x          ; $daa2: 16 0d     
            asl $2028,x        ; $daa4: 1e 28 20  
            ora $1e            ; $daa7: 05 1e     
            rol                ; $daa9: 2a        
            bmi __dab1         ; $daaa: 30 05     
            asl $122c,x        ; $daac: 1e 2c 12  
            .hex 03 1e         ; $daaf: 03 1e     Invalid Opcode - SLO ($1e,x)
__dab1:     bit $0320          ; $dab1: 2c 20 03  
            asl $08ff,x        ; $dab4: 1e ff 08  
            asl                ; $dab7: 0a        
            .hex 42            ; $dab8: 42        Invalid Opcode - KIL 
            .hex f0            ; $dab9: f0        Suspected data
__daba:     .hex ff 0d 07      ; $daba: ff 0d 07  Invalid Opcode - ISC $070d,x
            and $1c            ; $dabd: 25 1c     
            .hex ff c4 9a      ; $dabf: ff c4 9a  Invalid Opcode - ISC __9ac4,x
            and $049b          ; $dac2: 2d 9b 04  
            asl $0205          ; $dac5: 0e 05 02  
            ora $28            ; $dac8: 05 28     
            .hex 22            ; $daca: 22        Invalid Opcode - KIL 
            ldy $08            ; $dacb: a4 08     
            bpl __dad2         ; $dacd: 10 03     
            .hex 02            ; $dacf: 02        Invalid Opcode - KIL 
            php                ; $dad0: 08        
            .hex 14            ; $dad1: 14        Suspected data
__dad2:     .hex 03 02         ; $dad2: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 08 03      ; $dad4: 0c 08 03  Invalid Opcode - NOP $0308
            .hex 02            ; $dad7: 02        Invalid Opcode - KIL 
            .hex 0c 1e 05      ; $dad8: 0c 1e 05  Invalid Opcode - NOP $051e
            .hex 02            ; $dadb: 02        Invalid Opcode - KIL 
            .hex 14 0e         ; $dadc: 14 0e     Invalid Opcode - NOP $0e,x
            .hex 1f 01 14      ; $dade: 1f 01 14  Invalid Opcode - SLO $1401,x
            clc                ; $dae1: 18        
            .hex 0f 02 18      ; $dae2: 0f 02 18  Invalid Opcode - SLO $1802
            php                ; $dae5: 08        
            .hex 03 02         ; $dae6: 03 02     Invalid Opcode - SLO ($02,x)
            clc                ; $dae8: 18        
            asl $0203,x        ; $dae9: 1e 03 02  
            clc                ; $daec: 18        
            rol $03            ; $daed: 26 03     
            .hex 02            ; $daef: 02        Invalid Opcode - KIL 
            .hex 1c 0e 1f      ; $daf0: 1c 0e 1f  Invalid Opcode - NOP $1f0e,x
            ora ($1c,x)        ; $daf3: 01 1c     
            clc                ; $daf5: 18        
            .hex 1f 01 24      ; $daf6: 1f 01 24  Invalid Opcode - SLO $2401,x
            asl $011f          ; $daf9: 0e 1f 01  
            bit $18            ; $dafc: 24 18     
            .hex 1f 01 28      ; $dafe: 1f 01 28  Invalid Opcode - SLO $2801,x
            php                ; $db01: 08        
            .hex 03 02         ; $db02: 03 02     Invalid Opcode - SLO ($02,x)
            plp                ; $db04: 28        
            clc                ; $db05: 18        
            .hex 1f 01 28      ; $db06: 1f 01 28  Invalid Opcode - SLO $2801,x
            asl $0203,x        ; $db09: 1e 03 02  
            bit $1f0e          ; $db0c: 2c 0e 1f  
            ora ($2c,x)        ; $db0f: 01 2c     
            rol $0f            ; $db11: 26 0f     
            .hex 02            ; $db13: 02        Invalid Opcode - KIL 
            .hex 34 0c         ; $db14: 34 0c     Invalid Opcode - NOP $0c,x
            .hex 03 02         ; $db16: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 34 26         ; $db18: 34 26     Invalid Opcode - NOP $26,x
            .hex 03 02         ; $db1a: 03 02     Invalid Opcode - SLO ($02,x)
            sec                ; $db1c: 38        
            asl $03            ; $db1d: 06 03     
            .hex 02            ; $db1f: 02        Invalid Opcode - KIL 
            .hex 3c 0c 03      ; $db20: 3c 0c 03  Invalid Opcode - NOP $030c,x
            .hex 02            ; $db23: 02        Invalid Opcode - KIL 
            .hex 3c 22 03      ; $db24: 3c 22 03  Invalid Opcode - NOP $0322,x
            .hex 02            ; $db27: 02        Invalid Opcode - KIL 
            rol $270c,x        ; $db28: 3e 0c 27  
            asl $01ff,x        ; $db2b: 1e ff 01  
            .hex 0c 27 1f      ; $db2e: 0c 27 1f  Invalid Opcode - NOP $1f27
            .hex 04 26         ; $db31: 04 26     Invalid Opcode - NOP $26
            .hex 0f 02 07      ; $db33: 0f 02 07  Invalid Opcode - SLO $0702
            .hex 0c ae 06      ; $db36: 0c ae 06  Invalid Opcode - NOP $06ae
            php                ; $db39: 08        
            .hex 22            ; $db3a: 22        Invalid Opcode - KIL 
            ora $02            ; $db3b: 05 02     
            .hex 0c 06 0d      ; $db3d: 0c 06 0d  Invalid Opcode - NOP $0d06
            .hex 02            ; $db40: 02        Invalid Opcode - KIL 
            .hex 0c 26 0f      ; $db41: 0c 26 0f  Invalid Opcode - NOP $0f26
            .hex 02            ; $db44: 02        Invalid Opcode - KIL 
            .hex 14 1c         ; $db45: 14 1c     Invalid Opcode - NOP $1c,x
            .hex 03 02         ; $db47: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 14 22         ; $db49: 14 22     Invalid Opcode - NOP $22,x
            ora $02            ; $db4b: 05 02     
            .hex 14 26         ; $db4d: 14 26     Invalid Opcode - NOP $26,x
            ora $02            ; $db4f: 05 02     
            clc                ; $db51: 18        
            asl $0d            ; $db52: 06 0d     
            .hex 02            ; $db54: 02        Invalid Opcode - KIL 
            clc                ; $db55: 18        
            asl $03,x          ; $db56: 16 03     
            .hex 02            ; $db58: 02        Invalid Opcode - KIL 
            .hex 1c 0c 03      ; $db59: 1c 0c 03  Invalid Opcode - NOP $030c,x
            .hex 02            ; $db5c: 02        Invalid Opcode - KIL 
            .hex 1c 12 03      ; $db5d: 1c 12 03  Invalid Opcode - NOP $0312,x
            .hex 02            ; $db60: 02        Invalid Opcode - KIL 
            .hex 1c 26 05      ; $db61: 1c 26 05  Invalid Opcode - NOP $0526,x
            .hex 02            ; $db64: 02        Invalid Opcode - KIL 
            plp                ; $db65: 28        
            .hex 12            ; $db66: 12        Invalid Opcode - KIL 
            .hex 03 02         ; $db67: 03 02     Invalid Opcode - SLO ($02,x)
            plp                ; $db69: 28        
            asl $0203,x        ; $db6a: 1e 03 02  
            plp                ; $db6d: 28        
            bit $03            ; $db6e: 24 03     
            .hex 02            ; $db70: 02        Invalid Opcode - KIL 
            bit $1f16          ; $db71: 2c 16 1f  
            ora ($2c,x)        ; $db74: 01 2c     
            .hex 1a            ; $db76: 1a        Invalid Opcode - NOP 
            .hex 03 02         ; $db77: 03 02     Invalid Opcode - SLO ($02,x)
            bit $0326          ; $db79: 2c 26 03  
            .hex 02            ; $db7c: 02        Invalid Opcode - KIL 
            rol $2716          ; $db7d: 2e 16 27  
            jsr $2634          ; $db80: 20 34 26  
            .hex 1f 01 38      ; $db83: 1f 01 38  Invalid Opcode - SLO $3801,x
            rol $1f            ; $db86: 26 1f     
            ora ($3d,x)        ; $db88: 01 3d     
            ora $25,x          ; $db8a: 15 25     
            clc                ; $db8c: 18        
            .hex ff 92 9b      ; $db8d: ff 92 9b  Invalid Opcode - ISC __9b92,x
            .hex f7 9b         ; $db90: f7 9b     Invalid Opcode - ISC $9b,x
            .hex 04 0a         ; $db92: 04 0a     Invalid Opcode - NOP $0a
            ora $04            ; $db94: 05 04     
            php                ; $db96: 08        
            bpl __db9c         ; $db97: 10 03     
            .hex 04 08         ; $db99: 04 08     Invalid Opcode - NOP $08
            clc                ; $db9b: 18        
__db9c:     .hex 03 04         ; $db9c: 03 04     Invalid Opcode - SLO ($04,x)
            php                ; $db9e: 08        
            plp                ; $db9f: 28        
            ora $04            ; $dba0: 05 04     
            .hex 0c 0a 03      ; $dba2: 0c 0a 03  Invalid Opcode - NOP $030a
            .hex 04 0c         ; $dba5: 04 0c     Invalid Opcode - NOP $0c
            jsr $0403          ; $dba7: 20 03 04  
            .hex 0c 28 0d      ; $dbaa: 0c 28 0d  Invalid Opcode - NOP $0d28
            .hex 04 14         ; $dbad: 04 14     Invalid Opcode - NOP $14
            asl                ; $dbaf: 0a        
            .hex 0f 04 14      ; $dbb0: 0f 04 14  Invalid Opcode - SLO $1404
            .hex 0c 11 04      ; $dbb3: 0c 11 04  Invalid Opcode - NOP $0411
            .hex 14 16         ; $dbb6: 14 16     Invalid Opcode - NOP $16,x
            ora ($04),y        ; $dbb8: 11 04     
            .hex 14 28         ; $dbba: 14 28     Invalid Opcode - NOP $28,x
            ora $1804          ; $dbbc: 0d 04 18  
            bpl __dbc6         ; $dbbf: 10 05     
            .hex 04 18         ; $dbc1: 04 18     Invalid Opcode - NOP $18
            asl $11,x          ; $dbc3: 16 11     
            .hex 04            ; $dbc5: 04        Suspected data
__dbc6:     clc                ; $dbc6: 18        
            plp                ; $dbc7: 28        
            .hex 03 04         ; $dbc8: 03 04     Invalid Opcode - SLO ($04,x)
            .hex 1c 0a 0f      ; $dbca: 1c 0a 0f  Invalid Opcode - NOP $0f0a,x
            .hex 04 1c         ; $dbcd: 04 1c     Invalid Opcode - NOP $1c
            .hex 0c 11 04      ; $dbcf: 0c 11 04  Invalid Opcode - NOP $0411
            .hex 1c 16 11      ; $dbd2: 1c 16 11  Invalid Opcode - NOP $1116,x
            .hex 04 1c         ; $dbd5: 04 1c     Invalid Opcode - NOP $1c
            jsr $0403          ; $dbd7: 20 03 04  
            .hex 23 1e         ; $dbda: 23 1e     Invalid Opcode - RLA ($1e,x)
__dbdc:     .hex 03 04         ; $dbdc: 03 04     Invalid Opcode - SLO ($04,x)
            bit $0a            ; $dbde: 24 0a     
            .hex 03 04         ; $dbe0: 03 04     Invalid Opcode - SLO ($04,x)
            bit $10            ; $dbe2: 24 10     
            .hex 03 04         ; $dbe4: 03 04     Invalid Opcode - SLO ($04,x)
            .hex 27 1c         ; $dbe6: 27 1c     Invalid Opcode - RLA $1c
            .hex 03 04         ; $dbe8: 03 04     Invalid Opcode - SLO ($04,x)
            plp                ; $dbea: 28        
            asl                ; $dbeb: 0a        
            .hex 03 04         ; $dbec: 03 04     Invalid Opcode - SLO ($04,x)
            bit $0316          ; $dbee: 2c 16 03  
            .hex 04 2c         ; $dbf1: 04 2c     Invalid Opcode - NOP $2c
            .hex 22            ; $dbf3: 22        Invalid Opcode - KIL 
            .hex 03 04         ; $dbf4: 03 04     Invalid Opcode - SLO ($04,x)
            .hex ff 03 28      ; $dbf6: ff 03 28  Invalid Opcode - ISC $2803,x
            ora $0704          ; $dbf9: 0d 04 07  
            plp                ; $dbfc: 28        
            ora $1404          ; $dbfd: 0d 04 14  
            .hex 14 03         ; $dc00: 14 03     Invalid Opcode - NOP $03,x
            .hex 04 14         ; $dc02: 04 14     Invalid Opcode - NOP $14
            .hex 1c 03 04      ; $dc04: 1c 03 04  Invalid Opcode - NOP $0403,x
            clc                ; $dc07: 18        
            asl $03,x          ; $dc08: 16 03     
            .hex 04 18         ; $dc0a: 04 18     Invalid Opcode - NOP $18
            .hex 22            ; $dc0c: 22        Invalid Opcode - KIL 
            .hex 03 04         ; $dc0d: 03 04     Invalid Opcode - SLO ($04,x)
            bit $08            ; $dc0f: 24 08     
            .hex 03 04         ; $dc11: 03 04     Invalid Opcode - SLO ($04,x)
            bit $12            ; $dc13: 24 12     
            .hex 03 04         ; $dc15: 03 04     Invalid Opcode - SLO ($04,x)
            bit $1a            ; $dc17: 24 1a     
            ora $04            ; $dc19: 05 04     
            bit $25            ; $dc1b: 24 25     
            and ($85,x)        ; $dc1d: 21 85     
            plp                ; $dc1f: 28        
            asl $0403          ; $dc20: 0e 03 04  
            plp                ; $dc23: 28        
            .hex 1a            ; $dc24: 1a        Invalid Opcode - NOP 
            ora $04            ; $dc25: 05 04     
            bit $0308          ; $dc27: 2c 08 03  
            .hex 04 34         ; $dc2a: 04 34     Invalid Opcode - NOP $34
            php                ; $dc2c: 08        
            ora $04            ; $dc2d: 05 04     
            .hex 34 28         ; $dc2f: 34 28     Invalid Opcode - NOP $28,x
            ora $3804          ; $dc31: 0d 04 38  
            .hex 22            ; $dc34: 22        Invalid Opcode - KIL 
            .hex 03 04         ; $dc35: 03 04     Invalid Opcode - SLO ($04,x)
            sec                ; $dc37: 38        
            plp                ; $dc38: 28        
            ldx $3d06          ; $dc39: ae 06 3d  
            ora $25,x          ; $dc3c: 15 25     
            ora $083e,y        ; $dc3e: 19 3e 08  
            .hex 27 21         ; $dc41: 27 21     Invalid Opcode - RLA $21
            rol $2722,x        ; $dc43: 3e 22 27  
            .hex 22            ; $dc46: 22        Invalid Opcode - KIL 
            .hex ff 50 9c      ; $dc47: ff 50 9c  Invalid Opcode - ISC __9c50,x
            lda ($9c),y        ; $dc4a: b1 9c     
            dec __d39c         ; $dc4c: ce 9c d3  
            .hex 9c 01 10      ; $dc4f: 9c 01 10  Invalid Opcode - SHY $1001,x
            .hex 27 23         ; $dc52: 27 23     Invalid Opcode - RLA $23
            .hex 03 10         ; $dc54: 03 10     Invalid Opcode - SLO ($10,x)
            .hex 03 08         ; $dc56: 03 08     Invalid Opcode - SLO ($08,x)
            .hex 04 2e         ; $dc58: 04 2e     Invalid Opcode - NOP $2e
            .hex 03 08         ; $dc5a: 03 08     Invalid Opcode - SLO ($08,x)
            php                ; $dc5c: 08        
            asl $0803,x        ; $dc5d: 1e 03 08  
            php                ; $dc60: 08        
            rol                ; $dc61: 2a        
            .hex 1f 04 0c      ; $dc62: 1f 04 0c  Invalid Opcode - SLO $0c04,x
            asl $03,x          ; $dc65: 16 03     
            php                ; $dc67: 08        
            .hex 0c 24 1f      ; $dc68: 0c 24 1f  Invalid Opcode - NOP $1f24
            .hex 04 0c         ; $dc6b: 04 0c     Invalid Opcode - NOP $0c
            bmi __dc74         ; $dc6d: 30 05     
            php                ; $dc6f: 08        
            .hex 14 0e         ; $dc70: 14 0e     Invalid Opcode - NOP $0e,x
            .hex 03 08         ; $dc72: 03 08     Invalid Opcode - SLO ($08,x)
__dc74:     .hex 14 24         ; $dc74: 14 24     Invalid Opcode - NOP $24,x
            ora $08            ; $dc76: 05 08     
            clc                ; $dc78: 18        
            php                ; $dc79: 08        
            .hex 0f 08 18      ; $dc7a: 0f 08 18  Invalid Opcode - SLO $1808
            asl $03,x          ; $dc7d: 16 03     
            php                ; $dc7f: 08        
            clc                ; $dc80: 18        
            rol                ; $dc81: 2a        
            .hex 03 08         ; $dc82: 03 08     Invalid Opcode - SLO ($08,x)
            clc                ; $dc84: 18        
            bmi __dc8c         ; $dc85: 30 05     
            php                ; $dc87: 08        
            .hex 1c 0e 03      ; $dc88: 1c 0e 03  Invalid Opcode - NOP $030e,x
            php                ; $dc8b: 08        
__dc8c:     .hex 1c 1e 03      ; $dc8c: 1c 1e 03  Invalid Opcode - NOP $031e,x
            php                ; $dc8f: 08        
            .hex 23 16         ; $dc90: 23 16     Invalid Opcode - RLA ($16,x)
            ldx $2406          ; $dc92: ae 06 24  
            jsr $0805          ; $dc95: 20 05 08  
            bit $30            ; $dc98: 24 30     
            .hex 1f 04 24      ; $dc9a: 1f 04 24  Invalid Opcode - SLO $2404,x
            rol $1f,x          ; $dc9d: 36 1f     
            .hex 04 28         ; $dc9f: 04 28     Invalid Opcode - NOP $28
            php                ; $dca1: 08        
            ora $08            ; $dca2: 05 08     
            plp                ; $dca4: 28        
            clc                ; $dca5: 18        
            ora $08            ; $dca6: 05 08     
            plp                ; $dca8: 28        
            .hex 1c 05 08      ; $dca9: 1c 05 08  Invalid Opcode - NOP $0805,x
            bit $0326          ; $dcac: 2c 26 03  
            php                ; $dcaf: 08        
            .hex ff 04 0c      ; $dcb0: ff 04 0c  Invalid Opcode - ISC $0c04,x
            .hex 0f 08 04      ; $dcb3: 0f 08 04  Invalid Opcode - SLO $0408
            asl $05,x          ; $dcb6: 16 05     
            php                ; $dcb8: 08        
            .hex 04 32         ; $dcb9: 04 32     Invalid Opcode - NOP $32
            ora ($04),y        ; $dcbb: 11 04     
            php                ; $dcbd: 08        
            .hex 32            ; $dcbe: 32        Invalid Opcode - KIL 
            ora ($04),y        ; $dcbf: 11 04     
            .hex 0c 0c 0f      ; $dcc1: 0c 0c 0f  Invalid Opcode - NOP $0f0c
            php                ; $dcc4: 08        
            .hex 0c 32 11      ; $dcc5: 0c 32 11  Invalid Opcode - NOP $1132
            .hex 04 0e         ; $dcc8: 04 0e     Invalid Opcode - NOP $0e
            clc                ; $dcca: 18        
            .hex 27 24         ; $dccb: 27 24     Invalid Opcode - RLA $24
            .hex ff 08 08      ; $dccd: ff 08 08  Invalid Opcode - ISC $0808,x
            .hex 44 80         ; $dcd0: 44 80     Invalid Opcode - NOP $80
            .hex ff 0d 07      ; $dcd2: ff 0d 07  Invalid Opcode - ISC $070d,x
            and $1a            ; $dcd5: 25 1a     
            .hex ff bd d8      ; $dcd7: ff bd d8  Invalid Opcode - ISC __d8bd,x
            .hex 03 d0         ; $dcda: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 12            ; $dcdc: 12        Invalid Opcode - KIL 
            lda #$01           ; $dcdd: a9 01     
            ldy #$ca           ; $dcdf: a0 ca     
            jsr __ded0         ; $dce1: 20 d0 de  
            lda #$80           ; $dce4: a9 80     
            sta $0348,x        ; $dce6: 9d 48 03  
            lda #$a0           ; $dce9: a9 a0     
            sta $0324,x        ; $dceb: 9d 24 03  
            rts                ; $dcee: 60        

;-------------------------------------------------------------------------------
            lda $0444,x        ; $dcef: bd 44 04  
            jsr __c5bb         ; $dcf2: 20 bb c5  
            .hex ff 9c 0e      ; $dcf5: ff 9c 0e  Invalid Opcode - ISC $0e9c,x
            sta __9d22,x       ; $dcf8: 9d 22 9d  
            .hex 3b 9d 61      ; $dcfb: 3b 9d 61  Invalid Opcode - RLA $619d,y
            sta $78a9,x        ; $dcfe: 9d a9 78  
            sta $0456,x        ; $dd01: 9d 56 04  
            inc $0444,x        ; $dd04: fe 44 04  
            lda #$ff           ; $dd07: a9 ff     
            ldy #$80           ; $dd09: a0 80     
            jmp __e076         ; $dd0b: 4c 76 e0  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $dd0e: bd 56 04  
            bne __dd1c         ; $dd11: d0 09     
            jsr __9d2e         ; $dd13: 20 2e 9d  
            inc $0444,x        ; $dd16: fe 44 04  
            jmp __df82         ; $dd19: 4c 82 df  

;-------------------------------------------------------------------------------
__dd1c:     dec $0456,x        ; $dd1c: de 56 04  
__dd1f:     jmp __e0f4         ; $dd1f: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $2e            ; $dd22: a5 2e     
            and #$01           ; $dd24: 29 01     
            bne __dd37         ; $dd26: d0 0f     
            .hex fe 44         ; $dd28: fe 44     Suspected data
__dd2a:     .hex 04 fe         ; $dd2a: 04 fe     Invalid Opcode - NOP $fe
            .hex 44 04         ; $dd2c: 44 04     Invalid Opcode - NOP $04
            lda #$00           ; $dd2e: a9 00     
            sta $0456,x        ; $dd30: 9d 56 04  
            sta $0468,x        ; $dd33: 9d 68 04  
            rts                ; $dd36: 60        

;-------------------------------------------------------------------------------
__dd37:     inc $0444,x        ; $dd37: fe 44 04  
            rts                ; $dd3a: 60        

;-------------------------------------------------------------------------------
            inc $0456,x        ; $dd3b: fe 56 04  
            lda $0456,x        ; $dd3e: bd 56 04  
            cmp #$c0           ; $dd41: c9 c0     
            beq __dd53         ; $dd43: f0 0e     
            lda $04d4,x        ; $dd45: bd d4 04  
            cmp #$20           ; $dd48: c9 20     
            bne __dd4f         ; $dd4a: d0 03     
            jmp __9d9d         ; $dd4c: 4c 9d 9d  

;-------------------------------------------------------------------------------
__dd4f:     inc $04d4,x        ; $dd4f: fe d4 04  
            rts                ; $dd52: 60        

;-------------------------------------------------------------------------------
__dd53:     lda #$02           ; $dd53: a9 02     
            sta $0444,x        ; $dd55: 9d 44 04  
            lda #$00           ; $dd58: a9 00     
            sta $0456,x        ; $dd5a: 9d 56 04  
            sta $04d4,x        ; $dd5d: 9d d4 04  
            rts                ; $dd60: 60        

;-------------------------------------------------------------------------------
            ldy #$03           ; $dd61: a0 03     
            lda $0456,x        ; $dd63: bd 56 04  
            jsr __8d19         ; $dd66: 20 19 8d  
            lda $1d            ; $dd69: a5 1d     
            and #$01           ; $dd6b: 29 01     
            bne __dd1f         ; $dd6d: d0 b0     
            inc $0456,x        ; $dd6f: fe 56 04  
            lda $0456,x        ; $dd72: bd 56 04  
            cmp #$40           ; $dd75: c9 40     
            bne __dd81         ; $dd77: d0 08     
            lda #$00           ; $dd79: a9 00     
            sta $0456,x        ; $dd7b: 9d 56 04  
            inc $0468,x        ; $dd7e: fe 68 04  
__dd81:     lda $0468,x        ; $dd81: bd 68 04  
            cmp #$02           ; $dd84: c9 02     
            bne __dd1f         ; $dd86: d0 97     
            lda #$80           ; $dd88: a9 80     
            .hex 9d            ; $dd8a: 9d        Suspected data
__dd8b:     pha                ; $dd8b: 48        
            .hex 03 a9         ; $dd8c: 03 a9     Invalid Opcode - SLO ($a9,x)
            .hex 64 9d         ; $dd8e: 64 9d     Invalid Opcode - NOP $9d
            bit $03            ; $dd90: 24 03     
            jsr __9d2e         ; $dd92: 20 2e 9d  
            lda #$02           ; $dd95: a9 02     
            sta $0444,x        ; $dd97: 9d 44 04  
            jmp __df82         ; $dd9a: 4c 82 df  

;-------------------------------------------------------------------------------
            stx $10            ; $dd9d: 86 10     
            lda $0468,x        ; $dd9f: bd 68 04  
            cmp #$20           ; $dda2: c9 20     
            bne __ddca         ; $dda4: d0 24     
            lda #$00           ; $dda6: a9 00     
            sta $0468,x        ; $dda8: 9d 68 04  
            sta $04d4,x        ; $ddab: 9d d4 04  
            jsr __dfb3         ; $ddae: 20 b3 df  
            bcs __ddca         ; $ddb1: b0 17     
            lda #$45           ; $ddb3: a9 45     
            sta $03b4,x        ; $ddb5: 9d b4 03  
            ldy $10            ; $ddb8: a4 10     
            lda $0348,y        ; $ddba: b9 48 03  
            clc                ; $ddbd: 18        
            adc #$04           ; $ddbe: 69 04     
            sta $0348,x        ; $ddc0: 9d 48 03  
            lda $0324,y        ; $ddc3: b9 24 03  
            sta $0324,x        ; $ddc6: 9d 24 03  
            rts                ; $ddc9: 60        

;-------------------------------------------------------------------------------
__ddca:     ldx $10            ; $ddca: a6 10     
            inc $0468,x        ; $ddcc: fe 68 04  
            jmp __d9cf         ; $ddcf: 4c cf d9  

;-------------------------------------------------------------------------------
            stx $10            ; $ddd2: 86 10     
            lda $03d8,x        ; $ddd4: bd d8 03  
            bne __dde0         ; $ddd7: d0 07     
            lda #$02           ; $ddd9: a9 02     
            ldy #$df           ; $dddb: a0 df     
            jmp __ded0         ; $dddd: 4c d0 de  

;-------------------------------------------------------------------------------
__dde0:     lda #$02           ; $dde0: a9 02     
            sta $036c,x        ; $dde2: 9d 6c 03  
            lda #$00           ; $dde5: a9 00     
            ldy #$0a           ; $dde7: a0 0a     
            jsr __e2a2         ; $dde9: 20 a2 e2  
            bcc __ddf1         ; $ddec: 90 03     
            jmp __e0f4         ; $ddee: 4c f4 e0  

;-------------------------------------------------------------------------------
__ddf1:     lda #$09           ; $ddf1: a9 09     
            .hex 20            ; $ddf3: 20        Suspected data
__ddf4:     clc                ; $ddf4: 18        
            cmp ($20,x)        ; $ddf5: c1 20     
            inc __a69d,x       ; $ddf7: fe 9d a6  
            bpl __de48         ; $ddfa: 10 4c     
            .hex 42            ; $ddfc: 42        Invalid Opcode - KIL 
            .hex df a0 04      ; $ddfd: df a0 04  Invalid Opcode - DCP $04a0,x
            sty $0196          ; $de00: 8c 96 01  
__de03:     lda #$30           ; $de03: a9 30     
__de05:     sta $05            ; $de05: 85 05     
            ldy $0196          ; $de07: ac 96 01  
            lda __9e16,y       ; $de0a: b9 16 9e  
            jsr __8e21         ; $de0d: 20 21 8e  
            dec $0196          ; $de10: ce 96 01  
            bpl __de03         ; $de13: 10 ee     
            rts                ; $de15: 60        

;-------------------------------------------------------------------------------
            and ($28,x)        ; $de16: 21 28     
            bmi __de52         ; $de18: 30 38     
            .hex 3f bd d8      ; $de1a: 3f bd d8  Invalid Opcode - RLA __d8bd,x
            .hex 03 d0         ; $de1d: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 07 a9         ; $de1f: 07 a9     Invalid Opcode - SLO $a9
            ora ($a0,x)        ; $de21: 01 a0     
            .hex 44 4c         ; $de23: 44 4c     Invalid Opcode - NOP $4c
            bne __de05         ; $de25: d0 de     
            inc $04d4,x        ; $de27: fe d4 04  
            lda $04d4,x        ; $de2a: bd d4 04  
            cmp #$40           ; $de2d: c9 40     
            bne __de41         ; $de2f: d0 10     
            lda #$00           ; $de31: a9 00     
            sta $04d4,x        ; $de33: 9d d4 04  
            lda $03c6,x        ; $de36: bd c6 03  
            bne __de5a         ; $de39: d0 1f     
            lda #$44           ; $de3b: a9 44     
            sta $0300,x        ; $de3d: 9d 00 03  
            rts                ; $de40: 60        

;-------------------------------------------------------------------------------
__de41:     cmp #$30           ; $de41: c9 30     
            bne __de5a         ; $de43: d0 15     
            jsr __e010         ; $de45: 20 10 e0  
__de48:     lda #$45           ; $de48: a9 45     
            sta $0300,x        ; $de4a: 9d 00 03  
            jsr __8c8a         ; $de4d: 20 8a 8c  
            lda #$46           ; $de50: a9 46     
__de52:     jsr __8e26         ; $de52: 20 26 8e  
            lda #$08           ; $de55: a9 08     
            jmp __c118         ; $de57: 4c 18 c1  

;-------------------------------------------------------------------------------
__de5a:     lda $1d            ; $de5a: a5 1d     
            and #$0f           ; $de5c: 29 0f     
            beq __de7b         ; $de5e: f0 1b     
            .hex fe 44         ; $de60: fe 44     Suspected data
__de62:     .hex 04 bd         ; $de62: 04 bd     Invalid Opcode - NOP $bd
            .hex 44 04         ; $de64: 44 04     Invalid Opcode - NOP $04
            cmp #$30           ; $de66: c9 30     
            bne __de92         ; $de68: d0 28     
            lda #$00           ; $de6a: a9 00     
            sta $0444,x        ; $de6c: 9d 44 04  
__de6f:     ldy #$02           ; $de6f: a0 02     
            lda $2e            ; $de71: a5 2e     
            and #$3f           ; $de73: 29 3f     
            jsr __8d19         ; $de75: 20 19 8d  
            jmp __9e92         ; $de78: 4c 92 9e  

;-------------------------------------------------------------------------------
__de7b:     jsr __8d12         ; $de7b: 20 12 8d  
            bcc __de86         ; $de7e: 90 06     
            lda #$ff           ; $de80: a9 ff     
            ldy #$c0           ; $de82: a0 c0     
            bne __de8a         ; $de84: d0 04     
__de86:     lda #$00           ; $de86: a9 00     
            ldy #$40           ; $de88: a0 40     
__de8a:     .hex 20            ; $de8a: 20        Suspected data
__de8b:     ror $e0,x          ; $de8b: 76 e0     
            lda #$40           ; $de8d: a9 40     
            jsr __de6f         ; $de8f: 20 6f de  
__de92:     jsr __e0f4         ; $de92: 20 f4 e0  
            ldy #$03           ; $de95: a0 03     
            sty $0196          ; $de97: 8c 96 01  
__de9a:     ldy $0196          ; $de9a: ac 96 01  
            lda __9ed2,y       ; $de9d: b9 d2 9e  
            pha                ; $dea0: 48        
__dea1:     lda __9ed5,y       ; $dea1: b9 d5 9e  
            tay                ; $dea4: a8        
            pla                ; $dea5: 68        
            jsr __e2a2         ; $dea6: 20 a2 e2  
            bcs __deae         ; $dea9: b0 03     
            jsr __e03b         ; $deab: 20 3b e0  
__deae:     dec $0196          ; $deae: ce 96 01  
            bpl __de9a         ; $deb1: 10 e7     
            ldy #$03           ; $deb3: a0 03     
__deb5:     .hex 8c 96         ; $deb5: 8c 96     Suspected data
__deb7:     ora ($ac,x)        ; $deb7: 01 ac     
            stx $01,y          ; $deb9: 96 01     
            lda __9ed9,y       ; $debb: b9 d9 9e  
            pha                ; $debe: 48        
__debf:     lda __9ed5,y       ; $debf: b9 d5 9e  
__dec2:     tay                ; $dec2: a8        
            pla                ; $dec3: 68        
__dec4:     .hex 20 a2         ; $dec4: 20 a2     Suspected data
__dec6:     .hex e2 b0         ; $dec6: e2 b0     Invalid Opcode - NOP #$b0
            .hex 03 20         ; $dec8: 03 20     Invalid Opcode - SLO ($20,x)
__deca:     .hex 27 e0         ; $deca: 27 e0     Invalid Opcode - RLA $e0
__decc:     dec $0196          ; $decc: ce 96 01  
            .hex 10            ; $decf: 10        Suspected data
__ded0:     .hex e7 60         ; $ded0: e7 60     Invalid Opcode - ISC $60
            beq __dec4         ; $ded2: f0 f0     
            bpl __dee6         ; $ded4: 10 10     
            beq __dee8         ; $ded6: f0 10     
__ded8:     beq __dec6         ; $ded8: f0 ec     
            cpx $1414          ; $deda: ec 14 14  
            .hex bd            ; $dedd: bd        Suspected data
__dede:     cld                ; $dede: d8        
            .hex 03 d0         ; $dedf: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 12            ; $dee1: 12        Invalid Opcode - KIL 
            lda #$02           ; $dee2: a9 02     
            .hex 9d d8         ; $dee4: 9d d8     Suspected data
__dee6:     .hex 03 a9         ; $dee6: 03 a9     Invalid Opcode - SLO ($a9,x)
__dee8:     ora $9d            ; $dee8: 05 9d     
            .hex c2 04         ; $deea: c2 04     Invalid Opcode - NOP #$04
            lda #$3c           ; $deec: a9 3c     
            jsr __dd8b         ; $deee: 20 8b dd  
            jmp __dd2a         ; $def1: 4c 2a dd  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $def4: 20 2a dd  
            jmp __e0f4         ; $def7: 4c f4 e0  

;-------------------------------------------------------------------------------
            inc $579e,x        ; $defa: fe 9e 57  
            .hex 9f 04 0c      ; $defd: 9f 04 0c  Invalid Opcode - AHX $0c04,y
            .hex 03 0f         ; $df00: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $df02: 08        
            plp                ; $df03: 28        
            ora $0f            ; $df04: 05 0f     
            ora #$0c           ; $df06: 09 0c     
            rol $0a00,x        ; $df08: 3e 00 0a  
            .hex 0c 3e 00      ; $df0b: 0c 3e 00  Bad Addr Mode - NOP $003e
            .hex 0b 0c         ; $df0e: 0b 0c     Invalid Opcode - ANC #$0c
            rol $0c00,x        ; $df10: 3e 00 0c  
            .hex 0c 3e 00      ; $df13: 0c 3e 00  Bad Addr Mode - NOP $003e
            ora $3e0c          ; $df16: 0d 0c 3e  
            brk                ; $df19: 00        
            asl $3e0c          ; $df1a: 0e 0c 3e  
            brk                ; $df1d: 00        
            .hex 0f 0c 3e      ; $df1e: 0f 0c 3e  Invalid Opcode - SLO $3e0c
            brk                ; $df21: 00        
            .hex 14 12         ; $df22: 14 12     Invalid Opcode - NOP $12,x
            .hex 1f 08 14      ; $df24: 1f 08 14  Invalid Opcode - SLO $1408,x
            plp                ; $df27: 28        
            .hex 03 0f         ; $df28: 03 0f     Invalid Opcode - SLO ($0f,x)
            clc                ; $df2a: 18        
            .hex 0c 03 0f      ; $df2b: 0c 03 0f  Invalid Opcode - NOP $0f03
            clc                ; $df2e: 18        
            .hex 1a            ; $df2f: 1a        Invalid Opcode - NOP 
            .hex 03 0f         ; $df30: 03 0f     Invalid Opcode - SLO ($0f,x)
            clc                ; $df32: 18        
            jsr $0f03          ; $df33: 20 03 0f  
            .hex 1c 12 1f      ; $df36: 1c 12 1f  Invalid Opcode - NOP $1f12,x
            php                ; $df39: 08        
            bit $08            ; $df3a: 24 08     
            .hex 03 0f         ; $df3c: 03 0f     Invalid Opcode - SLO ($0f,x)
            bit $28            ; $df3e: 24 28     
            .hex 03 0f         ; $df40: 03 0f     Invalid Opcode - SLO ($0f,x)
__df42:     plp                ; $df42: 28        
            asl $03            ; $df43: 06 03     
            .hex 0f 28 20      ; $df45: 0f 28 20  Invalid Opcode - SLO $2028
            .hex 03 0f         ; $df48: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 34 0c         ; $df4a: 34 0c     Invalid Opcode - NOP $0c,x
            .hex 03 0f         ; $df4c: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 34 20         ; $df4e: 34 20     Invalid Opcode - NOP $20,x
            .hex 03 0f         ; $df50: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 3c 06 03      ; $df52: 3c 06 03  Invalid Opcode - NOP $0306,x
            .hex 0f ff 04      ; $df55: 0f ff 04  Invalid Opcode - SLO $04ff
            .hex 0c 03 0f      ; $df58: 0c 03 0f  Invalid Opcode - NOP $0f03
            .hex 04 14         ; $df5b: 04 14     Invalid Opcode - NOP $14
            .hex 03 0f         ; $df5d: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 04 2e         ; $df5f: 04 2e     Invalid Opcode - NOP $2e
            .hex 03 0f         ; $df61: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $df63: 08        
            asl $03            ; $df64: 06 03     
            .hex 0f 08 14      ; $df66: 0f 08 14  Invalid Opcode - SLO $1408
            .hex 03 0f         ; $df69: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $df6b: 08        
            .hex 1a            ; $df6c: 1a        Invalid Opcode - NOP 
            .hex 03 0f         ; $df6d: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $df6f: 08        
            jsr $0f03          ; $df70: 20 03 0f  
            php                ; $df73: 08        
            bit $0f03          ; $df74: 2c 03 0f  
            .hex 0c 0c 03      ; $df77: 0c 0c 03  Invalid Opcode - NOP $030c
            .hex 0f 0c 36      ; $df7a: 0f 0c 36  Invalid Opcode - SLO $360c
            .hex 03 0f         ; $df7d: 03 0f     Invalid Opcode - SLO ($0f,x)
__df7f:     .hex 14 36         ; $df7f: 14 36     Invalid Opcode - NOP $36,x
            .hex 03            ; $df81: 03        Suspected data
__df82:     .hex 0f 18 30      ; $df82: 0f 18 30  Invalid Opcode - SLO $3018
            .hex 03 0f         ; $df85: 03 0f     Invalid Opcode - SLO ($0f,x)
            clc                ; $df87: 18        
            rol                ; $df88: 2a        
            .hex ae            ; $df89: ae        Suspected data
__df8a:     asl $1c            ; $df8a: 06 1c     
            .hex 1a            ; $df8c: 1a        Invalid Opcode - NOP 
            .hex 03 0f         ; $df8d: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 1c 36 03      ; $df8f: 1c 36 03  Invalid Opcode - NOP $0336,x
            .hex 0f 28 1a      ; $df92: 0f 28 1a  Invalid Opcode - SLO $1a28
            .hex 03 0f         ; $df95: 03 0f     Invalid Opcode - SLO ($0f,x)
            bit $2716          ; $df97: 2c 16 27  
            and $2d            ; $df9a: 25 2d     
            and ($25),y        ; $df9c: 31 25     
            .hex 1b 34 28      ; $df9e: 1b 34 28  Invalid Opcode - SLO $2834,y
            .hex 0d 06         ; $dfa1: 0d 06     Suspected data
__dfa3:     sec                ; $dfa3: 38        
            .hex 14 05         ; $dfa4: 14 05     Invalid Opcode - NOP $05,x
            .hex 0f 38         ; $dfa6: 0f 38     Suspected data
__dfa8:     .hex 1a            ; $dfa8: 1a        Invalid Opcode - NOP 
            ora $0f            ; $dfa9: 05 0f     
            .hex 3c 20         ; $dfab: 3c 20     Suspected data
__dfad:     ora $0f            ; $dfad: 05 0f     
            .hex ff c4 9f      ; $dfaf: ff c4 9f  Invalid Opcode - ISC __9fc4,x
            .hex cc            ; $dfb2: cc        Suspected data
__dfb3:     .hex 9f 48 a6      ; $dfb3: 9f 48 a6  Invalid Opcode - AHX __a648,y
            lsr                ; $dfb6: 4a        
            ldx $52            ; $dfb7: a6 52     
            ldx $56            ; $dfb9: a6 56     
            ldx $ce            ; $dfbb: a6 ce     
            .hex 9f d0 9f      ; $dfbd: 9f d0 9f  Invalid Opcode - AHX __9fd0,y
            .hex dc 9f d6      ; $dfc0: dc 9f d6  Invalid Opcode - NOP __d69f,x
            .hex 9f e4 9f      ; $dfc3: 9f e4 9f  Invalid Opcode - AHX __9fe4,y
            ora #$a0           ; $dfc6: 09 a0     
            .hex 32            ; $dfc8: 32        Invalid Opcode - KIL 
            ldy #$4f           ; $dfc9: a0 4f     
            ldy #$68           ; $dfcb: a0 68     
            ldy #$79           ; $dfcd: a0 79     
            ldy #$79           ; $dfcf: a0 79     
            ldy #$8e           ; $dfd1: a0 8e     
            ldy #$a3           ; $dfd3: a0 a3     
            ldy #$53           ; $dfd5: a0 53     
            lda ($33,x)        ; $dfd7: a1 33     
            lda ($54,x)        ; $dfd9: a1 54     
            lda ($d0,x)        ; $dfdb: a1 d0     
            ldy #$01           ; $dfdd: a0 01     
            lda ($1a,x)        ; $dfdf: a1 1a     
            lda ($32,x)        ; $dfe1: a1 32     
            .hex a1            ; $dfe3: a1        Suspected data
__dfe4:     php                ; $dfe4: 08        
            .hex 0c 13 02      ; $dfe5: 0c 13 02  Invalid Opcode - NOP $0213
__dfe8:     .hex 0c 0c 03      ; $dfe8: 0c 0c 03  Invalid Opcode - NOP $030c
            ora ($14,x)        ; $dfeb: 01 14     
            .hex 0c 13 02      ; $dfed: 0c 13 02  Invalid Opcode - NOP $0213
            clc                ; $dff0: 18        
            asl                ; $dff1: 0a        
            .hex 03 01         ; $dff2: 03 01     Invalid Opcode - SLO ($01,x)
            .hex 1c 08 13      ; $dff4: 1c 08 13  Invalid Opcode - NOP $1308,x
            .hex 02            ; $dff7: 02        Invalid Opcode - KIL 
            plp                ; $dff8: 28        
            asl                ; $dff9: 0a        
__dffa:     .hex 03 01         ; $dffa: 03 01     Invalid Opcode - SLO ($01,x)
            bit $030c          ; $dffc: 2c 0c 03  
            ora ($34,x)        ; $dfff: 01 34     
            asl                ; $e001: 0a        
__e002:     .hex 03 01         ; $e002: 03 01     Invalid Opcode - SLO ($01,x)
__e004:     .hex 3c 0b 03      ; $e004: 3c 0b 03  Invalid Opcode - NOP $030b,x
            ora ($ff,x)        ; $e007: 01 ff     
            .hex 04            ; $e009: 04        Suspected data
__e00a:     asl                ; $e00a: 0a        
            .hex 03 01         ; $e00b: 03 01     Invalid Opcode - SLO ($01,x)
            .hex 0c 09 03      ; $e00d: 0c 09 03  Invalid Opcode - NOP $0309
__e010:     ora ($0e,x)        ; $e010: 01 0e     
            .hex 0c 04 01      ; $e012: 0c 04 01  Invalid Opcode - NOP $0104
            ora $0c,x          ; $e015: 15 0c     
            .hex 04 01         ; $e017: 04 01     Invalid Opcode - NOP $01
            .hex 1a            ; $e019: 1a        Invalid Opcode - NOP 
            .hex 0c 04 01      ; $e01a: 0c 04 01  Invalid Opcode - NOP $0104
            and $0c            ; $e01d: 25 0c     
__e01f:     .hex 04 01         ; $e01f: 04 01     Invalid Opcode - NOP $01
            rol                ; $e021: 2a        
            .hex 0c 04 01      ; $e022: 0c 04 01  Invalid Opcode - NOP $0104
            .hex 34 09         ; $e025: 34 09     Invalid Opcode - NOP $09,x
__e027:     .hex 03 01         ; $e027: 03 01     Invalid Opcode - SLO ($01,x)
            and $0c,x          ; $e029: 35 0c     
            .hex 04 01         ; $e02b: 04 01     Invalid Opcode - NOP $01
            sec                ; $e02d: 38        
            asl                ; $e02e: 0a        
            .hex 03 01         ; $e02f: 03 01     Invalid Opcode - SLO ($01,x)
            .hex ff 08 06      ; $e031: ff 08 06  Invalid Opcode - ISC $0608,x
            .hex 03 01         ; $e034: 03 01     Invalid Opcode - SLO ($01,x)
            php                ; $e036: 08        
            .hex 0c 03 01      ; $e037: 0c 03 01  Invalid Opcode - NOP $0103
            .hex 0c            ; $e03a: 0c        Suspected data
__e03b:     .hex 0d 43 00      ; $e03b: 0d 43 00  Bad Addr Mode - ORA $0043
            .hex 14 06         ; $e03e: 14 06     Invalid Opcode - NOP $06,x
            .hex 03 01         ; $e040: 03 01     Invalid Opcode - SLO ($01,x)
            clc                ; $e042: 18        
            .hex 0c 03 01      ; $e043: 0c 03 01  Invalid Opcode - NOP $0103
            ora $0306,y        ; $e046: 19 06 03  
            ora ($1d,x)        ; $e049: 01 1d     
            php                ; $e04b: 08        
            .hex 03 01         ; $e04c: 03 01     Invalid Opcode - SLO ($01,x)
            .hex ff            ; $e04e: ff        Suspected data
__e04f:     .hex 04 0a         ; $e04f: 04 0a     Invalid Opcode - NOP $0a
__e051:     .hex 03 01         ; $e051: 03 01     Invalid Opcode - SLO ($01,x)
            php                ; $e053: 08        
            .hex 0b 03         ; $e054: 0b 03     Invalid Opcode - ANC #$03
            ora ($0c,x)        ; $e056: 01 0c     
            .hex 0c 03 01      ; $e058: 0c 03 01  Invalid Opcode - NOP $0103
__e05b:     .hex 14 0d         ; $e05b: 14 0d     Invalid Opcode - NOP $0d,x
            .hex 43 00         ; $e05d: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 14 0a         ; $e05f: 14 0a     Invalid Opcode - NOP $0a,x
            .hex 03 01         ; $e061: 03 01     Invalid Opcode - SLO ($01,x)
            clc                ; $e063: 18        
            asl                ; $e064: 0a        
            .hex 03            ; $e065: 03        Suspected data
__e066:     ora ($ff,x)        ; $e066: 01 ff     
            .hex 04 0a         ; $e068: 04 0a     Invalid Opcode - NOP $0a
            .hex 03 01         ; $e06a: 03 01     Invalid Opcode - SLO ($01,x)
            asl                ; $e06c: 0a        
            .hex 0c 04 01      ; $e06d: 0c 04 01  Invalid Opcode - NOP $0104
            .hex 14 0a         ; $e070: 14 0a     Invalid Opcode - NOP $0a,x
            .hex 03 01         ; $e072: 03 01     Invalid Opcode - SLO ($01,x)
            clc                ; $e074: 18        
            asl                ; $e075: 0a        
__e076:     .hex 03 01         ; $e076: 03 01     Invalid Opcode - SLO ($01,x)
            .hex ff 04 0b      ; $e078: ff 04 0b  Invalid Opcode - ISC $0b04,x
            asl $04            ; $e07b: 06 04     
            php                ; $e07d: 08        
            .hex 0b 06         ; $e07e: 0b 06     Invalid Opcode - ANC #$06
            .hex 04 12         ; $e080: 04 12     Invalid Opcode - NOP $12
            .hex 0c bc 01      ; $e082: 0c bc 01  Invalid Opcode - NOP $01bc
            clc                ; $e085: 18        
            .hex 0c 04 04      ; $e086: 0c 04 04  Invalid Opcode - NOP $0404
            .hex 1c 0c 04      ; $e089: 1c 0c 04  Invalid Opcode - NOP $040c,x
__e08c:     .hex 04 ff         ; $e08c: 04 ff     Invalid Opcode - NOP $ff
            .hex 04 0c         ; $e08e: 04 0c     Invalid Opcode - NOP $0c
            .hex 04 04         ; $e090: 04 04     Invalid Opcode - NOP $04
            php                ; $e092: 08        
            .hex 0c 04 04      ; $e093: 0c 04 04  Invalid Opcode - NOP $0404
            asl __bc0c         ; $e096: 0e 0c bc  
            brk                ; $e099: 00        
            clc                ; $e09a: 18        
            .hex 0b 06         ; $e09b: 0b 06     Invalid Opcode - ANC #$06
            .hex 04 1a         ; $e09d: 04 1a     Invalid Opcode - NOP $1a
            .hex 0b 06         ; $e09f: 0b 06     Invalid Opcode - ANC #$06
            .hex 04            ; $e0a1: 04        Suspected data
__e0a2:     .hex ff 06 0d      ; $e0a2: ff 06 0d  Invalid Opcode - ISC $0d06,x
            .hex 02            ; $e0a5: 02        Invalid Opcode - KIL 
            .hex 04 08         ; $e0a6: 04 08     Invalid Opcode - NOP $08
            .hex 0d 43 00      ; $e0a8: 0d 43 00  Bad Addr Mode - ORA $0043
            asl                ; $e0ab: 0a        
            .hex 0c 15 04      ; $e0ac: 0c 15 04  Invalid Opcode - NOP $0415
            .hex 0c 0c 15      ; $e0af: 0c 0c 15  Invalid Opcode - NOP $150c
            .hex 04 14         ; $e0b2: 04 14     Invalid Opcode - NOP $14
            .hex 0d 43 00      ; $e0b4: 0d 43 00  Bad Addr Mode - ORA $0043
            asl $0c,x          ; $e0b7: 16 0c     
            ora $04,x          ; $e0b9: 15 04     
            ora $1208,x        ; $e0bb: 1d 08 12  
            .hex 04 28         ; $e0be: 04 28     Invalid Opcode - NOP $28
            asl                ; $e0c0: 0a        
            .hex 12            ; $e0c1: 12        Invalid Opcode - KIL 
            .hex 04 2c         ; $e0c2: 04 2c     Invalid Opcode - NOP $2c
            .hex 0c 06 04      ; $e0c4: 0c 06 04  Invalid Opcode - NOP $0406
            .hex 34 0c         ; $e0c7: 34 0c     Invalid Opcode - NOP $0c,x
            asl $04            ; $e0c9: 06 04     
            sec                ; $e0cb: 38        
            .hex 0c 06 04      ; $e0cc: 0c 06 04  Invalid Opcode - NOP $0406
            .hex ff 08 09      ; $e0cf: ff 08 09  Invalid Opcode - ISC $0908,x
            .hex 03 0f         ; $e0d2: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 0c 09 03      ; $e0d4: 0c 09 03  Invalid Opcode - NOP $0309
            .hex 0f 0e 0c      ; $e0d7: 0f 0e 0c  Invalid Opcode - SLO $0c0e
            .hex 04 0f         ; $e0da: 04 0f     Invalid Opcode - NOP $0f
            ora $0c,x          ; $e0dc: 15 0c     
            .hex 04 0f         ; $e0de: 04 0f     Invalid Opcode - NOP $0f
            clc                ; $e0e0: 18        
            .hex 0b 22         ; $e0e1: 0b 22     Invalid Opcode - ANC #$22
            eor ($1a,x)        ; $e0e3: 41 1a     
            .hex 0c 04 0f      ; $e0e5: 0c 04 0f  Invalid Opcode - NOP $0f04
            and $0c            ; $e0e8: 25 0c     
            .hex 04 0f         ; $e0ea: 04 0f     Invalid Opcode - NOP $0f
            plp                ; $e0ec: 28        
            .hex 0b 22         ; $e0ed: 0b 22     Invalid Opcode - ANC #$22
            eor ($2a,x)        ; $e0ef: 41 2a     
            .hex 0c 04 0f      ; $e0f1: 0c 04 0f  Invalid Opcode - NOP $0f04
__e0f4:     .hex 34 09         ; $e0f4: 34 09     Invalid Opcode - NOP $09,x
            .hex 03 0f         ; $e0f6: 03 0f     Invalid Opcode - SLO ($0f,x)
            and $0c,x          ; $e0f8: 35 0c     
            .hex 04 0f         ; $e0fa: 04 0f     Invalid Opcode - NOP $0f
            sec                ; $e0fc: 38        
            asl                ; $e0fd: 0a        
            .hex 03 0f         ; $e0fe: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex ff 04 0a      ; $e100: ff 04 0a  Invalid Opcode - ISC $0a04,x
            asl $0f            ; $e103: 06 0f     
            php                ; $e105: 08        
            asl                ; $e106: 0a        
            asl $0f            ; $e107: 06 0f     
            .hex 0c 0b 06      ; $e109: 0c 0b 06  Invalid Opcode - NOP $060b
            .hex 0f 14 0d      ; $e10c: 0f 14 0d  Invalid Opcode - SLO $0d14
            .hex 43 00         ; $e10f: 43 00     Invalid Opcode - SRE ($00,x)
            clc                ; $e111: 18        
            .hex 0c 06 0f      ; $e112: 0c 06 0f  Invalid Opcode - NOP $0f06
            .hex 1c 08 06      ; $e115: 1c 08 06  Invalid Opcode - NOP $0608,x
            .hex 0f ff 04      ; $e118: 0f ff 04  Invalid Opcode - SLO $04ff
            asl                ; $e11b: 0a        
            .hex 03 0f         ; $e11c: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $e11e: 08        
            .hex 0b 03         ; $e11f: 0b 03     Invalid Opcode - ANC #$03
            .hex 0f 0c 0c      ; $e121: 0f 0c 0c  Invalid Opcode - SLO $0c0c
            .hex 03 0f         ; $e124: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 14 0a         ; $e126: 14 0a     Invalid Opcode - NOP $0a,x
            .hex 03 0f         ; $e128: 03 0f     Invalid Opcode - SLO ($0f,x)
            asl $0d,x          ; $e12a: 16 0d     
            .hex 43 00         ; $e12c: 43 00     Invalid Opcode - SRE ($00,x)
            clc                ; $e12e: 18        
            asl                ; $e12f: 0a        
            .hex 03 0f         ; $e130: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex ff 0c 0c      ; $e132: ff 0c 0c  Invalid Opcode - ISC $0c0c,x
            .hex 04 0f         ; $e135: 04 0f     Invalid Opcode - NOP $0f
            .hex 14 0c         ; $e137: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 04 0f         ; $e139: 04 0f     Invalid Opcode - NOP $0f
            clc                ; $e13b: 18        
            .hex 0c 04 0f      ; $e13c: 0c 04 0f  Invalid Opcode - NOP $0f04
            .hex 1c 0c 04      ; $e13f: 1c 0c 04  Invalid Opcode - NOP $040c,x
            .hex 0f 24 0c      ; $e142: 0f 24 0c  Invalid Opcode - SLO $0c24
            .hex 04 0f         ; $e145: 04 0f     Invalid Opcode - NOP $0f
            plp                ; $e147: 28        
            .hex 0c 04 0f      ; $e148: 0c 04 0f  Invalid Opcode - NOP $0f04
            bit $040c          ; $e14b: 2c 0c 04  
            .hex 0f 34 0c      ; $e14e: 0f 34 0c  Invalid Opcode - SLO $0c34
            .hex 04 0f         ; $e151: 04 0f     Invalid Opcode - NOP $0f
            .hex ff 04 0c      ; $e153: ff 04 0c  Invalid Opcode - ISC $0c04,x
            .hex 03 0f         ; $e156: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $e158: 08        
            asl $03            ; $e159: 06 03     
            .hex 0f 08 0d      ; $e15b: 0f 08 0d  Invalid Opcode - SLO $0d08
            .hex 43 00         ; $e15e: 43 00     Invalid Opcode - SRE ($00,x)
            asl                ; $e160: 0a        
            .hex 0c 15 0f      ; $e161: 0c 15 0f  Invalid Opcode - NOP $0f15
            .hex 12            ; $e164: 12        Invalid Opcode - KIL 
            asl $03            ; $e165: 06 03     
            .hex 0f 18 0d      ; $e167: 0f 18 0d  Invalid Opcode - SLO $0d18
            .hex 43 00         ; $e16a: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 1a            ; $e16c: 1a        Invalid Opcode - NOP 
            .hex 0c 15 0f      ; $e16d: 0c 15 0f  Invalid Opcode - NOP $0f15
__e170:     .hex 23 06         ; $e170: 23 06     Invalid Opcode - RLA ($06,x)
            .hex 03 0f         ; $e172: 03 0f     Invalid Opcode - SLO ($0f,x)
            plp                ; $e174: 28        
            .hex 0d 43 00      ; $e175: 0d 43 00  Bad Addr Mode - ORA $0043
            rol                ; $e178: 2a        
__e179:     .hex 0c 15 0f      ; $e179: 0c 15 0f  Invalid Opcode - NOP $0f15
            rol $0d,x          ; $e17c: 36 0d     
            .hex 43 00         ; $e17e: 43 00     Invalid Opcode - SRE ($00,x)
            sec                ; $e180: 38        
            .hex 0c 15 0f      ; $e181: 0c 15 0f  Invalid Opcode - NOP $0f15
            .hex ff bd d8      ; $e184: ff bd d8  Invalid Opcode - ISC __d8bd,x
            .hex 03 d0         ; $e187: 03 d0     Invalid Opcode - SLO ($d0,x)
            .hex 12            ; $e189: 12        Invalid Opcode - KIL 
            jsr __deca         ; $e18a: 20 ca de  
            .hex 20            ; $e18d: 20        Suspected data
__e18e:     bpl __e170         ; $e18e: 10 e0     
            lda #$02           ; $e190: a9 02     
            ldy #$00           ; $e192: a0 00     
            jsr __e04f         ; $e194: 20 4f e0  
            lda #$1d           ; $e197: a9 1d     
            jmp __ded8         ; $e199: 4c d8 de  

;-------------------------------------------------------------------------------
            lda $0444,x        ; $e19c: bd 44 04  
            bne __e1d6         ; $e19f: d0 35     
            lda $0420,x        ; $e1a1: bd 20 04  
            bne __e1aa         ; $e1a4: d0 04     
            lda #$f0           ; $e1a6: a9 f0     
            bne __e1ac         ; $e1a8: d0 02     
__e1aa:     lda #$10           ; $e1aa: a9 10     
__e1ac:     ldy #$00           ; $e1ac: a0 00     
            jsr __e2a2         ; $e1ae: 20 a2 e2  
            .hex b0            ; $e1b1: b0        Suspected data
__e1b2:     .hex 03 20         ; $e1b2: 03 20     Invalid Opcode - SLO ($20,x)
            .hex 1f e0 bd      ; $e1b4: 1f e0 bd  Invalid Opcode - SLO __bde0,x
            jsr __d004         ; $e1b7: 20 04 d0  
            .hex 04 a9         ; $e1ba: 04 a9     Invalid Opcode - NOP $a9
            beq __e18e         ; $e1bc: f0 d0     
            .hex 02            ; $e1be: 02        Invalid Opcode - KIL 
__e1bf:     lda #$10           ; $e1bf: a9 10     
__e1c1:     ldy #$10           ; $e1c1: a0 10     
            jsr __e2af         ; $e1c3: 20 af e2  
            bcs __e1cb         ; $e1c6: b0 03     
            jmp __a642         ; $e1c8: 4c 42 a6  

;-------------------------------------------------------------------------------
__e1cb:     lda #$01           ; $e1cb: a9 01     
            sta $0444,x        ; $e1cd: 9d 44 04  
            lda #$fe           ; $e1d0: a9 fe     
            sta $036c,x        ; $e1d2: 9d 6c 03  
            rts                ; $e1d5: 60        

;-------------------------------------------------------------------------------
__e1d6:     lda #$20           ; $e1d6: a9 20     
            sta $08            ; $e1d8: 85 08     
            jsr __dfe4         ; $e1da: 20 e4 df  
            lda $0420,x        ; $e1dd: bd 20 04  
            bne __e1e6         ; $e1e0: d0 04     
            lda #$f0           ; $e1e2: a9 f0     
            bne __e1e8         ; $e1e4: d0 02     
__e1e6:     lda #$10           ; $e1e6: a9 10     
__e1e8:     ldy #$00           ; $e1e8: a0 00     
            jsr __e2a2         ; $e1ea: 20 a2 e2  
            bcs __e1f2         ; $e1ed: b0 03     
            jsr __e01f         ; $e1ef: 20 1f e0  
__e1f2:     lda $0420,x        ; $e1f2: bd 20 04  
            bne __e1fb         ; $e1f5: d0 04     
            .hex a9            ; $e1f7: a9        Suspected data
__e1f8:     cpx $02d0          ; $e1f8: ec d0 02  
__e1fb:     lda #$14           ; $e1fb: a9 14     
            ldy #$10           ; $e1fd: a0 10     
            .hex 20            ; $e1ff: 20        Suspected data
__e200:     ldx #$e2           ; $e200: a2 e2     
            bcs __e20d         ; $e202: b0 09     
            jsr __de62         ; $e204: 20 62 de  
            jsr __df8a         ; $e207: 20 8a df  
            jmp __dfad         ; $e20a: 4c ad df  

;-------------------------------------------------------------------------------
__e20d:     jmp __e0f4         ; $e20d: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e210: bd d8 03  
            bne __e21d         ; $e213: d0 08     
            jsr __deca         ; $e215: 20 ca de  
            lda #$1e           ; $e218: a9 1e     
            jmp __ded8         ; $e21a: 4c d8 de  

;-------------------------------------------------------------------------------
__e21d:     jsr __dd2a         ; $e21d: 20 2a dd  
            lda $0444,x        ; $e220: bd 44 04  
            jsr __c5bb         ; $e223: 20 bb c5  
            bit $34a2          ; $e226: 2c a2 34  
            ldx #$5c           ; $e229: a2 5c     
            ldx #$fe           ; $e22b: a2 fe     
            .hex 44 04         ; $e22d: 44 04     Invalid Opcode - NOP $04
            lda #$60           ; $e22f: a9 60     
            jmp __de6f         ; $e231: 4c 6f de  

;-------------------------------------------------------------------------------
            lda $0348,x        ; $e234: bd 48 03  
            sec                ; $e237: 38        
            sbc $0348          ; $e238: ed 48 03  
            bcs __e240         ; $e23b: b0 03     
            jsr __deb7         ; $e23d: 20 b7 de  
__e240:     cmp #$20           ; $e240: c9 20     
            bcc __e24d         ; $e242: 90 09     
            jsr __e0f4         ; $e244: 20 f4 e0  
            jsr __de8b         ; $e247: 20 8b de  
            jmp __dea1         ; $e24a: 4c a1 de  

;-------------------------------------------------------------------------------
__e24d:     inc $0444,x        ; $e24d: fe 44 04  
            lda #$fd           ; $e250: a9 fd     
            ldy #$00           ; $e252: a0 00     
            jsr __e076         ; $e254: 20 76 e0  
            lda #$80           ; $e257: a9 80     
            jmp __de6f         ; $e259: 4c 6f de  

;-------------------------------------------------------------------------------
            lda #$20           ; $e25c: a9 20     
            sta $08            ; $e25e: 85 08     
            jsr __dfe4         ; $e260: 20 e4 df  
            jsr __e0f4         ; $e263: 20 f4 e0  
            jsr __de8b         ; $e266: 20 8b de  
            lda #$00           ; $e269: a9 00     
            ldy #$10           ; $e26b: a0 10     
            jsr __e2a2         ; $e26d: 20 a2 e2  
            bcs __e27d         ; $e270: b0 0b     
            lda #$00           ; $e272: a9 00     
            sta $0444,x        ; $e274: 9d 44 04  
            jsr __df8a         ; $e277: 20 8a df  
            jmp __de62         ; $e27a: 4c 62 de  

;-------------------------------------------------------------------------------
__e27d:     rts                ; $e27d: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e27e: bd d8 03  
            bne __e286         ; $e281: d0 03     
            jmp __deca         ; $e283: 4c ca de  

;-------------------------------------------------------------------------------
__e286:     lda $0444,x        ; $e286: bd 44 04  
            jsr __c5bb         ; $e289: 20 bb c5  
            stx $a2,y          ; $e28c: 96 a2     
            cpy __e0a2         ; $e28e: cc a2 e0  
            ldx #$02           ; $e291: a2 02     
            .hex a3 4a         ; $e293: a3 4a     Invalid Opcode - LAX ($4a,x)
            .hex a3 fe         ; $e295: a3 fe     Invalid Opcode - LAX ($fe,x)
            lsr $04,x          ; $e297: 56 04     
            lda $0456,x        ; $e299: bd 56 04  
            cmp #$40           ; $e29c: c9 40     
            beq __e2a8         ; $e29e: f0 08     
            .hex bd d8         ; $e2a0: bd d8     Suspected data
__e2a2:     .hex 03 09         ; $e2a2: 03 09     Invalid Opcode - SLO ($09,x)
            .hex 80 4c         ; $e2a4: 80 4c     Invalid Opcode - NOP #$4c
            .hex cc de         ; $e2a6: cc de     Suspected data
__e2a8:     lda $03d8,x        ; $e2a8: bd d8 03  
            and #$7f           ; $e2ab: 29 7f     
            .hex 9d d8         ; $e2ad: 9d d8     Suspected data
__e2af:     .hex 03 bd         ; $e2af: 03 bd     Invalid Opcode - SLO ($bd,x)
            dec $03            ; $e2b1: c6 03     
            bne __e2b8         ; $e2b3: d0 03     
            jsr __e300         ; $e2b5: 20 00 e3  
__e2b8:     inc $0444,x        ; $e2b8: fe 44 04  
            lda #$fc           ; $e2bb: a9 fc     
            ldy #$80           ; $e2bd: a0 80     
            jsr __e076         ; $e2bf: 20 76 e0  
            lda #$00           ; $e2c2: a9 00     
            sta $0456,x        ; $e2c4: 9d 56 04  
            lda #$06           ; $e2c7: a9 06     
            jmp __ded8         ; $e2c9: 4c d8 de  

;-------------------------------------------------------------------------------
            jsr __a642         ; $e2cc: 20 42 a6  
            lda #$10           ; $e2cf: a9 10     
            sta $08            ; $e2d1: 85 08     
            jsr __dfe4         ; $e2d3: 20 e4 df  
            lda $036c,x        ; $e2d6: bd 6c 03  
            bpl __e2dc         ; $e2d9: 10 01     
            rts                ; $e2db: 60        

;-------------------------------------------------------------------------------
__e2dc:     inc $0444,x        ; $e2dc: fe 44 04  
            rts                ; $e2df: 60        

;-------------------------------------------------------------------------------
            jsr __a642         ; $e2e0: 20 42 a6  
            lda #$20           ; $e2e3: a9 20     
            sta $08            ; $e2e5: 85 08     
            jsr __dfe4         ; $e2e7: 20 e4 df  
            lda #$00           ; $e2ea: a9 00     
            ldy #$10           ; $e2ec: a0 10     
            jsr __e2a2         ; $e2ee: 20 a2 e2  
            bcs __e301         ; $e2f1: b0 0e     
            jsr __d3f6         ; $e2f3: 20 f6 d3  
            inc $0444,x        ; $e2f6: fe 44 04  
            jsr __df8a         ; $e2f9: 20 8a df  
            lda #$80           ; $e2fc: a9 80     
            .hex 20 6f         ; $e2fe: 20 6f     Suspected data
__e300:     .hex de            ; $e300: de        Suspected data
__e301:     rts                ; $e301: 60        

;-------------------------------------------------------------------------------
__e302:     .hex 20            ; $e302: 20        Suspected data
__e303:     rol                ; $e303: 2a        
            cmp $56fe,x        ; $e304: dd fe 56  
            .hex 04 bd         ; $e307: 04 bd     Invalid Opcode - NOP $bd
            lsr $04,x          ; $e309: 56 04     
            cmp #$ff           ; $e30b: c9 ff     
            beq __e338         ; $e30d: f0 29     
            lda $04d4,x        ; $e30f: bd d4 04  
            cmp #$60           ; $e312: c9 60     
            bne __e332         ; $e314: d0 1c     
            lda #$00           ; $e316: a9 00     
            sta $04d4,x        ; $e318: 9d d4 04  
__e31b:     lda $03c6,x        ; $e31b: bd c6 03  
            bne __e332         ; $e31e: d0 12     
            lda #$80           ; $e320: a9 80     
            jsr __de6f         ; $e322: 20 6f de  
            lda #$67           ; $e325: a9 67     
            sta $0300,x        ; $e327: 9d 00 03  
            jsr __8c8a         ; $e32a: 20 8a 8c  
            lda #$30           ; $e32d: a9 30     
            jmp __8e26         ; $e32f: 4c 26 8e  

;-------------------------------------------------------------------------------
__e332:     inc $04d4,x        ; $e332: fe d4 04  
            jmp __a639         ; $e335: 4c 39 a6  

;-------------------------------------------------------------------------------
__e338:     inc $0444,x        ; $e338: fe 44 04  
            lda #$00           ; $e33b: a9 00     
            sta $0456,x        ; $e33d: 9d 56 04  
            jsr __df82         ; $e340: 20 82 df  
            lda #$ff           ; $e343: a9 ff     
            ldy #$00           ; $e345: a0 00     
            jmp __e076         ; $e347: 4c 76 e0  

;-------------------------------------------------------------------------------
            jsr __a642         ; $e34a: 20 42 a6  
            lda #$20           ; $e34d: a9 20     
            sta $08            ; $e34f: 85 08     
            jsr __dfe4         ; $e351: 20 e4 df  
            lda $0324,x        ; $e354: bd 24 03  
            cmp #$c8           ; $e357: c9 c8     
            bcs __e35c         ; $e359: b0 01     
            rts                ; $e35b: 60        

;-------------------------------------------------------------------------------
__e35c:     lda $03c6,x        ; $e35c: bd c6 03  
            bne __e364         ; $e35f: d0 03     
            jsr __e300         ; $e361: 20 00 e3  
__e364:     jmp __df42         ; $e364: 4c 42 df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e367: bd d8 03  
            bne __e36f         ; $e36a: d0 03     
            jmp __deca         ; $e36c: 4c ca de  

;-------------------------------------------------------------------------------
__e36f:     lda $0444,x        ; $e36f: bd 44 04  
            .hex 20            ; $e372: 20        Suspected data
__e373:     .hex bb c5 7b      ; $e373: bb c5 7b  Invalid Opcode - LAS $7bc5,y
            .hex a3 a0         ; $e376: a3 a0     Invalid Opcode - LAX ($a0,x)
            .hex a3 be         ; $e378: a3 be     Invalid Opcode - LAX ($be,x)
            .hex a3 a5         ; $e37a: a3 a5     Invalid Opcode - LAX ($a5,x)
            ora $0729,x        ; $e37c: 1d 29 07  
            bne __e39d         ; $e37f: d0 1c     
            ldy $0456,x        ; $e381: bc 56 04  
            lda __a3e4,y       ; $e384: b9 e4 a3  
            sta $0300,x        ; $e387: 9d 00 03  
            inc $0456,x        ; $e38a: fe 56 04  
            lda $0456,x        ; $e38d: bd 56 04  
            cmp #$04           ; $e390: c9 04     
            bne __e39d         ; $e392: d0 09     
            dec $0456,x        ; $e394: de 56 04  
            inc $0444,x        ; $e397: fe 44 04  
            jmp __deca         ; $e39a: 4c ca de  

;-------------------------------------------------------------------------------
__e39d:     jmp __dec2         ; $e39d: 4c c2 de  

;-------------------------------------------------------------------------------
            jsr __e010         ; $e3a0: 20 10 e0  
            lda #$30           ; $e3a3: a9 30     
            sta $05            ; $e3a5: 85 05     
            lda $03c6,x        ; $e3a7: bd c6 03  
            bne __e3ba         ; $e3aa: d0 0e     
            lda $0420,x        ; $e3ac: bd 20 04  
__e3af:     bne __e3b5         ; $e3af: d0 04     
            .hex a9            ; $e3b1: a9        Suspected data
__e3b2:     jsr $02d0          ; $e3b2: 20 d0 02  
__e3b5:     lda #$00           ; $e3b5: a9 00     
            jsr __8e21         ; $e3b7: 20 21 8e  
__e3ba:     inc $0444,x        ; $e3ba: fe 44 04  
            rts                ; $e3bd: 60        

;-------------------------------------------------------------------------------
            lda $0468,x        ; $e3be: bd 68 04  
            cmp #$30           ; $e3c1: c9 30     
            bne __e3e0         ; $e3c3: d0 1b     
            lda $1d            ; $e3c5: a5 1d     
            and #$07           ; $e3c7: 29 07     
            bne __e3df         ; $e3c9: d0 14     
            ldy $0456,x        ; $e3cb: bc 56 04  
            lda __a3e4,y       ; $e3ce: b9 e4 a3  
            sta $0300,x        ; $e3d1: 9d 00 03  
            dec $0456,x        ; $e3d4: de 56 04  
            lda $0456,x        ; $e3d7: bd 56 04  
            bpl __e3df         ; $e3da: 10 03     
            jsr __dfa3         ; $e3dc: 20 a3 df  
__e3df:     rts                ; $e3df: 60        

;-------------------------------------------------------------------------------
__e3e0:     inc $0468,x        ; $e3e0: fe 68 04  
            rts                ; $e3e3: 60        

;-------------------------------------------------------------------------------
            brk                ; $e3e4: 00        
            eor $5b5a,y        ; $e3e5: 59 5a 5b  
            lda $03d8,x        ; $e3e8: bd d8 03  
            bne __e3fa         ; $e3eb: d0 0d     
            jsr __deca         ; $e3ed: 20 ca de  
__e3f0:     .hex a9            ; $e3f0: a9        Suspected data
__e3f1:     .hex f0            ; $e3f1: f0        Suspected data
__e3f2:     .hex 20            ; $e3f2: 20        Suspected data
__e3f3:     .hex 6f de a9      ; $e3f3: 6f de a9  Invalid Opcode - RRA __a9de
            .hex 1a            ; $e3f6: 1a        Invalid Opcode - NOP 
            jmp __ded8         ; $e3f7: 4c d8 de  

;-------------------------------------------------------------------------------
__e3fa:     jsr __dd2a         ; $e3fa: 20 2a dd  
            lda $04d4,x        ; $e3fd: bd d4 04  
            cmp #$40           ; $e400: c9 40     
__e402:     .hex d0            ; $e402: d0        Suspected data
__e403:     and ($a9,x)        ; $e403: 21 a9     
            brk                ; $e405: 00        
            sta $04d4,x        ; $e406: 9d d4 04  
            lda $03c6,x        ; $e409: bd c6 03  
            bne __e425         ; $e40c: d0 17     
            lda #$f0           ; $e40e: a9 f0     
__e410:     jsr __de6f         ; $e410: 20 6f de  
            lda #$30           ; $e413: a9 30     
            sta $05            ; $e415: 85 05     
__e417:     lda $0420,x        ; $e417: bd 20 04  
            bne __e420         ; $e41a: d0 04     
            lda #$20           ; $e41c: a9 20     
            bne __e422         ; $e41e: d0 02     
__e420:     lda #$00           ; $e420: a9 00     
__e422:     jmp __8e21         ; $e422: 4c 21 8e  

;-------------------------------------------------------------------------------
__e425:     inc $04d4,x        ; $e425: fe d4 04  
            jsr __de8b         ; $e428: 20 8b de  
            jsr __dea1         ; $e42b: 20 a1 de  
            jmp __e0f4         ; $e42e: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e431: bd d8 03  
            bne __e450         ; $e434: d0 1a     
            lda #$40           ; $e436: a9 40     
            sta $03d8,x        ; $e438: 9d d8 03  
            lda #$7f           ; $e43b: a9 7f     
            sta $0300,x        ; $e43d: 9d 00 03  
            lda $04d4,x        ; $e440: bd d4 04  
            sta $0420,x        ; $e443: 9d 20 04  
            lda $0324,x        ; $e446: bd 24 03  
            sec                ; $e449: 38        
            sbc #$06           ; $e44a: e9 06     
            sta $0324,x        ; $e44c: 9d 24 03  
            rts                ; $e44f: 60        

;-------------------------------------------------------------------------------
__e450:     .hex bd 44         ; $e450: bd 44     Suspected data
__e452:     .hex 04 20         ; $e452: 04 20     Invalid Opcode - NOP $20
            .hex bb c5 5c      ; $e454: bb c5 5c  Invalid Opcode - LAS $5cc5,y
            ldy $ab            ; $e457: a4 ab     
            ldy $ac            ; $e459: a4 ac     
            ldy $86            ; $e45b: a4 86     
            bpl __e47f         ; $e45d: 10 20     
            .hex b3 df         ; $e45f: b3 df     Invalid Opcode - LAX ($df),y
            ldy $10            ; $e461: a4 10     
            lda #$3d           ; $e463: a9 3d     
            sta $03b4,x        ; $e465: 9d b4 03  
            lda $0324,y        ; $e468: b9 24 03  
            clc                ; $e46b: 18        
            adc #$10           ; $e46c: 69 10     
            sta $0324,x        ; $e46e: 9d 24 03  
            lda $0420,y        ; $e471: b9 20 04  
            sta $0420,x        ; $e474: 9d 20 04  
            bne __e487         ; $e477: d0 0e     
            lda #$14           ; $e479: a9 14     
            clc                ; $e47b: 18        
            adc $0348,y        ; $e47c: 79 48 03  
__e47f:     sta $0348,x        ; $e47f: 9d 48 03  
            bcc __e497         ; $e482: 90 13     
            jmp __a492         ; $e484: 4c 92 a4  

;-------------------------------------------------------------------------------
__e487:     lda #$ec           ; $e487: a9 ec     
            clc                ; $e489: 18        
            adc $0348,y        ; $e48a: 79 48 03  
            sta $0348,x        ; $e48d: 9d 48 03  
            bcs __e497         ; $e490: b0 05     
            lda #$01           ; $e492: a9 01     
            sta $03c6,x        ; $e494: 9d c6 03  
__e497:     lda $10            ; $e497: a5 10     
            sta $0456,x        ; $e499: 9d 56 04  
            tax                ; $e49c: aa        
            inc $0444,x        ; $e49d: fe 44 04  
            lda #$01           ; $e4a0: a9 01     
            sta $42            ; $e4a2: 85 42     
            lda #$01           ; $e4a4: a9 01     
            ldy #$00           ; $e4a6: a0 00     
            jmp __e04f         ; $e4a8: 4c 4f e0  

;-------------------------------------------------------------------------------
            rts                ; $e4ab: 60        

;-------------------------------------------------------------------------------
            lda $0420,x        ; $e4ac: bd 20 04  
            bne __e4b5         ; $e4af: d0 04     
            lda #$f0           ; $e4b1: a9 f0     
            bne __e4b7         ; $e4b3: d0 02     
__e4b5:     lda #$10           ; $e4b5: a9 10     
__e4b7:     ldy #$14           ; $e4b7: a0 14     
            jsr __e2a2         ; $e4b9: 20 a2 e2  
            bcs __e4c4         ; $e4bc: b0 06     
            jsr __e027         ; $e4be: 20 27 e0  
            jmp __a4d9         ; $e4c1: 4c d9 a4  

;-------------------------------------------------------------------------------
__e4c4:     lda $0420,x        ; $e4c4: bd 20 04  
            bne __e4cd         ; $e4c7: d0 04     
            lda #$18           ; $e4c9: a9 18     
            bne __e4cf         ; $e4cb: d0 02     
__e4cd:     lda #$e8           ; $e4cd: a9 e8     
__e4cf:     ldy #$14           ; $e4cf: a0 14     
            jsr __e2a2         ; $e4d1: 20 a2 e2  
            bcs __e4d9         ; $e4d4: b0 03     
            jsr __e027         ; $e4d6: 20 27 e0  
__e4d9:     jmp __e0f4         ; $e4d9: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $048c,x        ; $e4dc: bd 8c 04  
            beq __e4e4         ; $e4df: f0 03     
            dec $048c,x        ; $e4e1: de 8c 04  
__e4e4:     lda $03d8,x        ; $e4e4: bd d8 03  
            bne __e4ef         ; $e4e7: d0 06     
            lda #$80           ; $e4e9: a9 80     
            tay                ; $e4eb: a8        
            jmp __ded0         ; $e4ec: 4c d0 de  

;-------------------------------------------------------------------------------
__e4ef:     .hex bc            ; $e4ef: bc        Suspected data
__e4f0:     .hex 44            ; $e4f0: 44        Suspected data
__e4f1:     .hex 04 f0         ; $e4f1: 04 f0     Invalid Opcode - NOP $f0
            .hex 04 88         ; $e4f3: 04 88     Invalid Opcode - NOP $88
            beq __e4f9         ; $e4f5: f0 02     
            rts                ; $e4f7: 60        

;-------------------------------------------------------------------------------
__e4f8:     rts                ; $e4f8: 60        

;-------------------------------------------------------------------------------
__e4f9:     ldy $0456,x        ; $e4f9: bc 56 04  
            lda $03b4,y        ; $e4fc: b9 b4 03  
            beq __e510         ; $e4ff: f0 0f     
            lda $0390,y        ; $e501: b9 90 03  
            sta $0390,x        ; $e504: 9d 90 03  
            lda $03a2,y        ; $e507: b9 a2 03  
            sta $03a2,x        ; $e50a: 9d a2 03  
            jmp __e0f4         ; $e50d: 4c f4 e0  

;-------------------------------------------------------------------------------
__e510:     jmp __df42         ; $e510: 4c 42 df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e513: bd d8 03  
            bne __e520         ; $e516: d0 08     
            jsr __dec2         ; $e518: 20 c2 de  
            lda #$1c           ; $e51b: a9 1c     
            jmp __ded8         ; $e51d: 4c d8 de  

;-------------------------------------------------------------------------------
__e520:     jsr __dd2a         ; $e520: 20 2a dd  
            lda $0444,x        ; $e523: bd 44 04  
            bne __e54e         ; $e526: d0 26     
            lda $0348,x        ; $e528: bd 48 03  
            sec                ; $e52b: 38        
            sbc $0348          ; $e52c: ed 48 03  
            bcs __e534         ; $e52f: b0 03     
            jsr __deb7         ; $e531: 20 b7 de  
__e534:     cmp #$50           ; $e534: c9 50     
            bcc __e539         ; $e536: 90 01     
            rts                ; $e538: 60        

;-------------------------------------------------------------------------------
__e539:     lda #$fa           ; $e539: a9 fa     
            sta $036c,x        ; $e53b: 9d 6c 03  
            jsr __dec6         ; $e53e: 20 c6 de  
            inc $0444,x        ; $e541: fe 44 04  
            lda #$40           ; $e544: a9 40     
            jsr __de6f         ; $e546: 20 6f de  
            lda #$1d           ; $e549: a9 1d     
            jmp __c118         ; $e54b: 4c 18 c1  

;-------------------------------------------------------------------------------
__e54e:     lda #$40           ; $e54e: a9 40     
            sta $08            ; $e550: 85 08     
            jsr __dfe4         ; $e552: 20 e4 df  
            jmp __e0f4         ; $e555: 4c f4 e0  

;-------------------------------------------------------------------------------
            stx $10            ; $e558: 86 10     
            lda $03d8,x        ; $e55a: bd d8 03  
            bne __e567         ; $e55d: d0 08     
            jsr __deca         ; $e55f: 20 ca de  
            lda #$05           ; $e562: a9 05     
            jmp __ded8         ; $e564: 4c d8 de  

;-------------------------------------------------------------------------------
__e567:     jsr __dd2a         ; $e567: 20 2a dd  
            lda $0444,x        ; $e56a: bd 44 04  
            jsr __c5bb         ; $e56d: 20 bb c5  
            sei                ; $e570: 78        
            lda $86            ; $e571: a5 86     
            lda $94            ; $e573: a5 94     
            lda $bc            ; $e575: a5 bc     
            lda $a9            ; $e577: a5 a9     
            .hex 80 20         ; $e579: 80 20     Invalid Opcode - NOP #$20
            .hex 6f de fe      ; $e57b: 6f de fe  Invalid Opcode - RRA __fede
            .hex 44 04         ; $e57e: 44 04     Invalid Opcode - NOP $04
            lda #$50           ; $e580: a9 50     
            sta $0456,x        ; $e582: 9d 56 04  
            rts                ; $e585: 60        

;-------------------------------------------------------------------------------
            dec $0456,x        ; $e586: de 56 04  
            bne __e591         ; $e589: d0 06     
            inc $0444,x        ; $e58b: fe 44 04  
            jmp __df82         ; $e58e: 4c 82 df  

;-------------------------------------------------------------------------------
__e591:     jmp __a639         ; $e591: 4c 39 a6  

;-------------------------------------------------------------------------------
            jsr __e010         ; $e594: 20 10 e0  
            lda $03c6,x        ; $e597: bd c6 03  
            bne __e5c1         ; $e59a: d0 25     
            jsr __dfb3         ; $e59c: 20 b3 df  
            bcs __e5c1         ; $e59f: b0 20     
            ldy $10            ; $e5a1: a4 10     
            lda #$32           ; $e5a3: a9 32     
            jsr __de7b         ; $e5a5: 20 7b de  
            lda $0324,y        ; $e5a8: b9 24 03  
            sec                ; $e5ab: 38        
            sbc #$02           ; $e5ac: e9 02     
            sta $0324,x        ; $e5ae: 9d 24 03  
            ldx $10            ; $e5b1: a6 10     
            inc $0444,x        ; $e5b3: fe 44 04  
            lda #$30           ; $e5b6: a9 30     
            sta $0456,x        ; $e5b8: 9d 56 04  
            rts                ; $e5bb: 60        

;-------------------------------------------------------------------------------
            dec $0456,x        ; $e5bc: de 56 04  
            bne __e5c6         ; $e5bf: d0 05     
__e5c1:     ldx $10            ; $e5c1: a6 10     
            jsr __dfa8         ; $e5c3: 20 a8 df  
__e5c6:     rts                ; $e5c6: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e5c7: bd d8 03  
            bne __e5d6         ; $e5ca: d0 0a     
            lda #$02           ; $e5cc: a9 02     
            ldy #$29           ; $e5ce: a0 29     
            jsr __ded0         ; $e5d0: 20 d0 de  
            jmp __e010         ; $e5d3: 4c 10 e0  

;-------------------------------------------------------------------------------
__e5d6:     jsr __e0f4         ; $e5d6: 20 f4 e0  
            lda $0444,x        ; $e5d9: bd 44 04  
            jsr __c5bb         ; $e5dc: 20 bb c5  
            sbc $a5            ; $e5df: e5 a5     
            .hex f4 a5         ; $e5e1: f4 a5     Invalid Opcode - NOP $a5,x
            asl __fea6         ; $e5e3: 0e a6 fe  
            .hex 44 04         ; $e5e6: 44 04     Invalid Opcode - NOP $04
            lda #$fd           ; $e5e8: a9 fd     
            ldy #$00           ; $e5ea: a0 00     
            jsr __e076         ; $e5ec: 20 76 e0  
            lda #$e0           ; $e5ef: a9 e0     
            jmp __de6f         ; $e5f1: 4c 6f de  

;-------------------------------------------------------------------------------
            lda #$20           ; $e5f4: a9 20     
            sta $08            ; $e5f6: 85 08     
            jsr __dfe4         ; $e5f8: 20 e4 df  
            lda #$00           ; $e5fb: a9 00     
            ldy #$08           ; $e5fd: a0 08     
            jsr __e2a2         ; $e5ff: 20 a2 e2  
            bcs __e60d         ; $e602: b0 09     
            inc $0444,x        ; $e604: fe 44 04  
            jsr __d3f6         ; $e607: 20 f6 d3  
            jmp __df8a         ; $e60a: 4c 8a df  

;-------------------------------------------------------------------------------
__e60d:     rts                ; $e60d: 60        

;-------------------------------------------------------------------------------
            lda #$00           ; $e60e: a9 00     
            ldy #$00           ; $e610: a0 00     
            jsr __e2a2         ; $e612: 20 a2 e2  
            bcc __e636         ; $e615: 90 1f     
            lda $0420,x        ; $e617: bd 20 04  
            bne __e620         ; $e61a: d0 04     
            lda #$fa           ; $e61c: a9 fa     
            bne __e622         ; $e61e: d0 02     
__e620:     lda #$06           ; $e620: a9 06     
__e622:     ldy #$08           ; $e622: a0 08     
            jsr __e2af         ; $e624: 20 af e2  
            bcs __e62a         ; $e627: b0 01     
            rts                ; $e629: 60        

;-------------------------------------------------------------------------------
__e62a:     lda #$01           ; $e62a: a9 01     
            sta $0444,x        ; $e62c: 9d 44 04  
            lda #$ff           ; $e62f: a9 ff     
            ldy #$80           ; $e631: a0 80     
            jmp __e076         ; $e633: 4c 76 e0  

;-------------------------------------------------------------------------------
__e636:     jmp __df42         ; $e636: 4c 42 df  

;-------------------------------------------------------------------------------
            jsr __de8b         ; $e639: 20 8b de  
            jsr __dea1         ; $e63c: 20 a1 de  
            jmp __e0f4         ; $e63f: 4c f4 e0  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $e642: 20 2a dd  
            jmp __e0f4         ; $e645: 4c f4 e0  

;-------------------------------------------------------------------------------
            .hex 5a            ; $e648: 5a        Invalid Opcode - NOP 
            ldx $6f            ; $e649: a6 6f     
            ldx $a0            ; $e64b: a6 a0     
            ldx $c1            ; $e64d: a6 c1     
            ldx $de            ; $e64f: a6 de     
            ldx $f3            ; $e651: a6 f3     
            ldx $24            ; $e653: a6 24     
            .hex a7 39         ; $e655: a7 39     Invalid Opcode - LAX $39
            .hex a7 66         ; $e657: a7 66     Invalid Opcode - LAX $66
            .hex a7 08         ; $e659: a7 08     Invalid Opcode - LAX $08
            asl $0e            ; $e65b: 06 0e     
            .hex 02            ; $e65d: 02        Invalid Opcode - KIL 
            .hex 0c 0c 03      ; $e65e: 0c 0c 03  Invalid Opcode - NOP $030c
            .hex 02            ; $e661: 02        Invalid Opcode - KIL 
            .hex 14 0a         ; $e662: 14 0a     Invalid Opcode - NOP $0a,x
            .hex 03 02         ; $e664: 03 02     Invalid Opcode - SLO ($02,x)
            clc                ; $e666: 18        
            asl $0e            ; $e667: 06 0e     
            .hex 02            ; $e669: 02        Invalid Opcode - KIL 
            .hex 1c 0b 03      ; $e66a: 1c 0b 03  Invalid Opcode - NOP $030b,x
            .hex 02            ; $e66d: 02        Invalid Opcode - KIL 
            .hex ff 04 1b      ; $e66e: ff 04 1b  Invalid Opcode - ISC $1b04,x
            .hex 43 00         ; $e671: 43 00     Invalid Opcode - SRE ($00,x)
            php                ; $e673: 08        
            .hex 0c 03 02      ; $e674: 0c 03 02  Invalid Opcode - NOP $0203
            php                ; $e677: 08        
            .hex 12            ; $e678: 12        Invalid Opcode - KIL 
            php                ; $e679: 08        
            .hex 02            ; $e67a: 02        Invalid Opcode - KIL 
            php                ; $e67b: 08        
            clc                ; $e67c: 18        
            .hex 03 02         ; $e67d: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 06 08      ; $e67f: 0c 06 08  Invalid Opcode - NOP $0806
            .hex 02            ; $e682: 02        Invalid Opcode - KIL 
            .hex 0c 18 03      ; $e683: 0c 18 03  Invalid Opcode - NOP $0318
            .hex 02            ; $e686: 02        Invalid Opcode - KIL 
            .hex 13 1b         ; $e687: 13 1b     Invalid Opcode - SLO ($1b),y
            .hex 43 00         ; $e689: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 14 0c         ; $e68b: 14 0c     Invalid Opcode - NOP $0c,x
            php                ; $e68d: 08        
            .hex 02            ; $e68e: 02        Invalid Opcode - KIL 
            .hex 14 1a         ; $e68f: 14 1a     Invalid Opcode - NOP $1a,x
            .hex 03 02         ; $e691: 03 02     Invalid Opcode - SLO ($02,x)
            clc                ; $e693: 18        
            asl $08            ; $e694: 06 08     
            .hex 02            ; $e696: 02        Invalid Opcode - KIL 
            clc                ; $e697: 18        
            asl $03,x          ; $e698: 16 03     
            .hex 02            ; $e69a: 02        Invalid Opcode - KIL 
            .hex 1c 0c 08      ; $e69b: 1c 0c 08  Invalid Opcode - NOP $080c,x
            .hex 02            ; $e69e: 02        Invalid Opcode - KIL 
            .hex ff 01 0c      ; $e69f: ff 01 0c  Invalid Opcode - ISC $0c01,x
            rol $76            ; $e6a2: 26 76     
            .hex 04 04         ; $e6a4: 04 04     Invalid Opcode - NOP $04
            php                ; $e6a6: 08        
            .hex 02            ; $e6a7: 02        Invalid Opcode - KIL 
            .hex 04 0c         ; $e6a8: 04 0c     Invalid Opcode - NOP $0c
            ora #$02           ; $e6aa: 09 02     
            .hex 0c 06 08      ; $e6ac: 0c 06 08  Invalid Opcode - NOP $0806
            .hex 02            ; $e6af: 02        Invalid Opcode - KIL 
            .hex 0c 0c 09      ; $e6b0: 0c 0c 09  Invalid Opcode - NOP $090c
            .hex 02            ; $e6b3: 02        Invalid Opcode - KIL 
            .hex 14 06         ; $e6b4: 14 06     Invalid Opcode - NOP $06,x
            php                ; $e6b6: 08        
            .hex 02            ; $e6b7: 02        Invalid Opcode - KIL 
            .hex 14 0c         ; $e6b8: 14 0c     Invalid Opcode - NOP $0c,x
            ora #$02           ; $e6ba: 09 02     
            .hex 1c 0c 09      ; $e6bc: 1c 0c 09  Invalid Opcode - NOP $090c,x
            .hex 02            ; $e6bf: 02        Invalid Opcode - KIL 
            .hex ff 04 04      ; $e6c0: ff 04 04  Invalid Opcode - ISC $0404,x
            asl $0502          ; $e6c3: 0e 02 05  
            ora $0d27          ; $e6c6: 0d 27 0d  
            php                ; $e6c9: 08        
            php                ; $e6ca: 08        
            .hex 03 02         ; $e6cb: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 06 0e      ; $e6cd: 0c 06 0e  Invalid Opcode - NOP $0e06
            .hex 02            ; $e6d0: 02        Invalid Opcode - KIL 
            .hex 14 06         ; $e6d1: 14 06     Invalid Opcode - NOP $06,x
            asl $1802          ; $e6d3: 0e 02 18  
            asl                ; $e6d6: 0a        
            .hex 03 02         ; $e6d7: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 1c 08 03      ; $e6d9: 1c 08 03  Invalid Opcode - NOP $0308,x
            .hex 02            ; $e6dc: 02        Invalid Opcode - KIL 
            .hex ff 04 08      ; $e6dd: ff 04 08  Invalid Opcode - ISC $0804,x
            .hex 03 02         ; $e6e0: 03 02     Invalid Opcode - SLO ($02,x)
            php                ; $e6e2: 08        
            asl                ; $e6e3: 0a        
            .hex 03 02         ; $e6e4: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 0c 03      ; $e6e6: 0c 0c 03  Invalid Opcode - NOP $030c
            .hex 02            ; $e6e9: 02        Invalid Opcode - KIL 
            .hex 14 0c         ; $e6ea: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 03 02         ; $e6ec: 03 02     Invalid Opcode - SLO ($02,x)
            clc                ; $e6ee: 18        
            asl                ; $e6ef: 0a        
            .hex 03 02         ; $e6f0: 03 02     Invalid Opcode - SLO ($02,x)
            .hex ff 04 0a      ; $e6f2: ff 04 0a  Invalid Opcode - ISC $0a04,x
            .hex 03 02         ; $e6f5: 03 02     Invalid Opcode - SLO ($02,x)
            php                ; $e6f7: 08        
            asl                ; $e6f8: 0a        
            .hex 03 02         ; $e6f9: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 0b 03      ; $e6fb: 0c 0b 03  Invalid Opcode - NOP $030b
            .hex 02            ; $e6fe: 02        Invalid Opcode - KIL 
            .hex 14 08         ; $e6ff: 14 08     Invalid Opcode - NOP $08,x
            .hex 03 02         ; $e701: 03 02     Invalid Opcode - SLO ($02,x)
            asl $0c,x          ; $e703: 16 0c     
            ora #$02           ; $e705: 09 02     
            clc                ; $e707: 18        
            asl $03            ; $e708: 06 03     
            .hex 02            ; $e70a: 02        Invalid Opcode - KIL 
            .hex 1c 0d 43      ; $e70b: 1c 0d 43  Invalid Opcode - NOP $430d,x
            .hex 02            ; $e70e: 02        Invalid Opcode - KIL 
            bit $06            ; $e70f: 24 06     
            .hex 03 02         ; $e711: 03 02     Invalid Opcode - SLO ($02,x)
            bit $0d            ; $e713: 24 0d     
            .hex 43 00         ; $e715: 43 00     Invalid Opcode - SRE ($00,x)
            plp                ; $e717: 28        
            php                ; $e718: 08        
            .hex 03 02         ; $e719: 03 02     Invalid Opcode - SLO ($02,x)
            bit $0308          ; $e71b: 2c 08 03  
            .hex 02            ; $e71e: 02        Invalid Opcode - KIL 
            and $090c          ; $e71f: 2d 0c 09  
            .hex 02            ; $e722: 02        Invalid Opcode - KIL 
            .hex ff 04 06      ; $e723: ff 04 06  Invalid Opcode - ISC $0604,x
            asl $0802          ; $e726: 0e 02 08  
            .hex 0c 03 02      ; $e729: 0c 03 02  Invalid Opcode - NOP $0203
            .hex 0c 06 0e      ; $e72c: 0c 06 0e  Invalid Opcode - NOP $0e06
            .hex 02            ; $e72f: 02        Invalid Opcode - KIL 
            .hex 14 06         ; $e730: 14 06     Invalid Opcode - NOP $06,x
            asl $1802          ; $e732: 0e 02 18  
            asl                ; $e735: 0a        
            .hex 03 02         ; $e736: 03 02     Invalid Opcode - SLO ($02,x)
            .hex ff 08 0a      ; $e738: ff 08 0a  Invalid Opcode - ISC $0a08,x
            .hex 03 02         ; $e73b: 03 02     Invalid Opcode - SLO ($02,x)
            .hex 0c 08 03      ; $e73d: 0c 08 03  Invalid Opcode - NOP $0308
            .hex 02            ; $e740: 02        Invalid Opcode - KIL 
            .hex 14 0c         ; $e741: 14 0c     Invalid Opcode - NOP $0c,x
            php                ; $e743: 08        
            .hex 02            ; $e744: 02        Invalid Opcode - KIL 
            clc                ; $e745: 18        
            asl $03            ; $e746: 06 03     
            .hex 02            ; $e748: 02        Invalid Opcode - KIL 
            .hex 1c 06 03      ; $e749: 1c 06 03  Invalid Opcode - NOP $0306,x
            .hex 02            ; $e74c: 02        Invalid Opcode - KIL 
            ora $080c,x        ; $e74d: 1d 0c 08  
            .hex 02            ; $e750: 02        Invalid Opcode - KIL 
            bit $06            ; $e751: 24 06     
            .hex 03 02         ; $e753: 03 02     Invalid Opcode - SLO ($02,x)
            and #$0d           ; $e755: 29 0d     
            .hex 22            ; $e757: 22        Invalid Opcode - KIL 
            eor $2c            ; $e758: 45 2c     
            .hex 04 03         ; $e75a: 04 03     Invalid Opcode - NOP $03
            .hex 02            ; $e75c: 02        Invalid Opcode - KIL 
            .hex 37 0d         ; $e75d: 37 0d     Invalid Opcode - RLA $0d,x
            .hex 22            ; $e75f: 22        Invalid Opcode - KIL 
            lsr $38            ; $e760: 46 38     
            asl $03            ; $e762: 06 03     
            .hex 02            ; $e764: 02        Invalid Opcode - KIL 
            .hex ff ff a0      ; $e765: ff ff a0  Invalid Opcode - ISC __a0ff,x
            brk                ; $e768: 00        
            ldx #$00           ; $e769: a2 00     
            lda $50            ; $e76b: a5 50     
            cmp #$05           ; $e76d: c9 05     
            bne __e77f         ; $e76f: d0 0e     
            lda $51            ; $e771: a5 51     
            and #$7f           ; $e773: 29 7f     
            cmp #$01           ; $e775: c9 01     
            bne __e77f         ; $e777: d0 06     
            iny                ; $e779: c8        
            lda $57            ; $e77a: a5 57     
            bne __e77f         ; $e77c: d0 01     
            inx                ; $e77e: e8        
__e77f:     sty $0194          ; $e77f: 8c 94 01  
            stx $4b            ; $e782: 86 4b     
            rts                ; $e784: 60        

;-------------------------------------------------------------------------------
            jsr __a7b8         ; $e785: 20 b8 a7  
            lda $0195          ; $e788: ad 95 01  
            beq __e7b7         ; $e78b: f0 2a     
            lda $4f            ; $e78d: a5 4f     
            cmp #$06           ; $e78f: c9 06     
            bne __e7b7         ; $e791: d0 24     
            lda $91            ; $e793: a5 91     
            and #$60           ; $e795: 29 60     
            cmp #$40           ; $e797: c9 40     
            bcc __e7b7         ; $e799: 90 1c     
            lda $03d8          ; $e79b: ad d8 03  
            cmp #$03           ; $e79e: c9 03     
            bne __e7b7         ; $e7a0: d0 15     
            dec $04ea          ; $e7a2: ce ea 04  
            bne __e7b7         ; $e7a5: d0 10     
            lda #$01           ; $e7a7: a9 01     
            sta $56            ; $e7a9: 85 56     
            lda #$00           ; $e7ab: a9 00     
            sta $0195          ; $e7ad: 8d 95 01  
            sta $4b            ; $e7b0: 85 4b     
            lda #$29           ; $e7b2: a9 29     
            jsr __c118         ; $e7b4: 20 18 c1  
__e7b7:     rts                ; $e7b7: 60        

;-------------------------------------------------------------------------------
            ldy #$00           ; $e7b8: a0 00     
            lda $0194          ; $e7ba: ad 94 01  
            beq __e7c6         ; $e7bd: f0 07     
            lda $56            ; $e7bf: a5 56     
            ora $57            ; $e7c1: 05 57     
            bne __e7c6         ; $e7c3: d0 01     
            iny                ; $e7c5: c8        
__e7c6:     sty $0195          ; $e7c6: 8c 95 01  
            rts                ; $e7c9: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e7ca: bd d8 03  
            bne __e7d7         ; $e7cd: d0 08     
            jsr __deca         ; $e7cf: 20 ca de  
            lda #$39           ; $e7d2: a9 39     
            jmp __ded8         ; $e7d4: 4c d8 de  

;-------------------------------------------------------------------------------
__e7d7:     jsr __dd2a         ; $e7d7: 20 2a dd  
            lda #$80           ; $e7da: a9 80     
            jsr __de6f         ; $e7dc: 20 6f de  
            jsr __8d12         ; $e7df: 20 12 8d  
            bcc __e7e8         ; $e7e2: 90 04     
            lda #$ff           ; $e7e4: a9 ff     
            bne __e7ea         ; $e7e6: d0 02     
__e7e8:     lda #$00           ; $e7e8: a9 00     
__e7ea:     ldy #$80           ; $e7ea: a0 80     
            jsr __e076         ; $e7ec: 20 76 e0  
            jmp __e0f4         ; $e7ef: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $e7f2: bd d8 03  
            bne __e816         ; $e7f5: d0 1f     
            jsr __deca         ; $e7f7: 20 ca de  
            lda #$20           ; $e7fa: a9 20     
            sta $0444,x        ; $e7fc: 9d 44 04  
            lda #$fe           ; $e7ff: a9 fe     
            ldy #$80           ; $e801: a0 80     
__e803:     .hex 20 76         ; $e803: 20 76     Suspected data
__e805:     cpx #$a9           ; $e805: e0 a9     
            cpy #$20           ; $e807: c0 20     
            .hex 6f de ad      ; $e809: 6f de ad  Invalid Opcode - RRA __adde
            bit $03            ; $e80c: 24 03     
            sta $0324,x        ; $e80e: 9d 24 03  
            lda #$3a           ; $e811: a9 3a     
            jmp __ded8         ; $e813: 4c d8 de  

;-------------------------------------------------------------------------------
__e816:     jsr __dd2a         ; $e816: 20 2a dd  
            dec $0444,x        ; $e819: de 44 04  
            bne __e826         ; $e81c: d0 08     
            lda #$20           ; $e81e: a9 20     
            sta $0444,x        ; $e820: 9d 44 04  
            jmp __e03b         ; $e823: 4c 3b e0  

;-------------------------------------------------------------------------------
__e826:     jmp __e0f4         ; $e826: 4c f4 e0  

;-------------------------------------------------------------------------------
            and ($a8),y        ; $e829: 31 a8     
            and $a8,x          ; $e82b: 35 a8     
            and $3ba8,y        ; $e82d: 39 a8 3b  
            tay                ; $e830: a8        
            .hex 3f a8 64      ; $e831: 3f a8 64  Invalid Opcode - RLA $64a8,x
            tay                ; $e834: a8        
            lda #$a8           ; $e835: a9 a8     
            sta $a8            ; $e837: 85 a8     
            tax                ; $e839: aa        
            tay                ; $e83a: a8        
            .hex d3 a8         ; $e83b: d3 a8     Invalid Opcode - DCP ($a8),y
            lda #$a8           ; $e83d: a9 a8     
            .hex 04 0a         ; $e83f: 04 0a     Invalid Opcode - NOP $0a
            .hex af 00 14      ; $e841: af 00 14  Invalid Opcode - LAX $1400
            .hex 0c 0a 04      ; $e844: 0c 0a 04  Invalid Opcode - NOP $040a
            clc                ; $e847: 18        
            asl                ; $e848: 0a        
            asl                ; $e849: 0a        
            .hex 04 1c         ; $e84a: 04 1c     Invalid Opcode - NOP $1c
            asl                ; $e84c: 0a        
            .hex 3f 04 24      ; $e84d: 3f 04 24  Invalid Opcode - RLA $2404,x
            asl                ; $e850: 0a        
            and $2c04,y        ; $e851: 39 04 2c  
            asl                ; $e854: 0a        
            and $3404,y        ; $e855: 39 04 34  
            .hex 0b 1b         ; $e858: 0b 1b     Invalid Opcode - ANC #$1b
            .hex 04 38         ; $e85a: 04 38     Invalid Opcode - NOP $38
            .hex 0c 3a 04      ; $e85c: 0c 3a 04  Invalid Opcode - NOP $043a
            .hex 3c 0b 1b      ; $e85f: 3c 0b 1b  Invalid Opcode - NOP $1b0b,x
            .hex 04 ff         ; $e862: 04 ff     Invalid Opcode - NOP $ff
            .hex 13 0d         ; $e864: 13 0d     Invalid Opcode - SLO ($0d),y
            .hex 34 20         ; $e866: 34 20     Invalid Opcode - NOP $20,x
            .hex 17 0d         ; $e868: 17 0d     Invalid Opcode - SLO $0d,x
            .hex 34 20         ; $e86a: 34 20     Invalid Opcode - NOP $20,x
            .hex 1b 0d 34      ; $e86c: 1b 0d 34  Invalid Opcode - SLO $340d,y
            jsr $0d1f          ; $e86f: 20 1f 0d  
            .hex 34 20         ; $e872: 34 20     Invalid Opcode - NOP $20,x
            and ($0d,x)        ; $e874: 21 0d     
            .hex 34 20         ; $e876: 34 20     Invalid Opcode - NOP $20,x
            and $0d            ; $e878: 25 0d     
            .hex 34 20         ; $e87a: 34 20     Invalid Opcode - NOP $20,x
            and #$0d           ; $e87c: 29 0d     
            .hex 34 20         ; $e87e: 34 20     Invalid Opcode - NOP $20,x
            and $340d          ; $e880: 2d 0d 34  
            jsr $06ff          ; $e883: 20 ff 06  
            .hex 0b 27         ; $e886: 0b 27     Invalid Opcode - ANC #$27
            .hex 14 14         ; $e888: 14 14     Invalid Opcode - NOP $14,x
            ora $2034          ; $e88a: 0d 34 20  
            clc                ; $e88d: 18        
            ora $2034          ; $e88e: 0d 34 20  
            .hex 1c 0d 34      ; $e891: 1c 0d 34  Invalid Opcode - NOP $340d,x
            jsr $0c24          ; $e894: 20 24 0c  
            .hex 3a            ; $e897: 3a        Invalid Opcode - NOP 
            php                ; $e898: 08        
            plp                ; $e899: 28        
            .hex 0b 3a         ; $e89a: 0b 3a     Invalid Opcode - ANC #$3a
            php                ; $e89c: 08        
            bit $3a0c          ; $e89d: 2c 0c 3a  
            php                ; $e8a0: 08        
            .hex 34 0a         ; $e8a1: 34 0a     Invalid Opcode - NOP $0a,x
            and $3808,y        ; $e8a3: 39 08 38  
            asl                ; $e8a6: 0a        
            and __ff08,y       ; $e8a7: 39 08 ff  
            php                ; $e8aa: 08        
            .hex 0c 3a 08      ; $e8ab: 0c 3a 08  Invalid Opcode - NOP $083a
            .hex 0c 0b 3a      ; $e8ae: 0c 0b 3a  Invalid Opcode - NOP $3a0b
            php                ; $e8b1: 08        
            .hex 14 0c         ; $e8b2: 14 0c     Invalid Opcode - NOP $0c,x
            .hex 3a            ; $e8b4: 3a        Invalid Opcode - NOP 
            php                ; $e8b5: 08        
            clc                ; $e8b6: 18        
            asl                ; $e8b7: 0a        
            .hex 3a            ; $e8b8: 3a        Invalid Opcode - NOP 
            php                ; $e8b9: 08        
            .hex 1c 0a 3f      ; $e8ba: 1c 0a 3f  Invalid Opcode - NOP $3f0a,x
            php                ; $e8bd: 08        
            bit $0c            ; $e8be: 24 0c     
            .hex 3b 08 28      ; $e8c0: 3b 08 28  Invalid Opcode - RLA $2808,y
            .hex 0c 3b 08      ; $e8c3: 0c 3b 08  Invalid Opcode - NOP $083b
            bit $3b0c          ; $e8c6: 2c 0c 3b  
            php                ; $e8c9: 08        
            .hex 34 0c         ; $e8ca: 34 0c     Invalid Opcode - NOP $0c,x
            asl                ; $e8cc: 0a        
            php                ; $e8cd: 08        
            sec                ; $e8ce: 38        
            .hex 0b 0a         ; $e8cf: 0b 0a     Invalid Opcode - ANC #$0a
            php                ; $e8d1: 08        
            .hex ff 08 0c      ; $e8d2: ff 08 0c  Invalid Opcode - ISC $0c08,x
            .hex 3a            ; $e8d5: 3a        Invalid Opcode - NOP 
            .hex 0f 0c 0c      ; $e8d6: 0f 0c 0c  Invalid Opcode - SLO $0c0c
            .hex 3a            ; $e8d9: 3a        Invalid Opcode - NOP 
            .hex 0f 14 0c      ; $e8da: 0f 14 0c  Invalid Opcode - SLO $0c14
            .hex 1b 0f 18      ; $e8dd: 1b 0f 18  Invalid Opcode - SLO $180f,y
            .hex 0c 3a 0f      ; $e8e0: 0c 3a 0f  Invalid Opcode - NOP $0f3a
            .hex 1c 0c 1b      ; $e8e3: 1c 0c 1b  Invalid Opcode - NOP $1b0c,x
            .hex 0f 24 0a      ; $e8e6: 0f 24 0a  Invalid Opcode - SLO $0a24
            and $280f,y        ; $e8e9: 39 0f 28  
            asl                ; $e8ec: 0a        
            and $2c0f,y        ; $e8ed: 39 0f 2c  
            asl                ; $e8f0: 0a        
            and $340f,y        ; $e8f1: 39 0f 34  
            asl                ; $e8f4: 0a        
            and __ff0f,y       ; $e8f5: 39 0f ff  
            lda $50            ; $e8f8: a5 50     
            cmp #$03           ; $e8fa: c9 03     
            bne __e913         ; $e8fc: d0 15     
            lda $91            ; $e8fe: a5 91     
            and #$7f           ; $e900: 29 7f     
__e902:     cmp #$7f           ; $e902: c9 7f     
            bne __e911         ; $e904: d0 0b     
            lda $92            ; $e906: a5 92     
            and #$02           ; $e908: 29 02     
            beq __e911         ; $e90a: f0 05     
            pla                ; $e90c: 68        
            pla                ; $e90d: 68        
            jmp __d672         ; $e90e: 4c 72 d6  

;-------------------------------------------------------------------------------
__e911:     pla                ; $e911: 68        
            pla                ; $e912: 68        
__e913:     rts                ; $e913: 60        

;-------------------------------------------------------------------------------
            lda $03d8          ; $e914: ad d8 03  
            cmp #$0b           ; $e917: c9 0b     
            beq __e950         ; $e919: f0 35     
            lda $50            ; $e91b: a5 50     
            cmp #$01           ; $e91d: c9 01     
            bne __e94b         ; $e91f: d0 2a     
            lda $51            ; $e921: a5 51     
            and #$7f           ; $e923: 29 7f     
            cmp #$01           ; $e925: c9 01     
            bne __e94b         ; $e927: d0 22     
            lda $53            ; $e929: a5 53     
            ora $54            ; $e92b: 05 54     
            bne __e94b         ; $e92d: d0 1c     
            lda $0348          ; $e92f: ad 48 03  
            cmp #$50           ; $e932: c9 50     
            bcs __e94b         ; $e934: b0 15     
            lda $4f            ; $e936: a5 4f     
            cmp #$06           ; $e938: c9 06     
            bne __e94b         ; $e93a: d0 0f     
            lda $91            ; $e93c: a5 91     
            and #$60           ; $e93e: 29 60     
            cmp #$60           ; $e940: c9 60     
            bcc __e94b         ; $e942: 90 07     
            lda $03d8          ; $e944: ad d8 03  
            cmp #$03           ; $e947: c9 03     
            beq __e951         ; $e949: f0 06     
__e94b:     lda #$00           ; $e94b: a9 00     
            sta $04ea          ; $e94d: 8d ea 04  
__e950:     rts                ; $e950: 60        

;-------------------------------------------------------------------------------
__e951:     dec $04ea          ; $e951: ce ea 04  
            bne __e950         ; $e954: d0 fa     
            lda #$0b           ; $e956: a9 0b     
            sta $03d8          ; $e958: 8d d8 03  
            lda #$00           ; $e95b: a9 00     
            sta $03d7          ; $e95d: 8d d7 03  
            lda #$1c           ; $e960: a9 1c     
            sta $03c5          ; $e962: 8d c5 03  
            lda #$80           ; $e965: a9 80     
            sta $03e9          ; $e967: 8d e9 03  
            lda #$f0           ; $e96a: a9 f0     
            sta $0359          ; $e96c: 8d 59 03  
            lda #$80           ; $e96f: a9 80     
            sta $0335          ; $e971: 8d 35 03  
            lda #$9c           ; $e974: a9 9c     
            sta $0311          ; $e976: 8d 11 03  
            lda #$00           ; $e979: a9 00     
            sta $0323          ; $e97b: 8d 23 03  
            sta $036b          ; $e97e: 8d 6b 03  
            sta $0347          ; $e981: 8d 47 03  
            lda #$00           ; $e984: a9 00     
            sta $0455          ; $e986: 8d 55 04  
            sta $0467          ; $e989: 8d 67 04  
            lda #$00           ; $e98c: a9 00     
            sta $04d3          ; $e98e: 8d d3 04  
            jsr __c0e7         ; $e991: 20 e7 c0  
            lda #$28           ; $e994: a9 28     
            jmp __c118         ; $e996: 4c 18 c1  

;-------------------------------------------------------------------------------
__e999:     lda $0348          ; $e999: ad 48 03  
            sec                ; $e99c: 38        
            sbc $0348,x        ; $e99d: fd 48 03  
            bcc __e9a5         ; $e9a0: 90 03     
            jsr __deb7         ; $e9a2: 20 b7 de  
__e9a5:     cmp #$10           ; $e9a5: c9 10     
            bcs __e9cb         ; $e9a7: b0 22     
            lda $0324          ; $e9a9: ad 24 03  
            sec                ; $e9ac: 38        
            sbc $0324,x        ; $e9ad: fd 24 03  
            bcc __e9b5         ; $e9b0: 90 03     
            jsr __deb7         ; $e9b2: 20 b7 de  
__e9b5:     cmp #$10           ; $e9b5: c9 10     
            bcs __e9cb         ; $e9b7: b0 12     
            lda #$00           ; $e9b9: a9 00     
            sta $0300          ; $e9bb: 8d 00 03  
            lda #$80           ; $e9be: a9 80     
            sta $03ea          ; $e9c0: 8d ea 03  
            inc $0444,x        ; $e9c3: fe 44 04  
            lda #$2d           ; $e9c6: a9 2d     
            jmp __c118         ; $e9c8: 4c 18 c1  

;-------------------------------------------------------------------------------
__e9cb:     lda #$c0           ; $e9cb: a9 c0     
            jsr __de6f         ; $e9cd: 20 6f de  
            jsr __a9e6         ; $e9d0: 20 e6 a9  
            jsr __8d12         ; $e9d3: 20 12 8d  
            bcc __e9dc         ; $e9d6: 90 04     
            lda #$ff           ; $e9d8: a9 ff     
            bne __e9de         ; $e9da: d0 02     
__e9dc:     lda #$00           ; $e9dc: a9 00     
__e9de:     ldy #$c0           ; $e9de: a0 c0     
            jsr __e076         ; $e9e0: 20 76 e0  
            jmp __e0f4         ; $e9e3: 4c f4 e0  

;-------------------------------------------------------------------------------
            ldy #$00           ; $e9e6: a0 00     
            lda $1d            ; $e9e8: a5 1d     
            and #$02           ; $e9ea: 29 02     
            beq __e9ef         ; $e9ec: f0 01     
            iny                ; $e9ee: c8        
__e9ef:     tya                ; $e9ef: 98        
            sta $0420,x        ; $e9f0: 9d 20 04  
            rts                ; $e9f3: 60        

;-------------------------------------------------------------------------------
            jsr __a9e6         ; $e9f4: 20 e6 a9  
            ldy $0444,x        ; $e9f7: bc 44 04  
            beq __e999         ; $e9fa: f0 9d     
            lda $0456,x        ; $e9fc: bd 56 04  
            ldy #$04           ; $e9ff: a0 04     
            .hex 20            ; $ea01: 20        Suspected data
__ea02:     ora __bd8d,y       ; $ea02: 19 8d bd  
            bcc __ea0a         ; $ea05: 90 03     
            sec                ; $ea07: 38        
            sbc #$01           ; $ea08: e9 01     
__ea0a:     sta $0390,x        ; $ea0a: 9d 90 03  
            lda $03a2,x        ; $ea0d: bd a2 03  
            sta $6c            ; $ea10: 85 6c     
            lda $0390,x        ; $ea12: bd 90 03  
            sta $6d            ; $ea15: 85 6d     
            jsr __e0f4         ; $ea17: 20 f4 e0  
            lda $0348,x        ; $ea1a: bd 48 03  
            sta $0348          ; $ea1d: 8d 48 03  
            lda $0324,x        ; $ea20: bd 24 03  
            sta $0324          ; $ea23: 8d 24 03  
            lda $0444,x        ; $ea26: bd 44 04  
            clc                ; $ea29: 18        
            adc #$c0           ; $ea2a: 69 c0     
            sta $0444,x        ; $ea2c: 9d 44 04  
            lda $0456,x        ; $ea2f: bd 56 04  
            adc #$00           ; $ea32: 69 00     
            and #$3f           ; $ea34: 29 3f     
            sta $0456,x        ; $ea36: 9d 56 04  
            rts                ; $ea39: 60        

;-------------------------------------------------------------------------------
            lda $4a            ; $ea3a: a5 4a     
            ora #$10           ; $ea3c: 09 10     
            sta $4a            ; $ea3e: 85 4a     
            lda #$12           ; $ea40: a9 12     
            sta $7f            ; $ea42: 85 7f     
            rts                ; $ea44: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ea45: bd d8 03  
            bne __ea52         ; $ea48: d0 08     
            jsr __deca         ; $ea4a: 20 ca de  
            lda #$18           ; $ea4d: a9 18     
            jmp __ded8         ; $ea4f: 4c d8 de  

;-------------------------------------------------------------------------------
__ea52:     jsr __dd2a         ; $ea52: 20 2a dd  
            lda #$c0           ; $ea55: a9 c0     
            jsr __de6f         ; $ea57: 20 6f de  
            jsr __8d12         ; $ea5a: 20 12 8d  
            bcc __ea65         ; $ea5d: 90 06     
            lda #$ff           ; $ea5f: a9 ff     
            ldy #$40           ; $ea61: a0 40     
            bne __ea69         ; $ea63: d0 04     
__ea65:     lda #$00           ; $ea65: a9 00     
            ldy #$c0           ; $ea67: a0 c0     
__ea69:     jsr __e076         ; $ea69: 20 76 e0  
            jmp __e0f4         ; $ea6c: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ea6f: bd d8 03  
            bne __ea8d         ; $ea72: d0 19     
            jsr __deca         ; $ea74: 20 ca de  
            lda #$3f           ; $ea77: a9 3f     
            jsr __ded8         ; $ea79: 20 d8 de  
            lda #$20           ; $ea7c: a9 20     
            sta $0456,x        ; $ea7e: 9d 56 04  
            lda #$00           ; $ea81: a9 00     
            ldy #$f0           ; $ea83: a0 f0     
            jsr __e076         ; $ea85: 20 76 e0  
            lda #$80           ; $ea88: a9 80     
            jmp __de6f         ; $ea8a: 4c 6f de  

;-------------------------------------------------------------------------------
__ea8d:     jsr __dd2a         ; $ea8d: 20 2a dd  
            dec $0456,x        ; $ea90: de 56 04  
            bne __ea9d         ; $ea93: d0 08     
            lda #$20           ; $ea95: a9 20     
            sta $0456,x        ; $ea97: 9d 56 04  
            jsr __e03b         ; $ea9a: 20 3b e0  
__ea9d:     jmp __e0f4         ; $ea9d: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $eaa0: bd d8 03  
            bne __eab0         ; $eaa3: d0 0b     
            lda #$01           ; $eaa5: a9 01     
            sta $03d8,x        ; $eaa7: 9d d8 03  
            lda #$be           ; $eaaa: a9 be     
            sta $0300,x        ; $eaac: 9d 00 03  
            rts                ; $eaaf: 60        

;-------------------------------------------------------------------------------
__eab0:     jsr __e010         ; $eab0: 20 10 e0  
            lda $0444,x        ; $eab3: bd 44 04  
            jsr __c5bb         ; $eab6: 20 bb c5  
            .hex bf aa de      ; $eab9: bf aa de  Invalid Opcode - LAX __deaa,y
            tax                ; $eabc: aa        
            sbc __adaa,y       ; $eabd: f9 aa ad  
            pha                ; $eac0: 48        
            .hex 03 38         ; $eac1: 03 38     Invalid Opcode - SLO ($38,x)
            sbc $0348,x        ; $eac3: fd 48 03  
            bcs __eacb         ; $eac6: b0 03     
            jsr __deb7         ; $eac8: 20 b7 de  
__eacb:     cmp #$40           ; $eacb: c9 40     
            bcs __eadd         ; $eacd: b0 0e     
            lda $03c6,x        ; $eacf: bd c6 03  
            bne __eadd         ; $ead2: d0 09     
            lda #$bf           ; $ead4: a9 bf     
            sta $0300,x        ; $ead6: 9d 00 03  
            inc $0444,x        ; $ead9: fe 44 04  
            rts                ; $eadc: 60        

;-------------------------------------------------------------------------------
__eadd:     rts                ; $eadd: 60        

;-------------------------------------------------------------------------------
            lda #$30           ; $eade: a9 30     
            sta $05            ; $eae0: 85 05     
            lda $0420,x        ; $eae2: bd 20 04  
            bne __eaeb         ; $eae5: d0 04     
            lda #$20           ; $eae7: a9 20     
            bne __eaed         ; $eae9: d0 02     
__eaeb:     lda #$00           ; $eaeb: a9 00     
__eaed:     jsr __8e21         ; $eaed: 20 21 8e  
            inc $0444,x        ; $eaf0: fe 44 04  
            lda #$40           ; $eaf3: a9 40     
            sta $0456,x        ; $eaf5: 9d 56 04  
            rts                ; $eaf8: 60        

;-------------------------------------------------------------------------------
            dec $0456,x        ; $eaf9: de 56 04  
            bne __eb0b         ; $eafc: d0 0d     
            lda #$00           ; $eafe: a9 00     
            .hex 9d 44         ; $eb00: 9d 44     Suspected data
__eb02:     .hex 04 9d         ; $eb02: 04 9d     Invalid Opcode - NOP $9d
            lsr $04,x          ; $eb04: 56 04     
            lda #$be           ; $eb06: a9 be     
            sta $0300,x        ; $eb08: 9d 00 03  
__eb0b:     rts                ; $eb0b: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $eb0c: bd d8 03  
            bne __eb19         ; $eb0f: d0 08     
            jsr __deca         ; $eb11: 20 ca de  
            lda #$24           ; $eb14: a9 24     
            jsr __ded8         ; $eb16: 20 d8 de  
__eb19:     lda $0444,x        ; $eb19: bd 44 04  
            jsr __c5bb         ; $eb1c: 20 bb c5  
            .hex 2b ab         ; $eb1f: 2b ab     Invalid Opcode - ANC #$ab
            eor $ab            ; $eb21: 45 ab     
            .hex 7f ab b4      ; $eb23: 7f ab b4  Invalid Opcode - RRA __b4ab,x
            .hex ab f1         ; $eb26: ab f1     Invalid Opcode - LAX #$f1
            .hex ab 18         ; $eb28: ab 18     Invalid Opcode - LAX #$18
            ldy $30a9          ; $eb2a: ac a9 30  
            sta $0324,x        ; $eb2d: 9d 24 03  
            inc $0444,x        ; $eb30: fe 44 04  
            lda #$40           ; $eb33: a9 40     
            jsr __de6f         ; $eb35: 20 6f de  
            lda #$ff           ; $eb38: a9 ff     
            ldy #$80           ; $eb3a: a0 80     
            jsr __e076         ; $eb3c: 20 76 e0  
            lda #$20           ; $eb3f: a9 20     
            sta $0456,x        ; $eb41: 9d 56 04  
            rts                ; $eb44: 60        

;-------------------------------------------------------------------------------
            dec $0456,x        ; $eb45: de 56 04  
            bne __eb53         ; $eb48: d0 09     
            jsr __e03b         ; $eb4a: 20 3b e0  
            lda #$20           ; $eb4d: a9 20     
            sta $0456,x        ; $eb4f: 9d 56 04  
            rts                ; $eb52: 60        

;-------------------------------------------------------------------------------
__eb53:     lda $0456,x        ; $eb53: bd 56 04  
            and #$03           ; $eb56: 29 03     
            beq __eb5d         ; $eb58: f0 03     
            jsr __dd2a         ; $eb5a: 20 2a dd  
__eb5d:     jsr __e0f4         ; $eb5d: 20 f4 e0  
            lda $0348,x        ; $eb60: bd 48 03  
            sec                ; $eb63: 38        
            sbc $0348          ; $eb64: ed 48 03  
            bcs __eb6c         ; $eb67: b0 03     
            jsr __deb7         ; $eb69: 20 b7 de  
__eb6c:     cmp #$40           ; $eb6c: c9 40     
            bcc __eb71         ; $eb6e: 90 01     
            rts                ; $eb70: 60        

;-------------------------------------------------------------------------------
__eb71:     lda #$02           ; $eb71: a9 02     
            sta $0444,x        ; $eb73: 9d 44 04  
            jsr __df82         ; $eb76: 20 82 df  
            lda #$00           ; $eb79: a9 00     
            sta $0456,x        ; $eb7b: 9d 56 04  
            rts                ; $eb7e: 60        

;-------------------------------------------------------------------------------
            inc $0456,x        ; $eb7f: fe 56 04  
            lda $0456,x        ; $eb82: bd 56 04  
            cmp #$50           ; $eb85: c9 50     
            beq __eb96         ; $eb87: f0 0d     
            lda $0456,x        ; $eb89: bd 56 04  
            and #$03           ; $eb8c: 29 03     
            beq __eb93         ; $eb8e: f0 03     
            jsr __dd2a         ; $eb90: 20 2a dd  
__eb93:     jmp __e010         ; $eb93: 4c 10 e0  

;-------------------------------------------------------------------------------
__eb96:     lda $0468,x        ; $eb96: bd 68 04  
            bne __ebd6         ; $eb99: d0 3b     
            inc $0444,x        ; $eb9b: fe 44 04  
            jsr __e010         ; $eb9e: 20 10 e0  
            lda #$02           ; $eba1: a9 02     
            ldy #$00           ; $eba3: a0 00     
            jsr __e04f         ; $eba5: 20 4f e0  
            lda #$05           ; $eba8: a9 05     
            ldy #$80           ; $ebaa: a0 80     
            jsr __e076         ; $ebac: 20 76 e0  
            lda #$91           ; $ebaf: a9 91     
            .hex 9d            ; $ebb1: 9d        Suspected data
__ebb2:     brk                ; $ebb2: 00        
            .hex 03 a9         ; $ebb3: 03 a9     Invalid Opcode - SLO ($a9,x)
            jsr $0885          ; $ebb5: 20 85 08  
            jsr __dffa         ; $ebb8: 20 fa df  
            lda $036c,x        ; $ebbb: bd 6c 03  
            beq __ebce         ; $ebbe: f0 0e     
            lda $0324          ; $ebc0: ad 24 03  
            sec                ; $ebc3: 38        
            sbc #$30           ; $ebc4: e9 30     
            cmp $0324,x        ; $ebc6: dd 24 03  
            bcc __ebce         ; $ebc9: 90 03     
            jmp __e0f4         ; $ebcb: 4c f4 e0  

;-------------------------------------------------------------------------------
__ebce:     lda #$01           ; $ebce: a9 01     
            sta $0468,x        ; $ebd0: 9d 68 04  
            jmp __ab71         ; $ebd3: 4c 71 ab  

;-------------------------------------------------------------------------------
__ebd6:     lda #$04           ; $ebd6: a9 04     
            sta $0444,x        ; $ebd8: 9d 44 04  
            jsr __e010         ; $ebdb: 20 10 e0  
            lda #$03           ; $ebde: a9 03     
            ldy #$00           ; $ebe0: a0 00     
            jsr __e04f         ; $ebe2: 20 4f e0  
            lda #$03           ; $ebe5: a9 03     
            ldy #$00           ; $ebe7: a0 00     
            jsr __e076         ; $ebe9: 20 76 e0  
__ebec:     lda #$91           ; $ebec: a9 91     
            .hex 9d 00         ; $ebee: 9d 00     Suspected data
__ebf0:     .hex 03 a9         ; $ebf0: 03 a9     Invalid Opcode - SLO ($a9,x)
            ora $85,x          ; $ebf2: 15 85     
            php                ; $ebf4: 08        
            jsr __dffa         ; $ebf5: 20 fa df  
            lda $036c,x        ; $ebf8: bd 6c 03  
            beq __ec08         ; $ebfb: f0 0b     
            .hex ad 24         ; $ebfd: ad 24     Suspected data
__ebff:     .hex 03            ; $ebff: 03        Suspected data
__ec00:     cmp $0324,x        ; $ec00: dd 24 03  
            bcc __ec08         ; $ec03: 90 03     
            jmp __e0f4         ; $ec05: 4c f4 e0  

;-------------------------------------------------------------------------------
__ec08:     jsr __e010         ; $ec08: 20 10 e0  
            lda #$03           ; $ec0b: a9 03     
            ldy #$00           ; $ec0d: a0 00     
            jsr __e04f         ; $ec0f: 20 4f e0  
            jsr __df8a         ; $ec12: 20 8a df  
            inc $0444,x        ; $ec15: fe 44 04  
            jsr __dd2a         ; $ec18: 20 2a dd  
            jmp __e0f4         ; $ec1b: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ec1e: bd d8 03  
            bne __ec29         ; $ec21: d0 06     
            lda #$01           ; $ec23: a9 01     
            sta $03d8,x        ; $ec25: 9d d8 03  
            rts                ; $ec28: 60        

;-------------------------------------------------------------------------------
__ec29:     jsr __dd2a         ; $ec29: 20 2a dd  
            lda $0444,x        ; $ec2c: bd 44 04  
            jsr __c5bb         ; $ec2f: 20 bb c5  
            .hex 3c ac 4e      ; $ec32: 3c ac 4e  Invalid Opcode - NOP $4eac,x
            ldy __ac72         ; $ec35: ac 72 ac  
            .hex b3 ac         ; $ec38: b3 ac     Invalid Opcode - LAX ($ac),y
            .hex 04 ad         ; $ec3a: 04 ad     Invalid Opcode - NOP $ad
            inc $0444,x        ; $ec3c: fe 44 04  
            lda #$27           ; $ec3f: a9 27     
            jsr __dd8b         ; $ec41: 20 8b dd  
            lda #$30           ; $ec44: a9 30     
            sta $0324,x        ; $ec46: 9d 24 03  
            lda #$80           ; $ec49: a9 80     
            jmp __de6f         ; $ec4b: 4c 6f de  

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $ec4e: 20 f4 e0  
            lda $0348          ; $ec51: ad 48 03  
            sec                ; $ec54: 38        
            sbc $0348,x        ; $ec55: fd 48 03  
            bcs __ec5d         ; $ec58: b0 03     
            jsr __deb7         ; $ec5a: 20 b7 de  
__ec5d:     cmp #$40           ; $ec5d: c9 40     
            beq __ec64         ; $ec5f: f0 03     
            bcc __ec64         ; $ec61: 90 01     
            rts                ; $ec63: 60        

;-------------------------------------------------------------------------------
__ec64:     inc $0444,x        ; $ec64: fe 44 04  
            lda #$40           ; $ec67: a9 40     
            jsr __de6f         ; $ec69: 20 6f de  
            lda #$03           ; $ec6c: a9 03     
            sta $036c,x        ; $ec6e: 9d 6c 03  
            rts                ; $ec71: 60        

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $ec72: 20 f4 e0  
            lda #$08           ; $ec75: a9 08     
            sta $08            ; $ec77: 85 08     
            jsr __dffa         ; $ec79: 20 fa df  
            jsr __de8b         ; $ec7c: 20 8b de  
            lda #$06           ; $ec7f: a9 06     
            ldy #$10           ; $ec81: a0 10     
            jsr __e2a2         ; $ec83: 20 a2 e2  
            bcc __ec9e         ; $ec86: 90 16     
            lda $0420,x        ; $ec88: bd 20 04  
            bne __ec91         ; $ec8b: d0 04     
            lda #$fa           ; $ec8d: a9 fa     
            bne __ec93         ; $ec8f: d0 02     
__ec91:     lda #$06           ; $ec91: a9 06     
__ec93:     ldy #$10           ; $ec93: a0 10     
            jsr __e2a2         ; $ec95: 20 a2 e2  
            bcs __ec9d         ; $ec98: b0 03     
            jsr __e01f         ; $ec9a: 20 1f e0  
__ec9d:     rts                ; $ec9d: 60        

;-------------------------------------------------------------------------------
__ec9e:     jsr __de62         ; $ec9e: 20 62 de  
            lda #$28           ; $eca1: a9 28     
            jsr __dd8b         ; $eca3: 20 8b dd  
            lda #$03           ; $eca6: a9 03     
            sta $0444,x        ; $eca8: 9d 44 04  
            jsr __df82         ; $ecab: 20 82 df  
            lda #$c0           ; $ecae: a9 c0     
            jmp __de6f         ; $ecb0: 4c 6f de  

;-------------------------------------------------------------------------------
            lda $2e            ; $ecb3: a5 2e     
            and #$3f           ; $ecb5: 29 3f     
            beq __ecc2         ; $ecb7: f0 09     
            jsr __de8b         ; $ecb9: 20 8b de  
            jsr __dea1         ; $ecbc: 20 a1 de  
            jmp __e0f4         ; $ecbf: 4c f4 e0  

;-------------------------------------------------------------------------------
__ecc2:     lda $0348,x        ; $ecc2: bd 48 03  
            cmp $0348          ; $ecc5: cd 48 03  
            bcc __ecd2         ; $ecc8: 90 08     
            lda #$20           ; $ecca: a9 20     
            sta $048c,x        ; $eccc: 9d 8c 04  
            jmp __acd7         ; $eccf: 4c d7 ac  

;-------------------------------------------------------------------------------
__ecd2:     lda #$00           ; $ecd2: a9 00     
            sta $048c,x        ; $ecd4: 9d 8c 04  
            lda #$31           ; $ecd7: a9 31     
            sta $05            ; $ecd9: 85 05     
            lda $03c6,x        ; $ecdb: bd c6 03  
            bne __ece6         ; $ecde: d0 06     
            lda $048c,x        ; $ece0: bd 8c 04  
            jsr __8e21         ; $ece3: 20 21 8e  
__ece6:     lda #$04           ; $ece6: a9 04     
            sta $047a,x        ; $ece8: 9d 7a 04  
            jsr __e010         ; $eceb: 20 10 e0  
            lda #$01           ; $ecee: a9 01     
            ldy #$80           ; $ecf0: a0 80     
            jsr __e04f         ; $ecf2: 20 4f e0  
            lda #$fe           ; $ecf5: a9 fe     
            sta $036c,x        ; $ecf7: 9d 6c 03  
            lda #$04           ; $ecfa: a9 04     
            sta $0444,x        ; $ecfc: 9d 44 04  
__ecff:     .hex a9            ; $ecff: a9        Suspected data
__ed00:     .hex 27 20         ; $ed00: 27 20     Invalid Opcode - RLA $20
            .hex 8b dd         ; $ed02: 8b dd     Invalid Opcode - XAA #$dd
            lda $0324,x        ; $ed04: bd 24 03  
            cmp #$20           ; $ed07: c9 20     
            bcs __ed0e         ; $ed09: b0 03     
            jsr __df42         ; $ed0b: 20 42 df  
__ed0e:     jmp __e0f4         ; $ed0e: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ed11: bd d8 03  
            bne __ed23         ; $ed14: d0 0d     
            lda #$60           ; $ed16: a9 60     
            jsr __de6f         ; $ed18: 20 6f de  
            jsr __deca         ; $ed1b: 20 ca de  
            lda #$35           ; $ed1e: a9 35     
            jsr __ded8         ; $ed20: 20 d8 de  
__ed23:     jsr __dd2a         ; $ed23: 20 2a dd  
            jsr __ad8d         ; $ed26: 20 8d ad  
            lda $0444,x        ; $ed29: bd 44 04  
            jsr __c5bb         ; $ed2c: 20 bb c5  
            .hex 37 ad         ; $ed2f: 37 ad     Invalid Opcode - RLA $ad,x
            .hex 47 ad         ; $ed31: 47 ad     Invalid Opcode - SRE $ad
            ror $ad            ; $ed33: 66 ad     
            ror __a9ad,x       ; $ed35: 7e ad a9  
            ora ($9d,x)        ; $ed38: 01 9d     
            .hex 44 04         ; $ed3a: 44 04     Invalid Opcode - NOP $04
            lda #$60           ; $ed3c: a9 60     
            jsr __de6f         ; $ed3e: 20 6f de  
            lda #$30           ; $ed41: a9 30     
            sta $0456,x        ; $ed43: 9d 56 04  
            rts                ; $ed46: 60        

;-------------------------------------------------------------------------------
            lda $0456,x        ; $ed47: bd 56 04  
            beq __ed50         ; $ed4a: f0 04     
            dec $0456,x        ; $ed4c: de 56 04  
            rts                ; $ed4f: 60        

;-------------------------------------------------------------------------------
__ed50:     lda $2e            ; $ed50: a5 2e     
            and #$01           ; $ed52: 29 01     
            bne __ed59         ; $ed54: d0 03     
            jmp __ad8a         ; $ed56: 4c 8a ad  

;-------------------------------------------------------------------------------
__ed59:     lda #$02           ; $ed59: a9 02     
            sta $0444,x        ; $ed5b: 9d 44 04  
            lda #$30           ; $ed5e: a9 30     
            sta $0456,x        ; $ed60: 9d 56 04  
            jsr __e01f         ; $ed63: 20 1f e0  
            lda $0456,x        ; $ed66: bd 56 04  
            beq __ed6f         ; $ed69: f0 04     
            dec $0456,x        ; $ed6b: de 56 04  
            rts                ; $ed6e: 60        

;-------------------------------------------------------------------------------
__ed6f:     lda #$03           ; $ed6f: a9 03     
            sta $0444,x        ; $ed71: 9d 44 04  
            lda #$30           ; $ed74: a9 30     
            sta $0468,x        ; $ed76: 9d 68 04  
            lda #$f0           ; $ed79: a9 f0     
            jsr __de6f         ; $ed7b: 20 6f de  
            jsr __dd2a         ; $ed7e: 20 2a dd  
            lda $0468,x        ; $ed81: bd 68 04  
            beq __ed8a         ; $ed84: f0 04     
            dec $0468,x        ; $ed86: de 68 04  
            rts                ; $ed89: 60        

;-------------------------------------------------------------------------------
__ed8a:     jmp __df7f         ; $ed8a: 4c 7f df  

;-------------------------------------------------------------------------------
            jsr __de8b         ; $ed8d: 20 8b de  
            jsr __dea1         ; $ed90: 20 a1 de  
            jmp __e0f4         ; $ed93: 4c f4 e0  

;-------------------------------------------------------------------------------
            ldy #$00           ; $ed96: a0 00     
            ldx #$00           ; $ed98: a2 00     
            lda $50            ; $ed9a: a5 50     
            cmp #$03           ; $ed9c: c9 03     
            bne __edae         ; $ed9e: d0 0e     
            lda $51            ; $eda0: a5 51     
            and #$7f           ; $eda2: 29 7f     
            cmp #$03           ; $eda4: c9 03     
            bne __edae         ; $eda6: d0 06     
            iny                ; $eda8: c8        
            lda $57            ; $eda9: a5 57     
            bne __edae         ; $edab: d0 01     
            inx                ; $edad: e8        
__edae:     sty $0194          ; $edae: 8c 94 01  
            stx $4b            ; $edb1: 86 4b     
            rts                ; $edb3: 60        

;-------------------------------------------------------------------------------
            jsr __ade7         ; $edb4: 20 e7 ad  
            lda $0195          ; $edb7: ad 95 01  
            beq __ede6         ; $edba: f0 2a     
            lda $4f            ; $edbc: a5 4f     
            cmp #$06           ; $edbe: c9 06     
            bne __ede6         ; $edc0: d0 24     
            lda $91            ; $edc2: a5 91     
            and #$60           ; $edc4: 29 60     
            cmp #$40           ; $edc6: c9 40     
            bcc __ede6         ; $edc8: 90 1c     
            lda $03d8          ; $edca: ad d8 03  
            cmp #$03           ; $edcd: c9 03     
            bne __ede6         ; $edcf: d0 15     
            dec $04ea          ; $edd1: ce ea 04  
            bne __ede6         ; $edd4: d0 10     
            lda #$01           ; $edd6: a9 01     
            sta $56            ; $edd8: 85 56     
            lda #$00           ; $edda: a9 00     
            sta $0195          ; $eddc: 8d 95 01  
            sta $4b            ; $eddf: 85 4b     
            lda #$2b           ; $ede1: a9 2b     
            jsr __c118         ; $ede3: 20 18 c1  
__ede6:     rts                ; $ede6: 60        

;-------------------------------------------------------------------------------
            ldy #$00           ; $ede7: a0 00     
            lda $0194          ; $ede9: ad 94 01  
            beq __edf5         ; $edec: f0 07     
            lda $56            ; $edee: a5 56     
            ora $57            ; $edf0: 05 57     
            bne __edf5         ; $edf2: d0 01     
            iny                ; $edf4: c8        
__edf5:     sty $0195          ; $edf5: 8c 95 01  
            rts                ; $edf8: 60        

;-------------------------------------------------------------------------------
            asl $af,x          ; $edf9: 16 af     
            .hex 1a            ; $edfb: 1a        Invalid Opcode - NOP 
            .hex af 1c af      ; $edfc: af 1c af  Invalid Opcode - LAX __af1c
            ora ($b2),y        ; $edff: 11 b2     
            jsr __a9af         ; $ee01: 20 af a9  
            .hex 0f 85 7f      ; $ee04: 0f 85 7f  Invalid Opcode - SLO $7f85
            .hex a5            ; $ee07: a5        Suspected data
__ee08:     .hex 92            ; $ee08: 92        Invalid Opcode - KIL 
            ora #$01           ; $ee09: 09 01     
            sta $92            ; $ee0b: 85 92     
            lda #$22           ; $ee0d: a9 22     
            jmp __c118         ; $ee0f: 4c 18 c1  

;-------------------------------------------------------------------------------
            lda $4a            ; $ee12: a5 4a     
            ora #$02           ; $ee14: 09 02     
            sta $4a            ; $ee16: 85 4a     
            lda #$10           ; $ee18: a9 10     
            sta $7f            ; $ee1a: 85 7f     
            lda #$22           ; $ee1c: a9 22     
            jmp __c118         ; $ee1e: 4c 18 c1  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ee21: bd d8 03  
            bne __ee2e         ; $ee24: d0 08     
            jsr __dec2         ; $ee26: 20 c2 de  
            lda #$38           ; $ee29: a9 38     
            jsr __ded8         ; $ee2b: 20 d8 de  
__ee2e:     jsr __dd2a         ; $ee2e: 20 2a dd  
            lda $0444,x        ; $ee31: bd 44 04  
            bne __ee5c         ; $ee34: d0 26     
            lda $0348,x        ; $ee36: bd 48 03  
            sec                ; $ee39: 38        
            sbc $0348          ; $ee3a: ed 48 03  
            bcs __ee42         ; $ee3d: b0 03     
            jsr __deb7         ; $ee3f: 20 b7 de  
__ee42:     cmp #$50           ; $ee42: c9 50     
            bcc __ee47         ; $ee44: 90 01     
            rts                ; $ee46: 60        

;-------------------------------------------------------------------------------
__ee47:     lda #$fa           ; $ee47: a9 fa     
            sta $036c,x        ; $ee49: 9d 6c 03  
            inc $0444,x        ; $ee4c: fe 44 04  
            jsr __dec6         ; $ee4f: 20 c6 de  
            lda #$40           ; $ee52: a9 40     
            jsr __de6f         ; $ee54: 20 6f de  
            lda #$1d           ; $ee57: a9 1d     
            jmp __c118         ; $ee59: 4c 18 c1  

;-------------------------------------------------------------------------------
__ee5c:     lda #$20           ; $ee5c: a9 20     
            sta $08            ; $ee5e: 85 08     
            jsr __dfe4         ; $ee60: 20 e4 df  
            jmp __e0f4         ; $ee63: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ee66: bd d8 03  
            bne __ee7f         ; $ee69: d0 14     
            jsr __deca         ; $ee6b: 20 ca de  
            lda #$20           ; $ee6e: a9 20     
            sta $0444,x        ; $ee70: 9d 44 04  
            lda #$00           ; $ee73: a9 00     
            ldy #$30           ; $ee75: a0 30     
            jsr __e076         ; $ee77: 20 76 e0  
            lda #$17           ; $ee7a: a9 17     
            jmp __ded8         ; $ee7c: 4c d8 de  

;-------------------------------------------------------------------------------
__ee7f:     jsr __dd2a         ; $ee7f: 20 2a dd  
            jsr __e010         ; $ee82: 20 10 e0  
            dec $0444,x        ; $ee85: de 44 04  
            bne __ee92         ; $ee88: d0 08     
            lda #$20           ; $ee8a: a9 20     
            sta $0444,x        ; $ee8c: 9d 44 04  
            jmp __e03b         ; $ee8f: 4c 3b e0  

;-------------------------------------------------------------------------------
__ee92:     jmp __e0f4         ; $ee92: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $ee95: bd d8 03  
            bne __ee9d         ; $ee98: d0 03     
            jmp __deca         ; $ee9a: 4c ca de  

;-------------------------------------------------------------------------------
__ee9d:     ldy $0444,x        ; $ee9d: bc 44 04  
            beq __eea9         ; $eea0: f0 07     
            dey                ; $eea2: 88        
            beq __eece         ; $eea3: f0 29     
            dey                ; $eea5: 88        
            beq __eeec         ; $eea6: f0 44     
            rts                ; $eea8: 60        

;-------------------------------------------------------------------------------
__eea9:     lda $1d            ; $eea9: a5 1d     
            and #$07           ; $eeab: 29 07     
            bne __eecb         ; $eead: d0 1c     
            ldy $0456,x        ; $eeaf: bc 56 04  
            lda __af12,y       ; $eeb2: b9 12 af  
            sta $0300,x        ; $eeb5: 9d 00 03  
            inc $0456,x        ; $eeb8: fe 56 04  
            lda $0456,x        ; $eebb: bd 56 04  
            cmp #$04           ; $eebe: c9 04     
            bne __eecb         ; $eec0: d0 09     
            dec $0456,x        ; $eec2: de 56 04  
            inc $0444,x        ; $eec5: fe 44 04  
            jmp __deca         ; $eec8: 4c ca de  

;-------------------------------------------------------------------------------
__eecb:     jmp __dec2         ; $eecb: 4c c2 de  

;-------------------------------------------------------------------------------
__eece:     jsr __e010         ; $eece: 20 10 e0  
            lda $03c6,x        ; $eed1: bd c6 03  
            bne __eee8         ; $eed4: d0 12     
            lda #$30           ; $eed6: a9 30     
            sta $05            ; $eed8: 85 05     
            lda $0420,x        ; $eeda: bd 20 04  
            bne __eee3         ; $eedd: d0 04     
            lda #$20           ; $eedf: a9 20     
            bne __eee5         ; $eee1: d0 02     
__eee3:     lda #$00           ; $eee3: a9 00     
__eee5:     jsr __8e21         ; $eee5: 20 21 8e  
__eee8:     inc $0444,x        ; $eee8: fe 44 04  
            rts                ; $eeeb: 60        

;-------------------------------------------------------------------------------
__eeec:     lda $0468,x        ; $eeec: bd 68 04  
            cmp #$30           ; $eeef: c9 30     
            bne __ef0e         ; $eef1: d0 1b     
            lda $1d            ; $eef3: a5 1d     
            and #$07           ; $eef5: 29 07     
            bne __ef0d         ; $eef7: d0 14     
            ldy $0456,x        ; $eef9: bc 56 04  
            lda __af12,y       ; $eefc: b9 12 af  
            sta $0300,x        ; $eeff: 9d 00 03  
            dec $0456,x        ; $ef02: de 56 04  
            lda $0456,x        ; $ef05: bd 56 04  
            bpl __ef0d         ; $ef08: 10 03     
            jsr __dfa3         ; $ef0a: 20 a3 df  
__ef0d:     rts                ; $ef0d: 60        

;-------------------------------------------------------------------------------
__ef0e:     inc $0468,x        ; $ef0e: fe 68 04  
            rts                ; $ef11: 60        

;-------------------------------------------------------------------------------
            brk                ; $ef12: 00        
            cpy #$c1           ; $ef13: c0 c1     
            .hex c2 22         ; $ef15: c2 22     Invalid Opcode - NOP #$22
            .hex af 4b af      ; $ef17: af 4b af  Invalid Opcode - LAX __af4b
            sei                ; $ef1a: 78        
            .hex af b1 af      ; $ef1b: af b1 af  Invalid Opcode - LAX __afb1
            dec __e3af         ; $ef1e: ce af e3  
            .hex af 04 0c      ; $ef21: af 04 0c  Invalid Opcode - LAX $0c04
            .hex 9e 06 08      ; $ef24: 9e 06 08  Invalid Opcode - SHX $0806,y
            .hex 0b 38         ; $ef27: 0b 38     Invalid Opcode - ANC #$38
            php                ; $ef29: 08        
            .hex 0c 0b 38      ; $ef2a: 0c 0b 38  Invalid Opcode - NOP $380b
            php                ; $ef2d: 08        
            ora $430d          ; $ef2e: 0d 0d 43  
            brk                ; $ef31: 00        
            bit $0d            ; $ef32: 24 0d     
            eor ($08,x)        ; $ef34: 41 08     
            plp                ; $ef36: 28        
            .hex 0b 41         ; $ef37: 0b 41     Invalid Opcode - ANC #$41
            php                ; $ef39: 08        
            .hex 33 0d         ; $ef3a: 33 0d     Invalid Opcode - RLA ($0d),y
            .hex 43 00         ; $ef3c: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 34 0b         ; $ef3e: 34 0b     Invalid Opcode - NOP $0b,x
            sec                ; $ef40: 38        
            php                ; $ef41: 08        
            sec                ; $ef42: 38        
            .hex 0b 38         ; $ef43: 0b 38     Invalid Opcode - ANC #$38
            php                ; $ef45: 08        
            .hex 3c 0b 38      ; $ef46: 3c 0b 38  Invalid Opcode - NOP $380b,x
            php                ; $ef49: 08        
            .hex ff 04 0c      ; $ef4a: ff 04 0c  Invalid Opcode - ISC $0c04,x
            .hex 03 0f         ; $ef4d: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 0c 0d 40      ; $ef4f: 0c 0d 40  Invalid Opcode - NOP $400d
            .hex 0f 0a 0d      ; $ef52: 0f 0a 0d  Invalid Opcode - SLO $0d0a
            .hex 43 00         ; $ef55: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 14 0c         ; $ef57: 14 0c     Invalid Opcode - NOP $0c,x
            clc                ; $ef59: 18        
            .hex 0f 18 0d      ; $ef5a: 0f 18 0d  Invalid Opcode - SLO $0d18
            .hex 43 00         ; $ef5d: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 1c 0d 40      ; $ef5f: 1c 0d 40  Invalid Opcode - NOP $400d,x
            .hex 0f 24 0d      ; $ef62: 0f 24 0d  Invalid Opcode - SLO $0d24
            rti                ; $ef65: 40        

;-------------------------------------------------------------------------------
            .hex 0f 28 0d      ; $ef66: 0f 28 0d  Invalid Opcode - SLO $0d28
            .hex 43 00         ; $ef69: 43 00     Invalid Opcode - SRE ($00,x)
            bit $180c          ; $ef6b: 2c 0c 18  
            .hex 0f 34 0d      ; $ef6e: 0f 34 0d  Invalid Opcode - SLO $0d34
            rti                ; $ef71: 40        

;-------------------------------------------------------------------------------
            .hex 0f 38 0d      ; $ef72: 0f 38 0d  Invalid Opcode - SLO $0d38
            .hex 43 00         ; $ef75: 43 00     Invalid Opcode - SRE ($00,x)
            .hex ff 04 0c      ; $ef77: ff 04 0c  Invalid Opcode - ISC $0c04,x
            .hex 9e 02 0a      ; $ef7a: 9e 02 0a  Invalid Opcode - SHX $0a02,y
            .hex 0b 38         ; $ef7d: 0b 38     Invalid Opcode - ANC #$38
            php                ; $ef7f: 08        
            .hex 0c 0b 38      ; $ef80: 0c 0b 38  Invalid Opcode - NOP $380b
            php                ; $ef83: 08        
            ora $430d          ; $ef84: 0d 0d 43  
            brk                ; $ef87: 00        
            .hex 14 09         ; $ef88: 14 09     Invalid Opcode - NOP $09,x
            eor ($08,x)        ; $ef8a: 41 08     
            clc                ; $ef8c: 18        
            ora #$03           ; $ef8d: 09 03     
            php                ; $ef8f: 08        
            .hex 1c 0a 41      ; $ef90: 1c 0a 41  Invalid Opcode - NOP $410a,x
            php                ; $ef93: 08        
            bit $0b            ; $ef94: 24 0b     
            .hex 03 08         ; $ef96: 03 08     Invalid Opcode - SLO ($08,x)
            plp                ; $ef98: 28        
            .hex 0c 4a 08      ; $ef99: 0c 4a 08  Invalid Opcode - NOP $084a
            bit $4a0c          ; $ef9c: 2c 0c 4a  
            php                ; $ef9f: 08        
            .hex 33 0d         ; $efa0: 33 0d     Invalid Opcode - RLA ($0d),y
            .hex 43 00         ; $efa2: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 34 0b         ; $efa4: 34 0b     Invalid Opcode - NOP $0b,x
            sec                ; $efa6: 38        
            php                ; $efa7: 08        
            sec                ; $efa8: 38        
            .hex 0b 38         ; $efa9: 0b 38     Invalid Opcode - ANC #$38
            php                ; $efab: 08        
            .hex 3c 0b 38      ; $efac: 3c 0b 38  Invalid Opcode - NOP $380b,x
            php                ; $efaf: 08        
            .hex ff 04 0a      ; $efb0: ff 04 0a  Invalid Opcode - ISC $0a04,x
            .hex 03 04         ; $efb3: 03 04     Invalid Opcode - SLO ($04,x)
            php                ; $efb5: 08        
            .hex 0c 16 04      ; $efb6: 0c 16 04  Invalid Opcode - NOP $0416
            php                ; $efb9: 08        
            .hex 1b 43 00      ; $efba: 1b 43 00  Invalid Opcode - SLO $0043,y
            .hex 0c 0c 03      ; $efbd: 0c 0c 03  Invalid Opcode - NOP $030c
            .hex 04 14         ; $efc0: 04 14     Invalid Opcode - NOP $14
            .hex 0c 16 04      ; $efc2: 0c 16 04  Invalid Opcode - NOP $0416
            clc                ; $efc5: 18        
            asl                ; $efc6: 0a        
            asl $04,x          ; $efc7: 16 04     
            .hex 1c 0a 03      ; $efc9: 1c 0a 03  Invalid Opcode - NOP $030a,x
            .hex 04 ff         ; $efcc: 04 ff     Invalid Opcode - NOP $ff
            .hex 04 08         ; $efce: 04 08     Invalid Opcode - NOP $08
            .hex 03 04         ; $efd0: 03 04     Invalid Opcode - SLO ($04,x)
            php                ; $efd2: 08        
            .hex 0c 4a 04      ; $efd3: 0c 4a 04  Invalid Opcode - NOP $044a
            .hex 0c 0c 4a      ; $efd6: 0c 0c 4a  Invalid Opcode - NOP $4a0c
            .hex 04 14         ; $efd9: 04 14     Invalid Opcode - NOP $14
            .hex 0c 41 04      ; $efdb: 0c 41 04  Invalid Opcode - NOP $0441
            clc                ; $efde: 18        
            .hex 0c 41 04      ; $efdf: 0c 41 04  Invalid Opcode - NOP $0441
            .hex ff            ; $efe2: ff        Suspected data
__efe3:     php                ; $efe3: 08        
            .hex 0c            ; $efe4: 0c        Suspected data
__efe5:     eor ($02,x)        ; $efe5: 41 02     
            .hex 0c 0c 41      ; $efe7: 0c 0c 41  Invalid Opcode - NOP $410c
            .hex 02            ; $efea: 02        Invalid Opcode - KIL 
            .hex 14 0c         ; $efeb: 14 0c     Invalid Opcode - NOP $0c,x
            eor ($02,x)        ; $efed: 41 02     
            .hex 1a            ; $efef: 1a        Invalid Opcode - NOP 
            asl                ; $eff0: 0a        
            eor ($02,x)        ; $eff1: 41 02     
            .hex ff bd d8      ; $eff3: ff bd d8  Invalid Opcode - ISC __d8bd,x
            .hex 03 d0         ; $eff6: 03 d0     Invalid Opcode - SLO ($d0,x)
            rol $1086,x        ; $eff8: 3e 86 10  
            lda #$01           ; $effb: a9 01     
            sta $03d8,x        ; $effd: 9d d8 03  
__f000:     lda #$56           ; $f000: a9 56     
__f002:     sta $0300,x        ; $f002: 9d 00 03  
            lda #$30           ; $f005: a9 30     
            sta $0456,x        ; $f007: 9d 56 04  
            lda #$20           ; $f00a: a9 20     
            jsr __de6f         ; $f00c: 20 6f de  
            jsr __dfb3         ; $f00f: 20 b3 df  
            bcs __f034         ; $f012: b0 20     
            lda #$19           ; $f014: a9 19     
            sta $03b4,x        ; $f016: 9d b4 03  
            ldy $10            ; $f019: a4 10     
            lda $0348,y        ; $f01b: b9 48 03  
            sta $0348,x        ; $f01e: 9d 48 03  
            lda $0324,y        ; $f021: b9 24 03  
            clc                ; $f024: 18        
            adc #$10           ; $f025: 69 10     
            sta $0324,x        ; $f027: 9d 24 03  
            lda $03c6,y        ; $f02a: b9 c6 03  
            sta $03c6,x        ; $f02d: 9d c6 03  
            tya                ; $f030: 98        
            sta $0444,x        ; $f031: 9d 44 04  
__f034:     ldx $10            ; $f034: a6 10     
            rts                ; $f036: 60        

;-------------------------------------------------------------------------------
            jsr __e010         ; $f037: 20 10 e0  
            inc $04d4,x        ; $f03a: fe d4 04  
            lda $04d4,x        ; $f03d: bd d4 04  
            cmp #$60           ; $f040: c9 60     
            bne __f060         ; $f042: d0 1c     
            lda #$00           ; $f044: a9 00     
            sta $04d4,x        ; $f046: 9d d4 04  
            lda $03c6,x        ; $f049: bd c6 03  
            bne __f060         ; $f04c: d0 12     
            lda #$30           ; $f04e: a9 30     
__f050:     sta $05            ; $f050: 85 05     
            lda $0420,x        ; $f052: bd 20 04  
            bne __f05b         ; $f055: d0 04     
            lda #$20           ; $f057: a9 20     
            bne __f05d         ; $f059: d0 02     
__f05b:     lda #$00           ; $f05b: a9 00     
__f05d:     jmp __8e21         ; $f05d: 4c 21 8e  

;-------------------------------------------------------------------------------
__f060:     dec $0456,x        ; $f060: de 56 04  
            bne __f06d         ; $f063: d0 08     
            lda #$30           ; $f065: a9 30     
            sta $0456,x        ; $f067: 9d 56 04  
            jmp __e027         ; $f06a: 4c 27 e0  

;-------------------------------------------------------------------------------
__f06d:     jmp __e0f4         ; $f06d: 4c f4 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f070: bd d8 03  
            bne __f07f         ; $f073: d0 0a     
            lda #$80           ; $f075: a9 80     
            sta $03d8,x        ; $f077: 9d d8 03  
            lda #$3e           ; $f07a: a9 3e     
            jmp __ded8         ; $f07c: 4c d8 de  

;-------------------------------------------------------------------------------
__f07f:     .hex bc 44         ; $f07f: bc 44     Suspected data
__f081:     .hex 04 b9         ; $f081: 04 b9     Invalid Opcode - NOP $b9
            ldy $03,x          ; $f083: b4 03     
            cmp #$36           ; $f085: c9 36     
            beq __f08f         ; $f087: f0 06     
            jsr __e010         ; $f089: 20 10 e0  
            jmp __dd2a         ; $f08c: 4c 2a dd  

;-------------------------------------------------------------------------------
__f08f:     jmp __df42         ; $f08f: 4c 42 df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f092: bd d8 03  
            bne __f09f         ; $f095: d0 08     
__f097:     jsr __deca         ; $f097: 20 ca de  
            lda #$25           ; $f09a: a9 25     
            .hex 4c            ; $f09c: 4c        Suspected data
__f09d:     cld                ; $f09d: d8        
            .hex de            ; $f09e: de        Suspected data
__f09f:     jsr __dd2a         ; $f09f: 20 2a dd  
            lda $0444,x        ; $f0a2: bd 44 04  
            jsr __c5bb         ; $f0a5: 20 bb c5  
            ldx __bbb0         ; $f0a8: ae b0 bb  
            bcs __f09d         ; $f0ab: b0 f0     
__f0ad:     bcs __f0ad         ; $f0ad: b0 fe     
            .hex 44 04         ; $f0af: 44 04     Invalid Opcode - NOP $04
            lda #$40           ; $f0b1: a9 40     
            sta $0456,x        ; $f0b3: 9d 56 04  
            lda #$c0           ; $f0b6: a9 c0     
            jmp __de6f         ; $f0b8: 4c 6f de  

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $f0bb: 20 f4 e0  
            jsr __de8b         ; $f0be: 20 8b de  
            jsr __dea1         ; $f0c1: 20 a1 de  
            lda $0456,x        ; $f0c4: bd 56 04  
            bne __f0da         ; $f0c7: d0 11     
            lda $0348          ; $f0c9: ad 48 03  
            sec                ; $f0cc: 38        
            sbc $0348,x        ; $f0cd: fd 48 03  
            bcs __f0d5         ; $f0d0: b0 03     
            jsr __deb7         ; $f0d2: 20 b7 de  
__f0d5:     cmp #$25           ; $f0d5: c9 25     
            bcc __f0de         ; $f0d7: 90 05     
            rts                ; $f0d9: 60        

;-------------------------------------------------------------------------------
__f0da:     dec $0456,x        ; $f0da: de 56 04  
            rts                ; $f0dd: 60        

;-------------------------------------------------------------------------------
__f0de:     lda #$30           ; $f0de: a9 30     
            sta $0456,x        ; $f0e0: 9d 56 04  
            inc $0444,x        ; $f0e3: fe 44 04  
            lda #$26           ; $f0e6: a9 26     
            jsr __ded8         ; $f0e8: 20 d8 de  
            lda #$f0           ; $f0eb: a9 f0     
__f0ed:     jmp __de6f         ; $f0ed: 4c 6f de  

;-------------------------------------------------------------------------------
            jsr __e0f4         ; $f0f0: 20 f4 e0  
            jsr __de8b         ; $f0f3: 20 8b de  
            lda $0420,x        ; $f0f6: bd 20 04  
            bne __f0ff         ; $f0f9: d0 04     
            lda #$f8           ; $f0fb: a9 f8     
            bne __f101         ; $f0fd: d0 02     
__f0ff:     lda #$08           ; $f0ff: a9 08     
__f101:     ldy #$10           ; $f101: a0 10     
            jsr __e2af         ; $f103: 20 af e2  
__f106:     bcc __f10b         ; $f106: 90 03     
            jsr __e01f         ; $f108: 20 1f e0  
__f10b:     dec $0456,x        ; $f10b: de 56 04  
            bne __f118         ; $f10e: d0 08     
            jsr __dfa8         ; $f110: 20 a8 df  
            lda #$25           ; $f113: a9 25     
            jmp __ded8         ; $f115: 4c d8 de  

;-------------------------------------------------------------------------------
__f118:     rts                ; $f118: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f119: bd d8 03  
            bne __f125         ; $f11c: d0 07     
            lda #$01           ; $f11e: a9 01     
            ldy #$c3           ; $f120: a0 c3     
            jmp __ded0         ; $f122: 4c d0 de  

;-------------------------------------------------------------------------------
__f125:     lda $0444,x        ; $f125: bd 44 04  
            jsr __c5bb         ; $f128: 20 bb c5  
            and ($b1),y        ; $f12b: 31 b1     
            .hex 3f b1 89      ; $f12d: 3f b1 89  Invalid Opcode - RLA __89b1,x
            lda ($fe),y        ; $f130: b1 fe     
            .hex 44 04         ; $f132: 44 04     Invalid Opcode - NOP $04
            lda $2e            ; $f134: a5 2e     
            and #$1f           ; $f136: 29 1f     
            clc                ; $f138: 18        
            adc #$03           ; $f139: 69 03     
            sta $0468,x        ; $f13b: 9d 68 04  
            rts                ; $f13e: 60        

;-------------------------------------------------------------------------------
            lda $0456,x        ; $f13f: bd 56 04  
            cmp $0468,x        ; $f142: dd 68 04  
            beq __f160         ; $f145: f0 19     
            inc $0456,x        ; $f147: fe 56 04  
            lda $0456,x        ; $f14a: bd 56 04  
            and #$03           ; $f14d: 29 03     
            .hex d0            ; $f14f: d0        Suspected data
__f150:     asl                ; $f150: 0a        
            lda $0300,x        ; $f151: bd 00 03  
            cmp #$c4           ; $f154: c9 c4     
            beq __f15c         ; $f156: f0 04     
            inc $0300,x        ; $f158: fe 00 03  
            rts                ; $f15b: 60        

;-------------------------------------------------------------------------------
__f15c:     dec $0300,x        ; $f15c: de 00 03  
            rts                ; $f15f: 60        

;-------------------------------------------------------------------------------
__f160:     lda #$00           ; $f160: a9 00     
            sta $0456,x        ; $f162: 9d 56 04  
            sta $0468,x        ; $f165: 9d 68 04  
            inc $0444,x        ; $f168: fe 44 04  
            lda #$c5           ; $f16b: a9 c5     
            sta $0300,x        ; $f16d: 9d 00 03  
__f170:     lda #$fd           ; $f170: a9 fd     
            sta $036c,x        ; $f172: 9d 6c 03  
            lda $2e            ; $f175: a5 2e     
            and #$3f           ; $f177: 29 3f     
            clc                ; $f179: 18        
            adc #$10           ; $f17a: 69 10     
            sta $0456,x        ; $f17c: 9d 56 04  
            jsr __e010         ; $f17f: 20 10 e0  
            lda #$01           ; $f182: a9 01     
            ldy #$40           ; $f184: a0 40     
            jmp __e04f         ; $f186: 4c 4f e0  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $f189: bd 56 04  
            sta $08            ; $f18c: 85 08     
            .hex 20 e4         ; $f18e: 20 e4     Suspected data
__f190:     .hex df 20 8b      ; $f190: df 20 8b  Invalid Opcode - DCP __8b20,x
            dec $6cbd,x        ; $f193: de bd 6c  
            .hex 03 30         ; $f196: 03 30     Invalid Opcode - SLO ($30,x)
            ora #$a9           ; $f198: 09 a9     
            brk                ; $f19a: 00        
            ldy #$06           ; $f19b: a0 06     
            jsr __e2a2         ; $f19d: 20 a2 e2  
            bcc __f1a5         ; $f1a0: 90 03     
__f1a2:     jmp __e0f4         ; $f1a2: 4c f4 e0  

;-------------------------------------------------------------------------------
__f1a5:     lda #$c3           ; $f1a5: a9 c3     
            sta $0300,x        ; $f1a7: 9d 00 03  
            jsr __de62         ; $f1aa: 20 62 de  
            lda #$0b           ; $f1ad: a9 0b     
            jsr __c118         ; $f1af: 20 18 c1  
            lda #$00           ; $f1b2: a9 00     
            sta $0444,x        ; $f1b4: 9d 44 04  
            sta $0456,x        ; $f1b7: 9d 56 04  
            jmp __df8a         ; $f1ba: 4c 8a df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f1bd: bd d8 03  
            bne __f1d1         ; $f1c0: d0 0f     
            lda #$40           ; $f1c2: a9 40     
            sta $03d8,x        ; $f1c4: 9d d8 03  
            lda #$20           ; $f1c7: a9 20     
            sta $03c6,x        ; $f1c9: 9d c6 03  
            lda #$0b           ; $f1cc: a9 0b     
            jmp __ded8         ; $f1ce: 4c d8 de  

;-------------------------------------------------------------------------------
__f1d1:     ldy $0444,x        ; $f1d1: bc 44 04  
            beq __f1dd         ; $f1d4: f0 07     
            dey                ; $f1d6: 88        
            beq __f1fd         ; $f1d7: f0 24     
            dey                ; $f1d9: 88        
            beq __f20e         ; $f1da: f0 32     
            rts                ; $f1dc: 60        

;-------------------------------------------------------------------------------
__f1dd:     ldy #$03           ; $f1dd: a0 03     
__f1df:     lda $03b4,y        ; $f1df: b9 b4 03  
            cmp #$09           ; $f1e2: c9 09     
            beq __f1ec         ; $f1e4: f0 06     
            iny                ; $f1e6: c8        
            cpy #$06           ; $f1e7: c0 06     
            bne __f1df         ; $f1e9: d0 f4     
__f1eb:     rts                ; $f1eb: 60        

;-------------------------------------------------------------------------------
__f1ec:     inc $0444,x        ; $f1ec: fe 44 04  
            lda $03c6,x        ; $f1ef: bd c6 03  
            and #$df           ; $f1f2: 29 df     
            sta $03c6,x        ; $f1f4: 9d c6 03  
            lda #$20           ; $f1f7: a9 20     
            sta $0456,x        ; $f1f9: 9d 56 04  
            rts                ; $f1fc: 60        

;-------------------------------------------------------------------------------
__f1fd:     dec $0456,x        ; $f1fd: de 56 04  
            bne __f20b         ; $f200: d0 09     
            inc $0444,x        ; $f202: fe 44 04  
            lda #$00           ; $f205: a9 00     
            sta $0312,x        ; $f207: 9d 12 03  
            rts                ; $f20a: 60        

;-------------------------------------------------------------------------------
__f20b:     jmp __d9cf         ; $f20b: 4c cf d9  

;-------------------------------------------------------------------------------
__f20e:     jmp __e010         ; $f20e: 4c 10 e0  

;-------------------------------------------------------------------------------
            .hex 1b b2 44      ; $f211: 1b b2 44  Invalid Opcode - SLO $44b2,y
            .hex b2            ; $f214: b2        Invalid Opcode - KIL 
            adc __e1b2,x       ; $f215: 7d b2 e1  
            .hex b2            ; $f218: b2        Invalid Opcode - KIL 
            sbc ($b2,x)        ; $f219: e1 b2     
            asl                ; $f21b: 0a        
            .hex 0d 43 00      ; $f21c: 0d 43 00  Bad Addr Mode - ORA $0043
            .hex 0c 0d 40      ; $f21f: 0c 0d 40  Invalid Opcode - NOP $400d
            .hex 0f 14 0c      ; $f222: 0f 14 0c  Invalid Opcode - SLO $0c14
            clc                ; $f225: 18        
            .hex 0f 18 0d      ; $f226: 0f 18 0d  Invalid Opcode - SLO $0d18
            .hex 43 00         ; $f229: 43 00     Invalid Opcode - SRE ($00,x)
            .hex 1c 0d 40      ; $f22b: 1c 0d 40  Invalid Opcode - NOP $400d,x
            .hex 0f 24 0d      ; $f22e: 0f 24 0d  Invalid Opcode - SLO $0d24
            rti                ; $f231: 40        

;-------------------------------------------------------------------------------
            .hex 0f 26 0d      ; $f232: 0f 26 0d  Invalid Opcode - SLO $0d26
            .hex 43 00         ; $f235: 43 00     Invalid Opcode - SRE ($00,x)
            bit $180c          ; $f237: 2c 0c 18  
            .hex 0f 34 0d      ; $f23a: 0f 34 0d  Invalid Opcode - SLO $0d34
            rti                ; $f23d: 40        

;-------------------------------------------------------------------------------
            .hex 0f 36 0d      ; $f23e: 0f 36 0d  Invalid Opcode - SLO $0d36
            .hex 43 00         ; $f241: 43 00     Invalid Opcode - SRE ($00,x)
            .hex ff 04 0c      ; $f243: ff 04 0c  Invalid Opcode - ISC $0c04,x
            ora $080f,x        ; $f246: 1d 0f 08  
            .hex 0c 10 0f      ; $f249: 0c 10 0f  Invalid Opcode - NOP $0f10
            .hex 0c 0c 1d      ; $f24c: 0c 0c 1d  Invalid Opcode - NOP $1d0c
            .hex 0f 14 0b      ; $f24f: 0f 14 0b  Invalid Opcode - SLO $0b14
            bpl __f263         ; $f252: 10 0f     
            clc                ; $f254: 18        
            .hex 0c 1d 0f      ; $f255: 0c 1d 0f  Invalid Opcode - NOP $0f1d
            .hex 1c 0b 10      ; $f258: 1c 0b 10  Invalid Opcode - NOP $100b,x
            .hex 0f 24 0c      ; $f25b: 0f 24 0c  Invalid Opcode - SLO $0c24
            .hex 34 20         ; $f25e: 34 20     Invalid Opcode - NOP $20,x
            .hex 27 0c         ; $f260: 27 0c     Invalid Opcode - RLA $0c
            .hex 34            ; $f262: 34        Suspected data
__f263:     jsr $0c2a          ; $f263: 20 2a 0c  
            .hex 34 20         ; $f266: 34 20     Invalid Opcode - NOP $20,x
            and $340c          ; $f268: 2d 0c 34  
            jsr $0c34          ; $f26b: 20 34 0c  
            bpl __f27f         ; $f26e: 10 0f     
            sec                ; $f270: 38        
            ora $0f1d          ; $f271: 0d 1d 0f  
            .hex 3a            ; $f274: 3a        Invalid Opcode - NOP 
            ora $1127          ; $f275: 0d 27 11  
            .hex 3c 0d 10      ; $f278: 3c 0d 10  Invalid Opcode - NOP $100d,x
            .hex 0f ff 04      ; $f27b: 0f ff 04  Invalid Opcode - SLO $04ff
            php                ; $f27e: 08        
__f27f:     .hex 03 0f         ; $f27f: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 04 22         ; $f281: 04 22     Invalid Opcode - NOP $22
            .hex 03 0f         ; $f283: 03 0f     Invalid Opcode - SLO ($0f,x)
            php                ; $f285: 08        
            bpl __f28b         ; $f286: 10 03     
            .hex 0f 0c 06      ; $f288: 0f 0c 06  Invalid Opcode - SLO $060c
__f28b:     .hex 03 0f         ; $f28b: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 0c 14 10      ; $f28d: 0c 14 10  Invalid Opcode - NOP $1014
            .hex 0f 0c 1c      ; $f290: 0f 0c 1c  Invalid Opcode - SLO $1c0c
            .hex 03 0f         ; $f293: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 0c 22 03      ; $f295: 0c 22 03  Invalid Opcode - NOP $0322
            .hex 0f 14 08      ; $f298: 0f 14 08  Invalid Opcode - SLO $0814
            .hex 03 0f         ; $f29b: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 14 14         ; $f29d: 14 14     Invalid Opcode - NOP $14,x
            bpl __f2b0         ; $f29f: 10 0f     
            asl $28,x          ; $f2a1: 16 28     
            .hex af 05 18      ; $f2a3: af 05 18  Invalid Opcode - LAX $1805
            .hex 22            ; $f2a6: 22        Invalid Opcode - KIL 
            .hex 03 0f         ; $f2a7: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 1c 1a 03      ; $f2a9: 1c 1a 03  Invalid Opcode - NOP $031a,x
            .hex 0f 21 28      ; $f2ac: 0f 21 28  Invalid Opcode - SLO $2821
            .hex 22            ; $f2af: 22        Invalid Opcode - KIL 
__f2b0:     jsr $0624          ; $f2b0: 20 24 06  
            .hex 03 0f         ; $f2b3: 03 0f     Invalid Opcode - SLO ($0f,x)
            bit $1a            ; $f2b5: 24 1a     
            bpl __f2c8         ; $f2b7: 10 0f     
            and $28            ; $f2b9: 25 28     
            .hex 22            ; $f2bb: 22        Invalid Opcode - KIL 
            jsr $0a28          ; $f2bc: 20 28 0a  
            .hex 03 0f         ; $f2bf: 03 0f     Invalid Opcode - SLO ($0f,x)
            plp                ; $f2c1: 28        
            .hex 1a            ; $f2c2: 1a        Invalid Opcode - NOP 
            bpl __f2d4         ; $f2c3: 10 0f     
            and #$28           ; $f2c5: 29 28     
            .hex 22            ; $f2c7: 22        Invalid Opcode - KIL 
__f2c8:     jsr $282d          ; $f2c8: 20 2d 28  
            .hex 22            ; $f2cb: 22        Invalid Opcode - KIL 
            jsr $0e34          ; $f2cc: 20 34 0e  
            .hex 03 0f         ; $f2cf: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex 34 1a         ; $f2d1: 34 1a     Invalid Opcode - NOP $1a,x
            .hex 03            ; $f2d3: 03        Suspected data
__f2d4:     .hex 0f 38 08      ; $f2d4: 0f 38 08  Invalid Opcode - SLO $0838
            .hex 03 0f         ; $f2d7: 03 0f     Invalid Opcode - SLO ($0f,x)
            sec                ; $f2d9: 38        
            bit $03            ; $f2da: 24 03     
            .hex 0f 3c 14      ; $f2dc: 0f 3c 14  Invalid Opcode - SLO $143c
            .hex 03 0f         ; $f2df: 03 0f     Invalid Opcode - SLO ($0f,x)
            .hex ff bd d8      ; $f2e1: ff bd d8  Invalid Opcode - ISC __d8bd,x
            .hex 03 d0         ; $f2e4: 03 d0     Invalid Opcode - SLO ($d0,x)
            php                ; $f2e6: 08        
            jsr __deca         ; $f2e7: 20 ca de  
            lda #$16           ; $f2ea: a9 16     
            jmp __ded8         ; $f2ec: 4c d8 de  

;-------------------------------------------------------------------------------
            jsr __dd2a         ; $f2ef: 20 2a dd  
            lda #$80           ; $f2f2: a9 80     
            jsr __de6f         ; $f2f4: 20 6f de  
            jsr __8d12         ; $f2f7: 20 12 8d  
            bcc __f300         ; $f2fa: 90 04     
            lda #$ff           ; $f2fc: a9 ff     
            bne __f302         ; $f2fe: d0 02     
__f300:     lda #$00           ; $f300: a9 00     
__f302:     ldy #$80           ; $f302: a0 80     
            jsr __e076         ; $f304: 20 76 e0  
            jmp __e0f4         ; $f307: 4c f4 e0  

;-------------------------------------------------------------------------------
            stx $10            ; $f30a: 86 10     
            lda $03d8,x        ; $f30c: bd d8 03  
            bne __f319         ; $f30f: d0 08     
            jsr __deca         ; $f311: 20 ca de  
            lda #$29           ; $f314: a9 29     
            jmp __ded8         ; $f316: 4c d8 de  

;-------------------------------------------------------------------------------
__f319:     ldx $10            ; $f319: a6 10     
            jsr __dd2a         ; $f31b: 20 2a dd  
            jsr __e0f4         ; $f31e: 20 f4 e0  
            lda $0444,x        ; $f321: bd 44 04  
            jsr __c5bb         ; $f324: 20 bb c5  
            .hex 2f b3 3c      ; $f327: 2f b3 3c  Invalid Opcode - RLA $3cb3
            .hex b3 4d         ; $f32a: b3 4d     Invalid Opcode - LAX ($4d),y
            .hex b3 7b         ; $f32c: b3 7b     Invalid Opcode - LAX ($7b),y
            .hex b3 fe         ; $f32e: b3 fe     Invalid Opcode - LAX ($fe),y
            .hex 44 04         ; $f330: 44 04     Invalid Opcode - NOP $04
            lda #$50           ; $f332: a9 50     
            sta $0456,x        ; $f334: 9d 56 04  
            lda #$80           ; $f337: a9 80     
            jmp __de6f         ; $f339: 4c 6f de  

;-------------------------------------------------------------------------------
            dec $0456,x        ; $f33c: de 56 04  
            bne __f347         ; $f33f: d0 06     
            inc $0444,x        ; $f341: fe 44 04  
            jmp __df82         ; $f344: 4c 82 df  

;-------------------------------------------------------------------------------
__f347:     jsr __de8b         ; $f347: 20 8b de  
            jmp __dea1         ; $f34a: 4c a1 de  

;-------------------------------------------------------------------------------
            jsr __e010         ; $f34d: 20 10 e0  
            lda $03c6,x        ; $f350: bd c6 03  
            bne __f380         ; $f353: d0 2b     
            jsr __dfb3         ; $f355: 20 b3 df  
            bcs __f380         ; $f358: b0 26     
            ldy $10            ; $f35a: a4 10     
            lda #$32           ; $f35c: a9 32     
            sta $03b4,x        ; $f35e: 9d b4 03  
            lda $0348,y        ; $f361: b9 48 03  
            sta $0348,x        ; $f364: 9d 48 03  
            lda $0324,y        ; $f367: b9 24 03  
            sec                ; $f36a: 38        
            sbc #$02           ; $f36b: e9 02     
            sta $0324,x        ; $f36d: 9d 24 03  
            ldx $10            ; $f370: a6 10     
            inc $0444,x        ; $f372: fe 44 04  
            lda #$30           ; $f375: a9 30     
            sta $0456,x        ; $f377: 9d 56 04  
            rts                ; $f37a: 60        

;-------------------------------------------------------------------------------
            dec $0456,x        ; $f37b: de 56 04  
            bne __f385         ; $f37e: d0 05     
__f380:     ldx $10            ; $f380: a6 10     
            jsr __dfa8         ; $f382: 20 a8 df  
__f385:     rts                ; $f385: 60        

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f386: bd d8 03  
            bne __f395         ; $f389: d0 0a     
            lda #$02           ; $f38b: a9 02     
            ldy #$29           ; $f38d: a0 29     
            jsr __ded0         ; $f38f: 20 d0 de  
            jmp __e010         ; $f392: 4c 10 e0  

;-------------------------------------------------------------------------------
__f395:     jsr __e0f4         ; $f395: 20 f4 e0  
            lda $0444,x        ; $f398: bd 44 04  
            jsr __c5bb         ; $f39b: 20 bb c5  
            ldy $b3            ; $f39e: a4 b3     
            .hex b3 b3         ; $f3a0: b3 b3     Invalid Opcode - LAX ($b3),y
            cmp __feb3         ; $f3a2: cd b3 fe  
            .hex 44 04         ; $f3a5: 44 04     Invalid Opcode - NOP $04
            lda #$fd           ; $f3a7: a9 fd     
            ldy #$00           ; $f3a9: a0 00     
            jsr __e076         ; $f3ab: 20 76 e0  
            lda #$e0           ; $f3ae: a9 e0     
            jmp __de6f         ; $f3b0: 4c 6f de  

;-------------------------------------------------------------------------------
            lda #$20           ; $f3b3: a9 20     
            sta $08            ; $f3b5: 85 08     
            jsr __dfe4         ; $f3b7: 20 e4 df  
            lda #$00           ; $f3ba: a9 00     
            ldy #$08           ; $f3bc: a0 08     
            jsr __e2a2         ; $f3be: 20 a2 e2  
            bcs __f3cc         ; $f3c1: b0 09     
            inc $0444,x        ; $f3c3: fe 44 04  
            jsr __d3f6         ; $f3c6: 20 f6 d3  
            jmp __df8a         ; $f3c9: 4c 8a df  

;-------------------------------------------------------------------------------
__f3cc:     rts                ; $f3cc: 60        

;-------------------------------------------------------------------------------
            lda #$00           ; $f3cd: a9 00     
            ldy #$00           ; $f3cf: a0 00     
            jsr __e2a2         ; $f3d1: 20 a2 e2  
            bcc __f3f5         ; $f3d4: 90 1f     
            lda $0420,x        ; $f3d6: bd 20 04  
            bne __f3df         ; $f3d9: d0 04     
            lda #$fa           ; $f3db: a9 fa     
            bne __f3e1         ; $f3dd: d0 02     
__f3df:     lda #$06           ; $f3df: a9 06     
__f3e1:     ldy #$08           ; $f3e1: a0 08     
            jsr __e2af         ; $f3e3: 20 af e2  
            bcs __f3e9         ; $f3e6: b0 01     
            rts                ; $f3e8: 60        

;-------------------------------------------------------------------------------
__f3e9:     lda #$01           ; $f3e9: a9 01     
            sta $0444,x        ; $f3eb: 9d 44 04  
            lda #$ff           ; $f3ee: a9 ff     
            ldy #$80           ; $f3f0: a0 80     
            jmp __e076         ; $f3f2: 4c 76 e0  

;-------------------------------------------------------------------------------
__f3f5:     jmp __df42         ; $f3f5: 4c 42 df  

;-------------------------------------------------------------------------------
            .hex fa            ; $f3f8: fa        Invalid Opcode - NOP 
            .hex b3 fe         ; $f3f9: b3 fe     Invalid Opcode - LAX ($fe),y
            .hex b3 fe         ; $f3fb: b3 fe     Invalid Opcode - LAX ($fe),y
            .hex b3 ff         ; $f3fd: b3 ff     Invalid Opcode - LAX ($ff),y
            lda $04a4          ; $f3ff: ad a4 04  
            .hex c9            ; $f402: c9        Suspected data
__f403:     .hex ff f0 52      ; $f403: ff f0 52  Invalid Opcode - ISC $52f0,x
            jsr __c5bb         ; $f406: 20 bb c5  
            ora $b4,x          ; $f409: 15 b4     
            bit $b4            ; $f40b: 24 b4     
            eor __8fb4,y       ; $f40d: 59 b4 8f  
            ldy $ac,x          ; $f410: b4 ac     
            ldy $e0,x          ; $f412: b4 e0     
            ldy $a9,x          ; $f414: b4 a9     
            brk                ; $f416: 00        
            sta $4d            ; $f417: 85 4d     
            lda #$80           ; $f419: a9 80     
            sta $045c          ; $f41b: 8d 5c 04  
            inc $04a4          ; $f41e: ee a4 04  
            jmp __b58d         ; $f421: 4c 8d b5  

;-------------------------------------------------------------------------------
            ldy #$00           ; $f424: a0 00     
            ldx #$08           ; $f426: a2 08     
            lda $045c          ; $f428: ad 5c 04  
            beq __f432         ; $f42b: f0 05     
            dec $045c          ; $f42d: ce 5c 04  
            bne __f454         ; $f430: d0 22     
__f432:     lda #$a0           ; $f432: a9 a0     
            sta $05a0,y        ; $f434: 99 a0 05  
            tya                ; $f437: 98        
            clc                ; $f438: 18        
            adc #$08           ; $f439: 69 08     
            tay                ; $f43b: a8        
            dex                ; $f43c: ca        
            bne __f432         ; $f43d: d0 f3     
            ldy #$81           ; $f43f: a0 81     
            lda $0348          ; $f441: ad 48 03  
            cmp #$30           ; $f444: c9 30     
            beq __f454         ; $f446: f0 0c     
            ldy #$01           ; $f448: a0 01     
            bcc __f454         ; $f44a: 90 08     
            cmp #$60           ; $f44c: c9 60     
            bcc __f454         ; $f44e: 90 04     
            dey                ; $f450: 88        
            inc $04a4          ; $f451: ee a4 04  
__f454:     sty $f7            ; $f454: 84 f7     
            sty $f5            ; $f456: 84 f5     
            rts                ; $f458: 60        

;-------------------------------------------------------------------------------
            ldx #$04           ; $f459: a2 04     
            ldy #$f0           ; $f45b: a0 f0     
__f45d:     lda #$4b           ; $f45d: a9 4b     
            sta $03bb,x        ; $f45f: 9d bb 03  
            lda #$82           ; $f462: a9 82     
            sta $03df,x        ; $f464: 9d df 03  
            lda #$60           ; $f467: a9 60     
            sta $034f,x        ; $f469: 9d 4f 03  
            lda #$ad           ; $f46c: a9 ad     
            sta $032b,x        ; $f46e: 9d 2b 03  
            lda #$00           ; $f471: a9 00     
            sta $0307,x        ; $f473: 9d 07 03  
            sta $0427,x        ; $f476: 9d 27 04  
            tya                ; $f479: 98        
            sta $045d,x        ; $f47a: 9d 5d 04  
            sec                ; $f47d: 38        
            sbc #$30           ; $f47e: e9 30     
            tay                ; $f480: a8        
            dex                ; $f481: ca        
            bpl __f45d         ; $f482: 10 d9     
            lda #$40           ; $f484: a9 40     
            sta $045c          ; $f486: 8d 5c 04  
            inc $04a4          ; $f489: ee a4 04  
            jmp __b58d         ; $f48c: 4c 8d b5  

;-------------------------------------------------------------------------------
            jsr __b58d         ; $f48f: 20 8d b5  
            lda $045c          ; $f492: ad 5c 04  
            beq __f49b         ; $f495: f0 04     
            dec $045c          ; $f497: ce 5c 04  
            rts                ; $f49a: 60        

;-------------------------------------------------------------------------------
__f49b:     jsr __b58d         ; $f49b: 20 8d b5  
            lda $03bf          ; $f49e: ad bf 03  
            bne __f4ab         ; $f4a1: d0 08     
            lda #$20           ; $f4a3: a9 20     
            sta $045d          ; $f4a5: 8d 5d 04  
            inc $04a4          ; $f4a8: ee a4 04  
__f4ab:     rts                ; $f4ab: 60        

;-------------------------------------------------------------------------------
            dec $045d          ; $f4ac: ce 5d 04  
            bne __f4dd         ; $f4af: d0 2c     
            lda #$4c           ; $f4b1: a9 4c     
            sta $03bb          ; $f4b3: 8d bb 03  
            lda #$d3           ; $f4b6: a9 d3     
            sta $0307          ; $f4b8: 8d 07 03  
            lda #$82           ; $f4bb: a9 82     
            sta $03df          ; $f4bd: 8d df 03  
            lda #$94           ; $f4c0: a9 94     
            sta $032b          ; $f4c2: 8d 2b 03  
            lda #$00           ; $f4c5: a9 00     
            sta $0427          ; $f4c7: 8d 27 04  
            lda #$80           ; $f4ca: a9 80     
            sta $034f          ; $f4cc: 8d 4f 03  
            sta $045d          ; $f4cf: 8d 5d 04  
            jsr __c0e7         ; $f4d2: 20 e7 c0  
            lda #$32           ; $f4d5: a9 32     
            jsr __c118         ; $f4d7: 20 18 c1  
            inc $04a4          ; $f4da: ee a4 04  
__f4dd:     jmp __b58d         ; $f4dd: 4c 8d b5  

;-------------------------------------------------------------------------------
            dec $045d          ; $f4e0: ce 5d 04  
            bne __f507         ; $f4e3: d0 22     
            ldy #$ff           ; $f4e5: a0 ff     
            sty $04a4          ; $f4e7: 8c a4 04  
            iny                ; $f4ea: c8        
            sty $03de          ; $f4eb: 8c de 03  
            sty $03df          ; $f4ee: 8c df 03  
            sty $03bb          ; $f4f1: 8c bb 03  
            sty $0307          ; $f4f4: 8c 07 03  
            sty $04ed          ; $f4f7: 8c ed 04  
            lda #$47           ; $f4fa: a9 47     
            sta $03ba          ; $f4fc: 8d ba 03  
            lda #$80           ; $f4ff: a9 80     
            sta $032a          ; $f501: 8d 2a 03  
            sta $034e          ; $f504: 8d 4e 03  
__f507:     jmp __b58d         ; $f507: 4c 8d b5  

;-------------------------------------------------------------------------------
            lda $0456,x        ; $f50a: bd 56 04  
            beq __f513         ; $f50d: f0 04     
            dec $0456,x        ; $f50f: de 56 04  
            rts                ; $f512: 60        

;-------------------------------------------------------------------------------
__f513:     lda #$e8           ; $f513: a9 e8     
            sta $0300,x        ; $f515: 9d 00 03  
            lda $0348,x        ; $f518: bd 48 03  
            cmp #$80           ; $f51b: c9 80     
            beq __f53b         ; $f51d: f0 1c     
            lda $1d            ; $f51f: a5 1d     
            and #$01           ; $f521: 29 01     
            bne __f53a         ; $f523: d0 15     
__f525:     dec $0324,x        ; $f525: de 24 03  
            lda $1d            ; $f528: a5 1d     
            and #$03           ; $f52a: 29 03     
            bne __f53a         ; $f52c: d0 0c     
            inc $0348,x        ; $f52e: fe 48 03  
            cpx #$0b           ; $f531: e0 0b     
            bne __f53a         ; $f533: d0 05     
            lda #$80           ; $f535: a9 80     
            sta $0473          ; $f537: 8d 73 04  
__f53a:     rts                ; $f53a: 60        

;-------------------------------------------------------------------------------
__f53b:     lda $0353          ; $f53b: ad 53 03  
            cmp #$80           ; $f53e: c9 80     
            bne __f53a         ; $f540: d0 f8     
            lda $1d            ; $f542: a5 1d     
            and #$03           ; $f544: 29 03     
            bne __f553         ; $f546: d0 0b     
            inc $0312,x        ; $f548: fe 12 03  
            lda $0312,x        ; $f54b: bd 12 03  
            and #$03           ; $f54e: 29 03     
            sta $0312,x        ; $f550: 9d 12 03  
__f553:     lda $0473          ; $f553: ad 73 04  
            beq __f560         ; $f556: f0 08     
            cpx #$0b           ; $f558: e0 0b     
            bne __f53a         ; $f55a: d0 de     
            dec $0473          ; $f55c: ce 73 04  
            rts                ; $f55f: 60        

;-------------------------------------------------------------------------------
__f560:     lda $0324,x        ; $f560: bd 24 03  
            cmp #$9d           ; $f563: c9 9d     
            bcs __f56b         ; $f565: b0 04     
            inc $0324,x        ; $f567: fe 24 03  
            rts                ; $f56a: 60        

;-------------------------------------------------------------------------------
__f56b:     lda #$00           ; $f56b: a9 00     
            sta $03b4,x        ; $f56d: 9d b4 03  
            sta $0300,x        ; $f570: 9d 00 03  
            sta $03d8,x        ; $f573: 9d d8 03  
            rts                ; $f576: 60        

;-------------------------------------------------------------------------------
            lda $1d            ; $f577: a5 1d     
            and #$07           ; $f579: 29 07     
            bne __f58c         ; $f57b: d0 0f     
            inc $0300,x        ; $f57d: fe 00 03  
            lda $0300,x        ; $f580: bd 00 03  
            cmp #$d7           ; $f583: c9 d7     
            bcc __f58c         ; $f585: 90 05     
            lda #$d3           ; $f587: a9 d3     
            sta $0300,x        ; $f589: 9d 00 03  
__f58c:     rts                ; $f58c: 60        

;-------------------------------------------------------------------------------
            ldy #$00           ; $f58d: a0 00     
            .hex 84            ; $f58f: 84        Suspected data
__f590:     .hex f7 84         ; $f590: f7 84     Invalid Opcode - ISC $84,x
            sbc $60,x          ; $f592: f5 60     
            lda $03d8,x        ; $f594: bd d8 03  
            bne __f5bf         ; $f597: d0 26     
            jsr __deca         ; $f599: 20 ca de  
            lda #$00           ; $f59c: a9 00     
            sta $0318          ; $f59e: 8d 18 03  
            sta $045c          ; $f5a1: 8d 5c 04  
            sta $0402          ; $f5a4: 8d 02 04  
            sta $0306          ; $f5a7: 8d 06 03  
            lda #$33           ; $f5aa: a9 33     
            sta $046e          ; $f5ac: 8d 6e 04  
            sta $0480          ; $f5af: 8d 80 04  
            lda #$c0           ; $f5b2: a9 c0     
            sta $04b6          ; $f5b4: 8d b6 04  
            sta $2a            ; $f5b7: 85 2a     
            lda #$f0           ; $f5b9: a9 f0     
            sta $04c8          ; $f5bb: 8d c8 04  
__f5be:     rts                ; $f5be: 60        

;-------------------------------------------------------------------------------
__f5bf:     lda $04b0,x        ; $f5bf: bd b0 04  
            beq __f60e         ; $f5c2: f0 4a     
            lda $1d            ; $f5c4: a5 1d     
            and #$01           ; $f5c6: 29 01     
            bne __f60d         ; $f5c8: d0 43     
            dec $04b0,x        ; $f5ca: de b0 04  
            lda $04b0,x        ; $f5cd: bd b0 04  
            cmp #$a0           ; $f5d0: c9 a0     
            bcc __f5db         ; $f5d2: 90 07     
            bne __f60d         ; $f5d4: d0 37     
            lda #$4d           ; $f5d6: a9 4d     
            jsr __c118         ; $f5d8: 20 18 c1  
__f5db:     ldy #$00           ; $f5db: a0 00     
            lda $04b0,x        ; $f5dd: bd b0 04  
            cmp #$80           ; $f5e0: c9 80     
            bcs __f5fb         ; $f5e2: b0 17     
            iny                ; $f5e4: c8        
            cmp #$60           ; $f5e5: c9 60     
            bcs __f5fb         ; $f5e7: b0 12     
            ldy #$03           ; $f5e9: a0 03     
            cmp #$40           ; $f5eb: c9 40     
            bcs __f5fb         ; $f5ed: b0 0c     
            ldy #$07           ; $f5ef: a0 07     
            cmp #$20           ; $f5f1: c9 20     
            bcs __f5fb         ; $f5f3: b0 06     
            lda #$33           ; $f5f5: a9 33     
            sta $0300,x        ; $f5f7: 9d 00 03  
            rts                ; $f5fa: 60        

;-------------------------------------------------------------------------------
__f5fb:     sty $00            ; $f5fb: 84 00     
            and $00            ; $f5fd: 25 00     
            bne __f60d         ; $f5ff: d0 0c     
            lda #$33           ; $f601: a9 33     
            ldy $0300,x        ; $f603: bc 00 03  
            beq __f60a         ; $f606: f0 02     
            lda #$00           ; $f608: a9 00     
__f60a:     sta $0300,x        ; $f60a: 9d 00 03  
__f60d:     rts                ; $f60d: 60        

;-------------------------------------------------------------------------------
__f60e:     lda $0468,x        ; $f60e: bd 68 04  
            beq __f620         ; $f611: f0 0d     
            dec $0468,x        ; $f613: de 68 04  
            lda $0468,x        ; $f616: bd 68 04  
            and #$0f           ; $f619: 29 0f     
            bne __f5be         ; $f61b: d0 a1     
            jmp __b65d         ; $f61d: 4c 5d b6  

;-------------------------------------------------------------------------------
__f620:     lda $1d            ; $f620: a5 1d     
            bne __f62f         ; $f622: d0 0b     
            lda #$28           ; $f624: a9 28     
            .hex 9d            ; $f626: 9d        Suspected data
__f627:     pla                ; $f627: 68        
            .hex 04 fe         ; $f628: 04 fe     Invalid Opcode - NOP $fe
            brk                ; $f62a: 00        
            .hex 03 4c         ; $f62b: 03 4c     Invalid Opcode - SLO ($4c,x)
            .hex 5d b6         ; $f62d: 5d b6     Suspected data
__f62f:     lda #$33           ; $f62f: a9 33     
            sta $0300,x        ; $f631: 9d 00 03  
            lda $1d            ; $f634: a5 1d     
            and #$01           ; $f636: 29 01     
            bne __f60d         ; $f638: d0 d3     
            inc $0456,x        ; $f63a: fe 56 04  
            lda $0456,x        ; $f63d: bd 56 04  
            and #$1f           ; $f640: 29 1f     
            sta $0456,x        ; $f642: 9d 56 04  
            asl                ; $f645: 0a        
            tay                ; $f646: a8        
            lda __b6d9,y       ; $f647: b9 d9 b6  
            sta $0348,x        ; $f64a: 9d 48 03  
            lda __b6da,y       ; $f64d: b9 da b6  
            sta $0324,x        ; $f650: 9d 24 03  
            dec $047a,x        ; $f653: de 7a 04  
            bne __f60d         ; $f656: d0 b5     
            lda #$3d           ; $f658: a9 3d     
            sta $047a,x        ; $f65a: 9d 7a 04  
            .hex 20 8a         ; $f65d: 20 8a     Suspected data
__f65f:     .hex 8c a9         ; $f65f: 8c a9     Suspected data
__f661:     pha                ; $f661: 48        
            jmp __8e26         ; $f662: 4c 26 8e  

;-------------------------------------------------------------------------------
__f665:     lda $1d            ; $f665: a5 1d     
            and #$03           ; $f667: 29 03     
            bne __f67a         ; $f669: d0 0f     
            inc $0300,x        ; $f66b: fe 00 03  
            lda $0300,x        ; $f66e: bd 00 03  
            cmp #$7e           ; $f671: c9 7e     
            bcc __f67a         ; $f673: 90 05     
            lda #$7a           ; $f675: a9 7a     
            sta $0300,x        ; $f677: 9d 00 03  
__f67a:     jsr __e0f4         ; $f67a: 20 f4 e0  
            lda $0324,x        ; $f67d: bd 24 03  
            clc                ; $f680: 18        
            adc #$20           ; $f681: 69 20     
            cmp #$31           ; $f683: c9 31     
            bcs __f60d         ; $f685: b0 86     
            jmp __df42         ; $f687: 4c 42 df  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f68a: bd d8 03  
            bne __f665         ; $f68d: d0 d6     
            jsr __deca         ; $f68f: 20 ca de  
            lda #$01           ; $f692: a9 01     
            sta $04c2,x        ; $f694: 9d c2 04  
            lda #$7a           ; $f697: a9 7a     
            sta $0300,x        ; $f699: 9d 00 03  
            jmp __e010         ; $f69c: 4c 10 e0  

;-------------------------------------------------------------------------------
            lda $03d8,x        ; $f69f: bd d8 03  
            bne __f6b1         ; $f6a2: d0 0d     
            lda #$e9           ; $f6a4: a9 e9     
            sta $0300,x        ; $f6a6: 9d 00 03  
            lda #$80           ; $f6a9: a9 80     
            sta $0456,x        ; $f6ab: 9d 56 04  
            jmp __deca         ; $f6ae: 4c ca de  

;-------------------------------------------------------------------------------
__f6b1:     dec $0456,x        ; $f6b1: de 56 04  
            bne __f6c3         ; $f6b4: d0 0d     
            lda #$00           ; $f6b6: a9 00     
            sta $03b4,x        ; $f6b8: 9d b4 03  
            sta $0300,x        ; $f6bb: 9d 00 03  
            lda #$0c           ; $f6be: a9 0c     
            sta $18            ; $f6c0: 85 18     
            rts                ; $f6c2: 60        

;-------------------------------------------------------------------------------
__f6c3:     lda $1d            ; $f6c3: a5 1d     
            and #$03           ; $f6c5: 29 03     
            bne __f6d8         ; $f6c7: d0 0f     
            inc $0300,x        ; $f6c9: fe 00 03  
            lda $0300,x        ; $f6cc: bd 00 03  
            cmp #$ed           ; $f6cf: c9 ed     
            bcc __f6d8         ; $f6d1: 90 05     
            lda #$e9           ; $f6d3: a9 e9     
            sta $0300,x        ; $f6d5: 9d 00 03  
__f6d8:     rts                ; $f6d8: 60        

;-------------------------------------------------------------------------------
            .hex 80 d0         ; $f6d9: 80 d0     Invalid Opcode - NOP #$d0
            .hex 80 30         ; $f6db: 80 30     Invalid Opcode - NOP #$30
            bmi __f65f         ; $f6dd: 30 80     
            bne __f661         ; $f6df: d0 80     
            bvs __f6b1         ; $f6e1: 70 ce     
            bcc __f716         ; $f6e3: 90 31     
            and ($70),y        ; $f6e5: 31 70     
            dec $618f          ; $f6e7: ce 8f 61  
            cmp #$9e           ; $f6ea: c9 9e     
            rol $36,x          ; $f6ec: 36 36     
            adc ($ca,x)        ; $f6ee: 61 ca     
            .hex 9e 53 c2      ; $f6f0: 9e 53 c2  Invalid Opcode - SHX __c253,y
            ldy $3d3d          ; $f6f3: ac 3d 3d  
            .hex 54 c2         ; $f6f6: 54 c2     Invalid Opcode - NOP $c2,x
            .hex ab 47         ; $f6f8: ab 47     Invalid Opcode - LAX #$47
            clv                ; $f6fa: b8        
            clv                ; $f6fb: b8        
            .hex 47 47         ; $f6fc: 47 47     Invalid Opcode - SRE $47
            .hex 47 b8         ; $f6fe: 47 b8     Invalid Opcode - SRE $b8
            clv                ; $f700: b8        
            and __c2ac,x       ; $f701: 3d ac c2  
            .hex 53 53         ; $f704: 53 53     Invalid Opcode - SRE ($53),y
            and __c2ac,x       ; $f706: 3d ac c2  
            rol $9e,x          ; $f709: 36 9e     
            cmp #$61           ; $f70b: c9 61     
            adc ($36,x)        ; $f70d: 61 36     
            .hex 9e c9 31      ; $f70f: 9e c9 31  Invalid Opcode - SHX $31c9,y
            .hex 8f ce 70      ; $f712: 8f ce 70  Invalid Opcode - SAX $70ce
            .hex 70            ; $f715: 70        Suspected data
__f716:     and ($8f),y        ; $f716: 31 8f     
            dec $ffff          ; $f718: ce ff ff  
            .hex ff ff ff      ; $f71b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f71e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f721: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f724: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f727: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f72a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f72d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f730: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f733: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f736: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f739: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f73c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f73f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f742: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f745: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f748: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f74b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f74e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f751: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f754: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f757: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f75a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f75d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f760: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f763: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f766: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f769: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f76c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f76f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f772: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f775: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f778: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f77b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f77e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f781: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f784: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f787: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f78a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f78d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f790: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f793: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f796: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f799: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f79c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f79f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7a2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7a5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7a8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7ab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7ae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7b1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7b4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7b7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7ba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7bd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7c0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7c3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7c6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7c9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7cc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7cf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7d2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7d5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7d8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7db: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7de: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7e1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7e4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7e7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7ea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7ed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7f0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7f3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7f6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7f9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f7fc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $f7ff: ff        Suspected data
__f800:     .hex ff ff         ; $f800: ff ff     Suspected data
__f802:     .hex ff            ; $f802: ff        Suspected data
__f803:     .hex ff ff ff      ; $f803: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f806: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f809: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f80c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f80f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f812: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f815: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f818: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f81b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f81e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f821: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f824: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f827: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f82a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f82d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f830: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f833: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f836: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f839: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f83c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f83f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f842: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f845: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f848: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f84b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f84e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f851: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f854: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f857: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f85a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f85d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f860: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f863: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f866: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f869: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f86c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f86f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f872: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f875: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f878: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f87b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f87e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f881: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f884: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f887: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f88a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f88d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f890: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f893: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f896: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f899: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f89c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f89f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8a2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8a5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8a8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8ab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8ae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8b1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8b4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8b7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8ba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8bd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8c0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8c3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8c6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8c9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8cc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8cf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8d2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8d5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8d8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8db: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8de: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8e1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8e4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8e7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8ea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8ed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8f0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8f3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8f6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8f9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f8fc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $f8ff: ff ff     Suspected data
__f901:     .hex ff ff ff      ; $f901: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f904: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f907: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f90a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f90d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f910: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f913: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f916: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f919: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f91c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f91f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f922: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f925: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f928: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f92b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f92e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f931: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f934: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f937: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f93a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f93d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $f940: ff        Suspected data
__f941:     .hex ff ff ff      ; $f941: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f944: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f947: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f94a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f94d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f950: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f953: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f956: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f959: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $f95c: ff        Suspected data
__f95d:     .hex ff ff ff      ; $f95d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f960: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f963: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f966: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f969: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f96c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f96f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f972: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f975: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f978: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f97b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f97e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f981: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f984: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f987: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f98a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f98d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f990: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f993: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f996: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f999: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f99c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f99f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9a2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9a5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9a8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9b1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9b4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9b7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9bd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9c0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9c3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9c6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9c9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9cc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9cf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9d2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9d5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9d8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9db: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9de: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9e1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9e4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9e7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9f0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9f3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9f6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9f9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9fc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $f9ff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa14: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa3e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa5f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa62: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa65: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa68: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa6b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa6e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa71: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa74: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa77: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa7a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa7d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa80: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa83: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa86: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa89: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa8c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa8f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa92: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa95: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa98: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa9b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fa9e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faa1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faa4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faa7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faaa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faad: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fab0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fab3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fab6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fab9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fabc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fabf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fac2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fac5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fac8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $facb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $face: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fad1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fad4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fad7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fada: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fadd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fae0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fae3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fae6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fae9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faec: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faef: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faf2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faf5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $faf8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fafb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fafe: ff ff ff  Invalid Opcode - ISC $ffff,x
__fb01:     .hex ff            ; $fb01: ff        Suspected data
__fb02:     .hex ff ff         ; $fb02: ff ff     Suspected data
__fb04:     .hex ff            ; $fb04: ff        Suspected data
__fb05:     .hex ff ff ff      ; $fb05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb14: ff ff ff  Invalid Opcode - ISC $ffff,x
__fb17:     .hex ff ff ff      ; $fb17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb3e: ff ff ff  Invalid Opcode - ISC $ffff,x
__fb41:     .hex ff ff ff      ; $fb41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fb5c: ff        Suspected data
__fb5d:     .hex ff ff ff      ; $fb5d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb60: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb63: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb66: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb69: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb6c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb6f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb72: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb75: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb96: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb99: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb9c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fb9f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fba2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fba5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fba8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbae: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbb1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbb4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbb7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbba: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbbd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbc0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fbc3: ff        Suspected data
__fbc4:     .hex ff ff ff      ; $fbc4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbc7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbcd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbd0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbd3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbd6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbd9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbdc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbdf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbe2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbe5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbe8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbeb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbee: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbf1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbf4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fbf7: ff        Suspected data
__fbf8:     .hex ff ff ff      ; $fbf8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fbfb: ff        Suspected data
__fbfc:     .hex ff ff ff      ; $fbfc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fbff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fc02: ff        Suspected data
__fc03:     .hex ff ff ff      ; $fc03: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc06: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc09: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fc0c: ff        Suspected data
__fc0d:     .hex ff ff ff      ; $fc0d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc10: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc13: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc16: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc19: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc1c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc1f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc22: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc25: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc28: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc2b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc2e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc31: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc34: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc37: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc3a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc3d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc40: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc43: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc46: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc49: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc4c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc4f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc52: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc55: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc58: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc5b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc5e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc61: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc64: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc67: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc6a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc6d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc70: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc73: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc76: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc79: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc7c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc7f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc82: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc85: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc88: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc8b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc8e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc91: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc94: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc97: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc9a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fc9d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fca0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fca3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fca6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fca9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcac: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcaf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcb2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcb5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcb8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcbb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcbe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcc1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcc4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcc7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fccd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcd0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcd3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcd6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcd9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcdc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fcdf: ff ff     Suspected data
__fce1:     .hex ff ff ff      ; $fce1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fce4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fce7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fced: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcf0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcf3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcf6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcf9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcfc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fcff: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd05: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd08: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd0b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd0e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd11: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd14: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd17: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd1a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd1d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd20: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd38: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd3b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd3e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd41: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd44: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd47: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd4a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd4d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd50: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd53: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd56: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd5f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd62: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd65: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd68: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd6b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd6e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd71: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd74: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd77: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd7a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd7d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd80: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd83: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd86: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd89: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd8c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd8f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd92: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd95: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd98: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd9b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fd9e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fda1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fda4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fda7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdaa: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdad: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdb0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdb3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdb6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdb9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdbc: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdbf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdc2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdc5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdc8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdcb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdce: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdd1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdd4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdd7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdda: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fddd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fde0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fde3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fde6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fde9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdec: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdef: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdf2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdf5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdf8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdfb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fdfe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fe01: ff        Suspected data
__fe02:     .hex ff ff         ; $fe02: ff ff     Suspected data
__fe04:     .hex ff ff ff      ; $fe04: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe07: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe0a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe0d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe10: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe13: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe16: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe19: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe1c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fe1f: ff ff     Suspected data
__fe21:     .hex ff            ; $fe21: ff        Suspected data
__fe22:     .hex ff            ; $fe22: ff        Suspected data
__fe23:     .hex ff ff ff      ; $fe23: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe26: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe29: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe2c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe2f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe32: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe35: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fe38: ff        Suspected data
__fe39:     .hex ff ff ff      ; $fe39: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe3c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe3f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe42: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe45: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe48: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe4b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe4e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe51: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe54: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fe57: ff        Suspected data
__fe58:     .hex ff ff ff      ; $fe58: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe5b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe5e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe61: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe64: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe67: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe6a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe6d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe70: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe73: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fe76: ff ff     Suspected data
__fe78:     .hex ff ff ff      ; $fe78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fe96: ff ff     Suspected data
__fe98:     .hex ff ff ff      ; $fe98: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe9b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fe9e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fea1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fea4: ff ff     Suspected data
__fea6:     .hex ff ff ff      ; $fea6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fea9: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $feac: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $feaf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $feb2: ff        Suspected data
__feb3:     .hex ff ff ff      ; $feb3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $feb6: ff ff     Suspected data
__feb8:     .hex ff ff ff      ; $feb8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $febb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $febe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fec1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fec4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fec7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $feca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fecd: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fed0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fed3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fed6: ff ff     Suspected data
__fed8:     .hex ff ff ff      ; $fed8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fedb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fede: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fee1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fee4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fee7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $feea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $feed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fef0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fef3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fef6: ff ff     Suspected data
__fef8:     .hex ff ff ff      ; $fef8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fefb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $fefe: ff ff     Suspected data
__ff00:     .hex ff ff         ; $ff00: ff ff     Suspected data
__ff02:     .hex ff ff ff      ; $ff02: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff05: ff ff ff  Invalid Opcode - ISC $ffff,x
__ff08:     .hex ff ff         ; $ff08: ff ff     Suspected data
__ff0a:     .hex ff ff ff      ; $ff0a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff         ; $ff0d: ff ff     Suspected data
__ff0f:     .hex ff ff ff      ; $ff0f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff12: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff15: ff ff ff  Invalid Opcode - ISC $ffff,x
__ff18:     .hex ff ff ff      ; $ff18: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff1b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $ff1e: ff        Suspected data
__ff1f:     .hex ff ff ff      ; $ff1f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff22: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff25: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff28: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff2b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff2e: ff ff ff  Invalid Opcode - ISC $ffff,x
__ff31:     .hex ff ff ff      ; $ff31: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff34: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff37: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff3a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff3d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff40: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff43: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff46: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff49: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff4c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff4f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff52: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff55: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $ff58: ff        Suspected data
__ff59:     .hex ff ff ff      ; $ff59: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff5c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $ff5f: ff        Suspected data
__ff60:     .hex ff ff ff      ; $ff60: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff63: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff66: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff69: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff6c: ff ff ff  Invalid Opcode - ISC $ffff,x
__ff6f:     .hex ff ff ff      ; $ff6f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff72: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff75: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff78: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff7b: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff7e: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff81: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff84: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff87: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff8a: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff8d: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff90: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff93: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff96: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff99: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff9c: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ff9f: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffa2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffa5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffa8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffab: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $ffae: ff        Suspected data
__ffaf:     .hex ff ff ff      ; $ffaf: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffb2: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffb5: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffb8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffbb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffbe: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffc1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffc4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffc7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffca: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffcd: ff ff ff  Invalid Opcode - ISC $ffff,x

;-------------------------------------------------------------------------------
; reset vector
;-------------------------------------------------------------------------------
reset:      cld                ; $ffd0: d8        
            sei                ; $ffd1: 78        
            inc $ffff          ; $ffd2: ee ff ff  
            jmp __c000         ; $ffd5: 4c 00 c0  

;-------------------------------------------------------------------------------
            .hex ff ff ff      ; $ffd8: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffdb: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffde: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffe1: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffe4: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffe7: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffea: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $ffed: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fff0: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fff3: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff ff ff      ; $fff6: ff ff ff  Invalid Opcode - ISC $ffff,x
            .hex ff            ; $fff9: ff        Suspected data

;-------------------------------------------------------------------------------
; Vector Table
;-------------------------------------------------------------------------------
vectors:    .dw nmi                        ; $fffa: 46 c0     Vector table
            .dw reset                      ; $fffc: d0 ff     Vector table
            .dw irq                        ; $fffe: 96 c0     Vector table
