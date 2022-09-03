; **********************
; *** name_input.asm ***
; ***    by teod     ***
; **********************
; dependencies:
; - vwf (ascii support)
; - sjis2ascii.asm

; ***************
; ** changelog **
; ***************
; 21-12-17
; - implement main name "idle" drawing func
; - reimplement sjis/ascii delete algo
; 21-12-14
; - fixed bug for loading partner names
;   (forgot to add +8 offset)
; 21-12-12
; - known bug: no auto confirm window when
;              name length is max
;    * likely 0x80A86C8 needs to be implemented
;    * it an idle func that runs in the bg
; - known bug: deleting ascii vs sjis char
;    * mainly an issue of sjis encoding...
; - reimplement default names
; - reimplement backspace
; - reimplement input char
; - added sjis2ascii conversion
; - dependent on vwf and sjis2ascii.asm
; 21-12-10
; - reimplement menu logic
; - this should work the same as original
; - independent of vwf / no ascii support

; **********
; ** data **
; **********
@cursorBlink equ 0x3003364

@btn_press   equ 0x3005920
@btn_fire    equ 0x3005944

; ------------------------
@menu_struct equ 0x3006B80
; ------------------------
; a = [0x3006B80]
; a+0  (half) = state; 3:main, 7:nickname
; a+2  (half) = ???
; a+4  (half) = true x cursor (0<=x<=16; cols 5,11 are empty)
; a+6  (half) = true y cursor (0<=y<=6; row 6 is special)
; a+8  (half) = currChar (x cursor)
; a+10 (half) = currLine (y cursor)
; a+12 (byte) = 0:mc, 1:partner
; a+13 (byte) = ???
; a+14 (byte) = currScreen (z); 0:hiragana, 1:katakana, 2:romanji
; a+15 (byte) = numChars (limit 6 halfs)

; -------------------------
@source_array equ 0x8BD566C
; -------------------------
; a = z*4 + 0x8BD566C (z = currScreen)
; b = y*4 + [a]       (y = currRow)
; c = x*2 + [b]       (x = currCol)

@defaultNames equ 0x8BD5788
@defaultNicks equ 0x8BD57B0

; **********************
; ** menu logic funcs **
; **********************
@func_setDefName equ 0x80A82A4 ; needs patching
@func_setDefNick equ 0x80A8364 ; needs patching
@func_inputChar  equ 0x80A83C8 ; 0x65
@func_backspace  equ 0x80A8448 ; some logic... addEvent(0x66,0);

@func_idle equ       0x80A86C8

@func_moveCursor equ 0x80A8924 ; 0x64
@func_doneInput  equ 0x80A94DC ; 0x65
@func_setScreen  equ 0x80A9520 ; 0x6A
@func_redraw     equ 0x80A954C ; some logic... addEvent(0x6A,0);

; other funcs
@func_renderString    equ 0x800B1AC
@func_prepareTextSlot equ 0x800B4E4
@func_getGlobal       equ 0x8012F60 ; looks up a certain index to get a global

; ************
; ** events **
; ************
; 0x64 : sets cursor position
; 0x65 : checks state; either redraw string or triggers confirmation window
; 0x66 : backspace
; 0x6A : draw / redraws whole screen
@func_addEvent   equ 0x80147B8 ; triggers gfx events


; ******************
; *** menu logic ***
; ******************
; no inputs, no outputs
.org 0x080A812C
.region 0x080A82A4-., 0x00
push {lr}

; get menu struct pointer
ldr r0, =@menu_struct
ldr r2, [r0]

; get button input
ldr r0, =@btn_press
ldrh r1, [r0]

mov r0, 1
and r0, r1
; cmp  r0, 0
beq @checkB

; ----------------
; A PRESS (Choose)
; ----------------
; x<6 || y<6 are characters
ldrh r0, [r2,8] ; x
ldrh r1, [r2,10]; y
cmp r0, 6
blt @inputChar
cmp r1, 6
blt @inputChar

; x>=6 && y==6
cmp r0, 15
beq @doneInput
cmp r0, 12
beq @backspace

; z desc     l r
; - -------- - -
; 0 hiragana 1 2
; 1 katakana 0 2
; 2 romanji  0 1
mov r1, 14
ldrb r1, [r2,r1]; z

cmp r0, 9
beq @right
cmp r0, 6
beq @left
; default case
b @done

@left:
cmp r1, 0
beq @katakana
mov r0, 0
b @setScreen

@katakana:
mov r0, 1
b @setScreen

@right:
cmp r1, 2
beq @katakana
mov r0, 2
b @setScreen

