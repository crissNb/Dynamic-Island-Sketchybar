#!/usr/bin/env bash
TITLE=$(jq -r '.title' <<< "$INFO")
ARTIST=$(jq -r '.artist' <<< "$INFO")
STATE=$(jq -r '.state' <<< "$INFO")

dynamic-island-sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS="$TITLE|$ARTIST|$STATE"
