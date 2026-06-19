#!/bin/bash


STATE=$(bluetoothctl show | awk -F': ' '/Powered:/ {print $2}' | tr -d '[:space:]')

if [ "$STATE" = "yes" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Disabled"
else
    bluetoothctl power on
    notify-send "Bluetooth" "Enabled"
fi
