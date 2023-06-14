#!/usr/bin/env sh
dynamic-island-sketchybar --set island.power_text drawing=off \
	--set island.power_icon drawing=off \
	--set island.power_background drawing=off \
	--set island background.drawing=true

sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
