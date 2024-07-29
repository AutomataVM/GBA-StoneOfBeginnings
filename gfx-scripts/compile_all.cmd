set "_ROM=..\swordcraft3.gba"

echo:; asm output> final\final.asm

::call compile.cmd %_ROM% s_main     14ECADC 152C5BC
::call compile.cmd %_ROM% s_equip_1  14EEE8C 152CB8C
::call compile.cmd %_ROM% s_status   14F0E6C 152D16C
::call compile.cmd %_ROM% s_item     14F2E5C 152D74C
::call compile.cmd %_ROM% s_magic    14F4ECC 152DD2C
::call compile.cmd %_ROM% s_weapon_1 14F6EAC 152E30C
::call compile.cmd %_ROM% s_secret_1 14F8D2C 152E88C
::call compile.cmd %_ROM% s_special  14FADBC 152EE2C
::call compile.cmd %_ROM% s_effect   14FCEAC 152F40C
::call compile.cmd %_ROM% s_dict     14FF70C 152F9EC
::call compile.cmd %_ROM% s_equip_2  150174C 152FFCC
::call compile.cmd %_ROM% s_equip_3  15038CC 153057C
::call compile.cmd %_ROM% s_rank     1505BAC 1530B4C
::call compile.cmd %_ROM% s_weapon_2 1507DBC 153110C
::call compile.cmd %_ROM% s_weapon_3 1509FCC 15316EC
::call compile.cmd %_ROM% s_combo    150C23C 1531CBC
::call compile.cmd %_ROM% s_secret_2 150E3AC 153228C
::call compile.cmd %_ROM% s_weapon_4 151046C 153286C
::call compile.cmd %_ROM% s_custom_1 151237C 1532E0C
::call compile.cmd %_ROM% s_custom_2 15144AC 15333EC
::call compile.cmd %_ROM% s_data     15163CC 153398C
::call compile.cmd %_ROM% s_buy      151870C 1533F6C
::call compile.cmd %_ROM% s_sell_1   151A6EC 153453C
::call compile.cmd %_ROM% s_sell_2   151C77C 1534B1C
::call compile.cmd %_ROM% s_make     151E5DC 15350BC
::call compile.cmd %_ROM% s_config   152073C 153569C
::::call compile.cmd %_ROM% bg_craft   152270C 1535C7C
::call compile.cmd %_ROM% s_fishing  152686C 153625C
::call compile.cmd %_ROM% s_tsuushin 152891C 153682C
::call compile.cmd %_ROM% s_omake    152A5EC 1536DEC
::
::call compile.cmd %_ROM% fishing    1646E2C 164684C
::call compile.cmd %_ROM% leftover1  164a99c 164b9ac
::call compile.cmd %_ROM% leftover2  164bcbc 164ce4c
::call compile.cmd %_ROM% guumu      165513C 165827C
pause
