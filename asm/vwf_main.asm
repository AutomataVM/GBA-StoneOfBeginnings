; This function is the main func responsible for drawing glyphs.
; The string drawing function calls it directly.
; Note: there are other drawing paths.
.org 0x08001F14
.region 0x080020A8-.,0x00
; Args: uint32_t *dst, const uint16_t *str, uint16_t *codeout, uint16_t yoff, uint32_t bgColor
; Returns: uint16_t pixelWidthDiv12
.func DrawStrGlyphs
push r4-r7,r14
mov r7,r10
mov r6,r9
mov r5,r8
push r5-r7
sub sp,8

; Save out the important parameters.
mov r10,r0
mov r4,r1
mov r9,r2
mov r8,r3

; Logging of strings.
ldrb r0,[r1,0]
cmp r0,0x80
blo @@skiplog
mov r12,r12
b @@skiplog
.ascii "dd"
.dh 0
.asciiz "STR: %r1% = %r0%"
.align 2
@@skiplog:

; Copy bgColor to sp+0 for all calls to DrawStrGlyph.
ldr r0,[sp,40]
str r0,[sp,0]

; Prep some counters, r7 will be pixelsWritten and sp+40 codepos+codeout.
mov r7,0
mov r6,r2
str r6,[sp,40]

; And a trick: this is where we push the str for a name.
; We reuse our main loop and just swap the pointer.
mov r5,0
; Fixed width flag.
mov r6,0xFF

; r0=FREE, r1=FREE, r2=FREE, r3=FREE, r4=str, r5=oldStr, r6=widthOverride, r7=pixelsWritten
; r8=yoff, r9=codeout, r10=dst, r12=FREE?, r14=FREE
; sp+0=bgColor, sp+4=widthParam, sp+40=codepos

@@nextChar:
; Read the first byte.
ldrb r0,[r4]
add r4,r4,1

; If it's 7F or lower, single byte (also end of string.)
cmp r0,0x7F
blo @@handleAscii
beq @@handleWidthControl

; Grab the high byte, but don't merge yet.
ldrb r1,[r4]
add r4,r4,1
lsr r2,r1,4

; 87 7? means control code (write to codeout.)
cmp r0,0x87
bne @@checkNameCode
cmp r2,0x07
beq @@handleControlCode

; 83 C? means name code (output name variable.)
@@checkNameCode:
cmp r0,0x83
bne @@handleJIS
cmp r2,0x0C
bne @@handleJIS

; Okay, this is a name.  Grab the index * 9.
lsl r1,r1,28
lsr r1,r1,28
; (x * 8) + x == x * 9
lsl r0,r1,3
add r0,r0,r1
; Double, since it's 9 shorts.
lsl r0,r0,1

; Save old str.
mov r5,r4
; This is where the names are.
ldr r4,=0x03005580
add r4,r4,r0

; Okay, we're ready, process chars.
b @@nextChar

@@handleAscii:
cmp r0,1
blo @@doneStr
beq @@pointerCode

mov r1,0
; Fall-through.

@@handleJIS:
; Combine to a single character code.
lsl r1,r1,8
orr r0,r1

; Now grab the glyph.
bl LookupGlyph
; That returned the width in r1.
str r1,[sp,4]

; Prep the dst, rounding to nearest tile pair.
lsl r1,r7,3
mov r2,0x3F
bic r1,r2
add r1,r10
; And now the x and y offsets.
mov r2,7
and r2,r7
mov r3,r8

bl DrawStrGlyph

cmp r6,0xFF
bne @@useFixedWidth

ldr r0,[sp,4]
add r7,r0
b @@nextChar

@@useFixedWidth:
add r7,r6
b @@nextChar

@@handleWidthControl:
; Read the next byte, which will be the fixed width.
ldrb r6,[r4]
add r4,r4,1
b @@nextChar

@@handleControlCode:
lsl r1,r1,28
lsr r1,r1,28

; Calculate tilesWritten, just pixels divided by 8.
add r0,r7,7
lsr r0,r0,3

; Combine and write to codeout.
lsl r0,r0,8
orr r0,r1
ldr r2,[sp,40]
strh r0,[r2]
add r2,r2,2
str r2,[sp,40]

; That's it for the control code.
b @@nextChar

@@pointerCode:
mov r0,r4
bl ReadUnalignedWord
add r5,r4,4
mov r4,r0
b @@nextChar

@@doneStr:
mov r4,r5
mov r5,0
; If it's not zero, we finished a name.  Back to the str.
cmp r4,0
bne @@nextChar

