; by teod 21/05/23

; need to fix groups 9,10,11

; group 9: hover animation (glowing)
; frames: 0x1B,0x1C,0x1D,0x1E,0x1F

; group 10: inactive animation (faint)
; frames: 0x22

; group 11: select animation (blinking)
; frames: 0x1B,0x24

; Table B
; ***entry format***
; .dw num_sprites
; .db palette_index :: .db oam_index :: .dh x_off :: .dh y_off
;
; oam_index is used to index into Table C


@x1 equ 24
@x2 equ -24

.org 0x095D870E
; entry 0x1B
.dw 2
.db 0x10 :: .db 0x3B :: .dh    0+@x1 :: .dh 0
.db 0x10 :: .db 0x3C :: .dh 0x50+@x2 :: .dh 0
; entry 0x1C
.dw 2
.db 0x12 :: .db 0x3B :: .dh    0+@x1 :: .dh 0
.db 0x12 :: .db 0x3C :: .dh 0x50+@x2 :: .dh 0
; entry 0x1D
.dw 2
.db 0x14 :: .db 0x3B :: .dh    0+@x1 :: .dh 0
.db 0x14 :: .db 0x3C :: .dh 0x50+@x2 :: .dh 0
; entry 0x1E
.dw 4
.db 0x10 :: .db 0x3D :: .dh    0+@x1 :: .dh 0
.db 0x10 :: .db 0x3E :: .dh 0x10+@x1 :: .dh 0
.db 0x10 :: .db 0x3F :: .dh 0x50+@x2 :: .dh 0
.db 0x10 :: .db 0x40 :: .dh 0x60+@x2 :: .dh 0
; entry 0x1F
.dw 4
.db 0x12 :: .db 0x3D :: .dh    0+@x1 :: .dh 0
.db 0x12 :: .db 0x3E :: .dh 0x10+@x1 :: .dh 0
.db 0x12 :: .db 0x3F :: .dh 0x50+@x2 :: .dh 0
.db 0x12 :: .db 0x40 :: .dh 0x60+@x2 :: .dh 0

.org 0x095D87AE
; entry 0x22
.dw 4
.db 0x12 :: .db 0x41 :: .dh    0+@x1 :: .dh 0
.db 0x12 :: .db 0x42 :: .dh    0+@x1 :: .dh 0x10
.db 0x12 :: .db 0x43 :: .dh 0x50+@x2 :: .dh 0
.db 0x12 :: .db 0x44 :: .dh 0x50+@x2 :: .dh 0x10

.org 0x095D87E6
; entry 0x24
.dw 6
.db 0x10 :: .db 0x45 :: .dh    0+@x1 :: .dh 0
.db 0x10 :: .db 0x46 :: .dh    8+@x1 :: .dh 0
.db 0x10 :: .db 0x47 :: .dh 0x18+@x1 :: .dh 0
.db 0x10 :: .db 0x48 :: .dh 0x50+@x2 :: .dh 0
.db 0x10 :: .db 0x49 :: .dh 0x58+@x2 :: .dh 0
.db 0x10 :: .db 0x4A :: .dh 0x68+@x2 :: .dh 0
