#!/bin/bash

wechat=(
	icon=$WECHAT
	icon.font="$FONT:Regular:18.0"
	script="$PLUGIN_DIR/app_status.sh"
	click_script="open -a Wechat"
)

sketchybar --add item wechat right \
	--set wechat "${wechat[@]}"
