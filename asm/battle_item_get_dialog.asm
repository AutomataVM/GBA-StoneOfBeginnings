;   KurobaM
;           251213
; Battle item gained message box 
; Fix text spill over

;dialog
.org 0x805D876
; mov    r0, #7 
mov r0, #6      ; move left by 1

.org 0x805D87E
; mov    r0, #0x10
mov r0, #0x12   ; increase size by 2

; text
.org 0x805D9AA 
; mov    r3, #0xA
mov r3, #9      ; move left by 1

; icon
.org 0x805D9BC 
;mov    r0, #8
mov r0, #7     ; move left by 1
