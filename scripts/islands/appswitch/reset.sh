#!/usr/bin/env sh
dynamic-island-sketchybar --set island.applogo drawing=off \
	--set island.appname drawing=off
sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
