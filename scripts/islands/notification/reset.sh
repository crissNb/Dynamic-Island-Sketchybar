#!/usr/bin/env sh
dynamic-island-sketchybar --set island.notification_title drawing=off \
	--set island.notification_subtitle drawing=off \
	--set island.notification_body drawing=off \
	--set island.notification_logo drawing=off \

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
