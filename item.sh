#!/usr/bin/env sh

sketchybar --add event    dynamic_island_queue \
		   --add event	  dynamic_island_request \
		   --add item     island center               \
           --set island   width=$P_DYNAMIC_ISLAND_DEFAULT_WIDTH         \
                          background.height=50         \
						  background.y_offset=9         \
						  background.color=$P_DYNAMIC_ISLAND_COLOR_BLACK \
						  background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
						  background.drawing=true	\
						  background.padding_left=0 \
						  background.padding_right=0 \
						  update_freq=2					\
						  mach_helper=git.crissnb.islandhelper \
						  drawing=on				\
						  popup.background.height=30 \
						  popup.height=$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT \
						  popup.align=center \
						  popup.y_offset=-69 \
						  popup.horizontal=on \
						  popup.background.border_color=$P_DYNAMIC_ISLAND_COLOR_BLACK \
						  popup.background.color=$P_DYNAMIC_ISLAND_COLOR_BLACK \
						  popup.background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
						  popup.background.padding_left=0 \
						  popup.background.padding_right=0 \
						  popup.background.shadow.drawing=off \
						  popup.drawing=false

if [[ $P_DYNAMIC_ISLAND_DISPLAY == "Primary" ]]; then
	sketchybar --set island associated_display=1
elif [[ $P_DYNAMIC_ISLAND_DISPLAY == "Active" ]]; then
	sketchybar --set island associated_display=active
fi

# subscribe to events to communicate with helper
sketchybar --subscribe island dynamic_island_queue \
		   --subscribe island dynamic_island_request

# module initalization
if [[ $P_DYNAMIC_ISLAND_MUSIC_ENABLED == 1 ]]; then
	if [[ $P_DYNAMIC_ISLAND_MUSIC_SOURCE == "Music" ]]; then
		MUSIC_EVENT="com.apple.Music.playerInfo"
	elif [[ $P_DYNAMIC_ISLAND_MUSIC_SOURCE == "Spotify" ]]; then
		MUSIC_EVENT="com.spotify.client.PlaybackStateChanged"
	else
		exit 0
	fi

	source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/creator.sh"

	sketchybar --add event	  music_change $MUSIC_EVENT \
			   --add item	  musicListener center \
			   --set musicListener	script="$DYNAMIC_ISLAND_DIR/scripts/islands/music/handler.sh $P_DYNAMIC_ISLAND_MUSIC_SOURCE" \
									width=0 \
			   --subscribe musicListener music_change
fi

if [[ $P_DYNAMIC_ISLAND_APPSWITCH_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/creator.sh"
	sketchybar --add item	  frontAppSwitchListener center \
			   --set frontAppSwitchListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/handler.sh" \
											width=0 \
			   --subscribe frontAppSwitchListener front_app_switched
fi

if [[ $P_DYNAMIC_ISLAND_VOLUME_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/volume/creator.sh"
	sketchybar --add item volumeChangeListener center \
			   --set volumeChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/volume/handler.sh" \
										  width=0 \
			   --subscribe volumeChangeListener volume_change
fi

if [[ $P_DYNAMIC_ISLAND_BRIGHTNESS_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/brightness/creator.sh"
	sketchybar --add item brightnessChangeListener center \
			   --set brightnessChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/brightness/handler.sh" \
											  width=0 \
			   --subscribe brightnessChangeListener brightness_change
fi

if [[ $P_DYNAMIC_ISLAND_WIFI_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/wifi/creator.sh"
	sketchybar --add item wifiChangeListener center \
			   --set wifiChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/wifi/handler.sh" \
										width=0 \
			   --subscribe wifiChangeListener wifi_change
fi

if [[ $P_DYNAMIC_ISLAND_POWER_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/power/creator.sh"
	sketchybar --add item powerChangeListener center \
			   --set powerChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/power/handler.sh" \
										width=0 \
			   --subscribe powerChangeListener power_source_change
fi

if [[ $P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/notification/creator.sh"
fi

# initialize listener to communicate with helper
source "$DYNAMIC_ISLAND_DIR/listener.sh"
