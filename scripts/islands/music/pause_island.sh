#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

args=$*
IFS='|'
read -ra strarr <<< "$args"
unset IFS

override="${strarr[0]}"
pauseStatus="${strarr[1]}"

# add
sketchybar --add item	island.resume_text popup.island \
		   --set island.resume_text	label.color=$TRANSPARENT_LABEL \
									label.padding_right=0 	\
									label.font="$FONT:Bold:11.0" \
									label.y_offset=-20		\
									background.padding_left=0 \
									background.padding_right=0 \
									width=30			\
		   --add item island.resume_bar popup.island \
		   --set island.resume_bar width=$RESUME_EXPAND_WIDTH \
								   background.height=$DEFAULT_HEIGHT \
								   background.color=$TRANSPARENT_LABEL \
								   background.border_color=$TRANSPARENT_LABEL \
								   background.corner_radius=$DEFAULT_CORNER_RADIUS \
								   background.padding_left=0 \
								   background.padding_right=0 \
								   background.y_offset=0 \
								   background.shadow.drawing=off \
		   --set island		popup.drawing=true \
							background.drawing=false \
							popup.horizontal=on
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
sketchybar --animate sin 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$RESUME_MAX_EXPAND_SQUISH_WIDTH width=$RESUME_MAX_EXPAND_WIDTH\
		   --animate sin 35 --set island popup.height=$RESUME_MAX_EXPAND_HEIGHT popup.height=$RESUME_EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$RESUME_CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.resume_text label.color=$DEFAULT_LABEL

sleep 0.8

sketchybar --animate tanh 25 --set island.resume_text label.color=$TRANSPARENT_LABEL

sleep 0.4

sketchybar --animate tanh 25 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate tanh 30 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$RESUME_EXPAND_WIDTH

sleep 0.7

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/reset-resume.sh"
