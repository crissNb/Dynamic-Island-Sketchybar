#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/appswitch.sh"

# call end event
sketchybar --trigger dynamic_island_request

sketchybar --remove island.applogo \
		   --remove island.appname \
		   --remove island.appbackground \
		   --set island		background.drawing=true \
							popup.horizontal=off \
							popup.drawing=false
