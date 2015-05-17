@echo off
set PPM=0
set FREQ=162.500M
set GAIN=42
rtl_fm -f %FREQ%-M fm -s 22050 -E dc -p %PPM% -g %GAIN%  -|  multimon-ng -t raw -a EAS -
