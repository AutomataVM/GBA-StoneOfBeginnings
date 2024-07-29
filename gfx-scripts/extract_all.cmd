set "_ROM=..\swordcraft3.gba"

call extract_bmp.cmd %_ROM% s_main     14ECADC 152C5BC
call extract_bmp.cmd %_ROM% s_equip_1  14EEE8C 152CB8C
call extract_bmp.cmd %_ROM% s_status   14F0E6C 152D16C
call extract_bmp.cmd %_ROM% s_item     14F2E5C 152D74C
call extract_bmp.cmd %_ROM% s_magic    14F4ECC 152DD2C
call extract_bmp.cmd %_ROM% s_weapon_1 14F6EAC 152E30C
call extract_bmp.cmd %_ROM% s_secret_1 14F8D2C 152E88C
call extract_bmp.cmd %_ROM% s_special  14FADBC 152EE2C
call extract_bmp.cmd %_ROM% s_effect   14FCEAC 152F40C
call extract_bmp.cmd %_ROM% s_dict     14FF70C 152F9EC
call extract_bmp.cmd %_ROM% s_equip_2  150174C 152FFCC
call extract_bmp.cmd %_ROM% s_equip_3  15038CC 153057C
call extract_bmp.cmd %_ROM% s_rank     1505BAC 1530B4C
call extract_bmp.cmd %_ROM% s_weapon_2 1507DBC 153110C
call extract_bmp.cmd %_ROM% s_weapon_3 1509FCC 15316EC
call extract_bmp.cmd %_ROM% s_combo    150C23C 1531CBC
call extract_bmp.cmd %_ROM% s_secret_2 150E3AC 153228C
call extract_bmp.cmd %_ROM% s_weapon_4 151046C 153286C
call extract_bmp.cmd %_ROM% s_custom_1 151237C 1532E0C
call extract_bmp.cmd %_ROM% s_custom_2 15144AC 15333EC
call extract_bmp.cmd %_ROM% s_data     15163CC 153398C
call extract_bmp.cmd %_ROM% s_buy      151870C 1533F6C
call extract_bmp.cmd %_ROM% s_sell_1   151A6EC 153453C
call extract_bmp.cmd %_ROM% s_sell_2   151C77C 1534B1C
call extract_bmp.cmd %_ROM% s_make     151E5DC 15350BC
call extract_bmp.cmd %_ROM% s_config   152073C 153569C
call extract_bmp.cmd %_ROM% s_fishing  152686C 153625C
call extract_bmp.cmd %_ROM% s_tsuushin 152891C 153682C
call extract_bmp.cmd %_ROM% s_omake    152A5EC 1536DEC

:: call extract_bmp.cmd %_ROM% bg_craft   152270C 1535C7C

call extract_bmp.cmd %_ROM% fishing    1646E2C 164684C
call extract_bmp.cmd %_ROM% leftover1  164a99c 164b9ac
call extract_bmp.cmd %_ROM% leftover2  164bcbc 164ce4c
call extract_bmp.cmd %_ROM% guumu      165513C 165827C
call extract_bmp.cmd %_ROM% firstprize 165513C 165827C


:: name_entry 18c8dec 18cae8c

call extract_bmp.cmd %_ROM% credits01 14604ac 14646bc
call extract_bmp.cmd %_ROM% credits02 1464bfc 146916c
call extract_bmp.cmd %_ROM% credits03 14696ac 1469b8c
call extract_bmp.cmd %_ROM% credits04 1469cbc 146c94c
call extract_bmp.cmd %_ROM% credits05 146CD1C 146D37C
call extract_bmp.cmd %_ROM% credits06 146d4dc 146f32c
call extract_bmp.cmd %_ROM% credits07 146f6dc 147008c
call extract_bmp.cmd %_ROM% credits08 147024c 1472b1c
call extract_bmp.cmd %_ROM% credits09 1472ecc 14739fc
call extract_bmp.cmd %_ROM% credits10 1473bcc 147635c
call extract_bmp.cmd %_ROM% credits11 147670c 1476f6c
call extract_bmp.cmd %_ROM% credits12 14770fc 1479fcc
call extract_bmp.cmd %_ROM% credits13 147a38c 147aecc
call extract_bmp.cmd %_ROM% credits14 147b0bc 147ceec
call extract_bmp.cmd %_ROM% credits15 147d29c 147da4c
call extract_bmp.cmd %_ROM% credits16 147dbec 148075c
call extract_bmp.cmd %_ROM% credits17 1480b2c 1481a1c
call extract_bmp.cmd %_ROM% credits18 1481c6c 14844ac
call extract_bmp.cmd %_ROM% credits19 148487c 1484ffc
call extract_bmp.cmd %_ROM% credits20 148517c 14879dc
call extract_bmp.cmd %_ROM% credits21 1487dac 1488a4c
call extract_bmp.cmd %_ROM% credits22 1488c5c 148ba0c
call extract_bmp.cmd %_ROM% credits23 148bddc 148c8ec
call extract_bmp.cmd %_ROM% credits24 148cadc 148f3bc
call extract_bmp.cmd %_ROM% credits25 148f77c 148ff0c
call extract_bmp.cmd %_ROM% credits26 149007c 14928ec
call extract_bmp.cmd %_ROM% credits27 1492cbc 149340c
call extract_bmp.cmd %_ROM% credits28 149357c 14963cc
call extract_bmp.cmd %_ROM% credits29 149678c 149730c
call extract_bmp.cmd %_ROM% credits30 14974bc 1499d1c
call extract_bmp.cmd %_ROM% credits31 149a0dc 149b0fc

