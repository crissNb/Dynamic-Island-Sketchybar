#!/usr/bin/env sh

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/general.sh"

sketchybar --add event    dynamic_island_queue \
		   --add event	  dynamic_island_request \
		   --add item     island center               \
           --set island   width=$DEFAULT_WIDTH          \
                          background.height=50         \
						  background.y_offset=9         \
						  background.color=$PITCH_BLACK \
						  background.corner_radius=$DEFAULT_CORNER_RADIUS \
						  background.drawing=true	\
						  background.padding_left=0 \
						  background.padding_right=0 \
						  update_freq=2					\
						  mach_helper=git.crissnb.islandhelper \
						  drawing=on				\
						  popup.background.height=30 \
						  popup.height=$DEFAULT_HEIGHT \
						  popup.align=center \
						  popup.y_offset=-69 \
						  popup.horizontal=on \
						  popup.background.border_color=$PITCH_BLACK \
						  popup.background.color=$PITCH_BLACK \
						  popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
						  popup.background.padding_left=0 \
						  popup.background.padding_right=0 \
						  popup.background.shadow.drawing=off \
						  popup.drawing=false

if [[ $DISPLAY_PRIMARY == "Primary" ]]; then
	sketchybar --set island associated_display=1
elif [[ $DISPLAY_PRIMARY == "Active" ]]; then
	sketchybar --set island associated_display=active
fi

# subscribe to events to communicate with helper
sketchybar --subscribe island dynamic_island_queue \
		   --subscribe island dynamic_island_request

# module initalization
if [[ $MUSIC_ENABLED == 1 ]]; then
	if [[ $MUSIC_SOURCE == "Music" ]]; then
		MUSIC_EVENT="com.apple.Music.playerInfo"
	elif [[ $MUSIC_SOURCE == "Spotify" ]]; then
		MUSIC_EVENT="com.spotify.client.PlaybackStateChanged"
	else
		exit 0
	fi
	sketchybar --add event	  music_change $MUSIC_EVENT \
			   --add item	  musicListener \
			   --set musicListener	script="$DYNAMIC_ISLAND_ENV_VARS $HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/handler.sh" \
			   --subscribe musicListener music_change
fi

if [[ $APPSWITCH_ENABLED == 1 ]]; then
	sketchybar --add item	  frontAppSwitchListener \
			   --set frontAppSwitchListener script="$DYNAMIC_ISLAND_ENV_VARS $HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/appswitch/handler.sh" \
			   --subscribe frontAppSwitchListener front_app_switched
fi

if [[ $VOLUME_ENABLED == 1 ]]; then
	sketchybar --add item volumeChangeListener \
			   --set volumeChangeListener script="$DYNAMIC_ISLAND_ENV_VARS $HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/volume/handler.sh" \
			   --subscribe volumeChangeListener volume_change
fi

if [[ $BRIGHTNESS_ENABLED == 1 ]]; then
	sketchybar --add item brightnessChangeListener \
			   --set brightnessChangeListener script="$DYNAMIC_ISLAND_ENV_VARS $HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/brightness/handler.sh" \
			   --subscribe brightnessChangeListener brightness_change
fi


# start listener
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/listener.sh"

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/init.sh" $NOTIFICATION_ENABLED
