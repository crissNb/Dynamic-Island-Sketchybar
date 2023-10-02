#!/usr/bin/env bash
PREVIOUS_ISLAND_CACHE="$HOME/.config/dynamic-island-sketchybar/scripts/islands/previous_island"

script_dir=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

echo "music"
echo "$INFO"

# $1: MUSIC_SOURCE

# check if music app is running
RUNNING=$(pgrep -x "$1")
if [[ ! "$RUNNING" ]]; then
	exit 0
fi

if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Stopped" ]; then
	exit 0
fi

cache="$script_dir/cache"
PLAYER_STATE=$(osascript -e "tell application \"$1\" to return (get player state)")

if ! test -f $cache; then
    printf 1 >"$cache"
fi

if [[ $(cat "$cache") == 0 ]]; then
	# resume
	printf 1 >"$cache"
	dynamic-island-sketchybar --trigger dynamic_island_queue INFO="pause" ISLAND_ARGS="1"
    if [[ ! $(grep -Fxq "music" "$PREVIOUS_ISLAND_CACHE") ]]; then
        echo "music" >> "$PREVIOUS_ISLAND_CACHE"
    fi
	exit 0
fi

if [[ $PLAYER_STATE == "paused" ]]; then
	# paused
	printf 0 >"$cache"
	dynamic-island-sketchybar --trigger dynamic_island_queue INFO="pause" ISLAND_ARGS="0"
    if [[ ! $(grep -Fxq "music" "$PREVIOUS_ISLAND_CACHE") ]]; then
        true > "$PREVIOUS_ISLAND_CACHE"
    fi
	exit 0
fi

# music display
dynamic-island-sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS=" "

# add "music" to previous island cache as a new line if it doesn't exist

if [[ ! $(grep -Fxq "music" "$PREVIOUS_ISLAND_CACHE") ]]; then
	echo "music" >> "$PREVIOUS_ISLAND_CACHE"
fi
