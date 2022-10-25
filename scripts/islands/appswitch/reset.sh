#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/appswitch.sh"

sketchybar --animate tanh 15 --set island.appname label.color=$TRANSPARENT_LABEL \
		   --animate tanh 15 --set island.applogo background.color=$ICON_HIDDEN

sleep 0.1

sketchybar --animate tanh 20 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate  sin 25 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 15 --set island.appbackground width=$SQUISH_WIDTH width=$EXPAND_WIDTH

sleep 0.4

sketchybar --set island		popup.drawing=false \
		   					background.drawing=true \
							popup.horizontal=off \
		   --remove island.applogo \
		   --remove island.appname \
		   --remove island.appbackground

# call end event
sketchybar --trigger dynamic_island_request
