#!/usr/bin/env sh
dynamic-island-sketchybar --set island.volume_icon drawing=off \
	--set island.volume_bar drawing=off \

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
