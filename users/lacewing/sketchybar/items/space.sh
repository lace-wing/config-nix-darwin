#!/bin/bash

source "$CONFIG_DIR/icons.sh"
SPACE=(
	icon="${SPACE_ICONS[0]}"
	icon.color=$WHITE
	icon.width=30
	background.drawing=off
	# label.drawing=off
  icon.drawing=off
	script="$PLUGIN_DIR/space.sh"
)

# for sid in $(aerospace list-workspaces --all); do
# 	i="$(($sid - 1))"
# 	space=(
# 		icon="${SPACE_ICONS[i]}"
# 		icon.color=$GREY
# 		icon.highlight_color=$WHITE
# 		background.drawing=off
# 		label.drawing=off
# 		script="$PLUGIN_DIR/space.sh $sid"
# 		click_script="aerospace workspace $sid"
# 	)
# 	sketchybar --add item space."$sid" left \
# 		--set space."$sid" "${space[@]}" \
# 		--subscribe space.$sid mouse.clicked aerospace_workspace_change
# done

sketchybar --add item space left \
	--set space ${SPACE[@]} \
	--subscribe space aerospace_workspace_change

# sketchybar --add item space.prev left \
# 	--set space.prev ${SPACE[@]} icon.color=$GREY \
# 	--subscribe space.prev aerospace_workspace_change
