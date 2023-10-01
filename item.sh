#!/usr/bin/env bash

export DYNAMIC_ISLAND_DIR
DYNAMIC_ISLAND_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

source "$DYNAMIC_ISLAND_DIR/helper.sh"
sleep 0.5

# Load user config overrides
USER_CONFIG="$DYNAMIC_ISLAND_DIR/userconfig.sh"
test -f "$USER_CONFIG" && source "$USER_CONFIG"

# clear cache
PREVIOUS_ISLAND_CACHE="$HOME/.config/dynamic-island-sketchybar/scripts/islands/previous_island"
true > "$PREVIOUS_ISLAND_CACHE"

PADDING=3

sketchy_bar=(
	height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT"
	color="$P_DYNAMIC_ISLAND_COLOR_BLACK"
	shadow=off
	position=top
	sticky=off
	topmost=on
	padding_left=0
    padding_right=0
	corner_radius="$P_DYNAMIC_ISLAND_CORNER_RADIUS"
	y_offset="-$P_DYNAMIC_ISLAND_CORNER_RADIUS"
    margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH))
	notch_width=0
)

sketchy_default=(
	updates=when_shown
	icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	icon.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
	icon.padding_left="$PADDING"
	icon.padding_right="$PADDING"
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:13.0"
	label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
	label.padding_left="$PADDING"
	label.padding_right="$PADDING"
	background.padding_right="$PADDING"
	background.padding_left="$PADDING"
)

dynamic-island-sketchybar --bar "${sketchy_bar[@]}"

dynamic-island-sketchybar --default "${sketchy_default[@]}"

island=(
	drawing=on
	mach_helper=git.crissnb.islandhelper
	update_freq=5
	width=0
)

dynamic-island-sketchybar --add event dynamic_island_queue \
	--add event dynamic_island_request \
	--add item island center \
	--set island "${island[@]}"

dynamic-island-sketchybar --bar display="$P_DYNAMIC_ISLAND_DISPLAY"

# subscribe to events to communicate with helper
dynamic-island-sketchybar --subscribe island dynamic_island_queue \
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

	dynamic-island-sketchybar --add event music_change $MUSIC_EVENT \
		--add item musicListener center \
		--set musicListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/music/handler.sh $P_DYNAMIC_ISLAND_MUSIC_SOURCE" \
		width=0 \
		--subscribe musicListener music_change
fi

if [[ $P_DYNAMIC_ISLAND_APPSWITCH_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/creator.sh"
	dynamic-island-sketchybar --add item frontAppSwitchListener center \
		--set frontAppSwitchListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/handler.sh" \
		width=0 \
		--subscribe frontAppSwitchListener front_app_switched
fi

if [[ $P_DYNAMIC_ISLAND_VOLUME_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/volume/creator.sh"
	dynamic-island-sketchybar --add item volumeChangeListener center \
		--set volumeChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/volume/handler.sh" \
		width=0 \
		--subscribe volumeChangeListener volume_change
fi

if [[ $P_DYNAMIC_ISLAND_BRIGHTNESS_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/brightness/creator.sh"
	dynamic-island-sketchybar --add item brightnessChangeListener center \
		--set brightnessChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/brightness/handler.sh" \
		width=0 \
		--subscribe brightnessChangeListener brightness_change
fi

if [[ $P_DYNAMIC_ISLAND_WIFI_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/wifi/creator.sh"
	dynamic-island-sketchybar --add item wifiChangeListener center \
		--set wifiChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/wifi/handler.sh" \
		width=0 \
		--subscribe wifiChangeListener wifi_change
fi

if [[ $P_DYNAMIC_ISLAND_POWER_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/power/creator.sh"
	dynamic-island-sketchybar --add item powerChangeListener center \
		--set powerChangeListener script="$DYNAMIC_ISLAND_DIR/scripts/islands/power/handler.sh" \
		width=0 \
		--subscribe powerChangeListener power_source_change
fi

if [[ $P_DYNAMIC_ISLAND_NOTIFICATION_ENABLED == 1 ]]; then
	source "$DYNAMIC_ISLAND_DIR/scripts/islands/notification/creator.sh"
fi

# initialize listener to communicate with helper
source "$DYNAMIC_ISLAND_DIR/listener.sh"
