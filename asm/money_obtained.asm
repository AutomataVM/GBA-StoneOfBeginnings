; teod 22-05-29
; fix centering and spacing

.org 0x806D824
.region 0x0806D854-.,0x00
; r0 = obtained string
; get string width in pixels
bl GetStrGlyphWidth
; width = digits + 2 + strWidth/8
lsr r0, 3
add r0, r9
add r0, 2
b 0x0806D854
.pool
.endregion

.org 0x806D92A
; originally 2, remove all extra spacing
add r3, 1
