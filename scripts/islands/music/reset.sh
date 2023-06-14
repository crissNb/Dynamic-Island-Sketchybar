#!/usr/bin/env sh
dynamic-island-sketchybar --set island popup.horizontal=off \
	background.drawing=true \
	--set island.music_title drawing=off \
	--set island.music_artist drawing=off \
	--set island.music_artwork drawing=off \
	--set island.music_placeholder drawing=off
sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
