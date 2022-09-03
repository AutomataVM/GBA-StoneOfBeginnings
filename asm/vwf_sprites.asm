; ------------------------------
; code by unknownbrackets & teod
; ------------------------------


; --------------------------------------
; 21/04/07
; teod:
; rewrote DrawStrSpriteGlyphs in another
; file to have more space and implmented
; glyph packing
;
; fixed an issue where having 9 sprites
; would consistently softlock the game
; where the hammer would not appear to
; advance the dialog
; --------------------------------------

; --------------------------------------
; 21/03/31
; teod: there are 5 specific patches
; 3 is for relocating the sprite entries
; 1 is to remove unused params
; 1 is to relocate vram destination
; --------------------------------------

.definelabel DrawStrSpriteGlyph,0x08002CB4

; teod: addr for relocated sprite entries
NewAddr equ 0x02034000


; This is the function that draws glyphs as sprites.
; We extend to support ASCII/etc.
.org 0x080036F8
.region 0x0800379C-.,0x00
; Args: uint32_t *dst, const uint16_t *str, int8_t *widths
; Returns: uint16_t charsDrawn
.func DrawStrSpriteGlyphs
push r4-r7,r14
mov r7,r10
mov r6,r9
mov r5,r8
push r5-r7

; Save out the important parameters.
mov r10,r0
mov r4,r1
mov r9,r2

; This will count drawn characters.
mov r7,0
; And a trick: this is where we push the str for a name.
; We reuse our main loop and just swap the pointer.
mov r5,0
; Fixed width flag.
mov r6,0xFF

; r0=FREE, r1=FREE, r2=FREE, r3=FREE, r4=str, r5=oldStr, r6=widthOverride, r7=charsWritten
; r8=FREE, r9=widths, r10=dst, r12=FREE?, r14=FREE

@@nextChar:
; Read the first byte.
ldrb r0,[r4]
add r4,r4,1

; If it's 7F or lower, single byte (also end of string.)
cmp r0,0
beq @@doneStr

cmp r0,0x7F
; ble @@handleAscii
blo @@handleAscii
beq @@handleWidthControl

; Grab the high byte, but don't merge yet.
ldrb r1,[r4]
add r4,r4,1
lsr r2,r1,4

; 87 7? means control code (ignored here.)
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
; lsl r0,r1,3
; add r0,r0,r1
; Double, since it's 9 shorts.
; lsl r0,r0,1
mov r0, 18
mul r0, r1

; Save old str.
mov r5,r4
; This is where the names are.
ldr r4,=0x03005580
add r4,r4,r0

; Okay, we're ready, process chars.
b @@nextChar

@@handleJIS:
; Combine to a single character code.
lsl r1,r1,8
orr r0,r1

@@handleAscii:
; cmp r0,0
; beq @@doneStr

; mov r1,0
; Fall-through.

; Now grab the glyph.
bl LookupGlyph
; That returned the width in r1.
mov r8,r1

; Prep the dst, always a multiple of 4 tiles.
lsl r1,r7,7
add r1,r10

bl DrawStrSpriteGlyph
add r7,r7,1

; Okay, get the last width offset - 1.
sub r3,r7,2
add r3,r9

; Set r2 to the width (applying override if needed.)
mov r2,r6
cmp r2,0xFF
bne @@keepFixedWidth
mov r2,r8
@@keepFixedWidth:
; Sum this width with the last one.  Subtract 12 first, since that's the sprite default.
; sub r2,12
cmp r7,1
bls @@skipAddFirst
mov r1,0
ldsb r1,[r3,r1]
add r2,r2,r1
@@skipAddFirst:
strb r2,[r3,1]
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

pop r1-r7
mov r8,r1
mov r9,r2
mov r10,r3
pop r15
.pool
.endfunc
.endregion


.org 0x0800B730
.region 0x0800B8F4-.,0x00
; Args: uint16_t index, const uint16_t *str
.func DrawStrSprites
push r4-r7,r14
; We can't have more than 8 characters (see +0x0174 buffer), but let's have extra space.
sub sp,16

; Convert index into an offset by bytes, masking first.
lsl r0,r0,16
lsr r0,r0,16
; 0x019C = 0x67 << 2
mov r2,0x67
lsl r2,r2,2
mul r0,r2

; Add the base and save the pointer.
ldr r6,=0x030056C0
add r6,r6,r0

; Update a flag (?) on the struct.
mov r0,1
strb r0,[r6,9]
; r2 is still 0x19C, sub 4 to 0x198.
sub r2,r2,4
; Put the string in at the end.
str r1,[r6,r2]
; Save the 0x198 for later as 0x194.
sub r5,r2,4

; This has the current target pos and offset.  Sum after aligning.
ldr r7,=0x03005180 + 0x03A8 ; 0x03005528
ldr r4,[r7,0]
ldr r2,[r7,8]
mov r0,3
bic r2,r0
add r4,r4,r2

; Now let's draw some glyphs.  r1 is still str.
mov r0,r4
mov r2,sp

