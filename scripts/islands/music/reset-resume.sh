#!/usr/bin/env sh
dynamic-island-sketchybar --set island.resume_text drawing=off
sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request
