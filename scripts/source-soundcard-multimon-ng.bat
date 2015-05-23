@echo off
echo INPUT: Current Sound Recording Device 1>&2
IF EXIST .\multimon-ng SET PATH=%PATH%;.\multimon-ng
multimon-ng -a EAS
