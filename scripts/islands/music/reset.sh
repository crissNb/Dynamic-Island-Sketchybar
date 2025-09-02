#!/usr/bin/env sh

# Safely hide music elements with error handling
dynamic-island-sketchybar --set island.music_title drawing=off 2>/dev/null \
	--set island.music_artist drawing=off 2>/dev/null \
	--set island.music_artwork drawing=off 2>/dev/null

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request 2>/dev/null
