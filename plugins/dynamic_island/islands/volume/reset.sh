#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/volume_island_settings.sh"

sketchybar --animate tanh 20 --set island.volume_icon icon.color=$TRANSPARENT_LABEL \
		   --animate tanh 20 --set island.volume_bar background.color=$TRANSPARENT_LABEL

sleep 0.4

sketchybar --set island.volume_bar width=10

sketchybar --animate tanh 20 --set island popup.height=13 \
		   --animate tanh 20 --set island.placeholder1 width=175 width=192 \
		   --animate sin 25 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS

sleep 1

sketchybar --remove island.placeholder1 \
		   --remove island.placeholder2 \
		   --remove island.placeholder3 \
		   --remove island.volume_icon \
		   --remove island.volume_bar \
		   --set island		popup.drawing=false \
		   					background.drawing=true
