#!/bin/bash

sketchybar --add item skhd left \
  --set skhd label.color=$MODE_INS \
  --set skhd label.font="$FONT Mono:Bold:14.0" \
  --set skhd label.y_offset=0 \
  --set skhd label=INS \
  --set skhd script="$PLUGIN_DIR/skhd.sh" \
  --subscribe skhd skhd_mode_change
