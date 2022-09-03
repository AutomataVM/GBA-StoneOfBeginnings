; 08012578 evaluates expression arguments from the script.
; Frequently, these are just single small numbers, but it wastes 6 bytes for those.
; We add an additional shorthand encoding to use 2 bytes in this scenario.
; This reduces total script size ~20-25% and compressed size by ~8%.
.org 0x08012578
.region 0x080127E4-.,0x00
; No args, returns uint32_t/int32_t value
.func PSI3CalcExpression
mov r2,r8
mov r3,r9
push r2-r7,r14

; Script info, the current bytecode pos is at offset 4.
ldr r0,=0x03006574
ldr r7,[r0]
; Save that in r9, and load the pos.  We'll flush back to RAM when done.
mov r9,r7
ldr r7,[r7,4]

; Values are pushed/popped to a stack at 03002008.  In the end, the front is the result.
; Original code tracked the pos in RAM at 03002088, we don't bother storing it there.

; Load the stack start pos, and remember it for later in r8.
ldr r6,=0x03002008
mov r8,r6

; We end up doing some signed loads/stores, so it's convenient to have this fixed 0 reg.
mov r5,0

@@nextCode:
; Read in the next code.
ldrh r4,[r7,0]
add r7,r7,2

; If it's 0, we're done.  Check the common 1 (push constant) while we're here.
cmp r4,1
blo @@finish
beq @@code01Const

; If bit 8 / 0x0100 is set, it's a fast constant (what we're adding here.)
lsr r0,r4,9 ; Sets CF/cs if 1 shifted off.
bcs @@fastConstant

; Bit 7 / 0x0080 means this reads operands (pops stack), otherwise a var/num push.
cmp r4,0x80
bhs @@handleOp

; We already checked 0 and 1 above, so now check 2/3 - the vars.
cmp r4,3
beq @@code03Var3
blo @@code02Var2
; If we got here, it's invalid - 0x0004 through 0x007F.
b @@nextCode

@@fastConstant:
mov r0,0xFF
and r0,r4

; Bit 9 / 0x0200 means this is an instant return, no 0x0000 end needed.
lsr r1,r4,10 ; Clears CF/cc if 0 shifted off.
bcc @@pushResultR0

; Okay, just return directly.
b @@expressonResultR0

@@code01Const:
; Read the constant off the script (r5 is fixed 0.)
ldrsh r2,[r7,r5]
add r7,r7,2
b @@pushResultR2

@@code02Var2:
; Okay, which type-2 variable is in the next halfword.
ldrh r4,[r7,0]
add r7,r7,2

; If it's below 0x0040, it's a word var, otherwise halfword or byte.
cmp r4,0x3F
bhi @@var2Halfword

; Words are at the pointer this points to.
ldr r1,=0x030067B0
ldr r1,[r1]
lsl r0,r4,2
ldr r2,[r1,r0]
b @@pushResultR2

@@var2Halfword:
; If it's 0x0040 through 0x017F (below 0x0180), it's a halfword.  Otherwise a byte.
mov r0,0x18
lsl r0,r0,4
cmp r4,r0
bhs @@var2Byte

; Type-2 halfwords at the pointer this points to.
ldr r1,=0x0300657C
ldr r1,[r1]
; Account for the 0x0040 offset from encoding.
sub r4,0x40
b @@varHalfwordAtR1R4

@@var2Byte:
; Type-2 bytes at the pointer this points to.
ldr r1,=0x03006584
ldr r1,[r1]
; r0 is still 0x0180, subtract it to get offset into bytes.
sub r4,r4,r0
b @@varByteAtR1R4

@@code03Var3:
; Which type-3 variable is in the next halfword.
ldrh r4,[r7,0]
add r7,r7,2

; There are only 0x0020 halfwords, including 0.  The rest are bytes or bitflags.
cmp r4,0x1F
bhi @@var3Byte

; Type-3 halfwords at the pointer this points to.
ldr r1,=0x030067AC
ldr r1,[r1]
; Fall through to the shared halfword code, no offset needed for r4.

@@varHalfwordAtR1R4:
lsl r0,r4,1
ldrsh r2,[r1,r0]
b @@pushResultR2

@@var3Byte:
; 0x0020 through 0x00FF are halfwords, above that it's just flags.
cmp r4,0xFF
bhi @@var3Flag

; Type-3 bytes at the pointer this points to.
ldr r1,=0x03006570
ldr r1,[r1]
; Now take off the 0x20 encoding offset.
sub r4,0x20

@@varByteAtR1R4:
ldrsb r2,[r1,r4]
b @@pushResultR2

