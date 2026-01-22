#!/bin/bash

qq=(
  icon=$QQ
  icon.font="$FONT:Regular:16.0"
  script="$PLUGIN_DIR/app_status.sh"
  click_script="open -a qq"
)

sketchybar --add item qq right \
  --set qq "${qq[@]}" \
