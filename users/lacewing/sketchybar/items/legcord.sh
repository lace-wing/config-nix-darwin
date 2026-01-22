#!/bin/bash

legcord=(
  icon=$LEGCORD
  icon.y_offset=1
  icon.font="$FONT:Regular:16.0"
  script="$PLUGIN_DIR/app_status.sh"
  click_script="open -a legcord"
)

sketchybar --add item legcord right \
  --set legcord "${legcord[@]}" \
