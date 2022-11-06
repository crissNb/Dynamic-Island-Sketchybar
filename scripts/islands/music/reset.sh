#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

# call end event
sketchybar --trigger dynamic_island_request

sketchybar --set island		popup.horizontal=off \
							popup.drawing=false \
		   					background.drawing=true \
		   --remove island.music_title \
		   --remove island.music_artist \
		   --remove island.music_artwork \
		   --remove island.music_placeholder 