; teod: relocated function
;ldr r3, =DrawStrSpriteGlyphs
;bl BXR3
;bl DrawStrSpriteGlyphs
bl RenderStringToSprites
; We saved 0x194 in r5 earlier.  Not sure what this value is, used for the next func.
ldr r1,[r6,r5]

; Store the glyph count.
strb r0,[r6,2]
; We'll need it after this call too, so save it away.
mov r5,r0

; And also convert to bytes for r2.
lsl r2,r0,7
; Finally r0 is just dst, which we stashed in r4.
mov r0,r4
; Not sure what this does exactly.
; teod: something to do with setting up the vram destination
; to be copied into
bl 0x08006BA4

; Now move forard that offset by bytes written.
lsl r0,r5,7
ldr r1,[r7,8]
add r1,r1,r0
str r1,[r7,8]

; 0x55 << 2 = 0x154
mov r1,0x55
lsl r1,r1,2
add r1,r1,r6

; We'll need this a bunch soon.
mov r3,0
; Okay, start filling in some struct fields.  Not sure the point of all of these.
str r3,[r1,0]
; This is still bytes written.
str r0,[r1,4]
strh r3,[r1,8]
; Convert r5 (charsWritten) to tile count.
lsl r0,r5,2
strh r0,[r1,10]
strh r0,[r1,12]
strh r3,[r1,14]
; Copy the value at +0x0194 to +0x0164.  Keep it in r2.
ldr r2,[r1,64]
str r2,[r1,16]
str r3,[r1,20]
; Store a pointer to +0x0170 at +0x016C.
mov r0,r1
add r0,28
str r0,[r1,24]
str r5,[r1,28]



; ----------------------------------------
; teod: these params don't seem to be used
; anywhere else in the game
; removed since it overwrites into other
; stuff when having more than 8 sprites
; ----------------------------------------

; We update the next part for each character.  But prep a reused value first.
; ldrb r4,[r6,12]
; lsl r4,r4,12

