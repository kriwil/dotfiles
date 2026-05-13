#!/bin/sh
# Build (if stale) and run the Swift sampler that backs cpu/mem/disk/temp.

SRC="$(dirname "$0")/sysinfo.swift"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/sketchybar"
BIN="$CACHE_DIR/sysinfo"

mkdir -p "$CACHE_DIR"

if [ ! -x "$BIN" ] || [ "$SRC" -nt "$BIN" ]; then
	swiftc -O -o "$BIN" "$SRC" >/dev/null 2>&1 || exit 0
fi

exec "$BIN" "$@"
