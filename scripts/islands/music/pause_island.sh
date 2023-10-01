#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

RESUME_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

override="${strarr[0]}"
pauseStatus="${strarr[1]}"

# enable
dynamic-island-sketchybar --set island.resume_text drawing=on

if [[ $pauseStatus == "0" ]]; then
	# paused
	dynamic-island-sketchybar --set island.resume_text label="Paused"
else
	# resume
	dynamic-island-sketchybar --set island.resume_text label="Resumed"
fi

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

	# animate
    dynamic-island-sketchybar --animate tanh 8 --bar margin=$target_width margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height=$RESUME_MAX_EXPAND_HEIGHT height="$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD"

	sleep 0.45
	dynamic-island-sketchybar --animate sin 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height=$RESUME_MAX_EXPAND_HEIGHT height="$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD"
	dynamic-island-sketchybar --animate sin 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
fi

sleep 0.8

dynamic-island-sketchybar --animate tanh 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.7

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset-resume.sh"
