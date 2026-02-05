#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [[ -n "$WM_MODE" ]]; then
	sketchybar --set $NAME label="$WM_MODE" label.color=$(eval "(echo \"\$MODE_$WM_MODE\")")
fi
