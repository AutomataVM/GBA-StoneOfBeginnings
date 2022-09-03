; teod 22-05-29
; fixes handling of sjis chars as ascii chars
; also fixes text centering

; dependencies:
; vwf_main.asm -> GetStrGlyphWidth

.org 0x0806D3CC
.region 0x0806D4B4-.,0x00

; lookup and check
ldr r0, =0x30056B8
bl 0x801BAD8

cmp r0, 1
beq @@getStr1
; return
; b 0x0806D356
b 0x806D71E

@@getStr1:
; some init function
ldr r0, =0x30056B8
mov r1, 1
bl 0x80199C0

; src = item string
mov r5, 0
ldr r0, =0x3005170
ldr r1, [r0]
ldrb r0, [r1]

add r6, sp, 40
add r3, sp, 80
mov r10, r3

cmp r0, 0
beq @@getStr2
; des = str buffer
add r2, r6, 0

@@copyStr1:
ldrb r0,[r1]
strb r0,[r2]
add r1,1
add r2,1
add r5,1
cmp r5,32
bge @@calcX
;ldrb r0,[r1]
cmp r0, 0
bne @@copyStr1

@@getStr2:
; r7 = "strlen" of item string
; src = "obtained!" string
; mov r3, 0
ldr r0, =0x3005174
ldr r1, [r0]
ldrb r0, [r1]

cmp r0, 0
beq @@calcX
sub r5, 1
add r2, r5, r6

@@copyStr2:
ldrb r0,[r1]
strb r0,[r2]
add r1,1
add r2,1
add r5,1
cmp r5,32
bge @@calcX
cmp r0, 0
bne @@copyStr2

@@calcX:
; safety: terminate with null char
add r0, r6, r5
mov r1, 0
strb r1, [r0]

; get width of string in pixels
; function from vwf_main.asm
; the game originally calls strlen_800B130
; which gives the amount of chars the string uses
; similar to length of string but special chars
; reference strings (such as mc/partner names)
mov r0, r6
bl GetStrGlyphWidth
; width=240px, icon=16px, edges=32px
; => remaining = 240-16-32 = 192px => 24 tiles
; xoff = (30-(textWidth+7)/8)/2
;      = 15 - (textWidth+7)/16
; add r0, 7
lsr r0, 4
mov r3, 15
sub r3, r0
cmp r3, 4
bge @@render
mov r3, 4

@@render:
; icon x
sub r4, r3, 2
; slot struct
ldr r0, =0x3005888
; y offset
ldr r7, =0x3006B14
ldrh r1, [r7]
add r1, 1
str r1, [sp]
; sub-palette
ldr r1, =0x44444444
str r1, [sp,4]
; palette
mov r1, 0
str r1, [sp,8]
; unknown
mov r2, 2
str r2, [sp,12]
str r1, [sp,16]
mov r2, r6
; render string
; r0      : slot
; r1      :
; r2      : string
; r3      : x offset
; [sp]    : y offset
; [sp+4]  : sub-palette
; [sp+8]  : palette
; [sp+12] :
; [sp+16] :
bl 0x800B1AC

; lookup item icon
mov r0, 3
mov r1, 6
bl 0x8001D3C
mov r1, r0
ldr r0, =0x3006AFC
ldr r0, [r0]
ldr r3, =0xFA000500
add r6, r0, r3
cmp r6, 0
bge 0x0806D4B4
ldr r2, =0xFA00051F
add r6, r0, r2
b 0x0806D4B4

.pool
.endregion


