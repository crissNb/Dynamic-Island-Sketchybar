#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/brightness.sh"

# call end event
sketchybar --trigger dynamic_island_request

sketchybar --remove island.placeholder1 \
		   --remove island.placeholder2 \
		   --remove island.placeholder3 \
		   --remove island.brightness_icon \
		   --remove island.brightness_bar \
		   --set island		popup.drawing=false \
		   					background.drawing=true
