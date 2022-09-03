; by teod 21/03/31
; these lookup tables are relocated due to size constraints
; they are extended to support more than 8 chars/sprites
; thus now they can support up to 32 chars

; ---------------------------------------------
; teod: update 21/04/07
; add an adjust variable for the sprite offsets
; since the renderer was updated
;
; for now, spacing = 12
; for cleanliness, I would like it to be 0
; but the other scaling tables would need 
; to be fixed first
; ---------------------------------------------

BaseAddr equ 0x094EA61C

; patch for new TableA location
.org 0x094EA630
.dw  TableA-BaseAddr
; patch for new TableB location
.org 0x094EA638
.dw  TableB-BaseAddr
; patch for new TableC location
.org 0x094EA640
.dw  TableC-BaseAddr



; the addr is where free space is available
.org 0x09FBC000

; each TableA entry is a collection of frames
; in this case, 8 frames of animation for each entry
TableA:
TA:
.dh TAD-TA       :: .dh TAD-TA+66    :: .dh TAD-TA+66*2  :: .dh TAD-TA+66*3
.dh TAD-TA+66*4  :: .dh TAD-TA+66*5  :: .dh TAD-TA+66*6  :: .dh TAD-TA+66*7
.dh TAD-TA+66*8  :: .dh TAD-TA+66*9  :: .dh TAD-TA+66*10 :: .dh TAD-TA+66*11
.dh TAD-TA+66*12 :: .dh TAD-TA+66*13 :: .dh TAD-TA+66*14 :: .dh TAD-TA+66*15
.dh TAD-TA+66*16 :: .dh TAD-TA+66*17 :: .dh TAD-TA+66*18 :: .dh TAD-TA+66*19
.dh TAD-TA+66*20 :: .dh TAD-TA+66*21 :: .dh TAD-TA+66*22 :: .dh TAD-TA+66*23
.dh TAD-TA+66*24 :: .dh TAD-TA+66*25 :: .dh TAD-TA+66*26 :: .dh TAD-TA+66*27
.dh TAD-TA+66*28 :: .dh TAD-TA+66*29 :: .dh TAD-TA+66*30 :: .dh TAD-TA+66*31

