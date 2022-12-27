#!/usr/bin/env sh
source "$HOME/.config/sketchybar/userconfig.sh"

RESUME_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_WIDTH-$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
RESUME_MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH+$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
RESUME_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT+$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

args=$*
IFS='|'
read -ra strarr <<< "$args"
unset IFS

override="${strarr[0]}"
pauseStatus="${strarr[1]}"

# enable
sketchybar --set island.resume_text drawing=on \
		   --set island.resume_bar drawing=on \
		   --set island		popup.drawing=true \
							background.drawing=false \
							popup.horizontal=on \
							popup.height=$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT

if [[ $pauseStatus == "0" ]]; then
	# paused
	sketchybar --set island.resume_text label="Paused" \
					 					label.padding_left=0
else
	# resume
	sketchybar --set island.resume_text label="Resumed" \
					 					label.padding_left=258
fi

# animate
sketchybar --animate sin 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$RESUME_MAX_EXPAND_SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH \
		   --animate sin 35 --set island popup.height=$RESUME_MAX_EXPAND_HEIGHT popup.height=$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.resume_text label.color=$P_DYNAMIC_ISLAND_COLOR_WHITE

sleep 0.8

sketchybar --animate tanh 25 --set island.resume_text label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT

sleep 0.4

sketchybar --animate tanh 20 --set island popup.height=$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT \
		   --animate tanh 30 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_WIDTH

sleep 0.7

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/reset-resume.sh"
