
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
gbamdc -e %_ROM% temp\%_NAME%_tile.bin %_TILE%
gbamdc -e %_ROM% temp\%_NAME%_map.bin %_MAP%

::xxd -p -l 0x30 temp\%_NAME%_tile.bin > temp\%_NAME%_tile.txt
::xxd -p -l 0x20 temp\%_NAME%_map.bin > temp\%_NAME%_map.txt
::xxd -p -s -0x20 temp\%_NAME%_tile.bin > temp\%_NAME%_pal.txt

:: construct tile bin
::xxd -p temp\%_NAME%.img.bin >> temp\%_NAME%_tile.txt
::xxd -r -p temp\%_NAME%_tile.txt temp\%_NAME%_tile_final.bin
::xxd -r -p -s 0xEF0 temp\%_NAME%_pal.txt temp\%_NAME%_tile_final.bin

:: construct map bin
::xxd -p temp\%_NAME%.map.bin >> temp\%_NAME%_map.txt
::xxd -r -p temp\%_NAME%_map.txt temp\%_NAME%_map_final.bin

:: patch
:: -r reverse
snsc3gfx -r -t temp\%_NAME%_tile.bin -m temp\%_NAME%_map.bin -T temp\%_NAME%.img.bin -M temp\%_NAME%.map.bin

:: compress
copy /b temp\%_NAME%_tile.bin final\%_NAME%_tile.lzss
copy /b temp\%_NAME%_map.bin final\%_NAME%_map.lzss
lzss -evo final\%_NAME%_tile.lzss
lzss -evo final\%_NAME%_map.lzss

:: asm stuff
set /a "_TEMP=0x8000000+0x%_TILE%"
call cmd /c exit /b %_TEMP%
echo:.org 0x%=EXITCODE% >> final\final.asm
echo:.import "asm/%_NAME%_tile.lzss" >> final\final.asm

set /a "_TEMP=0x8000000+0x%_MAP%"
call cmd /c exit /b %_TEMP%
echo:.org 0x%=EXITCODE% >> final\final.asm
echo:.import "asm/%_NAME%_map.lzss" >> final\final.asm

::pause