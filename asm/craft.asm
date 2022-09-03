; 08084584 is called to open the craft menu, and positions the box.
; We make it wider by adjusting constants.
.org 0x08084616
; This is the X position of the box.  We move it from 11 to 10.
mov r0,8
.org 0x08084624
; This is the width of the box.  We widen by 2 tiles.
mov r1,14

; 08084C48 is called by 08084584 to draw the text, and hardcodes the X.
.org 0x08084C60
; We move it one tile back from 13 to 12.
mov r0,12
