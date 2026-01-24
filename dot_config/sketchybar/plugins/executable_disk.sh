#!/bin/sh

# Get disk usage for root volume
DISK_INFO=$(df -h / | tail -1)

# Extract usage percentage (remove % sign)
DISK_PERCENT=$(echo "$DISK_INFO" | awk '{print $5}' | sed 's/%//')

if [ "$DISK_PERCENT" = "" ]; then
	exit 0
fi

sketchybar --set "$NAME" icon="DISK" label="${DISK_PERCENT}%"