; Okay, time for cleanup.  Write out FFFF if we wrote zero control codes.
ldr r2,[sp,40]
cmp r2,r9
bne @@skipFFFF

mov r0,0xFF
strb r0,[r2,0]
strb r0,[r2,1]

@@skipFFFF:
mov r0,r7
add r0,11
mov r1,12
swi 6 ; Div

add sp,8
pop r1-r7
mov r8,r1
mov r9,r2
mov r10,r3
pop r1
bx r1
.pool
.endfunc
.endregion

; This main text draw func calls this when a flag is set to apply underline.
; We update to account for VWF.
.org 0x080022B4
.region 0x08002388-.,0x00
; Args: uint32_t *dst, const uint16_t *str
; Returns: uint16_t pixelWidthDiv12
.func DrawStrUnderline
push r4,r14

; Let's not parse again, just get the width.  Save dst in r4.
mov r4,r0
mov r0,r1
bl GetStrGlyphWidth

; Okay, how many tiles (r2), and what's the overflow (r3)?
lsr r2,r0,3
lsl r3,r2,3
sub r3,r0,r3

; Move dest forward to y=15 (where we draw the underline.)
add r4,15 * 4

; Here's the underline pixels.
ldr r1,=0x66666666

; r0=pixelWidth, r1=underlineColor, r2=tiles, r3=leftover, r4=dst
; Look while r2 >= 0.
@@nextTile:
sub r2,r2,1
bmi @@finalTile

str r1,[r4,0]
add r4,0x40
b @@nextTile

@@finalTile:
; Okay, now we have leftover (r3) left to draw.  Multiply for 4bpp.
lsl r3,r3,2
; And now prepare a mask to preserve other bits.
mov r2,1
neg r2,r2
lsl r2,r3
; And clear out our underline for those bits.
bic r1,r2

; Now let's update the last and partial tile.
ldr r3,[r4,0]
and r3,r2
orr r3,r1
str r3,[r4,0]

; Now divide the pixel count by 12.  Not sure this result is actually used...
add r0,11
mov r1,12
swi 6 ; Div

pop r4,r15
.pool
.endfunc
.endregion

; This is the function that draws the glyphs for most text.
; In the original, it's split between even and odd character versions.
; We also overwrite the space for the underline funcs, since we handle those separtely.
.org 0x08003B9C
.region 0x080041C8-.,0x00
; Args: uint16_t *glyph, uint32_t *dst, int xoff, int yoff, uint32_t clearBG, uint32_t width
.func DrawStrGlyph
push r4-r7
mov r7,r10
mov r6,r9
mov r5,r8
push r5-r7

; Prep and shelve dst+yoff for later.
lsl r3,r3,2
mov r8,r3
add r8,r1

; Now get width plus xoff, to decide how much to clear.
ldr r6,[sp,32]
add r6,r6,r2

; It's convenient to consider xoff (r2) in terms of bits, so expand.
lsl r2,r2,2

; First, we need to clear the next 12 pixels to BG, respecting xoff.
ldr r7,[sp,28]
; r4 will be the clear bits to set.
mov r4,r7
lsl r4,r2
; r5 will be the bits to mask.
mov r5,1
neg r5,r5
lsl r5,r2

; Setup our clear threshold.
; The original code skipped some, but we can't do that safely in VWF land.
mov r3,r1
add r3,64
mov r9,r3

@@nextClear:
; First tile, adjusted for xoff.
ldr r3,[r1]
bic r3,r5
orr r3,r4
stmia [r1]!,r3

; Let's always clear two tiles, the game assumes we rounded up.
; 60 and 124 because we added 4 above.
str r7,[r1,60]
str r7,[r1,124]

; Actually, if we're near the edge already, we might need to clear 4 tiles.  Skip for short letters.
cmp r6,16
bls @@noClear4
mov r3,188
str r7,[r1,r3]
@@noClear4:

cmp r1,r9
blo @@nextClear

; Save the xoff mask we created.
mov r12,r5

; Now move the yoff adjusted dst back to r1.
mov r1,r8
; And we'll end 12 words later.
mov r3,48
add r8,r3

; These are used to carry the shadow forward.
mov r3,0
mov r9,r3
mov r10,r3

; r0=glyph, r1=dst, r2=xoffBits, r3=FREE, r4=FREE, r5=FREE, r6=FREE, r7=FREE
; r8=dstEnd, r9=prevLine0, r10=prevLine1, r12=xoffMask
; sp+28=clearBG

