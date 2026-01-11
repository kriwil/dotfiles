#!/bin/sh

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/helpers/icon_map.sh"

if [ "$SENDER" = "front_app_switched" ]; then
	__icon_map "$INFO"
	if [ "$icon_result" != "" ]; then
		sketchybar --set "$NAME" label="$INFO" icon="$icon_result"
	else
		sketchybar --set "$NAME" label="$INFO" icon=":default:"
	fi
fi
