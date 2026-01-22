#!/bin/bash

whatsapp=(
  icon=$WHATSAPP
  icon.font="$FONT:Regular:16.0"
  script="$PLUGIN_DIR/app_status.sh"
  click_script="open -a whatsapp"
)

sketchybar --add item whatsapp right \
  --set whatsapp "${whatsapp[@]}" \
