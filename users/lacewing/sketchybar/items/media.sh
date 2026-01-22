#!/bin/bash

media=(
    label.max_chars=25
    scroll_texts=on
    icon=􀑪
    icon.color=$WHITE
    icon.drawing=on
    script="$PLUGIN_DIR/media.sh"
)

sketchybar --add item media left \
    --set media ${media[@]} \
    --subscribe media media_change
