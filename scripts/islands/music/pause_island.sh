#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"

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
if [[ $1 == 0 ]]; then
	# paused
	sketchybar --set island.resume_text label="Paused" \
					 					label.padding_left=0
else
	# resume
	sketchybar --set island.resume_text label="Resumed" \
					 					label.padding_left=235
fi

# animate
sketchybar --animate sin 20 --set island.resume_bar width=$RESUME_SQUISH_WIDTH width=$RESUME_MAX_EXPAND_SQUISH_WIDTH width=$RESUME_MAX_EXPAND_WIDTH\
		   --animate sin 35 --set island popup.height=$RESUME_MAX_EXPAND_HEIGHT popup.height=$RESUME_EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$RESUME_CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.resume_text label.color=$DEFAULT_LABEL