; Trick: we fill in reverse, 4 bytes for each character (r5 is # of characters.)
; lsl r7,r5,2
; It's at +0x0174, so we add 0x20 to r1 temporarily.
; add r1,0x20

; @@nextCharInfo:
; sub r7,r7,4
; bmi @@charInfoDone

; Construct: { (uint8_t)0, (uint8_t)0x40, (uint16_t)(r7 | r4) }
; add r0,r7,r4
; lsl r0,r0,8
; add r0,0x40
; lsl r0,r0,8
; And write it all in one shot.
; str r0,[r1,r7]
; b @@nextCharInfo

; @@charInfoDone:
; sub r1,0x20





; At this point, all the args for 08009334 have been prepared except r0.
; Not entirely sure what this does, but presumably uses all those params we set.
ldrb r0,[r6,13]
bl 0x08009334

; Now a quick chain of funcs, which seems to prepare the sprites maybe?
mov r0,3
mov r1,7
bl 0x08001D3C
ldrb r1,[r6,15]
bl 0x08001D78
; This ends up as a value pointing into the ROM...
mov r2,r0
ldrb r0,[r6,14]
ldrb r1,[r6,13]
bl 0x0800A630

; Alright, one more loop for each character to prep the sprite info.
cmp r5,0
beq @@doneSprites

mov r7,0

; --------------------------------------------
; teod: this is to relocate the sprite entries
; mov r4,r6
; add r4,20
ldr r4, =NewAddr
; --------------------------------------------

@@nextSprite:
mov r0,r4
bl 0x08009F0C

; This seems to place the tiles and pos offset based on r2?
mov r0,r4
ldrb r1,[r6,14]
mov r2,r7
ldrb r3,[r6,16]
bl 0x08009F50

mov r0,r4
; These are the X,Y coordinates of the string start.
; They are automatically offset by the character at a standard width.
mov r3,4
ldsh r1,[r6,r3]
mov r3,6
ldsh r2,[r6,r3]

cmp r7,0

beq @@skipAdjust

; Here's where we apply our VWF.  The sum width offset so far is at sp[pos - 1].
; This sum already subtracts 12 for each character, so it's always negative.
mov r3,sp
sub r3,r3,1
ldsb r3,[r3,r7]
; ------------------------------------------
; teod: 21/6/6
; special case for non-doubled text

; ************** old code ******************
; Originally, the game makes the first letter slightly shorter (not sure why?)
; TODO: Keeping that for now...
; sub r3,r3,1
; TODO: How do we know it's doubled?  Sometimes it isn't it seems like?
; add r1,r1,r3
; add r1,r1,r3


; ************** new code ******************
; 0x030056CF stores the scaling option
ldr  r0,=0x030056CF
ldrb r0,[r0]
cmp  r0,0
bne  @@double
sub r3,r3,1 ; temporary measure, todo: need to edit sprite tables
add r1,r1,r3
b   @@skipAdjust

@@double:
add r1,r1,r3
add r1,r1,r3
; ------------------------------------------

@@skipAdjust:
; uses r0,r1,r2
mov r0,r4
bl 0x0800A678

mov r0,r4
ldrb r1,[r6,12]
mov r2,1
bl 0x0800A6C0

mov r0,r4
mov r1,1
lsl r1,r1,8
bl 0x0800A6CC

add r4,0x28
add r7,r7,1
cmp r7,r5
blo @@nextSprite

@@doneSprites:
; Technically two bytes, let's simplify as a halfword store.
mov r0,2
strh r0,[r6,0]

add sp,16
pop r4-r7
pop r0
bx r0
.pool
.endfunc
.endregion

; ---------------------------------------
; teod: fixing the sprite entry offsets
; there are 2 spots that need to be fixed
; ---------------------------------------

; ---------------------------------
; 1st location
; redo everything to get more space
; ---------------------------------

.org 0x0800CF84
.region 0x0800CFF6-.,0x00
.func sub_800CF84

push  r4-r7, lr
mov   r2, 0

LOC_C:
; pointless lines
; mov   r0, 0x19C
; mov   r1, r2
; muls  r1, r0
; ldr   r0, =0x30056C0
ldr   r5, =0x030056C0
; add   r5, r1, r0
mov   r6, 0
add   r7, r2, 1
ldrb  r0, [r5,1]
; cmp   r6, r0
; bcs   LOC_E (0 >= r0) -> (r0 == 0?)
cmp   r0, 0
beq   LOC_E

ldr   r4, =NewAddr

LOC_D:
mov   r0, r4
bl    0x08009FF8
mov   r0, r4
bl    0x0800A778
add   r4, 40
add   r6, 1
ldrb  r2, [r5,1]
cmp   r6, r2
blo   LOC_D

LOC_E:
ldrb  r1, [r5,1]
; mov   r2, 0x170
mov   r2, 0x17
lsl   r2, 4
add   r0, r5, r2
ldr   r0, [r0]
cmp   r1, r0
bne   LOC_F

mov   r0, 1
strb  r0, [r5]
b     LOC_H

LOC_F:
ldrb  r1, [r5,8]
cmp   r1, 0
beq   LOC_G

ldrb  r0, [r5,3]
sub   r0, 1
strb  r0, [r5,3]
lsl   r0, r0, 0x18
cmp   r0, 0
bge   LOC_H

strb  r1, [r5,3]
ldrb  r0, [r5,1]
add   r0, 1

LOC_G:
strb  r0, [r5,1]

LOC_H:
; r7 is always 1
; mov   r2, r7
; cmp   r2, 0
; beq   LOC_C

pop   r4-r7
pop   r0
bx    r0

.pool
.endfunc
.endregion

; ------------
; 2nd location
; ------------

.org 0x0800ED78
.region 0x0800EDE8-.,0x00
.func sub_800ED78

push  r4-r7,lr
; mov   r2, 0

LOC_J:
; redundant
; mov   r0, 0x19C
; mov   r1, r2
; mul   r1, r0
; ldr   r0, =0x30056C0
; add   r5, r1, r0
ldr   r5, =0x30056C0
ldrb  r0, [r5]
cmp   r0, 1
beq   LOC_K; r0==1

; redundant
; add   r7, r2, 1
; cmp   r0, 1
; ble   LOC_N; r0<=1

cmp   r0, 2
bne   LOC_N; r0!=2

mov   r0, r5
bl    0x0800CF84
b     LOC_N

LOC_K:
mov   r6, 0
; mov   r1, 0x170
mov   r1, 0x17
lsl   r1, 4
add   r0, r5, r1
ldr   r0, [r0]
; add   r7, r2, 1
cmp   r6, r0
bcs   LOC_N

; old address
; ROM:0800EDB4                 MOVS    R4, R5
; ROM:0800EDB6                 ADDS    R4, #0x14
; ROM:0800EDB8

; new address
ldr   r4, =NewAddr

; ROM:0800EDB8 loc_800EDB8                             ; CODE XREF: sub_800ED78+62↓j
LOC_L:
mov   r0, r4
bl    0x8009FF8
; mov   r0, 9
; ldrsb r0, [r5,r0]
ldrb  r0, [r5,9]
cmp   r0, 1
bne   LOC_M

mov   r0, r4
bl    0x800A778

LOC_M:
add   r4, 0x28
add   r6, 1
; mov   r1, 0x170
mov   r1, 0x17
lsl   r1, 4
add   r0, r5, r1
ldr   r0, [r0]
cmp   r6, r0
bcc   LOC_L

LOC_N:
; mov   r2, r7
; cmp   r2, 0
; beq   LOC_J
pop   r4-r7
pop   r0
bx    r0

.pool
.endfunc
.endregion

; ------------
; 3rd location
; ------------

; instead of loading numChars, the value
; is fixed to 1 to always check a safe place
.org 0x0800D944
mov r1, 1


; -------------------------------------
; teod: reposition vram destination
; this allows more space for more tiles
; -------------------------------------

.org 0x0800D8F8
; original location at tile 0
; .dw 0x06010000
; tile 448
.dw 0x06013800
; tile 320
; .dw 0x06012800
