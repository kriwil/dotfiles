#!/bin/sh

# Get memory statistics from vm_stat
MEMORY_STATS=$(vm_stat)

# Extract page counts (macOS uses 16KB pages on Apple Silicon, 4KB on Intel)
PAGE_SIZE=$(pagesize)
PAGES_FREE=$(echo "$MEMORY_STATS" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
PAGES_ACTIVE=$(echo "$MEMORY_STATS" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_INACTIVE=$(echo "$MEMORY_STATS" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$MEMORY_STATS" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
PAGES_SPECULATIVE=$(echo "$MEMORY_STATS" | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')

# Calculate used memory in GB
USED_PAGES=$((PAGES_ACTIVE + PAGES_INACTIVE + PAGES_WIRED + PAGES_SPECULATIVE))
USED_GB=$(echo "$USED_PAGES $PAGE_SIZE" | awk '{printf "%.1f", ($1 * $2) / 1073741824}')

# Get total memory in GB
TOTAL_MEMORY=$(sysctl -n hw.memsize)
TOTAL_GB=$(echo "$TOTAL_MEMORY" | awk '{printf "%.0f", $1 / 1073741824}')

# Calculate percentage
MEMORY_PERCENT=$(echo "$USED_GB $TOTAL_GB" | awk '{printf "%.0f", ($1 / $2) * 100}')

sketchybar --set "$NAME" icon="MEM" label="${USED_GB}G"