; the 2nd half is an index into TableB
TableAData:
TAD:
.dh 8
.dh 0x100 :: .dh 0 :: .dw 0 :: .dh 0x100 :: .dh 1 :: .dw 0
.dh 0x100 :: .dh 2 :: .dw 0 :: .dh 0x200 :: .dh 4 :: .dw 0
.dh 0x100 :: .dh 3 :: .dw 0 :: .dh 0x100 :: .dh 4 :: .dw 0
.dh 0x100 :: .dh 2 :: .dw 0 :: .dh 0x200 :: .dh 4 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5 :: .dw 0 :: .dh 0x100 :: .dh 1+5 :: .dw 0
.dh 0x100 :: .dh 2+5 :: .dw 0 :: .dh 0x200 :: .dh 4+5 :: .dw 0
.dh 0x100 :: .dh 3+5 :: .dw 0 :: .dh 0x100 :: .dh 4+5 :: .dw 0
.dh 0x100 :: .dh 2+5 :: .dw 0 :: .dh 0x200 :: .dh 4+5 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*2 :: .dw 0 :: .dh 0x100 :: .dh 1+5*2 :: .dw 0
.dh 0x100 :: .dh 2+5*2 :: .dw 0 :: .dh 0x200 :: .dh 4+5*2 :: .dw 0
.dh 0x100 :: .dh 3+5*2 :: .dw 0 :: .dh 0x100 :: .dh 4+5*2 :: .dw 0
.dh 0x100 :: .dh 2+5*2 :: .dw 0 :: .dh 0x200 :: .dh 4+5*2 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*3 :: .dw 0 :: .dh 0x100 :: .dh 1+5*3 :: .dw 0
.dh 0x100 :: .dh 2+5*3 :: .dw 0 :: .dh 0x200 :: .dh 4+5*3 :: .dw 0
.dh 0x100 :: .dh 3+5*3 :: .dw 0 :: .dh 0x100 :: .dh 4+5*3 :: .dw 0
.dh 0x100 :: .dh 2+5*3 :: .dw 0 :: .dh 0x200 :: .dh 4+5*3 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*4 :: .dw 0 :: .dh 0x100 :: .dh 1+5*4 :: .dw 0
.dh 0x100 :: .dh 2+5*4 :: .dw 0 :: .dh 0x200 :: .dh 4+5*4 :: .dw 0
.dh 0x100 :: .dh 3+5*4 :: .dw 0 :: .dh 0x100 :: .dh 4+5*4 :: .dw 0
.dh 0x100 :: .dh 2+5*4 :: .dw 0 :: .dh 0x200 :: .dh 4+5*4 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*5 :: .dw 0 :: .dh 0x100 :: .dh 1+5*5 :: .dw 0
.dh 0x100 :: .dh 2+5*5 :: .dw 0 :: .dh 0x200 :: .dh 4+5*5 :: .dw 0
.dh 0x100 :: .dh 3+5*5 :: .dw 0 :: .dh 0x100 :: .dh 4+5*5 :: .dw 0
.dh 0x100 :: .dh 2+5*5 :: .dw 0 :: .dh 0x200 :: .dh 4+5*5 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*6 :: .dw 0 :: .dh 0x100 :: .dh 1+5*6 :: .dw 0
.dh 0x100 :: .dh 2+5*6 :: .dw 0 :: .dh 0x200 :: .dh 4+5*6 :: .dw 0
.dh 0x100 :: .dh 3+5*6 :: .dw 0 :: .dh 0x100 :: .dh 4+5*6 :: .dw 0
.dh 0x100 :: .dh 2+5*6 :: .dw 0 :: .dh 0x200 :: .dh 4+5*6 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*7 :: .dw 0 :: .dh 0x100 :: .dh 1+5*7 :: .dw 0
.dh 0x100 :: .dh 2+5*7 :: .dw 0 :: .dh 0x200 :: .dh 4+5*7 :: .dw 0
.dh 0x100 :: .dh 3+5*7 :: .dw 0 :: .dh 0x100 :: .dh 4+5*7 :: .dw 0
.dh 0x100 :: .dh 2+5*7 :: .dw 0 :: .dh 0x200 :: .dh 4+5*7 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*8 :: .dw 0 :: .dh 0x100 :: .dh 1+5*8 :: .dw 0
.dh 0x100 :: .dh 2+5*8 :: .dw 0 :: .dh 0x200 :: .dh 4+5*8 :: .dw 0
.dh 0x100 :: .dh 3+5*8 :: .dw 0 :: .dh 0x100 :: .dh 4+5*8 :: .dw 0
.dh 0x100 :: .dh 2+5*8 :: .dw 0 :: .dh 0x200 :: .dh 4+5*8 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*9 :: .dw 0 :: .dh 0x100 :: .dh 1+5*9 :: .dw 0
.dh 0x100 :: .dh 2+5*9 :: .dw 0 :: .dh 0x200 :: .dh 4+5*9 :: .dw 0
.dh 0x100 :: .dh 3+5*9 :: .dw 0 :: .dh 0x100 :: .dh 4+5*9 :: .dw 0
.dh 0x100 :: .dh 2+5*9 :: .dw 0 :: .dh 0x200 :: .dh 4+5*9 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*10 :: .dw 0 :: .dh 0x100 :: .dh 1+5*10 :: .dw 0
.dh 0x100 :: .dh 2+5*10 :: .dw 0 :: .dh 0x200 :: .dh 4+5*10 :: .dw 0
.dh 0x100 :: .dh 3+5*10 :: .dw 0 :: .dh 0x100 :: .dh 4+5*10 :: .dw 0
.dh 0x100 :: .dh 2+5*10 :: .dw 0 :: .dh 0x200 :: .dh 4+5*10 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*11 :: .dw 0 :: .dh 0x100 :: .dh 1+5*11 :: .dw 0
.dh 0x100 :: .dh 2+5*11 :: .dw 0 :: .dh 0x200 :: .dh 4+5*11 :: .dw 0
.dh 0x100 :: .dh 3+5*11 :: .dw 0 :: .dh 0x100 :: .dh 4+5*11 :: .dw 0
.dh 0x100 :: .dh 2+5*11 :: .dw 0 :: .dh 0x200 :: .dh 4+5*11 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*12 :: .dw 0 :: .dh 0x100 :: .dh 1+5*12 :: .dw 0
.dh 0x100 :: .dh 2+5*12 :: .dw 0 :: .dh 0x200 :: .dh 4+5*12 :: .dw 0
.dh 0x100 :: .dh 3+5*12 :: .dw 0 :: .dh 0x100 :: .dh 4+5*12 :: .dw 0
.dh 0x100 :: .dh 2+5*12 :: .dw 0 :: .dh 0x200 :: .dh 4+5*12 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*13 :: .dw 0 :: .dh 0x100 :: .dh 1+5*13 :: .dw 0
.dh 0x100 :: .dh 2+5*13 :: .dw 0 :: .dh 0x200 :: .dh 4+5*13 :: .dw 0
.dh 0x100 :: .dh 3+5*13 :: .dw 0 :: .dh 0x100 :: .dh 4+5*13 :: .dw 0
.dh 0x100 :: .dh 2+5*13 :: .dw 0 :: .dh 0x200 :: .dh 4+5*13 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*14 :: .dw 0 :: .dh 0x100 :: .dh 1+5*14 :: .dw 0
.dh 0x100 :: .dh 2+5*14 :: .dw 0 :: .dh 0x200 :: .dh 4+5*14 :: .dw 0
.dh 0x100 :: .dh 3+5*14 :: .dw 0 :: .dh 0x100 :: .dh 4+5*14 :: .dw 0
.dh 0x100 :: .dh 2+5*14 :: .dw 0 :: .dh 0x200 :: .dh 4+5*14 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*15 :: .dw 0 :: .dh 0x100 :: .dh 1+5*15 :: .dw 0
.dh 0x100 :: .dh 2+5*15 :: .dw 0 :: .dh 0x200 :: .dh 4+5*15 :: .dw 0
.dh 0x100 :: .dh 3+5*15 :: .dw 0 :: .dh 0x100 :: .dh 4+5*15 :: .dw 0
.dh 0x100 :: .dh 2+5*15 :: .dw 0 :: .dh 0x200 :: .dh 4+5*15 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*16 :: .dw 0 :: .dh 0x100 :: .dh 1+5*16 :: .dw 0
.dh 0x100 :: .dh 2+5*16 :: .dw 0 :: .dh 0x200 :: .dh 4+5*16 :: .dw 0
.dh 0x100 :: .dh 3+5*16 :: .dw 0 :: .dh 0x100 :: .dh 4+5*16 :: .dw 0
.dh 0x100 :: .dh 2+5*16 :: .dw 0 :: .dh 0x200 :: .dh 4+5*16 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*17 :: .dw 0 :: .dh 0x100 :: .dh 1+5*17 :: .dw 0
.dh 0x100 :: .dh 2+5*17 :: .dw 0 :: .dh 0x200 :: .dh 4+5*17 :: .dw 0
.dh 0x100 :: .dh 3+5*17 :: .dw 0 :: .dh 0x100 :: .dh 4+5*17 :: .dw 0
.dh 0x100 :: .dh 2+5*17 :: .dw 0 :: .dh 0x200 :: .dh 4+5*17 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*18 :: .dw 0 :: .dh 0x100 :: .dh 1+5*18 :: .dw 0
.dh 0x100 :: .dh 2+5*18 :: .dw 0 :: .dh 0x200 :: .dh 4+5*18 :: .dw 0
.dh 0x100 :: .dh 3+5*18 :: .dw 0 :: .dh 0x100 :: .dh 4+5*18 :: .dw 0
.dh 0x100 :: .dh 2+5*18 :: .dw 0 :: .dh 0x200 :: .dh 4+5*18 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*19 :: .dw 0 :: .dh 0x100 :: .dh 1+5*19 :: .dw 0
.dh 0x100 :: .dh 2+5*19 :: .dw 0 :: .dh 0x200 :: .dh 4+5*19 :: .dw 0
.dh 0x100 :: .dh 3+5*19 :: .dw 0 :: .dh 0x100 :: .dh 4+5*19 :: .dw 0
.dh 0x100 :: .dh 2+5*19 :: .dw 0 :: .dh 0x200 :: .dh 4+5*19 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*20 :: .dw 0 :: .dh 0x100 :: .dh 1+5*20 :: .dw 0
.dh 0x100 :: .dh 2+5*20 :: .dw 0 :: .dh 0x200 :: .dh 4+5*20 :: .dw 0
.dh 0x100 :: .dh 3+5*20 :: .dw 0 :: .dh 0x100 :: .dh 4+5*20 :: .dw 0
.dh 0x100 :: .dh 2+5*20 :: .dw 0 :: .dh 0x200 :: .dh 4+5*20 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*21 :: .dw 0 :: .dh 0x100 :: .dh 1+5*21 :: .dw 0
.dh 0x100 :: .dh 2+5*21 :: .dw 0 :: .dh 0x200 :: .dh 4+5*21 :: .dw 0
.dh 0x100 :: .dh 3+5*21 :: .dw 0 :: .dh 0x100 :: .dh 4+5*21 :: .dw 0
.dh 0x100 :: .dh 2+5*21 :: .dw 0 :: .dh 0x200 :: .dh 4+5*21 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*22 :: .dw 0 :: .dh 0x100 :: .dh 1+5*22 :: .dw 0
.dh 0x100 :: .dh 2+5*22 :: .dw 0 :: .dh 0x200 :: .dh 4+5*22 :: .dw 0
.dh 0x100 :: .dh 3+5*22 :: .dw 0 :: .dh 0x100 :: .dh 4+5*22 :: .dw 0
.dh 0x100 :: .dh 2+5*22 :: .dw 0 :: .dh 0x200 :: .dh 4+5*22 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*23 :: .dw 0 :: .dh 0x100 :: .dh 1+5*23 :: .dw 0
.dh 0x100 :: .dh 2+5*23 :: .dw 0 :: .dh 0x200 :: .dh 4+5*23 :: .dw 0
.dh 0x100 :: .dh 3+5*23 :: .dw 0 :: .dh 0x100 :: .dh 4+5*23 :: .dw 0
.dh 0x100 :: .dh 2+5*23 :: .dw 0 :: .dh 0x200 :: .dh 4+5*23 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*24 :: .dw 0 :: .dh 0x100 :: .dh 1+5*24 :: .dw 0
.dh 0x100 :: .dh 2+5*24 :: .dw 0 :: .dh 0x200 :: .dh 4+5*24 :: .dw 0
.dh 0x100 :: .dh 3+5*24 :: .dw 0 :: .dh 0x100 :: .dh 4+5*24 :: .dw 0
.dh 0x100 :: .dh 2+5*24 :: .dw 0 :: .dh 0x200 :: .dh 4+5*24 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*25 :: .dw 0 :: .dh 0x100 :: .dh 1+5*25 :: .dw 0
.dh 0x100 :: .dh 2+5*25 :: .dw 0 :: .dh 0x200 :: .dh 4+5*25 :: .dw 0
.dh 0x100 :: .dh 3+5*25 :: .dw 0 :: .dh 0x100 :: .dh 4+5*25 :: .dw 0
.dh 0x100 :: .dh 2+5*25 :: .dw 0 :: .dh 0x200 :: .dh 4+5*25 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*26 :: .dw 0 :: .dh 0x100 :: .dh 1+5*26 :: .dw 0
.dh 0x100 :: .dh 2+5*26 :: .dw 0 :: .dh 0x200 :: .dh 4+5*26 :: .dw 0
.dh 0x100 :: .dh 3+5*26 :: .dw 0 :: .dh 0x100 :: .dh 4+5*26 :: .dw 0
.dh 0x100 :: .dh 2+5*26 :: .dw 0 :: .dh 0x200 :: .dh 4+5*26 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*27 :: .dw 0 :: .dh 0x100 :: .dh 1+5*27 :: .dw 0
.dh 0x100 :: .dh 2+5*27 :: .dw 0 :: .dh 0x200 :: .dh 4+5*27 :: .dw 0
.dh 0x100 :: .dh 3+5*27 :: .dw 0 :: .dh 0x100 :: .dh 4+5*27 :: .dw 0
.dh 0x100 :: .dh 2+5*27 :: .dw 0 :: .dh 0x200 :: .dh 4+5*27 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*28 :: .dw 0 :: .dh 0x100 :: .dh 1+5*28 :: .dw 0
.dh 0x100 :: .dh 2+5*28 :: .dw 0 :: .dh 0x200 :: .dh 4+5*28 :: .dw 0
.dh 0x100 :: .dh 3+5*28 :: .dw 0 :: .dh 0x100 :: .dh 4+5*28 :: .dw 0
.dh 0x100 :: .dh 2+5*28 :: .dw 0 :: .dh 0x200 :: .dh 4+5*28 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*29 :: .dw 0 :: .dh 0x100 :: .dh 1+5*29 :: .dw 0
.dh 0x100 :: .dh 2+5*29 :: .dw 0 :: .dh 0x200 :: .dh 4+5*29 :: .dw 0
.dh 0x100 :: .dh 3+5*29 :: .dw 0 :: .dh 0x100 :: .dh 4+5*29 :: .dw 0
.dh 0x100 :: .dh 2+5*29 :: .dw 0 :: .dh 0x200 :: .dh 4+5*29 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*30 :: .dw 0 :: .dh 0x100 :: .dh 1+5*30 :: .dw 0
.dh 0x100 :: .dh 2+5*30 :: .dw 0 :: .dh 0x200 :: .dh 4+5*30 :: .dw 0
.dh 0x100 :: .dh 3+5*30 :: .dw 0 :: .dh 0x100 :: .dh 4+5*30 :: .dw 0
.dh 0x100 :: .dh 2+5*30 :: .dw 0 :: .dh 0x200 :: .dh 4+5*30 :: .dw 0

