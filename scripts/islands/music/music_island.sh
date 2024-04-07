#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

INFO_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT) / 2))
INFO_EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH))

# $1 - override
args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - artist
# $3 - title
override="${strarr[0]}"
# fetch music info
ARTIST="${strarr[1]}"
TITLE="${strarr[2]}"

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
        --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
        --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
        --set island.music_artwork background.image.drawing=on \
		--set island "${island[@]}"
fi

dynamic-island-sketchybar --set island.music_artist label="$ARTIST" \
	--set island.music_title label="$TITLE"

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
	--animate tanh 15 --set island.music_artwork background.image.drawing=on

sleep 1.7

dynamic-island-sketchybar --animate tanh 15 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artwork background.image.drawing=off

sleep 0.2

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset.sh"
