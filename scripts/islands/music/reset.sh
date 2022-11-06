#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

sketchybar --set island		popup.horizontal=off \
		   					background.drawing=true \
		   --remove island.music_title \
		   --remove island.music_artist \
		   --remove island.music_artwork \
		   --remove island.music_placeholder 

sleep 0.1

sketchybar --set island popup.drawing=false

# call end event
sketchybar --trigger dynamic_island_request
