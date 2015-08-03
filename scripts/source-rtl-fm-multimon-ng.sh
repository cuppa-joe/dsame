#!/bin/sh
echo INPUT: rtl_fm Device 1>&2
PPM=0
FREQ=162.500M
GAIN=42
until rtl_fm -f ${FREQ} -M fm -s 22050 -E dc -p ${PPM} -g ${GAIN}  -|  multimon-ng -t raw -a EAS /dev/stdin; do
    echo Restarting... >&2
    sleep 2
done

