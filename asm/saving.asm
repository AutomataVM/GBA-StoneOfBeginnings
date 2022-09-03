; 08093038 prompts to load clear data, but the hammer is in a bad place.
.org 0x0809313A
mov r0,0x1C

; 080903EC confirms loading data, move the hammer a bit.
.org 0x080908DC
mov r0,0x1C

; 0806E0EC prompts to save (psi3 code 0357.)
.org 0x0806E14E
mov r0,0x14

; 0808FC64 prompts to overwrite the save.
.org 0x080900C8
mov r0,0x1C
