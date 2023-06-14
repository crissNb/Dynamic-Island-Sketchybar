#!/usr/bin/env sh
echo "brightness"
echo "$INFO"

dynamic-island-sketchybar --trigger dynamic_island_queue INFO="brightness" ISLAND_ARGS="$INFO"
