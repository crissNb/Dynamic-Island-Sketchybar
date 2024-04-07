#!/usr/bin/env bash
TITLE=$(jq -r '.title' <<< "$INFO")
ARTIST=$(jq -r '.artist' <<< "$INFO")
dynamic-island-sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS="$TITLE|$ARTIST"
