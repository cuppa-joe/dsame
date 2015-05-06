#!/bin/sh
PPM=0
FREQ=162.500
GAIN=42
rtl_fm -f ${FREQ} -M fm -s 22050 -E dc -p ${PPM} -g ${GAIN}  -|  multimon-ng -t raw -a EAS /dev/stdin
