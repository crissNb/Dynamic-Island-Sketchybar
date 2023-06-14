#!/usr/bin/env sh
dynamic-island-sketchybar --set island.wifi_icon drawing=off \
		   --set island.wifi_ssid drawing=off \
		   --set island.wifi_background drawing=off \
		   --set island background.drawing=true

sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
