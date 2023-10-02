#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"
ARTWORK_LOCATION="$DYNAMIC_ISLAND_DIR/scripts/islands/music/artwork.jpg"

INFO_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT) / 2))
INFO_EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH))

# $1 - override
override=$1

# fetch music info
TITLE=$(osascript -e "tell application \"$P_DYNAMIC_ISLAND_MUSIC_SOURCE\" to get name of current track")
ARTIST=$(osascript -e "tell application \"$P_DYNAMIC_ISLAND_MUSIC_SOURCE\" to get artist of current track")

if [[ $P_DYNAMIC_ISLAND_MUSIC_SOURCE == "Music" ]]; then
	osascript "$DYNAMIC_ISLAND_DIR/scripts/islands/music/get_artwork.scpt"
elif [[ $P_DYNAMIC_ISLAND_MUSIC_SOURCE == "Spotify" ]]; then
	COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
	curl -s --max-time 25 "$COVER" -o "$ARTWORK_LOCATION"
else
	exit 0
fi

if [[ ${#TITLE} -gt 25 ]]; then
	TITLE=$(printf "%s..." "$(echo "$TITLE" | cut -c 1-25)")
fi

if [[ ${#ARTIST} -gt 25 ]]; then
	ARTIST=$(printf "%s..." "$(echo "$ARTIST" | cut -c 1-25)")
fi

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --set island.music_artwork drawing=on \
		--set island.music_title drawing=on \
		--set island.music_artist drawing=on \
		--set island "${island[@]}"
fi

dynamic-island-sketchybar --set island.music_artist label="$ARTIST" \
	--set island.music_title label="$TITLE" \
    --set island.music_artwork background.image="$ARTWORK_LOCATION"

dynamic-island-sketchybar --set island.small_artwork background.image="$ARTWORK_LOCATION"

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

    dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($INFO_EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$INFO_EXPAND_SIZE" \
		--animate tanh 10 --bar height="$INFO_MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD"
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($INFO_EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$INFO_EXPAND_SIZE" \
		--animate tanh 10 --bar height="$INFO_MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD"
fi

sleep 0.15
dynamic-island-sketchybar --animate tanh 15 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 15 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 15 --set island.music_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 1.7

dynamic-island-sketchybar --animate tanh 15 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"

sleep 0.2

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset.sh"
