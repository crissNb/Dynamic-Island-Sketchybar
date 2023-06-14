#!/usr/bin/env sh
dynamic-island-sketchybar --set island background.drawing=true \
	popup.horizontal=off \
	--set island.resume_text drawing=off \
	--set island.resume_bar drawing=off
sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
