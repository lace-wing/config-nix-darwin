#!/bin/bash

svim=(
  scroll_texts=on
  icon="OFF"
  icon.color="$GREY"
  icon.y_offset=1
  label.max_chars=32
  label.scroll_duration=180
  script="$PLUGIN_DIR/svim.sh"
)

sketchybar --add item svim q \
  --set svim label.font="$FONT Mono:Normal:14.0" \
  --set svim ${svim[@]} \
  --subscribe svim svim_mode_change
