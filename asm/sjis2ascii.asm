; ******************
; *** sjis2ascii ***
; ***  by teod   ***
; ******************

; table taken from vwf_font.asm
; reorganized to do the reverse

; changelog
; 21-12-12
; - initial implementation

.autoregion
;***************
.func sjis2ascii
;***************
; input: r0 = fullwidth character
; output: r0 = ascii character (0 = not ascii)
; only uses r0 and r1

lsl r0, r0, 16
lsl r1, r0, 8
lsr r0, r0, 24 ; lo byte
lsr r1, r1, 24 ; hi byte

cmp r1, 0x7F
bls @alreadyAscii
cmp r1, 0x80
beq @notAscii
cmp r1, 0x83
bhs @notAscii

; only 0x81 <= hi <= 0x82

cmp r0, 0x40
blo @notAscii
cmp r0, 0x9F
bhi @notAscii

cmp r1, 0x81
bne @check82

; 0x81
ldr r1,=@lut81
b @lookup
@check82:
cmp r1, 0x82
bne @done

; 0x82
ldr r1,=@lut82
@lookup:
sub r0, 0x40
ldrb r0, [r1,r0]

@done:
bx lr

@notAscii:
mov r0, 0
bx lr

@alreadyAscii:
mov r0, r1
bx lr

.pool
.endfunc

@lut81:
;.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 0x00
;.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 0x10
;.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 0x20
;.db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; 0x30

; note: [81 60] and [81 E4] are both ~

;      0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
;  space    ,    .                   :    ;    ?    !                   `         ^    
.db 0x20,0x2c,0x2e,   0,   0,   0,0x3a,0x3b,0x3f,0x21,   0,   0,   0,0x60,   0,0x5e ; 0x40
;           _                                                                /    \ 
.db    0,0x5f,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,0x2f,0x5c ; 0x50
;      ~         |                   '    "         (    )              [    ]    {
.db 0x7e,   0,0x7c,   0,   0,   0,0x27,0x22,   0,0x28,0x29,   0,   0,0x5b,0x5d,0x7b ; 0x60
;      }                                                      +    -
.db 0x7d,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,0x2b,0x2d,   0,   0,   0 ; 0x70
;           =         <    >
.db    0,0x3d,   0,0x3c,0x3e,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0 ; 0x80
;      $              %    #    &    *    @
.db 0x24,   0,   0,0x25,0x23,0x26,0x2a,0x40,   0,   0,   0,   0,   0,   0,   0,   0 ; 0x90

@lut82:
;      0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
;                                                                                 0
.db    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,0x30 ; 0x40
;      1    2    3    4    5    6    7    8    9
.db 0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,   0,   0,   0,   0,   0,   0,   0 ; 0x50
;      A    B    C    D    E    F    G    H    I    J    K    L    M    N    O    P
.db 0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f,0x50 ; 0x60
;      Q    R    S    T    U    V    W    X    Y    Z
.db 0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5a,   0,   0,   0,   0,   0,   0 ; 0x70
;           a    b    c    d    e    f    g    h    i    j    k    l    m    n    o
.db    0,0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f ; 0x80
;      p    q    r    s    t    u    v    w    x    y    z
.db 0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7a,   0,   0,   0,   0,   0 ; 0x90
.endautoregion

