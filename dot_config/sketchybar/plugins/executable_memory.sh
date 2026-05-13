#!/bin/sh

VALUE=$("$(dirname "$0")/sysinfo.sh" mem) || exit 0
sketchybar --set "$NAME" icon="󰍛" label="$VALUE"
