; This is called to add lines to the dialog box.
; It copies text so we adjust for VWF control codes.
.org 0x0800C38C
.region 0x0800C614-.,0x00
; Args: const char *str
.func DialogAddStr
mov r1,r8
mov r2,r9
mov r3,r10
push r1-r7,r14

; Save the string away for later.
mov r8,r0

; This points to a pointer for the buffer we care about.
; We keep this in r3 for a while.
ldr r3,=0x03005554
ldr r3,[r3]

; Prep some constants for later.
mov r6,0
mov r7,0x34
lsl r7,r7,8
mov r12,r7

; Do we need to rotate things among the buffers?
ldrh r1,[r3,2]
cmp r1,0x1E
bne @@noRotation

; Rotation time... grab the read pos.
ldrh r0,[r3,4]
add r4,r0,1
; Wrap to 0 at 0x1E
cmp r4,0x1E
bne @@skipReadWrap
mov r4,0
@@skipReadWrap:

; This will be our pointer write position for the rotate.
mov r5,0

; Not sure if this can happen, but the old code had it.
cmp r4,0x1D
bhi @@endRotation

; Assemble the location of the buffer, r4 * 24 + 0x0340.
; r7 = r4 * 24 = (r4 * 2 + r4) * 8
lsl r7,r4,2
add r7,r7,r4
lsl r7,r7,3
; Now just the 0x0340 left.
add r7,r12

; r1 is still 0x1E, subtract the readPos to know how many leftover we're doing.
sub r1,r1,r4
mov r0,3
and r1,r0 ; Sets Z/eq if zero.
beq @@noLeftoverRotate

cmp r1,2
blo @@oneLeftover
beq @@twoLeftover

; If we're here, all three are leftover.  Set the new pointer.
add r0,r3,r7
str r0,[r3,0x3C]
add r7,0x28
add r5,r5,1
add r4,r4,1

@@twoLeftover:
add r0,r3,r7
; Now the next one, following r5.
lsl r1,r5,2
add r1,r1,r3
str r0,[r1,0x3C]
add r7,0x28
add r5,r5,1
add r4,r4,1

@@oneLeftover:
add r0,r3,r7
; Last one, following r5 still in case we only had one.
lsl r1,r5,2
add r1,r1,r3
str r0,[r1,0x3C]
add r7,0x28
add r5,r5,1
add r4,r4,1

; Did we reach the end?  Skip the loop if so.
cmp r4,0x1E
bhs @@endRotation

@@noLeftoverRotate:
; Now we do the rest in chunks of 4, since we're now aligned.
add r0,r3,r7
lsl r1,r5,2
add r1,r1,r3

@@rotateLoop:
; Four rapid fire.
str r0,[r1,0x3C]
add r0,0x28
str r0,[r1,0x40]
add r0,0x28
str r0,[r1,0x44]
add r0,0x28
str r0,[r1,0x48]

add r5,4
add r4,4
add r1,16

cmp r4,0x1D
bls @@rotateLoop
@@endRotation:

; Now the ones behind the read position.
ldrh r2,[r3,4]
cmp r2,0x1D
beq @@skipRotateBehind

; Reset r7 to the beginning of the buffer.
mov r7,r12
add r7,r7,r3
lsl r1,r5,2
add r1,r1,r3

; We just count down instead of up using r4.
mov r4,r2
@@rotateBehindLoop:
str r7,[r1,0x3C]
add r7,0x28
add r1,r1,4

sub r4,r4,1 ; Sets N/mi on negative, we loop <=.
bpl @@rotateBehindLoop
@@skipRotateBehind:

mov r7,0
; Now let's merge paths and copy strings.
b @@copyString

@@noRotation:
; Great, we can just use the free slot, first get the pointer location.
ldrh r2,[r3,2]
lsl r0,r2,2
; Pointer offset.
add r7,r3,r0

@@copyString:
; Okay, now r2 is the open slot.  Grab the pointer.
; r0 = r2 * 24 = (r2 * 2 + r2) * 8
lsl r0,r2,2
add r0,r0,r2
lsl r0,r0,3
; And add 0x0340 again.
add r0,r12
add r0,r0,r3

; Now save the buffer pos to the pointer.
cmp r7,0
beq @@skipUpdatePointer
str r0,[r7,0x3C]
@@skipUpdatePointer:

; r0=dst, r1=FREE, r2=FREE, r3=pointersBase, r4=str, r5=oldStr, r6=FREE, r7=cleanupFlag

; Grab the string pointer finally.
mov r4,r8
; A trick: this is where we push the str for a name.
; We reuse our main loop and just swap the pointer.
mov r5,0

@@nextChar:
; Read the first byte.
ldrb r1,[r4]
add r4,r4,1

; If it's 7F or lower, single byte (also end of string.)
cmp r1,0x7F
blo @@handleAscii
beq @@handleWidthControl

; Grab the high byte, but don't merge yet.
ldrb r2,[r4]
add r4,r4,1
lsr r6,r2,4

; 87 7? means control code (write to codeout), which we ignore.
cmp r1,0x87
bne @@checkNameCode
cmp r6,0x07
beq @@nextChar

; 83 C? means name code (output name variable.)
@@checkNameCode:
cmp r1,0x83
bne @@handleJIS
cmp r6,0x0C
bne @@handleJIS

; Okay, this is a name.  Grab the index * 9.
lsl r2,r2,28
lsr r2,r2,28
; (x * 8) + x == x * 9
lsl r1,r2,3
add r1,r1,r2
; Double, since it's 9 shorts.
lsl r1,r1,1

; Save old str.
mov r5,r4
; This is where the names are.
ldr r4,=0x03005580
add r4,r4,r1

; Okay, we're ready, process chars.
b @@nextChar

@@handleAscii:
cmp r1,0
beq @@doneStr

strb r1,[r0,0]
add r0,r0,1
b @@nextChar

@@handleJIS:
; Write both together.
strb r1,[r0,0]
strb r2,[r0,1]
add r0,r0,2
b @@nextChar

@@handleWidthControl:
; Copy the width control byte.
ldrb r2,[r4]
add r4,r4,1
; It happens to match this code exactly, jump there.
b @@handleJIS

@@doneStr:
mov r4,r5
mov r5,0
; If it's not zero, we finished a name.  Back to the str.
cmp r4,0
bne @@nextChar

; Write out the final NUL terminator.  r4 must be zero.
strb r4,[r0,0]

; Now we diverge again to update pointers.  r7=0 if we rotated buffers.
cmp r7,0
beq @@rotateCleanup

; Didn't rotate, increment write buffer then.
ldrh r0,[r3,2]
add r0,r0,1
strh r0,[r3,2]
; r0 also written to the read buffer when we merge again.

; Set nullptr in the next buffer.
mov r5,r0
b @@commonCleanup

@@rotateCleanup:
ldrh r0,[r3,4]
add r0,r0,1

; Set nullptr in the last buffer.
mov r5,0x1E

@@commonCleanup:
; Update the read pointer, but rotate if we hit 0x1E.
cmp r0,0x1E
bne @@skipZeroRead
mov r0,0
@@skipZeroRead:
strh r0,[r3,4]

; Set a nullptr here, I think to terminate the ringbuffer?
lsl r5,r5,2
add r5,r5,r3
str r4,[r5,0x3C]

pop r1-r7
mov r8,r1
mov r9,r2
mov r10,r3
pop r0
bx r0
.pool
.endfunc
.endregion
