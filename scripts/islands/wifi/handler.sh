#!/usr/bin/env sh
echo "wifi"
echo "$INFO"

dynamic-island-sketchybar --trigger dynamic_island_queue INFO="wifi" ISLAND_ARGS="$INFO"
