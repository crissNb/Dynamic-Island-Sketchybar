#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/music_island_settings.sh"

sketchybar --animate tanh 25 --set island.music_title label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.music_artist label.color=$TRANSPARENT_LABEL \
		   --animate sin 25 --set island.music_artwork background.color=$ICON_HIDDEN

sleep 0.4
sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate  sin 30 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.music_placeholder width=$SQUISH_SIZE width=$EXPAND_SIZE \

sleep 0.7
sketchybar --set island		popup.drawing=false \
		   					background.drawing=true \
							popup.horizontal=off \
		   --remove island.music_title \
		   --remove island.music_artist \
		   --remove island.music_artwork \
		   --remove island.music_placeholder 