.dh 8
.dh 0x100 :: .dh   5*31 :: .dw 0 :: .dh 0x100 :: .dh 1+5*31 :: .dw 0
.dh 0x100 :: .dh 2+5*31 :: .dw 0 :: .dh 0x200 :: .dh 4+5*31 :: .dw 0
.dh 0x100 :: .dh 3+5*31 :: .dw 0 :: .dh 0x100 :: .dh 4+5*31 :: .dw 0
.dh 0x100 :: .dh 2+5*31 :: .dw 0 :: .dh 0x200 :: .dh 4+5*31 :: .dw 0

; each entry stores the parameters for each frame of the sprite
TableB:
TB:
.dh TBD-TB       :: .dh TBD-TB+16    :: .dh TBD-TB+16*2  :: .dh TBD-TB+16*3  :: .dh TBD-TB+16*4
.dh TBD-TB+16*5  :: .dh TBD-TB+16*6  :: .dh TBD-TB+16*7  :: .dh TBD-TB+16*8  :: .dh TBD-TB+16*9
.dh TBD-TB+16*10 :: .dh TBD-TB+16*11 :: .dh TBD-TB+16*12 :: .dh TBD-TB+16*13 :: .dh TBD-TB+16*14
.dh TBD-TB+16*15 :: .dh TBD-TB+16*16 :: .dh TBD-TB+16*17 :: .dh TBD-TB+16*18 :: .dh TBD-TB+16*19

