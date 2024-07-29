
:: paths
set "_ROM=%1"
set "_NAME=%2"
set "_TILE=%3"
set "_MAP=%4"

:: make folders
::md temp
md raw

:: extract
gbamdc -e %_ROM% raw\%_NAME%_tile.bin %_TILE%
gbamdc -e %_ROM% raw\%_NAME%_map.bin %_MAP%
snsc3gfx -t raw\%_NAME%_tile.bin -m raw\%_NAME%_map.bin -b raw\%_NAME%.bmp
