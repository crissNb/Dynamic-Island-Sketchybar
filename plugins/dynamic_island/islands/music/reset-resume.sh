#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/music_island_settings.sh"

sketchybar --animate tanh 25 --set island.resume_text label.color=$TRANSPARENT_LABEL

sleep 0.4

sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate  sin 30 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.resume_bar width=$RESUME_SQUISH_SIZE width=$RESUME_EXPAND_SIZE

sleep 0.7

sketchybar --set island		popup.drawing=false \
		   					background.drawing=true \
							popup.horizontal=off \
		   --remove island.resume_text \
		   --remove island.resume_bar 
