@echo off
echo INPUT: rtl_fm Device 1>&2
IF EXIST .\multimon-ng SET PATH=%PATH%;.\multimon-ng
IF EXIST .\rtl-sdr-release SET PATH=%PATH%;.\rtl-sdr-release
set PPM=0
set FREQ=162.500M
set GAIN=42
:loop
rtl_fm -f %FREQ% -M fm -s 22050 -E dc -p %PPM% -g %GAIN%  -|  multimon-ng -t raw -a EAS -
echo Restarting... >&2
timeout /t 2 /nobreak
goto loop
