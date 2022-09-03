.gba
.open "swordcraft3.gba","swordcraft3-test.gba",0x08000000

; Patches to enable ASCII and the VWF.
.include "asm/vwf_font.asm"
.include "asm/vwf_main.asm"
.include "asm/vwf_dialog.asm"
.include "asm/vwf_extend_sprite_tables.asm"
.include "asm/vwf_sprite_renderer.asm"
.include "asm/vwf_sprites.asm"
.include "asm/name_portrait_check.asm"
.include "asm/names_obj.asm"

; Reduces the size of scripts so we don't have to worry about space much.
.include "asm/script_expr.asm"

; Patches to allow text to be wider and other tweaks.
.include "asm/craft.asm"
.include "asm/menu.asm"
.include "asm/shop.asm"
.include "asm/saving.asm"

; Fixes and tweaks for the naming screen.
;.include "asm/naming.asm"
.include "asm/name_input.asm"
.include "asm/sjis2ascii.asm"

; Allow using the debug menu features.
.include "asm/debug_menu.asm"

;Solves location space limitations
.include "asm/saving_location.asm"

;Fixes obtained! issue with money and items
.include "asm/item_obtained.asm"
.include "asm/money_obtained.asm"

;graphics
.include "asm/title.asm"
.include "asm/gfx_craftsword_edit.asm"
.include "asm/lyndbaum_text_en_1.asm"
.include "asm/lyndbaum_text_en_2.asm"
.include "asm/gfx_insert_lzss.asm"
.include "asm/select partner.asm"

;partner_info_gfx
.include "asm/partner_info_gfx/balance_TL.asm"
.include "asm/partner_info_gfx/flight_TL.asm"
.include "asm/partner_info_gfx/power_TL.asm"
.include "asm/partner_info_gfx/speed_TL.asm"

;title options
.include "asm/gfx_title_2player.asm"
.include "asm/gfx_title_omake.asm"
;title options EN
.include "asm/title_obj.asm"

;fishing_minigame
.org 0x09646E2C 
.import "asm/fishing/fishing_tile.lzss" 
.org 0x0964684C 
.import "asm/fishing/fishing_map.lzss" 

;lottery minigame gfx
;finish
.org 0x964EA2C
.import "asm/lottery/finish_gfx.bin" 
.org 0x964DD6C
.import "asm/lottery/start_ready.bin" 

;battle messages (guard, poison, sleep)
.include "asm/guard.asm"

;missing system messages
.org 0x80C0040
.sjis "Start new game from saved data?"

.org 0x80C0100
.sjis " Stuff that will carry on:"

.org 0x80C00E8
.sjisn "・minigames scores"
.db 16,12
.sjis " "

.org 0x80C00C8
.sjisn "・craft ranks"
.db 16,6
.sjis "・bestiary"

.org 0x80C00A8
.sjisn "・special attacks"
.db 2
.sjis "・effects"

.org 0x80C0084
.sjisn "・fishing points"
.db 10
.sjis "・stored weapons"
.org 0x80C0074
;.sjisn 
;.db 0x7F, 16 :: .ascii "  " :: .db 0x7F, 15 :: .ascii " " :: .db 0x7F, 0xFF
.sjis "・techniques"
.org 0x80C0060
.sjisn "・money            "

;fishing minigame system messages
;.org 0x80C7220
;.asciiz "string 1"
;.org 0x80C0220
;.asciiz "string 2"

.close