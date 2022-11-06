#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/volume.sh"

sketchybar --remove island.placeholder1 \
		   --remove island.placeholder2 \
		   --remove island.placeholder3 \
		   --remove island.volume_icon \
		   --remove island.volume_bar \
		   --set island background.drawing=true \
		   				popup.horizontal=on

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