@@var3Flag:
; The pointer to the flags pointer is here.
ldr r1,=0x030067A8
ldr r1,[r1]

; Okay, what's the bit offset?
mov r2,7
and r2,r4

; Shift out the bit offset, then remove the encoding offset (0x100 >> 3 = 0x20.)
; This is which byte that bit is in.
lsr r4,r4,3
sub r4,0x20

; Load and move the bit to position 0.
ldrb r0,[r1,r4]
lsr r0,r2

mov r2,1
and r2,r0
b @@pushResultR2

; Done with pushes, time for operations.
@@handleOp:
;; Check for 0x80 and 0x81
cmp r4,0x81
bhi @@codeBinaryOp

; Okay, must be a unary op then.  Grab the operand.
sub r6,r6,4
ldr r2,[r6,0]

; At this point, it's either 0x0080 or 0x0081.
cmp r4,0x81
blo @@code81BitNot

@@code80BoolNot:
; Boolean not, code 0x0080.
cmp r2,0
bne @@pushResultZero
b @@pushResultOne

@@code81BitNot:
mvn r2,r2
b @@pushResultR2

@@codeBinaryOp:
; Okay, load both operands.  lhs=r2, rhs=r3.
sub r6,8
ldr r2,[r6,0]
ldr r3,[r6,4]

sub r4,0x82
; Make sure it's not outside our jump table.  If so, just push the lhs back.
cmp r4,0x0F
bhi @@pushResultR2

; Okay, let's use our jump table for the op.
lsl r0,r4,2
add r1,=@@codeJumpTable
ldr r0,[r1,r0]
mov r15,r0

@@finish:
; Reset to stack start (just in case expression unbalanced.)
mov r6,r8
ldr r0,[r6,0]

@@expressonResultR0:
; Save the new script bytecode pos.
mov r1,r9
str r7,[r1,4]

pop r2-r7
mov r8,r2
mov r9,r3
pop r15

@@code82Mul:
mul r2,r3
b @@pushResultR2

@@code83Div:
; Avoid divide by zero.
cmp r3,0
beq @@pushResultZero

mov r0,r2
mov r1,r3
bl 0x080B8FF0 ; integer_divide
@@pushResultR0:
stmia [r6]!,r0
b @@nextCode

@@code84Mod:
; Avoid divide by zero.
cmp r3,0
beq @@pushResultZero

mov r0,r2
mov r1,r3
bl 0x080B9088 ; integer_modulo
b @@pushResultR0

@@code85Add:
add r2,r2,r3
b @@pushResultR2

@@code86Sub:
sub r2,r2,r3
b @@pushResultR2

@@code87CmpLT:
cmp r2,r3
blt @@pushResultOne
b @@pushResultZero

@@code88CmpLE:
cmp r2,r3
ble @@pushResultOne
b @@pushResultZero

@@code89CmpGT:
cmp r2,r3
bgt @@pushResultOne
b @@pushResultZero

@@code8ACmpGE:
cmp r2,r3
bge @@pushResultOne
b @@pushResultZero

@@code8BCmpEQ:
cmp r2,r3
beq @@pushResultOne
b @@pushResultZero

@@code8CCmpNE:
cmp r2,r3
beq @@pushResultZero

@@pushResultOne:
mov r2,1
b @@pushResultR2

@@pushResultZero:
mov r2,0
b @@pushResultR2

@@code8DAnd:
and r2,r3
b @@pushResultR2

@@code8EXor:
eor r2,r3
b @@pushResultR2

@@code8FOr:
orr r2,r3
b @@pushResultR2

@@code90BoolAnd:
and r2,r3
b @@boolResult

@@code91BoolOr:
orr r2,r3
@@boolResult:
; Basically, check the sign bit of the result to find zero.
neg r0,r2
orr r0,r2
lsr r2,r0,31

@@pushResultR2:
stmia [r6]!,r2
b @@nextCode

.align 4
@@codeJumpTable:
.dw @@code82Mul
.dw @@code83Div
.dw @@code84Mod
.dw @@code85Add
.dw @@code86Sub
.dw @@code87CmpLT
.dw @@code88CmpLE
.dw @@code89CmpGT
.dw @@code8ACmpGE
.dw @@code8BCmpEQ
.dw @@code8CCmpNE
.dw @@code8DAnd
.dw @@code8EXor
.dw @@code8FOr
.dw @@code90BoolAnd
.dw @@code91BoolOr

.pool
.endfunc

.org 0x08012740
.fill 0x40
.endregion
