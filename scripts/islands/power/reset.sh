#!/usr/bin/env sh
dynamic-island-sketchybar --set island.power_text drawing=off \
	--set island.power_icon drawing=off \

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
