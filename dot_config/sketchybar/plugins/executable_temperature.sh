#!/bin/sh

TEMPERATURE_C=""

if command -v ismc >/dev/null 2>&1; then
  TEMPERATURE_RAW=$(ismc temp -o json 2>/dev/null)
  TEMPERATURE_C=$(printf '%s\n' "$TEMPERATURE_RAW" | awk '
    /"value"[[:space:]]*:/ {
      if (match($0, /[0-9]+(\.[0-9]+)?/)) {
        value = substr($0, RSTART, RLENGTH) + 0
        if (value > max) {
          max = value
        }
      }
    }
    END {
      if (max > 0) {
        printf "%.0f\n", max
      }
    }
  ')
fi

if [ -z "$TEMPERATURE_C" ] && command -v osx-cpu-temp >/dev/null 2>&1; then
  TEMPERATURE_RAW=$(osx-cpu-temp 2>/dev/null)
  case "$TEMPERATURE_RAW" in
    *Error:* | *error:* | 0°C | 0.0°C | 0.00°C)
      TEMPERATURE_RAW=""
      ;;
  esac

  if [ -n "$TEMPERATURE_RAW" ]; then
    TEMPERATURE_C=$(printf '%s\n' "$TEMPERATURE_RAW" | awk 'match($0, /[0-9]+(\.[0-9]+)?/) { printf "%.0f\n", substr($0, RSTART, RLENGTH); exit }')
  fi
fi

if [ -z "$TEMPERATURE_C" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

TEMPERATURE_LABEL="${TEMPERATURE_C}°C"

sketchybar --set "$NAME" drawing=on icon="󰔄" label="$TEMPERATURE_LABEL"
