#!/bin/sh

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE="$(printf '%s\n' "$BATTERY_INFO" | grep -Eo '[0-9]+%' | cut -d% -f1)"

if [ "$PERCENTAGE" = "" ]; then
	exit 0
fi

ICON="󰁹"
CHARGING=0

case "$BATTERY_INFO" in
	*"; charging;"*)
		ICON="󰂄"
		CHARGING=1
		;;
esac

COLOR=0xffffffff
if [ "$CHARGING" -eq 1 ]; then
	COLOR=0xffa3be8c
elif [ "$PERCENTAGE" -le 20 ]; then
	COLOR=0xffeb6f92
elif [ "$PERCENTAGE" -le 50 ]; then
	COLOR=0xfff6c177
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%" label.color="$COLOR"