.dh TBD-TB+16*20 :: .dh TBD-TB+16*21 :: .dh TBD-TB+16*22 :: .dh TBD-TB+16*23 :: .dh TBD-TB+16*24
.dh TBD-TB+16*25 :: .dh TBD-TB+16*26 :: .dh TBD-TB+16*27 :: .dh TBD-TB+16*28 :: .dh TBD-TB+16*29
.dh TBD-TB+16*30 :: .dh TBD-TB+16*31 :: .dh TBD-TB+16*32 :: .dh TBD-TB+16*33 :: .dh TBD-TB+16*34
.dh TBD-TB+16*35 :: .dh TBD-TB+16*36 :: .dh TBD-TB+16*37 :: .dh TBD-TB+16*38 :: .dh TBD-TB+16*39

.dh TBD-TB+16*40 :: .dh TBD-TB+16*41 :: .dh TBD-TB+16*42 :: .dh TBD-TB+16*43 :: .dh TBD-TB+16*44
.dh TBD-TB+16*45 :: .dh TBD-TB+16*46 :: .dh TBD-TB+16*47 :: .dh TBD-TB+16*48 :: .dh TBD-TB+16*49
.dh TBD-TB+16*50 :: .dh TBD-TB+16*51 :: .dh TBD-TB+16*52 :: .dh TBD-TB+16*53 :: .dh TBD-TB+16*54
.dh TBD-TB+16*55 :: .dh TBD-TB+16*56 :: .dh TBD-TB+16*57 :: .dh TBD-TB+16*58 :: .dh TBD-TB+16*59

