#!/bin/sh

VALUE=$("$(dirname "$0")/sysinfo.sh" cpu) || exit 0

NUM=${VALUE%\%}
COLOR=0xffffffff
if [ "$NUM" -ge 95 ]; then
	COLOR=0xffeb6f92
elif [ "$NUM" -ge 75 ]; then
	COLOR=0xfff6c177
fi

sketchybar --set "$NAME" icon="󰻠" icon.color="$COLOR" label="$VALUE" label.color="$COLOR"