@@nextLine:
; Read the glyph bits in at 1bpp...
ldrh r7,[r0]
add r0,r0,2

; Decode to 4bpp, left 8 pixels to r3.
; This goes from right to left on the tile.
mov r3,0
mov r6,28
@@nextBit0:
lsr r7,r7,1
bcc @@skipBit0

mov r5,1
lsl r5,r6
orr r3,r5

@@skipBit0:
sub r6,r6,4
bpl @@nextBit0

; Skip 4 bits, since those would be right of the ones we want.
lsr r7,r7,4

; Okay, and now the right 4 pixels to r4.
mov r4,0
mov r6,12
@@nextBit1:
lsr r7,r7,1
bcc @@skipBit1

mov r5,1
lsl r5,r6
orr r4,r5

@@skipBit1:
sub r6,r6,4
bpl @@nextBit1

; At this point, r3=first 8 pixels, r4=next 4 pixels.
; Now let's prepare shadows by merging in the prev line.
mov r6,r9
mov r7,r10
orr r6,r3
orr r7,r4
; And save this line back as the prev line.
mov r9,r3
mov r10,r4

; Shift next4 by 1 pixel (4 bits) plus 1 (to get the shadow color.)
lsl r7,r7,5

; If the rightmost pixel on shadow line0 is set, set a 2 in the leftmost next4 pixel.
mov r5,r6
lsr r5,r5,27
orr r7,r5

; It's simpler to handle on first8 now.
lsl r6,r6,5

; Okay, merge the shadows back in.
orr r3,r6
orr r4,r7

; Grab clearBG - if non-zero, we flip bits using it.
ldr r5,[sp,28]
cmp r5,0
beq @@skipFlip
sub r3,r5,r3
sub r4,r5,r4
@@skipFlip:

; Now we apply xoff to the tile dest row.
ldr r7,[r1,0]
mov r6,r12
bic r7,r6
; And merge in the bits for that tile.
mov r5,r3
lsl r5,r2
orr r7,r5
stmia [r1]!,r7

; Okay, what's the next tile's value?  First shift off the pixels drawn above.
mov r7,32
sub r7,r7,r2
lsr r3,r7
; And get more from r4 (next4) as needed.
mov r5,r4
lsl r5,r2
orr r3,r5
; And shift those bits off r4 now.
lsr r4,r7

; Offset of the next tile - 60 because we already incremented.
mov r7,60
; If we started > 16 bits (4 pixels) in, we have three total tiles to draw.
mov r5,16
sub r5,r5,r2
bpl @@skipMiddleTile

str r3,[r1,r7]
add r7,64
; Add 16 (4 pixels) to the negative, which will be the remaining bits to write.
add r5,16
mov r3,r4
; Fall through to draw the remaining bits from r3.

@@skipMiddleTile:
; We still have the initial xoff mask in r6, which always has its high bit set.
; Convert to FFFFFFFF by a simple asr.
asr r6,r6,31
; Now the bits to overwrite, based on r5.
lsr r6,r5

; Now we just load and mask.
ldr r5,[r1,r7]
bic r5,r6
orr r5,r3
str r5,[r1,r7]

; Done yet?
cmp r1,r8
blo @@nextLine

pop r1-r7
mov r8,r1
mov r9,r2
mov r10,r3
bx r14
.pool
.endfunc
.endregion

; This function looks up the glyph in a set of table based on Shift-JIS.
; Rewritten to also return a width in r1.
.org 0x0800348C
.region 0x0800350C-.,0x00
; Args: r0=uint16_t ch
; Return: r0=uint16_t *glyph, r1=int width
.func LookupGlyph
mov r1,0xFF
lsr r2,r0,8
; r1=low (first) byte, r2=high (second) byte
and r2,r1
and r1,r0

cmp r1,0x80
blo @@rangeASCII

; Is it outside the first JIS range?
cmp r1,0x9F
bhi @@rangeE0

; Start of JIS range 1.
sub r1,0x81
ldr r3,=0x08B6D624
b @@lookupJIS

@@rangeASCII:
; For now at least, we reuse the existing glyphs.
mov r0,r1
sub r0,32
ldr r3,=AsciiTable

; Lookup the width (by r0) in the width table.
ldr r1,=AsciiWidths
ldrb r1,[r1,r0]
b @@lookupIndex

@@rangeE0:
; Start of JIS range 2.  This table is right after the other ends.
sub r1,0xE0
ldr r3,=0x08B704A4

