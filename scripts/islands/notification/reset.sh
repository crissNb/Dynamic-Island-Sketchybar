#!/usr/bin/env sh
dynamic-island-sketchybar --set island.notification_title drawing=off \
	--set island.notification_subtitle drawing=off \
	--set island.notification_body drawing=off \
	--set island.notification_logo drawing=off \
	--set island.notification_expanding drawing=off \
	--set island background.drawing=true

sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
