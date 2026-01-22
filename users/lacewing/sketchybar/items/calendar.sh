#!/bin/bash

calendar=(
  icon.drawing=off
  update_freq=12
  script="$PLUGIN_DIR/calender.sh"
  click_script="open -a Calendar"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
