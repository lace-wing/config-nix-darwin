#!/bin/bash

DRAWING=off
FREQ=0

if lsappinfo -all list | grep $NAME >>/dev/null; then
	LABEL=$(lsappinfo -all list | grep $NAME | egrep -o "\"StatusLabel\"=\{ \"label\"=\"?(.*?)\"? \}" | sed 's/\"StatusLabel\"={ \"label\"=\(.*\) }/\1/g')
	if [[ $LABEL =~ ^\".*\"$ ]]; then
		LABEL=$(echo $LABEL | sed 's/^"//' | sed 's/"$//')
		if [ -z "$LABEL" ]; then
			LABEL=0
		fi
	else
		LABEL=0
	fi
	DRAWING=on
	FREQ=5
else
	LABEL="?"
	FREQ=0
fi

sketchybar --set $NAME label=$LABEL drawing=$DRAWING updates=on update_freq=$FREQ \
	--subscribe $NAME space_windows_change
