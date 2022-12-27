#!/usr/bin/env sh
sketchybar --set island		background.drawing=true \
							popup.horizontal=off \
		   --set island.resume_text drawing=off \
		   --set island.resume_bar drawing=off
sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