@inputChar:
bl @func_inputChar
b @done

@checkB:
mov r0, 2
and r0, r1
beq @checkL

; -------------------
; B PRESS (Backspace)
; -------------------
@backspace:
bl @func_backspace
b @done


@checkL:
ldrb r3, [r2,14]
ldr r0, =0x200
and r0, r1
beq @checkR

; -------------------
; L PRESS (Menu Left)
; -------------------
sub r0, r3, 1
b @setScreen

@checkR:
ldr r0, =0x100
and r0, r1
beq @checkStart

; --------------------
; R PRESS (Menu Right)
; --------------------
add r0, r3, 1
@setScreen:
bl @func_setScreen
bl @func_redraw
b @done

@checkStart:
mov r0, 8
and r0, r1
beq @checkUp

; --------------------
; START PRESS (Finish)
; --------------------
@doneInput:
bl @func_doneInput
mov r0, 0x65
b @addEvent

@checkUp:
ldr r0, =@btn_fire
ldrh r1, [r0]
ldrh r3, [r2,6]; y
ldrh r2, [r2,4]; x

mov r0, 0x40
and r0, r1
beq @checkDown

; --------------------
; UP PRESS (Cursor Up)
; --------------------
sub r3, 1
b @moveCursor

@checkDown:
mov r0, 0x80
and r0, r1
beq @checkLeft

; ------------------------
; DOWN PRESS (Cursor Down)
; ------------------------
add r3, 1
b @moveCursor

@checkLeft:
mov r0, 0x20
and r0, r1
beq @checkRight

; ------------------------
; LEFT PRESS (Cursor Left)
; ------------------------
sub r2, 1
b @moveCursor

@checkRight:
mov r0, 0x10
and r0, r1
beq @done ; todo: possibly implement a secret menu lol!

; --------------------------
; RIGHT PRESS (Cursor Right)
; --------------------------
add r2, 1
;b @moveCursor

@moveCursor:
mov r0, r2
mov r1, r3
bl @func_moveCursor
mov r0, 0x64
@addEvent:
mov r1, 0
bl @func_addEvent

@done:
pop {r0}
bx r0
.pool
.endregion


; ******************
; *** setDefName ***
; ******************
; no inputs, no outputs
.org 0x080A82A4
.region 0x080A8364-., 0x00
push {r4-r6,lr}

; grab menu struct
ldr r0, =@menu_struct
ldr r6, [r0]; r6 = menu struct

; mc or partner ?
ldrb r0, [r6,12]
cmp r0, 2
bhs @done4
; mc=0, partner=1
ldr r1,=0x182
add r0, r1
bl @func_getGlobal; gets an index to a default name

; grab src ptr
ldrb r1, [r6,12]
lsl r1, r1, 3
lsl r0, r0, 2
add r0, r0, r1; if partner: defaultNames+8
ldr r1, =@defaultNames
ldr r5, [r1,r0]; r5 = source

; des ptr
mov r4, 48
add r4, r6

; copy
mov r1, 0
@loop:
ldrb r0, [r5,r1]
strb r0, [r4,r1]
add r1, 1
cmp r0, 0
bne @loop

; update len
sub r1, 1
strb r1, [r6,15]

@done4:
pop {r4-r6}
pop {r0}
bx r0
.endregion

; ******************
; *** setDefNick ***
; ******************
.org 0x080A8364
.region 0x080A83C8-., 0x00
push {r4-r6,lr}

; grab menu struct
ldr r0, =@menu_struct
ldr r6, [r0]; r6 = menu struct

; safety check...
ldrb r0, [r6,12]
cmp r0, 0
bne @done5
; get mc name index (0=ritchie, 1=rif)
ldr r0,=0x182
bl @func_getGlobal; gets an index to a default name

; grab src ptr
ldr r1, =@defaultNicks
lsl r0, r0, 2
ldr r5, [r1,r0]; r5 = source

; des ptr
mov r4, 62
add r4, r6

; copy
mov r1, 0
@loop2:
ldrb r0, [r5,r1]
strb r0, [r4,r1]
add r1, 1
cmp r0, 0
bne @loop2

; update len
sub r1, 1
strb r1, [r6,15]

@done5:
pop {r4-r6}
pop {r0}
bx r0
.endregion

; *****************
; *** inputChar ***
; *****************
; no inputs, no outputs
.org 0x080A83C8
.region 0x080A8448-., 0x00
push {r4,lr}