.dh TBD-TB+16*60 :: .dh TBD-TB+16*61 :: .dh TBD-TB+16*62 :: .dh TBD-TB+16*63 :: .dh TBD-TB+16*64
.dh TBD-TB+16*65 :: .dh TBD-TB+16*66 :: .dh TBD-TB+16*67 :: .dh TBD-TB+16*68 :: .dh TBD-TB+16*69
.dh TBD-TB+16*70 :: .dh TBD-TB+16*71 :: .dh TBD-TB+16*72 :: .dh TBD-TB+16*73 :: .dh TBD-TB+16*74
.dh TBD-TB+16*75 :: .dh TBD-TB+16*76 :: .dh TBD-TB+16*77 :: .dh TBD-TB+16*78 :: .dh TBD-TB+16*79

.dh TBD-TB+16*80 :: .dh TBD-TB+16*81 :: .dh TBD-TB+16*82 :: .dh TBD-TB+16*83 :: .dh TBD-TB+16*84
.dh TBD-TB+16*85 :: .dh TBD-TB+16*86 :: .dh TBD-TB+16*87 :: .dh TBD-TB+16*88 :: .dh TBD-TB+16*89
.dh TBD-TB+16*90 :: .dh TBD-TB+16*91 :: .dh TBD-TB+16*92 :: .dh TBD-TB+16*93 :: .dh TBD-TB+16*94
.dh TBD-TB+16*95 :: .dh TBD-TB+16*96 :: .dh TBD-TB+16*97 :: .dh TBD-TB+16*98 :: .dh TBD-TB+16*99

.dh TBD-TB+16*100 :: .dh TBD-TB+16*101 :: .dh TBD-TB+16*102 :: .dh TBD-TB+16*103 :: .dh TBD-TB+16*104
.dh TBD-TB+16*105 :: .dh TBD-TB+16*106 :: .dh TBD-TB+16*107 :: .dh TBD-TB+16*108 :: .dh TBD-TB+16*109
.dh TBD-TB+16*110 :: .dh TBD-TB+16*111 :: .dh TBD-TB+16*112 :: .dh TBD-TB+16*113 :: .dh TBD-TB+16*114
.dh TBD-TB+16*115 :: .dh TBD-TB+16*116 :: .dh TBD-TB+16*117 :: .dh TBD-TB+16*118 :: .dh TBD-TB+16*119

.dh TBD-TB+16*120 :: .dh TBD-TB+16*121 :: .dh TBD-TB+16*122 :: .dh TBD-TB+16*123 :: .dh TBD-TB+16*124
.dh TBD-TB+16*125 :: .dh TBD-TB+16*126 :: .dh TBD-TB+16*127 :: .dh TBD-TB+16*128 :: .dh TBD-TB+16*129
.dh TBD-TB+16*130 :: .dh TBD-TB+16*131 :: .dh TBD-TB+16*132 :: .dh TBD-TB+16*133 :: .dh TBD-TB+16*134
.dh TBD-TB+16*135 :: .dh TBD-TB+16*136 :: .dh TBD-TB+16*137 :: .dh TBD-TB+16*138 :: .dh TBD-TB+16*139

