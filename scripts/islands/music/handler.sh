#!/usr/bin/env sh

# check if music app is running
RUNNING=$(pgrep -x Music)
if [[ ! $RUNNING ]]; then
	exit 0
fi

cache="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/data/cache"

# PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
PLAYER_STATE=$(osascript "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/get_playerstate.scpt")

if [[ $(cat $cache) == 0 ]]; then
	# resume
	printf 1 > "$cache"
	bash "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/queue_island.sh" \
		"pause;" \
		"1.5;" \
		"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/pause_island.sh 1;" \
		"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/reset-resume.sh;" \
		"1.1"
	exit 0
fi

if [[ $PLAYER_STATE == "paused" ]]; then
	# paused
	printf 0 > "$cache"
	bash "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/queue_island.sh" \
		"pause;" \
		"1;" \
		"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/pause_island.sh 0;" \
		"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/reset-resume.sh;" \
		"1.1"
	exit 0
fi

# music display
bash "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/queue_island.sh" \
	"music;" \
	"3;" \
	"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/music_island.sh;" \
	"$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/reset.sh;" \
	"1.1" \