; -------------------
; grab struct pointer
; -------------------
ldr r0, =@menu_struct
ldr r4, [r0]
ldrb r3, [r4,15] ; length - this is what we need to fix
                 ; used to be number of 2 byte chars
				 ; fix to change to string length in bytes
cmp r3, 12
bhs @done2 ; length >= 12 (12 bytes max)

; --------------
; grab character
; --------------
ldr r1, =@source_array ; s
ldrb r0, [r4,14] ; z
lsl r0, 2
ldr r1, [r1,r0] ; a = [s + z*4] (which screen?)
ldrh r0, [r4,10] ; y
lsl r0, 2
ldr r1, [r1,r0] ; b = [a + y*4] (which line?)
ldrh r0, [r4,8] ; x
lsl r0, 1
ldrh r2, [r1,r0] ; c = [b + x*2] (which char?)

; convert full-width to ascii
mov r0, r2
bl sjis2ascii ; only uses r0 and r1

; -------------
; main or nick?
; -------------
ldrh r1, [r4]
cmp r1, 3
bne @checkNick
; main name
mov r1, 48
b @getDes
@checkNick:
cmp r1, 7
bne @done2
; nick name
mov r1, 62
@getDes:
add r1, r1, r4; r1+s

; -----------
; copy to des
; -----------
cmp r0, 0
bne @ascii
; sjis
cmp r3, 11
bhs @done2; len >= 11 means sjis char won't fit
; store sjis
strb r2, [r1,r3]
lsr r0, r2, 8
add r3, 1
@ascii:
strb r0, [r1,r3]
add r3, 1
strb r3, [r4,15]

@done2:
pop {r4}
pop {r0}
bx r0
.pool
.endregion

; *****************
; *** backspace ***
; *****************
; no inputs, no outputs
.org 0x080A8448
.region 0x080A84AC-., 0x00

push {lr}
; grab name length
ldr r0, =@menu_struct
ldr r2, [r0]
ldrb r0, [r2,15]; len
ldrh r1, [r2]; main/nick
cmp r0, 0
beq @restoreDefault

; grab string
cmp r1, 3
bne @nick2
mov r3, 48
b @delete2
@nick2:
mov r3, 62

; erase character
@delete2:
; add r3, r3, r2
; mov r1, 0
; sub r0, 1
; strb r1, [r3,r0]
; strb r0, [r2,15]; update len
; beq @done3 ; len==0
; sub r0, 1
; ldrb r1, [r3,r0]
; cmp r1, 0x80
; blo @done3 ; r1<0x80 -> ascii
; ; character >= 0x80
; ; -> must be sjis
; mov r1, 0
; strb r1, [r3,r0]
; strb r0, [r2,15]; update len
; b @done3

; parse sjis/ascii
add r3, r3, r2; str ptr
add r1, r3, r0; end

@parse:
ldrb r0, [r3]
cmp r0, 0x80
blo @ascii2

; sjis
add r3, 2
cmp r3, r1
blo @parse
; end reached
sub r3, 2
ldrb r0, [r2,15]
sub r0, 2
b @done6

; ascii
@ascii2:
add r3, 1
cmp r3, r1
blo @parse
; end reached
sub r3, r3, 1
ldrb r0, [r2,15]
sub r0, 1
b @done6

@restoreDefault:
; nothing more to delete
cmp r1, 3
bne @restoreNick
bl @func_setDefName
b @done3
@restoreNick:
bl @func_setDefNick

@done6:
strb r0, [r2,15]
mov r0, 0
strb r0, [r3]
strb r0, [r3,1]

@done3:
mov r0, 0x66
mov r1, 0
bl @func_addEvent
pop {r0}
bx r0
.pool
.endregion

; *************************
; *** mainNameInputIdle ***
; *************************

.org 0x080A86C8
.region 0x080A87CC-., 0x00
push {r4-r7,lr}
mov r7, r8
push {r7}
sub sp, sp, 44

ldr r0, =@menu_struct
ldr r4, [r0]; s
add r2, sp, 20; des = sp+20

; copy name to buffer
mov r1, 48
add r1, r1, r4; src = s+48
mov r3, 0
@name2buffer:
ldrb r0, [r1,r3]
strb r0, [r2,r3]
add r3, 1
cmp r3, 14
blo @name2buffer

ldrb r3, [r4,15]; length
cmp r3, 12
bhs @space

ldrh r0, [r4]
cmp r0, 4
bhi @space
cmp r0, 3
blo @space
ldr r0, =@cursorBlink
ldr r0, [r0]
mov r1, 16
and r0, r1
beq @space

