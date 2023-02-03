#!/usr/bin/env sh
sketchybar --set island.power_text drawing=off \
		   --set island.power_icon drawing=off \
		   --set island.power_background drawing=off \
		   --set island background.drawing=true

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
