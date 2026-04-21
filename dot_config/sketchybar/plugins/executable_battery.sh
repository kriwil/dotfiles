#!/bin/sh

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE="$(printf '%s\n' "$BATTERY_INFO" | grep -Eo '[0-9]+%' | cut -d% -f1)"

if [ "$PERCENTAGE" = "" ]; then
	exit 0
fi

ICON="󰁹"

case "$BATTERY_INFO" in
	*"; charging;"*)
		ICON="󰂄"
		;;
esac

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