; attach cursor
;mov r0, 0x81
;strb r0, [r2,r3]
;add r3, 1
;mov r0, 0x51
;strb r0, [r2,r3]
mov r0, 0x5F
strb r0, [r2,r3]
mov r0, 0x20
add r3, 1
strb r0, [r2,r3]
b @draw

; let's try 2 spaces...
@space:
mov r0, 0x20
strb r0, [r2,r3]
add r3, 1
strb r0, [r2,r3]
;mov r0, 0x81
;mov r1, 0x40
;strb r0, [r2,r3]
;add r3, 1
;strb r1, [r2,r3]
;add r3, 1
;strb r0, [r2,r3]
;add r3, 1
;strb r1, [r2,r3]

; call draw funcs
@draw:
ldrh r0, [r4,38]
cmp r0, 0
beq @skip1
mov r0, 38
add r0, r0, r4
bl @func_prepareTextSlot

@skip1:
ldrh r0, [r4,32]
cmp r0, 0
beq @skip2
mov r0, 32
add r0, r0, r4
bl @func_prepareTextSlot

@skip2:
mov r0, 0
mov r1, 1
mov r2, 2
str r2, [sp]
str r0, [sp,4]
str r1, [sp,8]
str r0, [sp,12]
str r0, [sp,16]
mov r0, 38
add r0, r0, r4
mov r1, 1
;ldr r2, =0x8BD5730 ; original jpn text
ldr r2, =@nameString
mov r3, 2; x offset
bl @func_renderString

mov r0, 0
mov r2, 2
str r2, [sp]   ; y offset
str r0, [sp,4]
str r0, [sp,8] ; palette
str r0, [sp,12]
str r0, [sp,16]
mov r0, 32
add r0, r0, r4 ; text "slot"
mov r1, 1      ; unk type?
add r2, sp, 20 ; string
mov r3, 11     ; x offset
bl @func_renderString

@done7:
add sp, sp, 44
pop {r3}
mov r8, r3
pop {r4-r7}
pop {r0}
bx r0

@nameString:
.asciiz "Name"
.pool
.endregion

; *************************
; *** nickNameInputIdle ***
; *************************
.org 0x080A87CC
.region 0x080A8924-., 0x00
push {r4-r7,lr}
mov r7, r8
push {r7}
sub sp, sp, 44

ldr r0, =@menu_struct
ldr r4, [r0]
; nickname src
mov r1, 62
add r1, r1, r4
; buffer des
add r2, sp, 20
mov r3, 0
ldrb r5, [r4,15]; len
cmp r3, r5
bhs @copyCursor

@copyNick:
ldrb r0, [r1,r3]
strb r0, [r2,r3]
add r3, 1
cmp r3, r5
blo @copyNick

cmp r3, 12
bhs @fillSpace

@copyCursor:
ldr r0, [r4]
cmp r0, 6
blo @fillSpace
cmp r0, 8
bhi @fillSpace
ldr r0, =@cursorBlink
ldr r0, [r0]
mov r1, 16
and r0, r1
beq @fillSpace
; attach cursor
mov r0, 0x5F
strb r0, [r2,r3]
add r3, 1

@fillSpace:
;mov r0, 0x20
mov r0, 16; teod's special fixed space char...
@copySpace:
strb r0, [r2,r3]
add r3, 1
cmp r3, 14
;cmp r3, 16
blo @copySpace

mov r0, 0
strb r0, [r2,r3]; null terminate

; @render:
ldrh r0, [r4,38]
cmp r0, 0
beq @skip3
mov r0, 38
add r0, r0, r4
bl @func_prepareTextSlot

@skip3:
ldrh r0, [r4,34]
cmp r0, 0
beq @skip4
mov r0, 34
add r0, r0, r4
bl @func_prepareTextSlot

@skip4:
mov r0, 0
mov r1, 1
mov r2, 2
str r2, [sp]
str r0, [sp,4]
str r1, [sp,8]
str r0, [sp,12]
str r0, [sp,16]
mov r0, 38
add r0, r0, r4
;mov r1, 1
;add r2, sp, 36
ldr r2, =@nickNameString
mov r3, 2
bl @func_renderString

mov r0, 0
mov r2, 2
str r2, [sp]
str r0, [sp,4]
str r0, [sp,8]
str r0, [sp,12]
str r0, [sp,16]
mov r0, 34
add r0, r0, r4
mov r1, 1
add r2, sp, 20
mov r3, 11
bl @func_renderString

add sp, sp, 44
pop {r3}
mov r8, r3
pop {r4-r7}
pop {r0}
bx r0

@nickNameString:
.asciiz "Nickname"

.pool
.endregion
