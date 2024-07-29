
:: paths
::set "_ROM=..\swordcraft3.gba"
set "_ROM=%1"

:: variables
::set "_NAME=credits_craftsword"
::set "_TILE=154458C"
::set "_MAP=1544BFC"
set "_NAME=%2"
set "_TILE=%3"
set "_MAP=%4"

:: make folders
md temp
md final

:: generate new tiles and map
:: -g = output tiles, -gB 4 = 4bit
:: -m = output map  , -mRtpf = reduce
:: -p! = no palette output
:: -ftb = output as binary
:: -fh = output header file
:: -o = set output path
grit eng\%_NAME%.bmp -g -gB 4 -m -mRtpf -p! -ftb -o temp\%_NAME%

:: extract original headers
copy /b uncomp\%_NAME%_tile.bin temp\%_NAME%_tile.bin
copy /b uncomp\%_NAME%_map.bin temp\%_NAME%_map.bin

:: patch
:: -r reverse
snsc3gfx -r -t temp\%_NAME%_tile.bin -m temp\%_NAME%_map.bin -T temp\%_NAME%.img.bin -M temp\%_NAME%.map.bin

copy /b temp\%_NAME%_tile.bin final\%_NAME%_tile.bin
copy /b temp\%_NAME%_map.bin final\%_NAME%_map.bin

:: asm stuff
set /a "_TEMP=0x8000000+0x%_TILE%"
call cmd /c exit /b %_TEMP%
echo:.org 0x%=EXITCODE% >> final\final.asm
echo:.import "asm/%_NAME%_tile.bin" >> final\final.asm

set /a "_TEMP=0x8000000+0x%_MAP%"
call cmd /c exit /b %_TEMP%
echo:.org 0x%=EXITCODE% >> final\final.asm
echo:.import "asm/%_NAME%_map.bin" >> final\final.asm

::pause