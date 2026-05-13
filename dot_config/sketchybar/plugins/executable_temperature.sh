#!/bin/sh

if VALUE=$("$(dirname "$0")/sysinfo.sh" temp) && [ -n "$VALUE" ]; then
	sketchybar --set "$NAME" drawing=on icon="󰔄" label="$VALUE"
else
	sketchybar --set "$NAME" drawing=off
fi
