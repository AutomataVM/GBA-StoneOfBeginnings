; Summon Night 3 by Normmatt

;This changes first banner on boot to show this menu
;build date/ver/date/checksum
;.org 0x080AB310
;bl 0x080A9DCC

; Patch 08070240 to show the debug menu.
.org 0x0807026A
.region 0x0807028A-.,0x00
ldrh r2,[r6,4]
ldr r0,=0x08BC9D00
cmp r2,1
; 0 is the main menu, already in r0.
blo @join
beq @submenu
cmp r2,3
blo @secrets
beq @debugmenu
b @join
.pool

@debugmenu:
add r0,0x1C
; Fall-through.

@secrets:
add r0,0x64
b @join

@submenu:
add r0,0x40 ; 0x20 for non-debug.
; Fall-through.

@join:
.if org() != 0x0807028A
	b 0x0807028A
.endif
.endregion

;This stuff below makes debug menu work correctly
;Have to repoint the state arrays here because the debug menus are outside the retail state arrays bounds
.org 0x08069CCC
    .word MenuInitStates
    
.org 0x08069D00
    .word MenuUpdateStates
    
.autoregion
.align 4
MenuInitStates:
    .word 0x08073340+1     ; 0x00 - Main menu
    .word 0x080733EC+1     ; 0x01 - Status
    .word 0x08071D2C+1     ; 0x02 - Config
    .word 0x0807BA70+1     ; 0x03 - Item
    .word 0x0807D35C+1     ; 0x04 - Magic
    .word 0x0807DF90+1     ; 0x05 - Weapon
    .word 0x08083AD0+1     ; 0x06 - Quests
    .word 0x08083D40+1     ; 0x07 - Secrets
    .word 0x08083BA0+1     ; 0x08 - Special Attacks
    .word 0x08083C70+1     ; 0x09 - Effect
    .word 0x08073498+1     ; 0x0A - Craft Rank
    .word 0x08080BCC+1     ; 0x0B - Weapon detail 1
    .word 0x08083E10+1     ; 0x0C - Weapon detail 2
    .word 0x08083ED0+1     ; 0x0D - Secrets detail
    .word 0x08083F90+1     ; 0x0E - Special Attack detail
    .word 0x08084050+1     ; 0x0F - Effect detail/combos
    .word 0x080778D8+1     ; 0x10 - Equipment
    .word 0x080757D0+1     ; 0x11 - Select new weapon equip
    .word 0x08077984+1     ; 0x12 - Select new accessory
    .word 0x08077A54+1     ; 0x13 - Support
    .word 0x0808F174+1     ; 0x14 - Buy
    .word 0x0808B6F8+1     ; 0x15 - Sell
    .word 0x0808F248+1     ; 0x16 - ? Sell weapon or other??
    .word 0x0808F318+1     ; 0x17 - Make
    .word 0x0808F4E8+1     ; 0x18 - Save/Load
    .word 0x0808A8CC+1     ; 0x19 - Craft menu
    .word 0x08084EF0+1     ; 0x1A - Craft review
    .word 0x0808822C+1     ; 0x1B - Craft animation
    .word 0x08086858+1     ; 0x1C - Imbue
    .word 0x080879D8+1     ; 0x1D - Refine
    .word 0x0808F3DC+1     ; 0x1E - Fishing
    .word 0x08073660+1     ; 0x1F - Dictionary
    .word 0x080793AC+1     ; 0x20 - ?
    .word 0x08077BA8+1     ; 0x21 - ?
    .word 0                ; 0x22
    .word 0                ; 0x23
    .word 0                ; 0x24
    .word 0                ; 0x25
    .word 0                ; 0x26
    .word 0                ; 0x27
    .word 0x080B4B6C+1     ; 0x28 - Debug Menu 1
    .word 0x080B63C0+1     ; 0x29 - Debug Menu 2
    .word 0x080B6494+1     ; 0x2A - Debug Menu 3
    
MenuUpdateStates:
    .word 0x0806F71C+1     ; 0
    .word 0x08070334+1     ; 1
    .word 0x08071E5C+1     ; 2
    .word 0x0807BBC4+1     ; 3
    .word 0x0807D430+1     ; 4
    .word 0x0807E080+1     ; 5
    .word 0x0807F718+1     ; 6
    .word 0x0807FAFC+1     ; 7
    .word 0x080801CC+1     ; 8 - Special Attack?
    .word 0x080807EC+1     ; 9 - Effect
    .word 0x080712B8+1     ; 0xA
    .word 0x08080C8C+1     ; 0xB
    .word 0x080819B0+1     ; 0xC
    .word 0x0808263C+1     ; 0xD
    .word 0x08082BF8+1     ; 0xE
    .word 0x08083364+1     ; 0xF
    .word 0x08074AC4+1     ; 0x10
    .word 0x080758A8+1     ; 0x11
    .word 0x08076728+1     ; 0x12
    .word 0x08076EFC+1     ; 0x13
    .word 0x0808ABAC+1     ; 0x14
    .word 0x0808B7DC+1     ; 0x15
    .word 0x0808C1E4+1     ; 0x16
    .word 0x0808CEAC+1     ; 0x17
    .word 0x0808F5DC+1     ; 0x18
    .word 0x08084510+1     ; 0x19
    .word 0x08085010+1     ; 0x1A
    .word 0x080883D0+1     ; 0x1B
    .word 0x0808692C+1     ; 0x1C
    .word 0x08087AC0+1     ; 0x1D
    .word 0x0808E09C+1     ; 0x1E
    .word 0x080738AC+1     ; 0x1F - Dictionary
    .word 0x080794B8+1     ; 0x20
    .word 0x08077CC4+1     ; 0x21
    .word 0                ; 0x22
    .word 0                ; 0x23
    .word 0                ; 0x24
    .word 0                ; 0x25
    .word 0                ; 0x26
    .word 0                ; 0x27
    .word 0x080B4C64+1     ; 0x28 - Debug Menu 1
    .word 0x080B55D4+1     ; 0x29 - Debug Menu 2
    .word 0x080B6568+1     ; 0x2A - Debug Menu 3
.endautoregion

;Unlock ALL items
.org 0x080B5F32
    B             UnlockAll
    
.org 0x080B6128
    ;MOV             R0, #0x63
UnlockAll:
    MOV             R0, #0

.org 0x08001C50
bl VsyncAndDebug

.autoregion
.func VsyncAndDebug
push r14
bl 0x080001D0
bl 0x080B8BE8
pop r15
.endfunc
.endautoregion
