#!/usr/bin/env sh
dynamic-island-sketchybar --set island.music_title drawing=off \
	--set island.music_artist drawing=off \
	--set island.music_artwork drawing=off

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
