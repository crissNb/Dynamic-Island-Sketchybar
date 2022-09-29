#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/appswitch_island_settings.sh"

sketchybar --animate tanh 25 --set island.appname label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.applogo background.color=$ICON_HIDDEN

sleep 0.4

sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate  sin 30 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.appbackground width=$SQUISH_SIZE width=$EXPAND_SIZE

sleep 0.7

sketchybar --set island		popup.drawing=false \
		   					background.drawing=true \
							popup.horizontal=off \
		   --remove island.applogo \
		   --remove island.appname \
		   --remove island.appbackground 
