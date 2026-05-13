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

COLOR=0xffffffff
if [ "$PERCENTAGE" -le 20 ]; then
	COLOR=0xffeb6f92
elif [ "$PERCENTAGE" -le 50 ]; then
	COLOR=0xfff6c177
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%" label.color="$COLOR"
