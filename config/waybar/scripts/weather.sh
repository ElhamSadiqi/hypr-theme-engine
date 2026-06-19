#!/bin/bash

LOCATION="${WEATHER_LOCATION:-Kabul}"

data=$(curl -s "wttr.in/${LOCATION}?format=%C|%t")

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
