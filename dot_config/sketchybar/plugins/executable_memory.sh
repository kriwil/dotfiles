#!/bin/sh

# Get memory statistics from vm_stat
MEMORY_STATS=$(vm_stat)

# Extract page counts (macOS uses 16KB pages on Apple Silicon, 4KB on Intel)
PAGE_SIZE=$(pagesize)
PAGES_ACTIVE=$(echo "$MEMORY_STATS" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$MEMORY_STATS" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')

# "Real" used memory (Active + Wired) - excludes Inactive and Speculative (cached)
USED_PAGES=$((PAGES_ACTIVE + PAGES_WIRED))
USED_GB=$(echo "$USED_PAGES $PAGE_SIZE" | awk '{printf "%.2f", ($1 * $2) / 1073741824}')

# Get total memory
TOTAL_MEMORY=$(sysctl -n hw.memsize)
TOTAL_GB=$(echo "$TOTAL_MEMORY" | awk '{printf "%.2f", $1 / 1073741824}')

# Calculate percentage
MEMORY_PERCENT=$(echo "$USED_GB $TOTAL_GB" | awk '{printf "%.0f", ($1 / $2) * 100}')

sketchybar --set "$NAME" icon="󰍛" label="${MEMORY_PERCENT}%"
