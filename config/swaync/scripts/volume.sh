#!/bin/bash

STEP="$1"
SINK="@DEFAULT_AUDIO_SINK@"

case "$STEP" in
    up)
        wpctl set-volume "$SINK" 5%+
        ;;
    down)
        wpctl set-volume "$SINK" 5%-
        ;;
    mute)
        wpctl set-mute "$SINK" toggle
        ;;
esac

# ------------------------
# SAFE READ (IMPORTANT)
# ------------------------
VOLUME_INFO=$(wpctl get-volume "$SINK")

VOLUME=$(awk '{printf "%d", $2 * 100}' <<< "$VOLUME_INFO")

# proper mute check (reliable)
if echo "$VOLUME_INFO" | grep -q MUTED; then
    MUTED=1
else
    MUTED=0
fi

# ------------------------
# NOTIFICATION
# ------------------------
if [ "$MUTED" -eq 1 ]; then
    notify-send "Volume" "󰖁  Muted"
else
    notify-send "Volume" "󰕾  ${VOLUME}%"
fi
