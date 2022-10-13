#!/usr/bin/env sh

# create cache file to check when dynamic_island is active
active="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/data/active"
printf "0" > "$active"

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/general.sh"

sketchybar --add item     island center               \
           --set island   update_freq=1               \
		   				  script="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/dynamic_island.sh" \
                          width=$DEFAULT_WIDTH          \
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
		   --add event	  music_change "com.apple.Music.playerInfo" \
		   --add item	  musicListener\
		   --set musicListener	script="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/handler.sh" \
		   --subscribe musicListener music_change \
		   --add item	  frontAppSwitchListener \
		   --set frontAppSwitchListener script="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/appswitch/handler.sh" \
		   --subscribe frontAppSwitchListener front_app_switched \
		   --add item volumeChangeListener \
		   --set volumeChangeListener script="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/volume/handler.sh" \
		   --subscribe volumeChangeListener volume_change

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/init.sh"

# empty queued list
queued="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/data/queued"
printf "" > "$queued"