.dh TBD-TB+16*140 :: .dh TBD-TB+16*141 :: .dh TBD-TB+16*142 :: .dh TBD-TB+16*143 :: .dh TBD-TB+16*144
.dh TBD-TB+16*145 :: .dh TBD-TB+16*146 :: .dh TBD-TB+16*147 :: .dh TBD-TB+16*148 :: .dh TBD-TB+16*149
.dh TBD-TB+16*150 :: .dh TBD-TB+16*151 :: .dh TBD-TB+16*152 :: .dh TBD-TB+16*153 :: .dh TBD-TB+16*154
.dh TBD-TB+16*155 :: .dh TBD-TB+16*156 :: .dh TBD-TB+16*157 :: .dh TBD-TB+16*158 :: .dh TBD-TB+16*159

; this controls the spacing between each char/sprite
Spacing equ 24
Adjust  equ 4

TableBData:
TBD:
.dw 1 :: .db 0x20 :: .db 0 :: .dh      4+Adjust :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 0 :: .dh 0xFFFC+Adjust :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 0 :: .dh 0xFFFC+Adjust :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 0 :: .dh 0xFFFC+Adjust :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 0 :: .dh 0xFFFC+Adjust :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 1 :: .dh      4+Adjust+Spacing :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 1 :: .dh 0xFFFC+Adjust+Spacing :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 1 :: .dh 0xFFFC+Adjust+Spacing :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 1 :: .dh 0xFFFC+Adjust+Spacing :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 1 :: .dh 0xFFFC+Adjust+Spacing :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 2 :: .dh      4+Adjust+Spacing*2 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 2 :: .dh 0xFFFC+Adjust+Spacing*2 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 2 :: .dh 0xFFFC+Adjust+Spacing*2 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 2 :: .dh 0xFFFC+Adjust+Spacing*2 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 2 :: .dh 0xFFFC+Adjust+Spacing*2 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 3 :: .dh      4+Adjust+Spacing*3 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 3 :: .dh 0xFFFC+Adjust+Spacing*3 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 3 :: .dh 0xFFFC+Adjust+Spacing*3 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 3 :: .dh 0xFFFC+Adjust+Spacing*3 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 3 :: .dh 0xFFFC+Adjust+Spacing*3 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 4 :: .dh      4+Adjust+Spacing*4 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 4 :: .dh 0xFFFC+Adjust+Spacing*4 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 4 :: .dh 0xFFFC+Adjust+Spacing*4 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 4 :: .dh 0xFFFC+Adjust+Spacing*4 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 4 :: .dh 0xFFFC+Adjust+Spacing*4 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 5 :: .dh      4+Adjust+Spacing*5 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 5 :: .dh 0xFFFC+Adjust+Spacing*5 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 5 :: .dh 0xFFFC+Adjust+Spacing*5 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 5 :: .dh 0xFFFC+Adjust+Spacing*5 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 5 :: .dh 0xFFFC+Adjust+Spacing*5 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 6 :: .dh      4+Adjust+Spacing*6 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 6 :: .dh 0xFFFC+Adjust+Spacing*6 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 6 :: .dh 0xFFFC+Adjust+Spacing*6 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 6 :: .dh 0xFFFC+Adjust+Spacing*6 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 6 :: .dh 0xFFFC+Adjust+Spacing*6 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 7 :: .dh      4+Adjust+Spacing*7 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 7 :: .dh 0xFFFC+Adjust+Spacing*7 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 7 :: .dh 0xFFFC+Adjust+Spacing*7 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 7 :: .dh 0xFFFC+Adjust+Spacing*7 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 7 :: .dh 0xFFFC+Adjust+Spacing*7 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 8 :: .dh      4+Adjust+Spacing*8 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 8 :: .dh 0xFFFC+Adjust+Spacing*8 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 8 :: .dh 0xFFFC+Adjust+Spacing*8 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 8 :: .dh 0xFFFC+Adjust+Spacing*8 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 8 :: .dh 0xFFFC+Adjust+Spacing*8 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 9 :: .dh      4+Adjust+Spacing*9 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 9 :: .dh 0xFFFC+Adjust+Spacing*9 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 9 :: .dh 0xFFFC+Adjust+Spacing*9 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 9 :: .dh 0xFFFC+Adjust+Spacing*9 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 9 :: .dh 0xFFFC+Adjust+Spacing*9 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 10 :: .dh      4+Adjust+Spacing*10 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 10 :: .dh 0xFFFC+Adjust+Spacing*10 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 10 :: .dh 0xFFFC+Adjust+Spacing*10 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 10 :: .dh 0xFFFC+Adjust+Spacing*10 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 10 :: .dh 0xFFFC+Adjust+Spacing*10 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 11 :: .dh      4+Adjust+Spacing*11 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 11 :: .dh 0xFFFC+Adjust+Spacing*11 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 11 :: .dh 0xFFFC+Adjust+Spacing*11 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 11 :: .dh 0xFFFC+Adjust+Spacing*11 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 11 :: .dh 0xFFFC+Adjust+Spacing*11 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 12 :: .dh      4+Adjust+Spacing*12 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 12 :: .dh 0xFFFC+Adjust+Spacing*12 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 12 :: .dh 0xFFFC+Adjust+Spacing*12 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 12 :: .dh 0xFFFC+Adjust+Spacing*12 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 12 :: .dh 0xFFFC+Adjust+Spacing*12 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 13 :: .dh      4+Adjust+Spacing*13 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 13 :: .dh 0xFFFC+Adjust+Spacing*13 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 13 :: .dh 0xFFFC+Adjust+Spacing*13 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 13 :: .dh 0xFFFC+Adjust+Spacing*13 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 13 :: .dh 0xFFFC+Adjust+Spacing*13 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 14 :: .dh      4+Adjust+Spacing*14 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 14 :: .dh 0xFFFC+Adjust+Spacing*14 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 14 :: .dh 0xFFFC+Adjust+Spacing*14 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 14 :: .dh 0xFFFC+Adjust+Spacing*14 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 14 :: .dh 0xFFFC+Adjust+Spacing*14 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 15 :: .dh      4+Adjust+Spacing*15 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 15 :: .dh 0xFFFC+Adjust+Spacing*15 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 15 :: .dh 0xFFFC+Adjust+Spacing*15 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 15 :: .dh 0xFFFC+Adjust+Spacing*15 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 15 :: .dh 0xFFFC+Adjust+Spacing*15 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 16 :: .dh      4+Adjust+Spacing*16 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 16 :: .dh 0xFFFC+Adjust+Spacing*16 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 16 :: .dh 0xFFFC+Adjust+Spacing*16 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 16 :: .dh 0xFFFC+Adjust+Spacing*16 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 16 :: .dh 0xFFFC+Adjust+Spacing*16 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 17 :: .dh      4+Adjust+Spacing*17 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 17 :: .dh 0xFFFC+Adjust+Spacing*17 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 17 :: .dh 0xFFFC+Adjust+Spacing*17 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 17 :: .dh 0xFFFC+Adjust+Spacing*17 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 17 :: .dh 0xFFFC+Adjust+Spacing*17 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 18 :: .dh      4+Adjust+Spacing*18 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 18 :: .dh 0xFFFC+Adjust+Spacing*18 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 18 :: .dh 0xFFFC+Adjust+Spacing*18 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 18 :: .dh 0xFFFC+Adjust+Spacing*18 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 18 :: .dh 0xFFFC+Adjust+Spacing*18 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 19 :: .dh      4+Adjust+Spacing*19 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 19 :: .dh 0xFFFC+Adjust+Spacing*19 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 19 :: .dh 0xFFFC+Adjust+Spacing*19 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 19 :: .dh 0xFFFC+Adjust+Spacing*19 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 19 :: .dh 0xFFFC+Adjust+Spacing*19 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 20 :: .dh      4+Adjust+Spacing*20 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 20 :: .dh 0xFFFC+Adjust+Spacing*20 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 20 :: .dh 0xFFFC+Adjust+Spacing*20 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 20 :: .dh 0xFFFC+Adjust+Spacing*20 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 20 :: .dh 0xFFFC+Adjust+Spacing*20 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 21 :: .dh      4+Adjust+Spacing*21 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 21 :: .dh 0xFFFC+Adjust+Spacing*21 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 21 :: .dh 0xFFFC+Adjust+Spacing*21 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 21 :: .dh 0xFFFC+Adjust+Spacing*21 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 21 :: .dh 0xFFFC+Adjust+Spacing*21 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 22 :: .dh      4+Adjust+Spacing*22 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 22 :: .dh 0xFFFC+Adjust+Spacing*22 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 22 :: .dh 0xFFFC+Adjust+Spacing*22 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 22 :: .dh 0xFFFC+Adjust+Spacing*22 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 22 :: .dh 0xFFFC+Adjust+Spacing*22 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 23 :: .dh      4+Adjust+Spacing*23 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 23 :: .dh 0xFFFC+Adjust+Spacing*23 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 23 :: .dh 0xFFFC+Adjust+Spacing*23 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 23 :: .dh 0xFFFC+Adjust+Spacing*23 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 23 :: .dh 0xFFFC+Adjust+Spacing*23 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 24 :: .dh      4+Adjust+Spacing*24 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 24 :: .dh 0xFFFC+Adjust+Spacing*24 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 24 :: .dh 0xFFFC+Adjust+Spacing*24 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 24 :: .dh 0xFFFC+Adjust+Spacing*24 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 24 :: .dh 0xFFFC+Adjust+Spacing*24 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 25 :: .dh      4+Adjust+Spacing*25 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 25 :: .dh 0xFFFC+Adjust+Spacing*25 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 25 :: .dh 0xFFFC+Adjust+Spacing*25 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 25 :: .dh 0xFFFC+Adjust+Spacing*25 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 25 :: .dh 0xFFFC+Adjust+Spacing*25 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 26 :: .dh      4+Adjust+Spacing*26 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 26 :: .dh 0xFFFC+Adjust+Spacing*26 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 26 :: .dh 0xFFFC+Adjust+Spacing*26 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 26 :: .dh 0xFFFC+Adjust+Spacing*26 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 26 :: .dh 0xFFFC+Adjust+Spacing*26 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 27 :: .dh      4+Adjust+Spacing*27 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 27 :: .dh 0xFFFC+Adjust+Spacing*27 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 27 :: .dh 0xFFFC+Adjust+Spacing*27 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 27 :: .dh 0xFFFC+Adjust+Spacing*27 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 27 :: .dh 0xFFFC+Adjust+Spacing*27 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 28 :: .dh      4+Adjust+Spacing*28 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 28 :: .dh 0xFFFC+Adjust+Spacing*28 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 28 :: .dh 0xFFFC+Adjust+Spacing*28 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 28 :: .dh 0xFFFC+Adjust+Spacing*28 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 28 :: .dh 0xFFFC+Adjust+Spacing*28 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 29 :: .dh      4+Adjust+Spacing*29 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 29 :: .dh 0xFFFC+Adjust+Spacing*29 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 29 :: .dh 0xFFFC+Adjust+Spacing*29 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 29 :: .dh 0xFFFC+Adjust+Spacing*29 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 29 :: .dh 0xFFFC+Adjust+Spacing*29 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 30 :: .dh      4+Adjust+Spacing*30 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 30 :: .dh 0xFFFC+Adjust+Spacing*30 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 30 :: .dh 0xFFFC+Adjust+Spacing*30 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 30 :: .dh 0xFFFC+Adjust+Spacing*30 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 30 :: .dh 0xFFFC+Adjust+Spacing*30 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

