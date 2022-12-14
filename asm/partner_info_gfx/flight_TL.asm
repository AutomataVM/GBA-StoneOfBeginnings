;
;@{{BLOCK(flight_TL)
;
;@=======================================================================
;@
;@	flight_TL, 512x144@4, 
;@	+ palette 256 entries, not compressed
;@	+ 199 tiles (t|f|p reduced) not compressed
;@	+ regular map (flat), not compressed, 64x18 
;@	Total size: 512 + 6368 + 2304 = 9184
;@
;@	Time-stamp: 2021-06-22, 00:54:07
;@	Exported by Cearn's GBA Image Transmogrifier, v0.8.6
;@	( http://www.coranac.com/projects/#grit )
;@
;@=======================================================================
;tiles


.org 0x096945FC
flight_TLTiles:
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x5550,0x0000,0xEE50,0x0000,0xCE40,0x0000,0xCE50
	.dh 0x0000,0xCE40,0x0000,0xCE50,0x0000,0xCE50,0x0000,0x7C50
	.dh 0x5555,0x5555,0xEEEE,0x7EEE,0xCCEC,0x7CCC,0x9CED,0x7C99
	.dh 0x9CEA,0x7C6F,0x9CE6,0x7C66,0xCCEC,0x7CCC,0xCCE7,0x7CCC
	.dh 0x5555,0x5555,0xEEEE,0xEEEE,0xCCCC,0xCCCC,0xDDDD,0xDDDD
	.dh 0xAAAA,0xAAAA,0x6666,0x6666,0xCCCC,0xCCCC,0x7777,0x7777

	.dh 0x4555,0x4444,0xEEEE,0xEEEE,0xCCCC,0xCCCC,0xDDDD,0xDDDD
	.dh 0xAAAA,0xAAAA,0x6666,0x6666,0xCCCC,0xCCCC,0x7777,0x7777
	.dh 0x4444,0x4444,0xEEEE,0xEEEE,0xCCCC,0xCCCC,0xDDDD,0xDDDD
	.dh 0xAAAA,0xAAAA,0x6666,0x6666,0xCCCC,0xCCCC,0x7777,0x7777
	.dh 0x4444,0x4544,0xEEEE,0xEEEE,0xCCCC,0xCCCC,0xDDDD,0xDDDD
	.dh 0xAAAA,0xAAAA,0x6666,0x6666,0xCCCC,0xCCCC,0x7777,0x7777
	.dh 0x5544,0x5555,0xEEEE,0xEEEE,0xCCCC,0xCCCC,0xDDDD,0xDDDD
	.dh 0xAAAA,0xAAAA,0x6666,0x6666,0xCCCC,0xCCCC,0x7777,0x7777

	.dh 0x5555,0x5555,0xEEEE,0xEEEE,0xCCCE,0xC7CC,0x99CE,0xD7C9
	.dh 0xF9CE,0xA7C6,0x69CE,0x67C6,0xCCCE,0xC7CC,0xCCCE,0x77CC
	.dh 0x0555,0x0000,0x04CE,0x0000,0x057C,0x0000,0x057C,0x0000
	.dh 0x057C,0x0000,0x057C,0x0000,0x047C,0x0000,0x0577,0x0000
	.dh 0x0000,0x3330,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x7CCC

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x111F,0x1111
	.dh 0x111F,0x1111,0x911F,0xAAAA,0xA11F,0xDDDC,0xA11F,0xFFFD
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xD11D,0xFFFF
	.dh 0xA11A,0xFD11,0xA11A,0xDA11,0xA11D,0x1AAC,0xA11F,0x1D11
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x1FFF
	.dh 0xFFFF,0x1D11,0x1111,0x1A11,0x1111,0x1A11,0xAAA1,0x1A11

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFD1,0xFFFF
	.dh 0xFDA1,0xFFFF,0xFDA1,0xFFFF,0xFDA1,0xFFFF,0x1111,0x1ED1
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xD11F,0xFFFF,0xA11F,0xFFFD,0x1111,0xFD11
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x47CC
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x57CC

	.dh 0xCCE4,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xA11F,0xFFFD,0x111F,0xD111,0x111F,0xA111,0x911F,0xAAAA
	.dh 0xA11F,0xDDDC,0xA11F,0xFFFD,0xA11F,0xFFFD,0xA11F,0xFFFD
	.dh 0xA11F,0x1A11,0xA11E,0x1A11,0xA11D,0x1A11,0xA11D,0x1A11
	.dh 0xA11E,0xCA11,0xA11F,0xDA11,0xA11F,0x1A11,0xA11F,0x1A11
	.dh 0xDCA1,0x1A11,0xFDA1,0x1A11,0xFDA1,0x1A11,0x1111,0x1A11
	.dh 0x1111,0x1A11,0xAAAD,0x1A11,0x1111,0x1A11,0x1111,0x1AA1

	.dh 0x1111,0x1D11,0xAA91,0xDA11,0xDCA1,0xDA11,0xFDA1,0xDA11
	.dh 0xFDA1,0xDA11,0xFDA1,0xDA11,0xFDA1,0xDA11,0xFDA1,0xDA11
	.dh 0x1111,0xDA11,0x911A,0xDAAA,0xA11D,0xFDDC,0xA11F,0xFFFD
	.dh 0xA11F,0xFFFD,0xA11F,0xFFFD,0x111F,0xFD11,0x11DF,0xDA11
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x46AC,0xCCCE,0x47CC
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x47CC
	.dh 0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE4,0x6CCC,0xCCE5,0x7CCC,0xCCE4,0x6CCC

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x444F,0x4444,0xBBFF,0xBBBB
	.dh 0xDEFF,0xDDDD,0x11FF,0xD111,0xB1FF,0xBBBA,0xA1FF,0xDDDC
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFEE1,0xFFFF,0xE1B1,0xE1FF,0xB1B1,0xB1FD
	.dh 0xAADF,0xFFFD,0xDDEF,0xFFFE,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFEE1,0xFFFF,0x11DD,0xFD11,0xB1D1,0xD1BA
	.dh 0xAADF,0xDAAD,0xDDEF,0xFDDF,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFFFF,0xFFFF,0x111F,0xFFD1,0xBBD1,0xFDB1

	.dh 0xAAAA,0xDDAA,0xDDDD,0xEEDD,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xE1FF,0xFFFE,0xB1FF,0x1FFD,0x111F,0x1D11
	.dh 0xFDAA,0xDAAD,0xFEDD,0xEDDE,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFFFF,0xFFFF,0x1FFE,0x111E,0x1FDB,0xAB1B
	.dh 0xADFF,0xDAAA,0xDEFF,0xEDDD,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFFFF,0xFFFF,0xFFD1,0xD111,0x1D1B,0x1BBD
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x4444,0x4444,0xBBBB,0xBBBB
	.dh 0xDDDD,0xDDDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFD,0xFFFF

	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0x4444,0x7E44,0xBBBB,0x7BBB
	.dh 0xDDDD,0x7EDD,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x57CC
	.dh 0xCCCE,0x47CC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x46CC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0x11FF,0xED11,0xA1FF,0xEBBA,0xA1FF,0xEDDC,0xB1FF,0xFFFD
	.dh 0xBDFF,0xFFFD,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFD11

	.dh 0x1CB1,0xB1ED,0xDDB1,0xB1D1,0xEDB1,0xBC1D,0x11B1,0xDBC1
	.dh 0xBDBD,0xEDBB,0xDEEF,0xFFDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xA1B1,0xB1DC,0xA1A1,0xB1FD,0xA1A1,0xB1FD,0xB1B1,0xB1FD
	.dh 0xBDBD,0xBDFD,0xEEEF,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xDDB1,0xFDA1,0x111C,0xFDA1,0xABC1,0xFDA1,0x111D,0xFDBB
	.dh 0xBBDD,0xFFDB,0xDDFF,0xFFFD,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xA1EF,0xDBBA,0xA1FF,0xEDDC,0xB1FF,0xFFFD,0x1DFF,0x1D11
	.dh 0xDFFF,0xDBBB,0xFFFF,0xEDDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF

	.dh 0x1ED1,0xCA1B,0x1D1D,0x111B,0xC1DE,0xAA1B,0xBC11,0xCA1D
	.dh 0xDBBB,0xDBDE,0xFDDD,0xFEFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x1B1D,0x1DDB,0x1BD1,0x1111,0x1DBB,0xAAAA,0xDEDD,0x1111
	.dh 0xFFFF,0xBBBD,0xFFFF,0xDDDF,0xFFFF,0xFFFF,0xE1FF,0xFFFF
	.dh 0xFFDB,0xFFFF,0xFFDA,0xFFFF,0xD11A,0xFFFF,0xA11D,0xFFFD
	.dh 0xAADB,0xFFFD,0xDDED,0xFFFF,0xFFFF,0xFFFF,0xFFE1,0xFFFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFE1,0x7FFF

	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x57CC
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x47CC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0x1FFF,0xD1BD,0xD1FF,0xCDDC,0xB1FF,0xEEED,0xB1FF,0xFFFD
	.dh 0x1DFF,0xE1ED,0xDFFF,0xCD11,0xEFFF,0xDBBD,0xFFFF,0xFDDF
	.dh 0x111F,0x11ED,0xBBEE,0xB1D1,0x111F,0xA1B1,0xBBD1,0xA1A1
	.dh 0xDDB1,0xA1A1,0x111D,0xB1A1,0xBBDF,0xBDBA,0xDDFF,0xEEDD

	.dh 0xFD11,0xFFFF,0xD1BA,0x1FFF,0xB1DC,0xEFFD,0xB1FD,0xEFFD
	.dh 0xB1FD,0x1FFD,0xB1FD,0xEFFD,0xBDFD,0xFFFD,0xEFFF,0xFFFF
	.dh 0xD111,0x11FF,0x1BBD,0xBD1D,0xDDC1,0xDB1C,0xD11D,0xDB1D
	.dh 0x1BDD,0xDB1D,0xB111,0x11DC,0xBBBD,0xBDFD,0xDDDF,0xDFFF
	.dh 0xFFD1,0xD111,0xED1B,0x1BBE,0xDB1D,0x1111,0x1B1F,0x1BBD
	.dh 0x1B1F,0x1DDB,0xDBD1,0x1111,0xFDBB,0xABBD,0xFFDD,0xDDDF
	.dh 0x1E1E,0xFD11,0xC11D,0xEBBB,0xBA1B,0xFDDD,0xDA1A,0xFFFE
	.dh 0xDA1A,0xFFFF,0xDB1A,0xFFFF,0xDBDB,0xFFFF,0xFEED,0xFFFF

	.dh 0xB1FF,0xFFFD,0x11FF,0xFD11,0xA1FF,0xD1BA,0xA1FF,0xB1DC
	.dh 0xB1FF,0xB1FD,0xB1FF,0xB1FD,0xBDFF,0xBDFD,0xEFFF,0xEFFF
	.dh 0x1EDE,0xD111,0xD1D1,0xA1BB,0xB1B1,0xA1DD,0x1BB1,0xA111
	.dh 0xC1A1,0xA1AB,0x1DB1,0xBB11,0xDDBD,0xDBBB,0xEEDE,0xFDDD
	.dh 0xFDB1,0x7FFF,0x1111,0x7FFD,0xBAA1,0x7FD1,0xDBA1,0x7DB1
	.dh 0xFDA1,0x7DB1,0xFDB1,0x7DB1,0xFDBD,0x7DBD,0xFFDF,0x7EEE
	.dh 0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x57CC,0xCCCE,0x47CC
	.dh 0xCCCE,0x57CC,0xCACE,0x47CC,0xACAE,0x46AC,0xCCCE,0x47CC

	.dh 0xCCE4,0x6ACC,0xCCE5,0x7CCC,0xAAE4,0x6CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xFFFF,0xFFFF,0x1FFF,0xFFFE,0x1FFF,0xFFDB,0x11FF,0xD111
	.dh 0x1EFF,0xBBAA,0x1EFF,0xDDCA,0x1FFF,0xFFDB,0xDFFF,0xD111
	.dh 0xFFFF,0xFFFF,0xFFE1,0xFFFF,0xFDB1,0xE1FF,0x1111,0x11ED
	.dh 0xBAA1,0xA1D1,0xDCA1,0xA1B1,0xFDB1,0xA1B1,0xFDB1,0xB1B1
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xD111,0x111F,0xBBBC,0xBBD1
	.dh 0xDDDB,0xDDB1,0xFFED,0xFDB1,0xFFFD,0xFDB1,0xFFFD,0x111D

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE1ED,0xE1FF,0xB1D1,0xB1FD
	.dh 0xB1B1,0xB1FD,0xB1B1,0xB1FD,0xB1B1,0xB1FD,0x1DBD,0xA111
	.dh 0xFFFF,0xFFFF,0xFFFF,0xE1FF,0x111F,0xB1D1,0xBBD1,0x11A1
	.dh 0xDDB1,0xA1A1,0x111C,0xA1A1,0xABC1,0xA1A1,0x111D,0xB1BB
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFD,0xFFFF,0xFD11,0x1FFF
	.dh 0xD1BA,0xEFFF,0xB1DC,0xEFFD,0xB1FD,0xFFFD,0xB1FD,0xFFFD
	.dh 0xFFFF,0xFFFF,0xFFE1,0xFE1F,0xFDB1,0xDB1F,0x1111,0x111D
	.dh 0xBAA1,0xAA1B,0xDCA1,0xCA1D,0xFDB1,0xDB1F,0x111D,0xDB1D

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xD111,0x1FD1,0x1BBD
	.dh 0x1D1B,0x1DDB,0x1B1D,0x1111,0x1B1F,0xAAAA,0xCB1F,0x1111
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFED,0x7FFF
	.dh 0xFFDB,0x7FFF,0xFFDA,0x7FFF,0xFFDB,0x7FFF,0xFFED,0x7FFF
	.dh 0xCCCE,0x47CC,0xCCCE,0x47CC,0xCCCE,0x57CC,0xCACE,0x46AC
	.dh 0xCCCE,0x57CC,0xCCCE,0x57CC,0xCCCE,0x46CC,0xCCCE,0x57CC
	.dh 0xFFFF,0xBBBD,0xFFFF,0xDDDF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x1FFF,0xED11,0xEFFF,0xD1BB,0x1FFF,0xB111,0xD1FF,0xA1BB

	.dh 0xFDBD,0xBDBD,0xFFEE,0xEEEF,0xFFFF,0xFFFF,0xFFE1,0xFFFF
	.dh 0xE1DE,0xD111,0x11D1,0xBBBC,0xA1B1,0xDDDB,0xA1A1,0xFFED
	.dh 0xFFFD,0xBBDF,0xFFFF,0xDDFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xD111,0xFFFE,0x1BBE,0xFFFF,0x1111,0x1FFF,0x1BBD
	.dh 0xDEDB,0xBABB,0xFFFD,0xDDDD,0xFFFF,0xFFFF,0xE1FF,0xFFFF
	.dh 0xB1FF,0xFFFD,0x111D,0xFD11,0xA1DB,0xEBBA,0xA1DA,0xFDDC
	.dh 0xBBDD,0xBDDB,0xDDEE,0xEFED,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xD1FF,0xE1D1,0xB1FF,0xB1B1,0xB1FF,0xB1B1,0xA1FF,0xB1B1

	.dh 0xBDFD,0xFFFD,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xE1E1,0xFFE1
	.dh 0xB1DD,0xFDB1,0xB1D1,0xFDB1,0xA1B1,0xFDA1,0xA1A1,0xFDA1
	.dh 0xBBDF,0xDBDB,0xDDFF,0xFDED,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xDBDF,0xBBBD,0xFEEF,0xDDDE,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFDB,0x7FFF,0xFFED,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF

	.dh 0xCCAE,0x46AC,0xCCCE,0x47CC,0xCCCE,0x47CC,0xCCCE,0x47CC
	.dh 0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x57CC,0xCCCE,0x47CC
	.dh 0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xB1FF,0xA1DD,0x1DFF,0xA111,0xDFFF,0xBABB,0xFFFF,0xDDDD
	.dh 0xFFFF,0xFFFF,0x11FF,0xD111,0xB1FF,0xBBBA,0xA1FF,0xDDDC
	.dh 0xA1A1,0xFFFD,0xB1A1,0xFFFD,0xBDBD,0xFFFD,0xEEEE,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFE,0xFFFF,0x111E,0x1FFD,0xBBEF,0xD1D1

	.dh 0x1FFF,0x1DDB,0xDFFF,0x1111,0xFFFF,0xABBD,0xFFFF,0xDDDF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xED11,0xFFE1,0xD1BB,0xFDB1
	.dh 0xB1DA,0xFFFD,0x1DDA,0xFD11,0xDEDB,0xEBBB,0xFFFD,0xFDDD
	.dh 0xFFFF,0xFFFF,0xFFFF,0xE1FF,0xFFE1,0xB1FF,0xFDB1,0x111F
	.dh 0xB1FF,0xA1B1,0x1DFF,0xBB1B,0xDEFF,0xDCCB,0xEFFF,0xFEED
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFD,0xD111,0x1D11,0x1BBD
	.dh 0xA1A1,0x11A1,0xA1A1,0x11A1,0xBDBD,0xADBD,0xEEEF,0xDEEE
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFE1,0xFFFD,0xFDB1

	.dh 0xFFFD,0xFFFF,0xFFDA,0xFFFF,0xFFDA,0xFFFF,0xFFFD,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x1FE1,0xFD11,0xD1B1,0xD1BB
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x111F,0xFFFD,0xBBD1,0xFFD1
	.dh 0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x46CC,0xCCCE,0x47CC
	.dh 0xCCCE,0x46CC,0xCCCE,0x47CC,0xCCCE,0x47CC,0xCCCE,0x46CC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xAAE4,0x6CAA,0xCAE3,0x6ACC,0xCCE5,0x7CCC

	.dh 0x11FF,0xED11,0xA1FF,0xEBBA,0xA1FF,0xFDDC,0x11FF,0xD111
	.dh 0xBDFF,0xBBBA,0xDEFF,0xDDDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x111F,0x1DB1,0xBBD1,0xDDA1,0xDDB1,0xD1A1,0x111D,0x1DA1
	.dh 0xBBDD,0xDDBA,0xDDFE,0xFEDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xCDDC,0xED1D,0xDD11,0xD1DF,0xD1BD,0x1DEE,0xCB11,0xC111
	.dh 0xDBBB,0xBBBD,0xEDDD,0xDDDE,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFDB1,0xA1EF,0xFDB1,0xA1EF,0xFDBC,0xB1FF,0xFFDB,0x1DFF
	.dh 0xFFED,0xDFFF,0xFFFE,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF

	.dh 0x1BBA,0x1DDB,0x1DDC,0x1FDB,0x1FFD,0x1FDB,0xDD11,0xD111
	.dh 0xDBBB,0xBBBD,0xEDDD,0xDDDF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFDB,0xFDB1,0xFFDB,0xFDB1,0xFFDB,0xFDB1,0xFFDB,0x111D
	.dh 0xFFFD,0xBBDF,0xFFFE,0xDDEF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x1DB1,0xCDDC,0xDDB1,0xDD11,0xD1B1,0xD1BD,0x1DA1,0xCB11
	.dh 0xDDBA,0xDBBB,0xFFDD,0xEDDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xDDB1,0xFDB1,0x1111,0xFDA1,0xAAA1,0x11BA,0x111D,0x11D1
	.dh 0xBBDF,0xADBB,0xDDEF,0xDFDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF

	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFD,0x7FFF,0xFFDA,0x7FFF
	.dh 0xFFDA,0x7FFF,0xFFED,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xCCCE,0x47CC,0xCCCE,0x57CC,0xCCCE,0x47CC,0xCCCE,0x57CC
	.dh 0xCCCE,0x57CC,0xACCE,0x47CC,0xCCCE,0x46CC,0xAACE,0x46CA
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE4,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x7CCC
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x11FF,0xD111
	.dh 0xBEFF,0xBAA1,0xDFFF,0xDCA1,0xFFFF,0xFDB1,0xFFFF,0xFDB1

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFE1,0xFFFF
	.dh 0xFDB1,0x1FFF,0x1111,0xEFFD,0xBAA1,0x1ED1,0xDCA1,0xD1B1
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFE1F
	.dh 0xFD11,0xDB1F,0xD1BB,0x1111,0xB111,0xAA1D,0xA1BB,0xCA1D
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0x11FF,0xFFD1,0xBD1F,0xFEBB,0xC1EF,0xFFDD,0x1DFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFD1,0xD111,0xED1B,0x1BBE,0xECDD,0x1111,0x1DD1,0x1BBD

	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFE1F,0x1FFF
	.dh 0xEDEE,0x1FFF,0xED1D,0x1111,0x1B1B,0x1BBD,0x1A1A,0x1DDB
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0x1FFF
	.dh 0xFFDB,0x1FFF,0xFFDA,0x1FFF,0xFFDA,0x1FFF,0xFFDA,0x1FFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFE,0xFFFF
	.dh 0xFFDB,0x11FF,0xD111,0xBD1F,0x1BAA,0xDB1D,0x1DCA,0x111B
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xFED1,0x7FFF,0xFD1B,0x7FFF,0xDB1D,0x7FFF,0xDA11,0x7FFF

	.dh 0xCCAE,0x36AC,0xCCCE,0x57CC,0xCCCE,0x57CC,0xACCE,0x47CC
	.dh 0xCAAE,0x46AA,0xAAAE,0x46AA,0xCCCE,0x46CA,0xACCE,0x46AC
	.dh 0xCCE4,0x7CCC,0xCCE4,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC
	.dh 0xFFFF,0xFDB1,0xFFFF,0xFDB1,0xFFFF,0xFDBD,0xFFFF,0xFFEF
	.dh 0xFFFF,0xFFFF,0xE1FF,0xFFFF,0xB1FF,0xFFFD,0x11FF,0xFD11
	.dh 0xFDB1,0xB1B1,0xFDB1,0x1CB1,0xFDBD,0xDDBD,0xFFEF,0xEFEF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x111F,0x1FFD,0xBBEF,0xD1D1

	.dh 0xA1DD,0xDB1D,0xA111,0x11DD,0xBABB,0xBDED,0xDDDD,0xDFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFD11,0x1FFF,0xD1BB,0x1FFF
	.dh 0xFFFF,0xDD1F,0xFFD1,0x11EF,0xFEBB,0xBDFF,0xFFDD,0xDFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xE1D1,0x11FF,0x1C1B,0xBD1D
	.dh 0x1D1B,0x1DDB,0xDCB1,0x1111,0xFDBB,0xABBD,0xFFDD,0xDDDF
	.dh 0xFFFF,0xFFFF,0xFFFF,0x1FFF,0xFFD1,0x1FFF,0xED1B,0x1111
	.dh 0x1A1A,0x1FDB,0xCA1A,0x1111,0xDBDB,0xABBD,0xFEED,0xDDDE
	.dh 0xFFFF,0xFFFF,0xFE1E,0xFFFF,0xEDDB,0xD111,0x1D1A,0x1BBD

	.dh 0xD11B,0x1FFF,0xB1DA,0x1FFD,0xBC1B,0xDFFD,0xDCDD,0xFFFF
	.dh 0xFEFF,0xFFFF,0xFFFF,0xFFFF,0x11FE,0x1FD1,0xBD1D,0x1D1B
	.dh 0x1FDB,0xAA1B,0x1FDB,0x11BB,0xDFDB,0xBDDB,0xEFFE,0xDFED
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0x111D,0x11ED,0xBBB1,0xBD1B
	.dh 0xDBAB,0x7FFF,0xFB11,0x7FFF,0xDBBB,0x7FFF,0xEDDD,0x7FFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFED1,0x7FFF,0xED1B,0x7FFF
	.dh 0xCCCE,0x57CC,0xCCCE,0x46CC,0xACCE,0x47CC,0xCCAE,0x46CC
	.dh 0xCCCE,0x57CC,0xACCE,0x47CC,0xACAE,0x46CC,0xCCCE,0x47CC

	.dh 0xCCE4,0x6CAA,0xCCE5,0x7CCC,0xCCE4,0x7CCC,0xCCE5,0x7CCC
	.dh 0xAAE4,0x6AAA,0xCCE4,0x6ACC,0xCCE4,0x7CCA,0xCAE4,0x6ACC
	.dh 0xA1FF,0xD1BA,0xA1FF,0xB1DB,0xB1FF,0xB1FD,0xB1FF,0xB1FD
	.dh 0xBDFF,0xBDFD,0xDEFF,0xDEFE,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x111F,0x1DB1,0xBBD1,0xDDA1,0xDDB1,0xD1A1,0x111B,0x1DA1
	.dh 0xBBDD,0xDDBA,0xDDFE,0xFFDD,0xFFFF,0xFFFF,0xED1F,0xFFFF
	.dh 0xBDDB,0x1FFD,0xDD11,0x1FFE,0xD1BD,0x1FFE,0xBB11,0x1FFF
	.dh 0xDBBB,0xDFFE,0xEDDD,0xEFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF

	.dh 0x1B1A,0xDB1B,0x1B1B,0x111A,0x1B1B,0xAA1B,0x1B1B,0x11BB
	.dh 0xDBDB,0xBDDB,0xFDFD,0xDFED,0xFFFF,0xFFFF,0xD1FF,0xFFFE
	.dh 0x1B1D,0x1BBD,0x1A11,0x1DDB,0x1BAA,0x1FDB,0xDB11,0x1111
	.dh 0xDBBB,0xABBD,0xEDDD,0xDDDF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0x1B1A,0x1DDB,0x1B1A,0x1FDB,0x1A1A,0x1FDB,0xBB1A,0xD111
	.dh 0xDBDB,0xBBBD,0xEDFD,0xDDDF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xDB1B,0x1BDD,0xDB1B,0x1DFF,0xDB1B,0x1D1F,0x11DB,0x1BD1
	.dh 0xBDFD,0xDDBB,0xDEFE,0xEFDD,0xFFFF,0xFFFF,0xFFFF,0xFFFF

	.dh 0xDDBA,0xDB1D,0xFFDA,0x111F,0xFFDB,0xAA1F,0xFFDB,0x11DF
	.dh 0xFFDB,0xBDEF,0xFFED,0xDEFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xDB1D,0x7FFF,0xDA11,0x7FFF,0xDBAB,0x7FFF,0xFB11,0x7FFF
	.dh 0xDBBB,0x7FFF,0xEDDD,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xAAAE,0x46AA,0xACCE,0x46CA,0xAAAE,0x36AA,0xCCCE,0x56CC
	.dh 0xCCCE,0x47CC,0xCACE,0x47CC,0xAAAE,0x36AA,0xCCCE,0x46CA
	.dh 0xCCE5,0x7CCC,0xCCE4,0x6CCC,0xCCE5,0x7CCC,0xCCE5,0x7CCC
	.dh 0xCCE4,0x6ACC,0xCCE5,0x7CCC,0xCCE5,0x7CCC,0xCCE4,0x6ACC

	.dh 0x1FFF,0xED11,0xD1FF,0xD1BB,0x1DFF,0xBDDB,0xDEFF,0xDD11
	.dh 0xD1FF,0xD1BD,0x1DFF,0xBB11,0xDEFF,0xDBBB,0xFFFF,0xFDDD
	.dh 0xDB1F,0x1FFF,0x1111,0xDED1,0xAA1D,0x1DBB,0xBA1F,0xD1DD
	.dh 0xDB1F,0xB1FF,0x11DD,0x1DD1,0xBDEE,0xDDBB,0xDFFF,0xEEDD
	.dh 0xFD11,0x1D11,0xD1BB,0xB1B1,0xB111,0xB1A1,0xA1BB,0xB1B1
	.dh 0xA1DD,0xB1B1,0xA111,0xB1B1,0xBABB,0xBDBD,0xDDDD,0xEEEE
	.dh 0xDDFD,0x1111,0xD1D1,0xBAB1,0xB1B1,0xDBA1,0xB1B1,0xFDB1
	.dh 0xB1B1,0xFDB1,0xB1B1,0xFDB1,0xBDBD,0xFDBD,0xEEEE,0xFEEE

	.dh 0x1FED,0xED11,0xDFD1,0xD1BB,0x1DB1,0xB111,0xD1B1,0xA1BB
	.dh 0xB1B1,0xA1DD,0x1BB1,0xA111,0xDDBD,0xBABB,0xFFDE,0xDDDD
	.dh 0xFFFF,0xFFFF,0xFFFE,0xFFFF,0xFFFD,0xFFFF,0xFFFD,0xFFFF
	.dh 0xED11,0xFFFF,0xDA11,0xFFFF,0xDAAD,0xFFFF,0xFDDE,0xFFFF
	.dh 0xFFFF,0xFFFF,0xEFFF,0xFFFF,0xFFFF,0xEFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF,0xFFFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFEFF,0x7FFF,0xFFFF,0x7FFF
	.dh 0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF,0xFFFF,0x7FFF

	.dh 0xAAAE,0x36AA,0xAAAE,0x46AA,0xAAAE,0x46AA,0xCCCE,0x46CC
	.dh 0xAACE,0x46AA,0xAAAE,0x36AA,0xCACE,0x46CA,0xAAAE,0x46AA
	.dh 0x0000,0x5553,0x0000,0xEEE3,0x0000,0xCCE3,0x0000,0x7AE3
	.dh 0x0000,0x7AE3,0x0000,0x9CE3,0x0000,0xCAE3,0x0000,0xCCE3
	.dh 0xCCE5,0x7CCC,0xEEEE,0xEEEE,0xCACC,0xAACA,0xAA97,0xAAAA
	.dh 0xAA6F,0xAAAC,0xCC66,0x2CCC,0xAACA,0x21AA,0xCCCC,0xF2CC
	.dh 0x7777,0x7777,0xEEEE,0xEEEE,0xCCAC,0xCCCC,0xCAAA,0xCCCC
	.dh 0x2222,0xAC22,0xFFF2,0xC22F,0xFFFF,0x22FF,0x22FF,0x2FFF

	.dh 0x7777,0x6666,0xEEEE,0xEEEE,0xACAC,0xCCCC,0xCACA,0xCACA
	.dh 0xCCCA,0xCCCC,0xCCCC,0xCCCC,0x22AA,0xAA22,0xF2CC,0xAA2F
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xCCCC,0x222C,0xAAAC,0xFF22
	.dh 0xAAAA,0xFFF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0x2222,0x2222,0x2FFF,0x2FF2
	.dh 0xFFFF,0x2FF2,0xFF22,0x2FF2,0xFF2A,0x2FF2,0xFF2A,0xFFF2
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xCCCA,0xAAAC,0x222A,0xAAA2
	.dh 0xFF22,0xAAA2,0xFFF2,0xAAA2,0x2FFF,0xAAA2,0x22FF,0xAAAA

	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xACAC,0xACAC,0xCACA,0xAAAA
	.dh 0xCCAA,0xCCCC,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xACAC,0xACAC,0xAAAA,0xAAAA
	.dh 0xACAC,0xACCC,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAC,0xAAAA
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xCAAC,0xAAAA,0xAACA,0xACAC
	.dh 0xACAC,0xAACA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0x6666,0x6666,0xEEEE,0xEEEE,0xAAAA,0xAAAA,0xAAAC,0xACAA
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA

	.dh 0xAAAE,0x36AA,0xEEEE,0xEEEE,0xAAAA,0xAAAA,0xAAAA,0x77AA
	.dh 0xAAAA,0xF7AA,0xAAAA,0x59AA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0x3433,0x0000,0x3AEE,0x0000,0x36AA,0x0000,0x36A9,0x0000
	.dh 0x36A6,0x0000,0x36A5,0x0000,0x36AA,0x0000,0x36AA,0x0000
	.dh 0x0000,0xAAE3,0x0000,0xAAE3,0x0000,0xCCE3,0x0000,0xCCE3
	.dh 0x0000,0xCCE3,0x0000,0xCAE3,0x0000,0xAAE3,0x0000,0xCCE3
	.dh 0xACAC,0xF2AA,0xAAAA,0xF2AA,0xCACC,0xF2AA,0xCCCC,0xF2CC
	.dh 0xCCCC,0xF3CC,0xACCA,0xF2CC,0xCCAC,0xF2AC,0xAAAA,0x22CA

	.dh 0x222F,0x2FF2,0x222F,0x2FF2,0xFFFF,0x2FFF,0xFFFF,0x2FFF
	.dh 0x332F,0x2FF2,0xCC2F,0x2FF2,0xCA2F,0x2FF2,0xAA22,0x2222
	.dh 0xF2AA,0xAA2F,0x22AA,0xAA22,0xAAAA,0xAAAA,0x22AC,0xAA22
	.dh 0xF2CC,0xCC2F,0xF2CC,0xAA2F,0x22AA,0xAA22,0xACAA,0xAAAA
	.dh 0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2
	.dh 0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0xFFF2,0xAAAA,0xFF22
	.dh 0xFF2A,0xFFF2,0xFF2A,0xFFF2,0xFF2A,0x2FF2,0xFF2A,0x2FF2
	.dh 0xFF2A,0x2FF2,0xFF22,0x2FF2,0xFFFF,0x2FF2,0x2FFF,0x2FF2

	.dh 0xA22F,0xAAAA,0xA2FF,0xAAAA,0x22FF,0xAAAA,0x2FFF,0xAAAA
	.dh 0x2FF2,0xAAA2,0xFFF2,0xAAA2,0xFF22,0xAAA2,0xFF2A,0xAAA2
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0x36AA,0x0000,0x36AA,0x0000,0x36AA,0x0000,0x36AA,0x0000
	.dh 0x36AA,0x0000,0x36AA,0x0000,0x36AA,0x0000,0x36AA,0x0000
	.dh 0x0000,0xAAE3,0x0000,0xCCE3,0x0000,0xAAE3,0x0000,0xAAE3
	.dh 0x0000,0xAAE3,0x0000,0xAAE3,0x0000,0xAAE3,0x0000,0xCAE3

	.dh 0xAAAA,0xAAAA,0xACAA,0x22CC,0xAAAA,0xF2AA,0xAAAA,0xF1AA
	.dh 0xAAAA,0xF2AA,0xCAAC,0xF1AA,0xAAAA,0xF2AA,0xAAAA,0xF2AA
	.dh 0xAAAA,0xAAAA,0x2222,0xC223,0xFFFF,0x22FF,0xFFFF,0x2FFF
	.dh 0x122F,0x2FF2,0x112F,0x1FF2,0xFFFF,0x12FF,0xFFFF,0x2FFF
	.dh 0xAAAA,0xAAAA,0xCCCC,0xACAC,0xAAAC,0xAAAA,0x22AA,0xAA22
	.dh 0xF2AA,0xAA2F,0xF1AA,0xAA1F,0x11AA,0xAA11,0xAAAA,0xAAAA
	.dh 0xAAAA,0x222A,0xAAAC,0xFF22,0xAAAA,0xFFF2,0xAAAA,0x2FF2
	.dh 0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2

	.dh 0x2222,0x2222,0x2FFF,0xAAC2,0xFFFF,0x2222,0xFF22,0xFF22
	.dh 0xFF2A,0xFF22,0x222A,0x2222,0xAAAA,0xFF22,0xAAAA,0xFFF2
	.dh 0x222A,0xAAA2,0xAAAC,0xAAAA,0x2222,0xAAAA,0x2FFF,0x2222
	.dh 0xFFFF,0xFFF2,0xFF22,0xFFF2,0xFFFF,0x2FF2,0xFFFF,0x2FF2
	.dh 0xAAAA,0xAAAA,0xAAAA,0xCAAA,0xAAAA,0xAAAA,0x2222,0x222A
	.dh 0x2FFF,0xFF22,0xFFFF,0xFFF2,0xFF22,0x2FF2,0xFF2A,0x2FF2
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0x2222,0x222A
	.dh 0x2FFF,0xFF22,0xFFFF,0xFFF2,0xFF22,0x2FF2,0xFF2A,0x2FF2

	.dh 0xAAAA,0x2222,0xAAAA,0x2FF2,0xAAAA,0x2FF2,0x2222,0x2FF2
	.dh 0x2FFF,0x2FF2,0xFFFF,0x2FF2,0xFF22,0x2FF2,0xFF22,0x2FF2
	.dh 0x0000,0xAAE3,0x0000,0xACE3,0x0000,0x7AE3,0x0000,0x7AE3
	.dh 0x0000,0x9CE3,0x0000,0xAAE3,0x0000,0x66E3,0x0000,0x4443
	.dh 0xAAAA,0xF1AA,0xAAAA,0xF2AA,0xAA97,0xF2AA,0xAA5D,0xF1AA
	.dh 0xAA66,0x22AA,0xAAAA,0xAAAA,0x6666,0x6666,0x4444,0x4444
	.dh 0x211F,0x1FF1,0x222F,0x2FF2,0xFFFF,0x2FFF,0xFFFF,0x11FF
	.dh 0x2222,0xA222,0xCCCA,0xCCCC,0x6666,0x6666,0x3444,0x3344

	.dh 0x11AA,0xAA11,0xF2AC,0xAA2F,0xF2AA,0xAA2F,0x11AA,0xAA11
	.dh 0xAAAA,0xAAAA,0xCCCC,0xCCCA,0x6666,0x6666,0x3333,0x3333
	.dh 0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0x2FF2,0xAAAA,0xFFF2
	.dh 0xAAAA,0xFF22,0xCCCC,0x222C,0x6666,0x6666,0x3333,0x4433
	.dh 0x222A,0x2FF2,0xFF2A,0x2FF2,0xFF22,0x2FF2,0xFFFF,0xFFF2
	.dh 0x2FFF,0xFF22,0x2222,0x222C,0x6666,0x6666,0x3333,0x4333
	.dh 0xFF22,0x2FF2,0xFF2A,0x2FF2,0xFF22,0x2FF2,0xFFFF,0x2FF2
	.dh 0x2FFF,0x2FF2,0x2222,0x2222,0x6666,0x6666,0x3333,0x3333

	.dh 0xFF2A,0x2FF2,0xFF2A,0x2FF2,0xFF2A,0x2FF2,0xFF2A,0xFFF2
	.dh 0xFF2A,0xFF22,0x222A,0x2222,0x6666,0x6666,0x3333,0x3333
	.dh 0x222A,0xFFF2,0xFF2A,0xFFF2,0xFF22,0x2FF2,0xFFFF,0xFFF2
	.dh 0x2FFF,0xFF22,0x2222,0x222A,0x6666,0x6666,0x3333,0x3333
	.dh 0xFFFF,0x2FF2,0xFFFF,0x2FF2,0x2222,0x2FF2,0xFFFF,0x2FF2
	.dh 0xFFFF,0x2FF2,0x2222,0x2222,0x6666,0x6666,0x3333,0x3333
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA
	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0x6666,0x6666,0x3333,0x3333

	.dh 0xAAAA,0xAAAA,0xAAAA,0xAAAA,0xAAAA,0x77AA,0xAAAA,0xD7AA
	.dh 0xAAAA,0x57AA,0xAAAA,0xAAAA,0x6666,0x6666,0x3333,0x3333
	.dh 0x36AA,0x0000,0x36AA,0x0000,0x36A9,0x0000,0x36A5,0x0000
	.dh 0x36A5,0x0000,0x36AA,0x0000,0x3666,0x0000,0x3223,0x0000
;map

.org 0x0969615A
flight_TLMap:
	.dh 0x1001,0x1002,0x1003,0x1003,0x1003,0x1004,0x1005,0x1006
	.dh 0x1007,0x1003,0x1003,0x1008,0x1009,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x100A,0x100B,0x000C,0x000C,0x000D,0x000E,0x000F,0x0010
	.dh 0x0011,0x000C,0x0012,0x1013,0x140A,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1014,0x000C,0x000C,0x0015,0x0016,0x0017,0x0018
	.dh 0x0019,0x000C,0x0012,0x101A,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x101B,0x001C,0x001D,0x001E,0x001F,0x0020,0x0021
	.dh 0x0022,0x0023,0x0024,0x1025,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1026,0x0027,0x0028,0x0029,0x002A,0x002B,0x002C
	.dh 0x002D,0x002E,0x002F,0x1030,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1031,0x0032,0x0033,0x0034,0x0035,0x0036,0x0037
	.dh 0x0038,0x0039,0x003A,0x103B,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x103C,0x003D,0x003E,0x003F,0x0040,0x0041,0x0042
	.dh 0x0043,0x0044,0x0045,0x1046,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1026,0x0047,0x0048,0x0049,0x004A,0x004B,0x004C
	.dh 0x004D,0x004E,0x004F,0x1050,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1051,0x0052,0x0053,0x0054,0x0055,0x0056,0x0057
	.dh 0x0058,0x0059,0x0012,0x105A,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x105B,0x005C,0x005D,0x005E,0x005F,0x0060,0x0061
	.dh 0x0062,0x0063,0x0064,0x1065,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1066,0x0067,0x0068,0x0069,0x006A,0x006B,0x006C
	.dh 0x006D,0x006E,0x006F,0x1070,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1071,0x0072,0x0073,0x0074,0x0075,0x0076,0x0077
	.dh 0x0078,0x0079,0x007A,0x107B,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x107C,0x007D,0x007E,0x007F,0x0080,0x0081,0x0082
	.dh 0x0083,0x0084,0x0085,0x1086,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x0000,0x1087,0x0088,0x0089,0x008A,0x008B,0x008C,0x008D
	.dh 0x000C,0x008E,0x008F,0x1090,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x1091,0x1092,0x1093,0x1094,0x1095,0x1096,0x1097,0x1098
	.dh 0x1099,0x109A,0x109B,0x109C,0x109D,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x109E,0x109F,0x10A0,0x10A1,0x10A2,0x10A3,0x10A4,0x10A5
	.dh 0x10A5,0x10A5,0x10A5,0x10A5,0x10A6,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x10A7,0x10A8,0x10A9,0x10AA,0x10AB,0x10AC,0x10AD,0x10AE
	.dh 0x10AF,0x10B0,0x10A5,0x10A5,0x10A6,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

	.dh 0x10B1,0x10B2,0x10B3,0x10B4,0x10B5,0x10B6,0x10B7,0x10B8
	.dh 0x10B9,0x10BA,0x10BB,0x10BC,0x10BD,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.dh 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000