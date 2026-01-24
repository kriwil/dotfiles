#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"

if [ "$PERCENTAGE" = "" ]; then
	exit 0
fi

sketchybar --set "$NAME" icon="BAT" label="${PERCENTAGE}%"
