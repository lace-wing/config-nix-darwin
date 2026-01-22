#!/bin/bash

. "$CONFIG_DIR/colors.sh"

icon="OFF"
color="$GREY"
label=""
label_drawing=off

case $MODE in
"I")
	icon="INS"
	color="$INSERT"
	;;
"N")
	icon="NOR"
	color="$NORMAL"
	;;
"V")
	icon="VIS"
	color="$VISUAL"
	;;
"C")
	icon="COM"
	color="$COMMAND"
	label="$CMD"
	label_drawing=on
	;;
*)
	icon="OFF"
	color="$GREY"
	;;
esac

sketchybar --set svim icon="$icon" icon.color="$color" label="$label" label.drawing="$label_drawing"
