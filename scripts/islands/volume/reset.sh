#!/usr/bin/env sh
sketchybar --set island.volume_placeholder1 drawing=off \
		   --set island.volume_placeholder2 drawing=off \
		   --set island.volume_placeholder3 drawing=off \
		   --set island.volume_icon drawing=off \
		   --set island.volume_bar drawing=off \
		   --set island background.drawing=true \
		   				popup.horizontal=on

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
