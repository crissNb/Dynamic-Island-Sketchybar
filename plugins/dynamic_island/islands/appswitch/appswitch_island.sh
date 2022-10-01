#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/appswitch_island_settings.sh"

# $1 - front app name
BUNDLENAME=$(osascript -e "id of app \"$1\"")

sketchybar --add item island.appname popup.island \
		   --set island.appname		width=0 \
								    label.color=$TRANSPARENT_LABEL \
								    label.padding_left=0 \
								    label.padding_right=0 \
								    label="$1" \
								    label.font="$FONT:Bold:14.0" \
								    label.y_offset=-17 \
									label.align=right \
								    background.padding_left=5 \
								    background.padding_right=0 \
		   --add item island.appbackground popup.island \
		   --set island.appbackground width=$EXPAND_SIZE \
								   background.height=$DEFAULT_HEIGHT \
								   background.color=$PITCH_BLACK \
								   background.border_color=$PITCH_BLACK \
								   background.corner_radius=$DEFAULT_CORNER_RADIUS \
								   background.padding_left=0 \
								   background.padding_right=0 \
								   background.y_offset=0 \
								   background.shadow.drawing=off \
		   --add item island.applogo popup.island \
		   --set island.applogo background.color=$ICON_HIDDEN \
							 background.padding_left=20 \
							 background.padding_right=5 \
							 background.image="app.$BUNDLENAME" \
							 background.image.scale=0.7 \
							 y_offset=-16 \
		   --set island		popup.drawing=true \
							background.drawing=false \
							popup.horizontal=on

sketchybar --animate sin 15 --set island.appbackground width=$SQUISH_SIZE width=$MAX_EXPAND_SQUISH_SIZE width=$MAX_EXPAND_SIZE\
		   --animate sin 20 --set island popup.height=70 popup.height=65 \
		   --animate sin 20 --set island popup.background.corner_radius=15

sleep 0.25

sketchybar --animate sin 15 --set island.appname label.color=$DEFAULT_LABEL \
		   --animate sin 15 --set island.applogo background.color=$TRANSPARENT_LABEL

sleep 0.75

source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/reset.sh"
