@echo off
echo INPUT: Current Sound Recording Device 1>&2
IF EXIST .\multimon-ng SET PATH=%PATH%;.\multimon-ng
:loop
multimon-ng -a EAS
echo Restarting... >&2
timeout /t 2 /nobreak
goto loop