#!/bin/bash

# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#   sketchybar --set $NAME icon.highlight=on
# else
#   sketchybar --set $NAME icon.highlight=off
# fi

source "$CONFIG_DIR/icons.sh"

if [ -z $FOCUSED_WORKSPACE ]; then
  # sketchybar --set space icon=${SPACE_ICONS[0]}
  sketchybar --set space label=${SPACE_ICONS[0]}
  # sketchybar --set space.prev icon=${SPACE_ICONS[0]}
else
  # sketchybar --set space icon=${SPACE_ICONS[$FOCUSED_WORKSPACE - 1]}
  sketchybar --set space label=${SPACE_ICONS[$FOCUSED_WORKSPACE - 1]}
  # sketchybar --set space.prev icon=${SPACE_ICONS[$PREV_WORKSPACE - 1]}
fi
