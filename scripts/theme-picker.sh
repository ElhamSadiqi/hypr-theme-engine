#!/bin/bash

THEMES="$HOME/.config/themes/list.txt"

THEME=$(cat "$THEMES" | rofi -dmenu -i -p "Theme")

[ -z "$THEME" ] && exit 0

theme "$THEME"
