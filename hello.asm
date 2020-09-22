.include "atari2600.inc"

; RAM Variables

PATTERN = $80

; Constants

TIMETOCHANGE = 20

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
   lda #0
   sta PATTERN

   lda #$45
   sta COLUPF

   ldy #0

StartOfFrame:

; Start of vertical blank processing
   lda #0
   sta VBLANK

   lda #2
   sta VSYNC

   lda #0
   sta COLUBK

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

   ;------------------------------------------------
   ; Handle a change in the pattern once every 20 frames
   ; and write the pattern to the PF1 register
   iny                    ; increment speed count by one
   cpy #TIMETOCHANGE      ; has it reached our "change point"?
   bne notyet             ; no, so branch past
   ldy #0                 ; reset speed count
   inc PATTERN            ; switch to next pattern
notyet:
   lda PATTERN            ; use our saved pattern
   sta PF1                ; as the playfield shape

; 192 scanlines of picture...

   ldx #192
@picture_loop:
   stx COLUBK
   sta WSYNC
   dex
   bne @picture_loop

   lda #%01000010
   sta VBLANK                     ; end of screen - enter blanking

   ; 30 scanlines of overscan...

   ldx #30
@oscan_loop:
   sta WSYNC
   dex
   bne @oscan_loop

   jmp StartOfFrame

.org $1FFA
.segment "VECTORS"

.word Reset          ; NMI
.word Reset          ; RESET
.word Reset          ; IRQ
