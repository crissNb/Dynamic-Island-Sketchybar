#!/usr/bin/env sh 
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/notifications.sh"

sketchybar --remove island.expanding \
		   --set island	background.drawing=true \
		   --remove island.title \
		   --remove island.subtitle \
		   --remove island.body \
		   --remove island.logo

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
