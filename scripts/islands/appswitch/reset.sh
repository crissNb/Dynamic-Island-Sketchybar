#!/usr/bin/env sh
sketchybar --set island.applogo drawing=off \
		   --set island.appname drawing=off \
		   --set island.appbackground drawing=off \
		   --set island background.drawing=true

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
