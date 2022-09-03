; 080A87CC draws the 'Nickname' text using an 8 byte buffer.
; There's no reason for the buffer, so we just delete it.
.org 0x080A880E
.region 0x080A8828-.,0x00
ldr r0,[0x080A8854] ; 0x08BD573C = Nickname pointer
ldr r3,[r0,4]
mov r8,r3
b 0x080A8828
.endregion
