#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

sketchybar --animate tanh 25 --set island.resume_text label.color=$TRANSPARENT_LABEL

sleep 0.4

sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate tanh 30 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$RESUME_EXPAND_WIDTH

sleep 0.7

sketchybar --set island		popup.drawing=false \
		   					background.drawing=true \
							popup.horizontal=off \
		   --remove island.resume_text \
		   --remove island.resume_bar 
