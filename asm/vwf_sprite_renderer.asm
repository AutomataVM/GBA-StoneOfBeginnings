; ----------
; teod
; 2021/04/07
; ----------

; ------------------------------
; teod 21/04/07:
; new file
; updated along with vwf_sprites
; and vwf_extend_sprite_tables
; ------------------------------

; ---------------------
; functions
; 
; RenderGlyph
; RenderStringToSprites
; ---------------------

; -----------------------------------------
; inputs:
; r0 = src, bitmap data
;   24 bytes, starting from top left
;   and ending bottom right
;   each 2 bytes represent a row
;   so 12 rows
;   high bit is left low bit right
; r1 = des, vram tile
;   4 tiles, 128 bytes
;   this will be copied directly to
;   vram
;
; the code will need to render a shadow
; 0xF represents the main color
; 0xE represents the shadow
; 0x0 is transparent
;
; notes:
; basically just redoing the whole function
;
; the original code limits to a width of 13
; and pads the left side by 2 pixels
;
; the new code will not pad the left side
; and render all of the available width
; -----------------------------------------
.org 0x08002CB4
.region 0x080031E8-.,0x00
.func RenderGlyph
push r4-r7,lr
mov  r7, r10
mov  r6, r9
mov  r5, r8
push r5-r7
; sub  sp, 16

mov  r4, r0; src
mov  r5, r1; des

; blank lines
mov  r0, 0
; top 2 lines
str r0,[r5]   :: str r0,[r5,32]
str r0,[r5,4] :: str r0,[r5,36]
; bottom 2 lines
str r0,[r5,88] :: str r0,[r5,120]
str r0,[r5,92] :: str r0,[r5,124]

; top 6 lines
mov  r6, 0
mov  r7, 8
@@forEachTop:
bl   @@renderLine2

add  r4, 2
add  r7, 4
cmp  r7, 32
blt  @@forEachTop

; bottom 6 lines
mov  r7, 64
@@forEachBot:
bl   @@renderLine2

add  r4, 2
add  r7, 4
cmp  r7, 88
blt  @@forEachBot

; add  sp, 16
pop  r3-r5
mov  r8, r3
mov  r9, r4
mov  r10, r5
pop  r4-r7
pop  r0
bx   r0
.pool
.endfunc

; unpacks bits into nibbles
; in = r0 = 4 bits (abcd)
; out = r0 = 000d000c 000b000a
; x = abcd => 000d000c000b000a
; y = (x>>3)|(x<<2)|(x<<7)|(x<<12)
; z = y&0x1111
@@bitUnpack:
lsr  r1, r0, 3
lsl  r0, r0, 2
orr  r1, r0
lsl  r0, r0, 5 ;7
orr  r1, r0
lsl  r0, r0, 5 ;12
orr  r1, r0
ldr  r0, =0x1111
and  r0, r1
bx lr
.pool

; renders a half from bitmaps
; a half is 4 pixels of color
; in:
; r0 = main (4bits)
; r1 = shadow (4bits)
; out:
; r0 = rendered half
@@renderHalf:
push lr

lsl  r0, r0, 28
lsr  r2, r0, 28
lsl  r1, r1, 28
lsr  r3, r1, 28

mov  r0, r2
bl   @@bitUnpack
mov  r2, 0xE
mul  r2, r0

mov  r0, r3
bl   @@bitUnpack
mov  r3, 0xF
mul  r3, r0

mov  r0, r2
orr  r0, r3

pop  pc

; renders a line
; in:
; r0 = main bitmap
; r1 = shadow bitmap
; r2 = des
@@renderLine:
push r4-r6, lr
mov  r4, r0
mov  r5, r1
mov  r6, r2

lsr  r0, r4, 12
lsr  r1, r5, 12
bl   @@renderHalf
strh r0, [r6]

lsr  r0, r4, 8
lsr  r1, r5, 8
bl   @@renderHalf
strh r0, [r6,2]

lsr  r0, r4, 4
lsr  r1, r5, 4
bl   @@renderHalf
strh r0, [r6,32]

mov  r0, r4
mov  r1, r5
bl   @@renderHalf
strh r0, [r6,34]

pop  r4-r6, pc

@@renderLine2:
push lr
ldrh r0, [r4]
; swap bytes
lsl  r1, r0, 16
orr  r0, r1
lsl  r0, 8
lsr  r0, 16
; shadow =
;   (prev>>1)|(curr>>1) & ~curr
lsr  r1, r0, 1
lsr  r6, 1
orr  r1, r6
bic  r1, r0

; update prev line
mov  r6, r0

mov  r2, r5
add  r2, r7
bl   @@renderLine
pop  pc



