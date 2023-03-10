#!/usr/bin/env sh
echo "volume"
echo "$INFO"

sketchybar --trigger dynamic_island_queue INFO="volume" ISLAND_ARGS="$INFO"
