#!/usr/bin/env sh

# Safely hide resume text with error handling
dynamic-island-sketchybar --set island.resume_text drawing=off 2>/dev/null

sleep 0.1

# call end event
dynamic-island-sketchybar --trigger dynamic_island_request 2>/dev/null
