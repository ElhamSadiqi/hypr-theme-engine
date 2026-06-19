#!/bin/bash

brightnessctl set "$1"

BRIGHTNESS=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$(( 100 * BRIGHTNESS / MAX ))

notify-send -h string:x-canonical-private-synchronous:brightness_change \
            -h int:value:"$PERCENT" \
            -t 1500 \
            "Brightness" "${PERCENT}%"
