#!/usr/bin/env sh 
source "$HOME/.config/sketchybar/plugins/dynamic_island/configs/notifications.sh"

sketchybar --animate tanh 25 --set island.title label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.subtitle label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.body label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.logo background.color=$ICON_HIDDEN \

sleep 0.4

sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate  sin 35 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.expanding width=$SQUISH_WIDTH width=$EXPAND_WIDTH \

sleep 0.7
sketchybar --remove island.expanding \
		   --set island		popup.drawing=false \
		   					background.drawing=true \
		   --remove island.title \
		   --remove island.subtitle \
		   --remove island.body \
		   --remove island.logo
