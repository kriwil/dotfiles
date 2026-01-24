#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/helpers/icon_map.sh"

# Get list of workspaces with apps
WORKSPACES_WITH_APPS=$(aerospace list-workspaces --monitor all --empty no)

# Check if current workspace has apps
WORKSPACE_HAS_APPS=false
for ws in $WORKSPACES_WITH_APPS; do
	if [ "$ws" = "$1" ]; then
		WORKSPACE_HAS_APPS=true
		break
	fi
done

# Show workspace if it has apps, hide if empty
if [ "$WORKSPACE_HAS_APPS" = true ]; then
	# Get app names in this workspace
	APPS=$(aerospace list-windows --workspace "$1" --format '%{app-name}' | sort -u)

	# Build icon string from apps
	ICONS=""
	while IFS= read -r app; do
		if [ -n "$app" ]; then
			__icon_map "$app"
			if [ "$icon_result" != "" ]; then
				ICONS="$ICONS$icon_result"
			fi
		fi
	done <<<"$APPS"

	# Set icons or use workspace number if no icons found
	if [ -n "$ICONS" ]; then
		sketchybar --set $NAME icon="$ICONS" label="$1" icon.drawing=on label.drawing=on
	else
		sketchybar --set $NAME label="$1" icon.drawing=off label.drawing=on
	fi

	# Highlight focused workspace
	if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
		sketchybar --set $NAME background.drawing=on
	else
		sketchybar --set $NAME background.drawing=off
	fi
else
	sketchybar --set $NAME icon.drawing=off label.drawing=off background.drawing=off
fi
