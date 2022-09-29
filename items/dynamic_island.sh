#!/usr/bin/env sh

source "$HOME/.config/sketchybar/dynamic_island_settings.sh"

sketchybar --add item     island center               \
           --set island   update_freq=1               \
		   				  script="$PLUGIN_DIR/dynamic_island/dynamic_island.sh" \
                          width=205          \
                          align=center                 \
                          background.height=50         \
						  background.y_offset=9         \
						  background.color=$PITCH_BLACK \
						  background.corner_radius=$DEFAULT_CORNER_RADIUS \
						  background.drawing=true	\
						  drawing=on				\
						  popup.background.height=30 \
						  popup.height=$DEFAULT_HEIGHT \
						  popup.align=center \
						  popup.y_offset=-69 \
						  popup.horizontal=on \
						  popup.background.border_color=$PITCH_BLACK \
						  popup.background.color=$PITCH_BLACK \
						  popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
						  popup.background.shadow.drawing=off \
						  popup.drawing=false \
						  horizontal=off \
		   --add event	  music_change "com.apple.Music.playerInfo" \
		   --add item	  musicListener\
		   --set musicListener	script="$PLUGIN_DIR/dynamic_island/islands/music/music_island.sh" \
		   --subscribe musicListener music_change \
		   --add item	  frontAppSwitchListener \
		   --set frontAppSwitchListener script="$PLUGIN_DIR/dynamic_island/islands/appswitch/handler.sh" \
		   --subscribe frontAppSwitchListener front_app_switched
