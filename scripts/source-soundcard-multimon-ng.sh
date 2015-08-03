#!/bin/sh
echo INPUT: Current Sound Recording Device 1>&2
until multimon-ng -a EAS; do
    echo Restarting... >&2
    sleep 2
done

