#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

DRAWING=on
COLOR=$WHITE
LABEL="${PERCENTAGE}%"

if [[ $CHARGING != "" ]]; then
	ICON=$BATTERY_CHARGING
elif [[ $PERCENTAGE -lt 10 ]]; then
	ICON=$BATTERY_0
elif [[ $PERCENTAGE -lt 35 ]]; then
	ICON=$BATTERY_25
elif [[ $PERCENTAGE -lt 60 ]]; then
	ICON=$BATTERY_50
elif [[ $PERCENTAGE -lt 85 ]]; then
	ICON=$BATTERY_75
else
	ICON=$BATTERY_100
fi

sketchybar --set $NAME drawing=$DRAWING icon="$ICON" icon.color=$COLOR label=$LABEL
