#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [[ -n "$SKHD_MODE" ]]; then
	sketchybar --set $NAME label="$SKHD_MODE" label.color=$(eval "(echo \"\$MODE_$SKHD_MODE\")")
fi