.dw 1 :: .db 0x20 :: .db 31 :: .dh      4+Adjust+Spacing*31 :: .dh      4 :: .dh 0 :: .dh 0xCC  :: .dh 0xCC
.dw 1 :: .db 0x28 :: .db 31 :: .dh 0xFFFC+Adjust+Spacing*31 :: .dh 0xFFFC :: .dh 0 :: .dh 0x133 :: .dh 0x133
.dw 1 :: .db 0x28 :: .db 31 :: .dh 0xFFFC+Adjust+Spacing*31 :: .dh 0xFFFC :: .dh 0 :: .dh 0x199 :: .dh 0x199
.dw 1 :: .db 0x28 :: .db 31 :: .dh 0xFFFC+Adjust+Spacing*31 :: .dh 0xFFFC :: .dh 0 :: .dh 0x233 :: .dh 0x233
.dw 1 :: .db 0x28 :: .db 31 :: .dh 0xFFFC+Adjust+Spacing*31 :: .dh 0xFFFC :: .dh 0 :: .dh 0x200 :: .dh 0x200

; 1st half is obj attr 1 ?
; 2nd half is obj attr 2, tile #
TableC:
.dh 0x4000 :: .dh 0
.dh 0x4000 :: .dh 4
.dh 0x4000 :: .dh 4*2
.dh 0x4000 :: .dh 4*3
.dh 0x4000 :: .dh 4*4
.dh 0x4000 :: .dh 4*5
.dh 0x4000 :: .dh 4*6
.dh 0x4000 :: .dh 4*7
.dh 0x4000 :: .dh 4*8
.dh 0x4000 :: .dh 4*9
.dh 0x4000 :: .dh 4*10
.dh 0x4000 :: .dh 4*11
.dh 0x4000 :: .dh 4*12
.dh 0x4000 :: .dh 4*13
.dh 0x4000 :: .dh 4*14
.dh 0x4000 :: .dh 4*15
.dh 0x4000 :: .dh 4*16
.dh 0x4000 :: .dh 4*17
.dh 0x4000 :: .dh 4*18
.dh 0x4000 :: .dh 4*19
.dh 0x4000 :: .dh 4*20
.dh 0x4000 :: .dh 4*21
.dh 0x4000 :: .dh 4*22
.dh 0x4000 :: .dh 4*23
.dh 0x4000 :: .dh 4*24
.dh 0x4000 :: .dh 4*25
.dh 0x4000 :: .dh 4*26
.dh 0x4000 :: .dh 4*27
.dh 0x4000 :: .dh 4*28
.dh 0x4000 :: .dh 4*29
.dh 0x4000 :: .dh 4*30
.dh 0x4000 :: .dh 4*31
