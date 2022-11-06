#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

sketchybar --set island		background.drawing=true \
							popup.horizontal=off \
		   --remove island.resume_text \
		   --remove island.resume_bar 

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
