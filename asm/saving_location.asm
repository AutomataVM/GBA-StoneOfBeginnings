
; saving_location.asm
; by teod
; 2022-07-04
;
; modify how the location strings are stored and read
; originally the main location and sub location are separate
; and stored at fixed locations
;
; now the locations are simply stored together
; while the "reader" parses for the separation character

; -------------------
; prepareSave_8091538
; -------------------
; this subroutine prepares a save in memory for writing to eeprom
; we're patching how the location string is written
; previously, location and sub-location are separated by sjis space...
; now we're simply writing both together...
;
; i.e, removing the string separation logic...
; and moving that logic into the rendering routine
;
; main location = a2+0x18 .. a2+0x2A
; sub location = a2+0x2C .. a2+0x3E
; 0x18 .. 0x3E => 0x40-0x18 = 0x28 bytes (40 bytes)
;
; r6 = a2+0x18
; r9 = a2 = safe offset (slot 1: a+0x10, slot 2: a+0x54)
; r10 = a = des for save

.org 0x8091668
.region 0x80916FE-.,0x00
; getPlaceNamePtr_8018E64
; calling this routine gets us the string for the location
bl 0x8018E64

mov r2, 0
; just simply copy until null
@@loop:
ldrb r1, [r0,r2]
strb r1, [r6,r2]
add r2, 1
; safety check
cmp r2, 39
bge @@done
cmp r1, 0
bne @@loop

@@done:
;b 0x8091798
; safety null
mov r1, 0
strb r1, [r6,r2]
b 0x809179E
.pool
.endregion

; -------------------
; SplitLocationString
; -------------------
; empty space from prepareSave
;
; splits the input into two locations
; using a separation character
;
; r0 = input string
; r1 = output buffer
;
; -> r0 = ptr to 2nd part of string
.org 0x8091714
;.region 0x08091798-.,0x00
.region 0x0809179E-.,0x00
.func SplitLocationString

; copy first part of location until null or '81 40' (sjis space)
@@loop1:
ldrb r2, [r0]
strb r2, [r1]
add r0, 1
add r1, 1
cmp r2, 0
beq @@done1
cmp r2, 0x81
bne @@loop1
ldrb r2, [r0]
strb r2, [r1]
add r0, 1
add r1, 1
cmp r2, 0
beq @@done1
cmp r2, 0x40
bne @@loop1
; we've hit '81 40'
sub r1, 2
mov r2, 0
strb r2, [r1]
add r1, 1
; strb r2, [r1]
; location for 2nd part of string
mov r3, r1
@@loop2:
ldrb r2, [r0]
strb r2, [r1]
add r0, 1
add r1, 1
cmp r2, 0
bne @@loop2

mov r0, r3
bx lr

@@done1:
; 2nd string points to null
sub r0, r1, 1
bx lr

.endfunc
.pool
.endregion


; ------------------
; renderSave_8090CFC
; ------------------
; checks and renders info about the save file (the save/load menu)
; does this for slot 1 and slot 2

; get more space
; pointer + 40 byte buffer
; sp+44: ptr to str2
; sp+48: str1
.org 0x8090D06
;sub sp, sp, 44+88
sub sp, sp, 44+44

; split our string for slot 1
; ---------------------------
.org 0x8090E76
.region 0x8090E94-., 0x00				
mov r1, 1
strb r1, [r4,14]
mov r1, 0x50
strh r1, [r4,20]
; r5 = 0 here
strh r5, [r4,22]
mov r1, 2
strb r1, [r4,24]
strb r1, [r4,25]

; get at string for slot 1
; r7 = [r6,36] = [a+36]
mov r0, r7
add r0, 40
add r1, sp, 48
bl SplitLocationString
str r0, [sp,44]
.endregion

.org 0x8090EB0
; orig:
; mov r2, r7
; add r2, 40
add r2, sp, 48
nop

.org 0x8090ECA
; orig:
; mov r2, r7
; add r2, 60
ldr r2, [sp,44]
nop

; split our string for slot 2
; ---------------------------
.org 0x80910EA
.region 0x8091108-., 0x00
mov r1, 1
strb r1, [r4,14]
mov r1, 0x50
strh r1, [r4,20]
strh r1, [r4,22]
mov r1, 2
strb r1, [r4,24]
strb r1, [r4,25]

; get at string for slot 2
; r8 = [r6+36] = [a+36]
mov r0, r8
add r0, 108
add r1, sp, 48
bl SplitLocationString
str r0, [sp,44]
.endregion

.org 0x8091126
; orig:
; mov r2, r8
; add r2, 0x6C
add r2, sp, 48
nop

.org 0x8091140
; orig:
; mov r2, r8
; add r2, 0x80
ldr r2, [sp,44]
nop

; return stack space
.org 0x809131E
add sp, sp, 44+44
