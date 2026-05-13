#!/bin/sh

VALUE=$("$(dirname "$0")/sysinfo.sh" cpu) || exit 0
sketchybar --set "$NAME" icon="󰻠" label="$VALUE"