:: 149b33c 149d55c
:: 149d90c 149e7ac
:: 149e9ac 14a0f9c
:: 14a136c 14a1c0c
:: 14a1d7c 14a3d4c
:: 14a40cc 14a470c
:: 14a486c 14a4c5c
:: 14a4d5c 14a519c
:: 14a529c 14a587c
:: 14af74c 14b1c9c (cg8/sc8)
:: 14b207c 14b502c (cg8/sc8)
:: gameover 14b9c9c 14bdc1c
:: banpresto 14be23c 14be91c

:: bg_sky1 1537b4c 1539d1c
:: bg_sky2 153a36c 153cfcc
:: bg_town 153d61c 1542b0c
:: ...
:: craftsword 154458c 1544bfc
:: ritchie   1544e1c 15462dc
:: rifmonica 15466ac 1547bcc

:: 1547f9c 154947c
:: 154974c 154ac1c
:: 154aefc 154c85c
:: 154cd3c 154df5c
:: 154e2dc 154f7dc
:: 154fbbc 155112c
:: 155150c 155278c
:: 1552a6c 155411c
:: 15543fc 15556fc
:: 15559ac 1556dbc
:: 155709c 155879c
:: 1558b7c 1559c8c
:: 1559efc 155b9fc
:: 155be6c 155dc6c
:: 155e0dc 155f9ac
:: 155fcdc 156180c
:: 1561c4c 1562bdc
:: 1562f3c 156339c
:: 15635fc 1564e5c
:: 156515c 156576c
:: 156594c 156606c
:: 156620c 156817c
:: 156861c 156b3dc
:: 156b92c 156d08c
:: 156d47c 156ef7c
:: 156f38c 157106c
:: rufeel shadow 157149c 1572c8c
:: 1572fcc 1574bac
:: 157507c 157799c
:: 1577eac 1579d4c
:: 157a21c 157c2cc
:: 157c79c 157e78c
:: 157ec9c 158083c
:: 1580c7c 158228c
:: 158267c 1583bbc
:: 1583fac 15846fc
:: 15848ac ("ANP" file)
:: 1584cbc (tileset for text in intro)
:: ... various sprite data
:: 160e82c 160ef9c ... ("SCA" file, animation?)
:: 160f28c 1611a5c ... ("SCA" file)
:: rank up! 16120dc 16135dc
:: ... "CG8" "SC8" (8 stands for 8bpp)
:: forge 161931c 161d6cc
:: 161dcac 161f8bc
:: 161fdfc 162180c
:: 1621c5c 1624fec (CG8)
:: 16254ec 16296cc (CG8)
:: 1629c2c 162b00c ?

:: training area 162c88c 162ee0c
:: training area 162c88c 162f08c
:: ... lots of CG4 stuff

:: fishing 1646e2c 164684c
:: leftover1 164a99c 164b9ac (残り)
:: leftover2 164bcbc 164ce4c
:: ... bunch of CG4

:: guumu 165513c 165827c (グーム説明)
:: 16588ec 165aeac (CG8)
:: ...

:: newgame bg(?) 166181c 166729c
:: sunset 16aad7c 16ae30c
:: sunset-ritchie 16ae9bc 16afa2c 16afc6c (+ "SCA" file)
:: sunset-rifmonica 16afcac 16b0e0c 16b104c
:: 16b10ac ("ANP")
:: ... ANP + CG4 files

:: sunset-handshake-m 16c03ac 16c2abc
:: 16c2e4c 16c436c
:: 16c458c 16c6a5c
:: 16c6dec 16c860c
:: 16c885c 16ca83c
:: 16cabcc 16cc41c
:: 16cc69c 16ce3ec
:: 16ce77c 16d002c
:: 16d02ac 16d269c
:: 16d2a1c 16d3f4c
:: 16d418c 16d652c
:: 16d68bc 16d7efc
:: 16d813c 16da13c
:: 16da4ac 16dbeac
:: 16dc13c 16de0ac
:: 16de41c 16dfe3c
:: 16e00dc 16e248c
:: 16e281c 16e42dc
:: 16e457c 16e6a1c
:: 16e6dac 16e88ac
:: 16e8b3c 16ead7c
:: 16eb10c 16ec7fc
:: 16eca5c 16eec0c
:: 16eef9c 16f058c
:: 16f07ec 16f2bcc
:: 16f2f5c 16f4a0c
:: 16f4c8c 16f712c
:: 16f74bc 16f8f2c
:: 16f91ac 16fb58c
:: 16fb91c 16fd23c
:: 16fd4cc 16ff7fc
:: 16ffb8c 170157c
:: 170180c 1703b2c
:: 1703ebc 170587c
:: 1705afc 1707fbc
:: 170834c 1709cfc
:: 1709f7c 170b2ec
:: 170b4fc 170c92c
:: 170cb6c 170df6c
:: 170e19c 170f45c
:: 170f64c 17106bc
:: 171089c 17117cc
:: 171198c 171292c
:: 1712afc 171466c
:: 171493c 1715f5c
:: 171617c 1717c4c
:: 1717f1c 1718e1c

:: ... script files (PSI3)

:: name_entry 18c8dec 18cae8c

:: 18d437c 18d8cac (home overworld)
:: 18d437c 18d93cc
:: 18d719c 18d995c
:: 18da35c ("MD  " file)
:: ... more overworld stuff

:: 1a14f8c 1a1ae7c (lava cave overworld)
:: 1a159ec 1a1b36c (empty)
:: 1a16ffc 1a1b70c
:: 1a1c0fc ("MD  " file "map data"?)
:: ...

:: 1da1cec ... a bunch of cg4 (portraits)
pause
