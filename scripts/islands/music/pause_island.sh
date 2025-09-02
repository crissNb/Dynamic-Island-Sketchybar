#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

# Validate essential configuration values for pause island
validate_pause_config() {
    if [[ -z "$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" ]] || ! [[ "$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT not set, using default" >&2
        P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT=56
    fi
    
    if [[ -z "$P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH" ]] || ! [[ "$P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH not set, using default" >&2
        P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH=155
    fi
}

validate_pause_config

PREVIOUS_ISLAND_CACHE="$DYNAMIC_ISLAND_DIR/scripts/islands/previous_island"

RESUME_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

override="${strarr[0]}"
pauseStatus="${strarr[1]}"

# Validate pause status
if [[ -z "$pauseStatus" ]]; then
    pauseStatus="0"  # Default to paused if unknown
fi

# Ensure cache directory exists
if [[ ! -f "$PREVIOUS_ISLAND_CACHE" ]]; then
    touch "$PREVIOUS_ISLAND_CACHE"
fi

if [[ $pauseStatus == "0" ]]; then
    echo "paused" > "$PREVIOUS_ISLAND_CACHE"
else
    echo "music" > "$PREVIOUS_ISLAND_CACHE"
fi

# enable
dynamic-island-sketchybar --set island.resume_text drawing=on 2>/dev/null

if [[ $pauseStatus == "0" ]]; then
	# paused
	dynamic-island-sketchybar --set island.resume_text label="Paused" 2>/dev/null
else
	# resume
	dynamic-island-sketchybar --set island.resume_text label="Resumed" 2>/dev/null
fi

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

	# animate
    dynamic-island-sketchybar --animate tanh 8 --bar margin=$target_width margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height=$RESUME_MAX_EXPAND_HEIGHT height="$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD" 2>/dev/null || {
			echo "Warning: Pause island animation failed" >&2
		}

	sleep 0.45
	dynamic-island-sketchybar --animate sin 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" 2>/dev/null
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height=$RESUME_MAX_EXPAND_HEIGHT height="$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD" 2>/dev/null || {
			echo "Warning: Pause island animation failed" >&2
		}
	dynamic-island-sketchybar --animate sin 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" 2>/dev/null
fi

sleep 0.8

dynamic-island-sketchybar --animate tanh 10 --set island.resume_text label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" 2>/dev/null

sleep 0.1

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.7

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset-resume.sh"
