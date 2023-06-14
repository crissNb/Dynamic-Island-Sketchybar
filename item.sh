#!/usr/bin/env bash

export DYNAMIC_ISLAND_DIR
DYNAMIC_ISLAND_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

source "$DYNAMIC_ISLAND_DIR/helper.sh"
sleep 0.5

# Load user config overrides
USER_CONFIG="$HOME/.config/dis-userconfig/userconfig.sh"
test -f "$USER_CONFIG" && source "$USER_CONFIG"

PADDING=3

sketchy_bar=(
	height=32
	color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	shadow=off
	position=top
	sticky=on
	padding_right=$((10 - $PADDING))
	topmost="${P_DYNAMIC_ISLAND_TOPMOST:=off}"
	padding_left=18
	corner_radius=9
	y_offset=0
	margin=10
	blur_radius=30
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
	popup.background.corner_radius=11
	popup.background.shadow.drawing=off
	popup.background.border_width=2
	popup.horizontal=on
)

dynamic-island-sketchybar --bar "${sketchy_bar[@]}"
	
dynamic-island-sketchybar --default "${sketchy_default[@]}"

island=(
	drawing=on
	mach_helper=git.crissnb.islandhelper
	update_freq=2
	width="$P_DYNAMIC_ISLAND_DEFAULT_WIDTH"
	background.color="$P_DYNAMIC_ISLAND_COLOR_BLACK"
	background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS"
	background.drawing=true
	background.height=50
	background.padding_left=0
	background.padding_right=0
	background.y_offset=9
	popup.background.height=30
	popup.align=center
	popup.drawing=false
	popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT"
	popup.horizontal=on
	popup.y_offset=-69
	popup.background.border_color="$P_DYNAMIC_ISLAND_COLOR_BLACK"
	popup.background.color="$P_DYNAMIC_ISLAND_COLOR_BLACK"
	popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS"
	popup.background.padding_left=0
	popup.background.padding_right=0
	popup.background.shadow.drawing=off
)

dynamic-island-sketchybar --add event dynamic_island_queue \
	--add event dynamic_island_request \
	--add item island center \
	--set island "${island[@]}"

if [[ $P_DYNAMIC_ISLAND_DISPLAY == "Primary" ]]; then
	dynamic-island-sketchybar --set island associated_display=1
elif [[ $P_DYNAMIC_ISLAND_DISPLAY == "Active" ]]; then
	dynamic-island-sketchybar --set island associated_display=active
fi

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
