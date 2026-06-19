#!/bin/bash

# Adjust brightness (+ / -)
brightnessctl set "$1"

# Get current brightness percentage
BRIGHTNESS=$(brightnessctl info | grep -oP '\(\K[^%]+(?=%\))')

notify-send -h string:x-canonical-private-synchronous:brightness_change \
            -h int:value:"$BRIGHTNESS" \
            -t 1500 \
            "Brightness" "${BRIGHTNESS}%"