@@lookupJIS:
; Byte 2 can be one of 0xC0 options, so multiply by that.
; (x * 2 + x) * 64 = x * 192
lsl r0,r1,1
add r0,r0,r1
lsl r0,r0,6
; The first 64 are unused for byte 2 (that's why only 0xC0), subtract then add to index.
sub r2,64
add r0,r0,r2

; JIS are always fixed 12 width.
mov r1,12

@@lookupIndex:
; The glyph index is in an int16_t array, so double and lookup in table.
lsl r0,r0,1
ldrh r0,[r3,r0]

sub r0,r0,1 ; Sets N/mi if it was 0
bmi @@badEntry

; Get the glyph base address.
ldr r3,=0x03002984
ldr r3,[r3]

; Each glyph is 24 bytes, so multiply the looked up glyph index.
; (x * 2 + x) * 8 = x * 24
lsl r2,r0,1
add r2,r2,r0
lsl r2,r2,3

add r0,r3,r2

@@return:
bx r14

@@badEntry:
ldr r0,=0x08B6D5D0
b @@return
.pool
.endfunc
.endregion

; Gets the total pixel width, divided by 12.
; The game sorta uses this as a length, but makes assumptions about pixel width.
.org 0x0800B130
; Args: const char *str
.region 0x0800B1AC-.,0x00
.func GetStrGlyphWidth12
push r14
bl GetStrGlyphWidth
add r0,11
mov r1,12
swi 6 ; Div
pop r3
bx r3
.pool
.endfunc
.endregion

.autoregion
; Args: const char *str
; Returns width, in pixels (not tiles or by 12.)
.func GetStrGlyphWidth
push r4-r7,r15

; Save the string and prep a counter.
mov r4,r0
mov r7,0

; And a trick: this is where we push the str for a name.
; We reuse our main loop and just swap the pointer.
mov r5,0
; Fixed width flag.
mov r6,0xFF

; r0=FREE, r1=FREE, r2=FREE, r3=FREE, r4=str, r5=oldStr, r6=widthOverride, r7=pixels

@@nextChar:
; Read the first byte.
ldrb r0,[r4]
add r4,r4,1

; If it's 7F or lower, single byte (also end of string.)
cmp r0,0x7F
blo @@handleAscii
beq @@handleWidthControl

; Grab the high byte, but don't merge yet.
ldrb r1,[r4]
add r4,r4,1
lsr r2,r1,4

; 87 7? means control code (write to codeout), which we ignore.
cmp r0,0x87
bne @@checkNameCode
cmp r2,0x07
beq @@nextChar

; 83 C? means name code (output name variable.)
@@checkNameCode:
cmp r0,0x83
bne @@handleJIS
cmp r2,0x0C
bne @@handleJIS

; Okay, this is a name.  Grab the index * 9.
lsl r1,r1,28
lsr r1,r1,28
; (x * 8) + x == x * 9
lsl r0,r1,3
add r0,r0,r1
; Double, since it's 9 shorts.
lsl r0,r0,1

; Save old str.
mov r5,r4
; This is where the names are.
ldr r4,=0x03005580
add r4,r4,r0

; Okay, we're ready, process chars.
b @@nextChar

@@handleAscii:
cmp r0,0
beq @@doneStr

mov r1,0
; Fall-through.

@@handleJIS:
; Combine to a single character code.
lsl r1,r1,8
orr r0,r1

; Now grab the glyph (and, importantly, width.)
bl LookupGlyph
; That returned the width in r1.

cmp r6,0xFF
bne @@useFixedWidth

add r7,r1
b @@nextChar

@@useFixedWidth:
add r7,r6
b @@nextChar

@@handleWidthControl:
; Read the next byte, which will be the fixed width.
ldrb r6,[r4]
add r4,r4,1
b @@nextChar

@@doneStr:
mov r4,r5
mov r5,0
; If it's not zero, we finished a name.  Back to the str.
cmp r4,0
bne @@nextChar

mov r0,r7

pop r4-r7,r15
.pool
.endfunc
.endautoregion

.autoregion
.func ReadUnalignedWord
ldrb r1,[r0,0]
ldrb r2,[r0,1]
lsl r2,r2,8
orr r1,r2
ldrb r2,[r0,2]
lsl r2,r2,16
orr r1,r2
ldrb r0,[r0,3]
lsl r0,r0,24
orr r0,r1
bx r14
.endfunc
.endautoregion
