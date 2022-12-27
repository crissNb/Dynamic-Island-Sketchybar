#!/usr/bin/env sh 
sketchybar --set island.notification_title drawing=off \
	       --set island.notification_subtitle drawing=off \
		   --set island.notification_body drawing=off \
		   --set island.notification_logo drawing=off \
		   --set island.notification_expanding drawing=off \
		   --set island	background.drawing=true

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
