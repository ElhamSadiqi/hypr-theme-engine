#!/bin/bash

# Fetch weather condition and temperature separated by a unique delimiter (like '|')
data=$(curl -s 'wttr.in/Kabul?format=%C|%t')

# Split safely using the pipe character as the field separator
condition=$(echo "$data" | awk -F'|' '{print $1}')
temp=$(echo "$data" | awk -F'|' '{print $2}' | sed 's/+//')

icon="󰖙"

case "$condition" in
    *Sunny*|*Clear*)
        icon=""
        ;;
    *Cloud*|*Overcast*)
        icon="󰖐"
        ;;
    *Rain*|*Drizzle*)
        icon="󰖖"
        ;;
    *Thunder*)
        icon="󰙾"
        ;;
    *Snow*)
        icon="󰼶"
        ;;
esac

echo "{\"text\":\"$icon $temp\"}"
