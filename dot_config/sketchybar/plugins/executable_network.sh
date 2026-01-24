#!/bin/bash

# Network interface to monitor (usually en0 for Wi-Fi)
INTERFACE="en0"

# Cache file to store previous values
CACHE_FILE="/tmp/sketchybar_network_stats"

# Get current stats
CURRENT_STATS=$(netstat -ib | grep -e "$INTERFACE" | awk '{print $7":"$10}' | head -1)
CURRENT_RX=$(echo "$CURRENT_STATS" | cut -d: -f1)
CURRENT_TX=$(echo "$CURRENT_STATS" | cut -d: -f2)
CURRENT_TIME=$(date +%s)

# Read previous stats
if [ -f "$CACHE_FILE" ]; then
	PREV_STATS=$(cat "$CACHE_FILE")
	PREV_RX=$(echo "$PREV_STATS" | cut -d: -f1)
	PREV_TX=$(echo "$PREV_STATS" | cut -d: -f2)
	PREV_TIME=$(echo "$PREV_STATS" | cut -d: -f3)

	# Calculate time difference
	TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

	if [ "$TIME_DIFF" -gt 0 ]; then
		# Calculate bytes per second
		RX_BYTES=$((CURRENT_RX - PREV_RX))
		TX_BYTES=$((CURRENT_TX - PREV_TX))

		RX_RATE=$((RX_BYTES / TIME_DIFF))
		TX_RATE=$((TX_BYTES / TIME_DIFF))

		# Convert to human readable format (KB/s or MB/s)
		if [ "$RX_RATE" -ge 1048576 ]; then
			RX_DISPLAY=$(echo "$RX_RATE" | awk '{printf "%.1fM", $1/1048576}')
		else
			RX_DISPLAY=$(echo "$RX_RATE" | awk '{printf "%.0fK", $1/1024}')
		fi

		if [ "$TX_RATE" -ge 1048576 ]; then
			TX_DISPLAY=$(echo "$TX_RATE" | awk '{printf "%.1fM", $1/1048576}')
		else
			TX_DISPLAY=$(echo "$TX_RATE" | awk '{printf "%.0fK", $1/1024}')
		fi

		sketchybar --set "$NAME" icon="NET" label="↓${RX_DISPLAY} ↑${TX_DISPLAY}"
	fi
fi

# Save current stats
echo "$CURRENT_RX:$CURRENT_TX:$CURRENT_TIME" >"$CACHE_FILE"
