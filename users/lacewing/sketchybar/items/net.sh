#!/bin/bash

sketchybar --add item net right \
  --set net script="$PLUGIN_DIR/net.sh" \
  updates=on \
  icon.y_offset=1 \
  label.drawing=off \
  --subscribe net wifi_change
