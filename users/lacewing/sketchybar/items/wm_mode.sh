#!/bin/bash

sketchybar --add item wm_mode left \
  --set wm_mode label.color=$MODE_INS \
  --set wm_mode label=INS \
  --set wm_mode script="$PLUGIN_DIR/wm_mode.sh" \
  --subscribe wm_mode wm_mode_change
