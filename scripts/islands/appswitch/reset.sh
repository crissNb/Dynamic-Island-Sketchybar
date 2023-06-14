#!/usr/bin/env sh
dynamic-island-sketchybar --set island.applogo drawing=off \
	--set island.appname drawing=off \
	--set island.appbackground drawing=off \
	--set island background.drawing=true

sleep 0.1

dynamic-island-sketchybar --set island popup.drawing=false

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
