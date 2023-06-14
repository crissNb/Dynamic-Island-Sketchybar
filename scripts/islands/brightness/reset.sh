#!/usr/bin/env sh
# call end event
dynamic-island-sketchybar --trigger dynamic_island_request

dynamic-island-sketchybar --set island.brightness_placeholder1 drawing=off \
	--set island.brightness_placeholder2 drawing=off \
	--set island.brightness_placeholder3 drawing=off \
	--set island.brightness_icon drawing=off \
	--set island.brightness_bar drawing=off \
	--set island background.drawing=true \
	popup.horizontal=on

sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false
