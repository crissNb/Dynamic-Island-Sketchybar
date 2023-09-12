#!/usr/bin/env sh
dynamic-island-sketchybar --set island.wifi_icon drawing=off \
		   --set island.wifi_ssid drawing=off \

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
