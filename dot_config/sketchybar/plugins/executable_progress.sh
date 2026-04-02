#!/bin/sh

# Get the first line of ON_PROGRESS.txt
PROGRESS=$(head -n 1 "$HOME/Documents/ON_PROGRESS.txt" 2>/dev/null)

if [ "$PROGRESS" != "" ]; then
  # Set the label for the sketchybar item and show it
  sketchybar --set "$NAME" label="$PROGRESS" drawing=on
else
  # Hide the item if the file is empty or doesn't exist
  sketchybar --set "$NAME" drawing=off
fi