; --------------------------------------------------------
; This is to replace DrwaStrSpriteGlyphs
; this area simply has more space so it'll be easier to
; implement more complex VWF functions
; specifically, we want to pack the glyphs together
; into a single sprite
; inputs:
; r0 = des, sprite tiles, 128 bytes per sprite
; r1 = src, character data
; r2 = xoff, byte array storing x offsets for each sprite
; outputs:
; r0 = numSprites
;
; this is borrowed from unknownbrackets' code
; the code was adapted to accomodate glyph packing
;
; This is the function that draws glyphs as sprites.
; We extend to support ASCII/etc.
; .org 0x080036F8
; .region 0x0800379C-.,0x00
; Args: uint32_t *dst, const uint16_t *str, int8_t *widths
; Returns: uint16_t charsDrawn
; .func DrawStrSpriteGlyphs
; --------------------------------------------------------
.func RenderStringToSprites
push r4-r7, lr
mov  r7, r11
mov  r6, r10
mov  r5, r9
mov  r4, r8
push r4-r7
; space for our custom glyph
sub  sp, 24

; init
mov  r4, r0; des
mov  r5, r1; src
mov  r6, r2; xoff

mov  r0, 0
mov  r8, r0; numSprites
mov  r9, r0; totalWidth
mov  r10, r0; saved ptr
mov  r11, r0; saved ptr for nameCode

@@initGlyph:
mov  r0, 0
str  r0, [sp]
str  r0, [sp,4]
str  r0, [sp,8]
str  r0, [sp,12]
str  r0, [sp,16]
str  r0, [sp,20]
; width is 0
mov  r7, 0

@@nextChar:
; we have to grab in by bytes
; to avoid misaligned loads...
mov  r10, r5
ldrb r0, [r5]
add  r5, 1

cmp  r0, 0
beq  @@null
cmp  r0, 0x7F
blo  @@lookup
bne  @@doubleWidth

; fixedWidth
; not implementing this now
; skip over to next byte
add  r5, 1
b    @@nextChar

@@nameCode:
lsl  r1, r1, 28
lsr  r1, r1, 28
mov  r0, 18
mul  r0, r1

mov  r11, r5
; This is where the names are.
ldr  r5, =0x03005580
add  r5, r5, r0
mov  r10, r5
b    @@nextChar

@@doubleWidth:
ldrb r1, [r5]
add  r5, 1
;lsr  r2, r1, 4
;lsl  r2, r2, 12
;orr  r0, r2
lsr  r3, r1, 4
lsl  r3, r3, 12
orr  r3, r0

ldr  r2, =0x7087
cmp  r3, r2
beq  @@nextChar ; control code
ldr  r2, =0xC083
cmp  r3, r2
beq  @@nameCode

lsl  r1, 8
orr  r0, r1

@@lookup:
bl   LookupGlyph
; r0 = bitmap, r1 = width

; check size
add  r1, r7
cmp  r1, 16
bgt  @@renderSprite ; too large to fit
                    ; need to render

; append new glyph
mov  r2, r7; old width is new insert location
mov  r7, r1; update width
mov  r1, sp
bl   @@appendGlyph
b    @@nextChar

@@renderSprite:
mov  r0, sp; src, custom glyph
mov  r1, r4; des, sprite buffer
bl   RenderGlyph

; update widths
add  r7, r9
; todo: update the tables for other scalings
; temporary: so it won't break other stuff
sub  r7, 12
strb r7, [r6]
mov  r9, r7
add  r4, 128; des
; sub  r5, 1  ; try again next loop
mov  r5, r10
mov  r0, 1
add  r8, r0 ; numSprites++
add  r6, 1
b    @@initGlyph ; falls thru to get next char

@@null:
mov  r5, r11
mov  r0, 0
mov  r11, r0
cmp  r5, 0 ; was in nameCode ?
bne  @@nextChar
cmp  r7, 0
beq  @@done

; last render
mov  r0, sp; src, custom glyph
mov  r1, r4; des, sprite buffer
bl   RenderGlyph

add  r7, r9
strb r7, [r6]
mov  r0, 1
add  r8, r0 ; numSprites++

@@done:
mov  r0, r8; numSprites

add  sp, 24
pop  r4-r7
mov  r8, r4
mov  r9, r5
mov  r10, r6
mov  r11, r7
pop  r4-r7, pc
.pool
.endfunc

; in:
; r0 = src, new glyph
; r1 = des, glyph buffer to append into
; r2 = xoff, "location" to append to
@@appendGlyph:
push r4-r6, lr

mov  r4, r0
mov  r5, r1
; mov  r6, r2
; counter
mov  r6, 0

@@appendLoop:
ldrb r0, [r4]
lsl  r0, 8
ldrb r1, [r4,1]
orr  r1, r0
lsr  r1, r2

ldrb r0, [r5,1]
orr  r0, r1
strb r0, [r5,1]
lsr  r1, r1, 8
ldrb r0, [r5]
orr  r0, r1
strb r0, [r5]

add  r4, 2
add  r5, 2
add  r6, 1
cmp  r6, 12
blt  @@appendLoop

pop  r4-r6, pc


.endregion

