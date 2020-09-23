.include "atari2600.inc"

; RAM Variables

; Constants

.org $1000
.segment "STARTUP"

Reset:
   ldx #0
   lda #0
Clear:
   sta 0,x
   inx
   bne Clear

   ; Initialize graphics
   lda #$45
   sta COLUPF

   lda #0
   sta COLUBK

StartOfFrame:

; Start of vertical blank processing
   lda #0
   sta VBLANK

   lda #2
   sta VSYNC

; 3 scanlines of VSYNCH signal...
   sta WSYNC

   sta WSYNC

   sta WSYNC


   lda #0
   sta VSYNC

; 37 scanlines of vertical blank...

   ldx #37
@vblank_loop:
   sta WSYNC
   dex
   bne @vblank_loop

; 192 scanlines of picture...

   ldx #0
   stx PF0
   stx PF1
   stx PF2
@header_loop:
   sta WSYNC
   inx
   cpx #30
   bne @header_loop

   ldx #6
@line1_loop:
   lda #%10100000
   sta PF0
   lda #%01101001
   sta PF1
   lda #%10001000
   sta PF2
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   lda #%10000000
   sta PF0
   lda #%00100110
   sta PF1
   lda #%00110010
   sta PF2
   sta WSYNC
   dex
   bne @line1_loop

   ldx #6
@line2_loop:
   lda #%10100000
   sta PF0
   lda #%01001001
   sta PF1
   lda #%10010100
   sta PF2
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   lda #%10000000
   sta PF0
   lda #%01010101
   sta PF1
   lda #%01010010
   sta PF2
   sta WSYNC
   dex
   bne @line2_loop

   ldx #6
@line3_loop:
   lda #%11100000
   sta PF0
   lda #%01101001
   sta PF1
   lda #%10010100
   sta PF2
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   lda #%10100000
   sta PF0
   lda #%01010110
   sta PF1
   lda #%01010010
   sta PF2
   sta WSYNC
   dex
   bne @line3_loop

   ldx #6
@line4_loop:
   lda #%10100000
   sta PF0
   lda #%01001001
   sta PF1
   lda #%10010100
   sta PF2
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   lda #%10100000
   sta PF0
   lda #%01010101
   sta PF1
   lda #%01010010
   sta PF2
   sta WSYNC
   dex
   bne @line4_loop

   ldx #6
@line5_loop:
   lda #%10100000
   sta PF0
   lda #%01101101
   sta PF1
   lda #%00001001
   sta PF2
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   nop
   lda #%01010000
   sta PF0
   lda #%00100101
   sta PF1
   lda #%00110110
   sta PF2
   sta WSYNC
   dex
   bne @line5_loop

   ldx #0
   stx PF0
   stx PF1
   stx PF2
@footer_loop:
   sta WSYNC
   inx
   cpx #132
   bne @footer_loop

   lda #%01000010
   sta VBLANK                     ; end of screen - enter blanking

   ; 30 scanlines of overscan...

   ldx #30
@oscan_loop:
   sta WSYNC
   dex
   bne @oscan_loop

   jmp StartOfFrame

; Pattern Data

.org $1FFA
.segment "VECTORS"

.word Reset          ; NMI
.word Reset          ; RESET
.word Reset          ; IRQ
