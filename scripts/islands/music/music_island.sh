#!/usr/bin/env bash
source "$HOME/.config/sketchybar/userconfig.sh"

ARTWORK_LOCATION="$DYNAMIC_ISLAND_DIR/scripts/islands/music/artwork.jpg"
INFO_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
INFO_MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
INFO_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT)

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
	island=(
		popup.drawing=true
		background.drawing=false
		popup.horizontal=on
		popup.height="$P_DYNAMIC_ISLAND_MUSIC_INFO_DEFAULT_HEIGHT"
	)

	sketchybar --set island.music_artwork drawing=on \
		background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN" \
		--set island.music_title drawing=on \
		--set island.music_artist drawing=on \
		--set island.music_placeholder drawing=on \
		--set island "${island[@]}"
fi

sketchybar --set island.music_artist label="$ARTIST" \
	--set island.music_title label="$TITLE" \
	--set island.music_artwork background.image="$ARTWORK_LOCATION"

if [[ $override == "0" ]]; then
	sketchybar --animate sin 15 --set island.music_placeholder width="$INFO_SQUISH_WIDTH" width="$INFO_MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH" \
		--animate sin 25 --set island popup.height="$INFO_MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate sin 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD"
else
	sketchybar --animate sin 15 --set island.music_placeholder width="$INFO_MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH" \
		--animate sin 25 --set island popup.height="$INFO_MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate sin 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD"
fi

sleep 0.15
sketchybar --animate tanh 25 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 25 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 25 --set island.music_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 1.5

sketchybar --animate tanh 25 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 25 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 25 --set island.music_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"

sleep 0.4
sketchybar --animate tanh 25 --set island popup.height="$P_DYNAMIC_ISLAND_MUSIC_INFO_DEFAULT_HEIGHT" \
	--animate sin 30 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS" \
	--animate tanh 20 --set island.music_placeholder width="$INFO_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH"

sleep 0.7

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset.sh"
