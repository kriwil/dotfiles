#!/bin/sh

if VALUE=$("$(dirname "$0")/sysinfo.sh" temp) && [ -n "$VALUE" ]; then
	NUM=${VALUE%%°*}
	COLOR=0xffffffff
	if [ "$NUM" -ge 95 ]; then
		COLOR=0xffeb6f92
	elif [ "$NUM" -ge 80 ]; then
		COLOR=0xfff6c177
	fi
	sketchybar --set "$NAME" drawing=on icon="󰔄" icon.color="$COLOR" label="$VALUE" label.color="$COLOR"
else
	sketchybar --set "$NAME" drawing=off
fi
