#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_icons.sh"
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/volume_island_settings.sh"

# $1 volume
# $2 muted
# $3 displaying

# calculate volume logo
case $1 in
	100) ICON=$VOLUME_MAX;;
	9[0-9]) ICON=$VOLUME_MAX;;
	8[0-9]) ICON=$VOLUME_MAX;;
	7[0-9]) ICON=$VOLUME_MAX;;
	6[0-9]) ICON=$VOLUME_MED;;
	5[0-9]) ICON=$VOLUME_MED;;
	4[0-9]) ICON=$VOLUME_MED;;
	3[0-9]) ICON=$VOLUME_LOW;;
	2[0-9]) ICON=$VOLUME_LOW;;
	1[0-9]) ICON=$VOLUME_LOW;;
	[0-9]) ICON=$VOLUME_MUTED;;
	*) ICON=$VOLUME_MUTED
esac

VOLUME_LOGO_COLOR=$NORMAL_ICON_COLOR

# check muted
if [[ "$2" == 1 ]]; then
	VOLUME_LOGO_COLOR=$MUTED_ICON_COLOR
	ICON=$VOLUME_MUTED
fi

if [[ "$3" == 0 ]]; then
	#create volume items
	sketchybar --set island	   popup.drawing=true		\
							   popup.horizontal=off \
							   background.drawing=false \
			   --add item     island.placeholder1 popup.island	\
			   --set island.placeholder1 width=192			\
									  background.height=2 \
									  background.color=$PITCH_BLACK \
									  background.border_color=$PITCH_BLACK \
									  background.corner_radius=$DEFAULT_CORNER_RADIUS \
									  background.padding_left=5 \
									  background.padding_right=6 \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
			   --add item     island.placeholder2 popup.island	\
			   --set island.placeholder2 width=10			\
									  background.height=2 \
									  background.color=$PITCH_BLACK \
									  background.border_color=$PITCH_BLACK \
									  background.corner_radius=$DEFAULT_CORNER_RADIUS \
									  background.padding_left=5 \
									  background.padding_right=6 \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
			   --add item     island.placeholder3 popup.island	\
			   --set island.placeholder3 width=10			\
									  background.height=1 \
									  background.color=$PITCH_BLACK \
									  background.border_color=$PITCH_BLACK \
									  background.corner_radius=$DEFAULT_CORNER_RADIUS \
									  background.padding_left=5 \
									  background.padding_right=5 \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
			   --add item	   island.volume_icon popup.island \
			   --set island.volume_icon icon="$ICON"			\
										icon.color=$TRANSPARENT_LABEL \
										icon.font="$FONT:Bold:14.0" \
										icon.y_offset=2 \
										icon.padding_left=10 \
										icon.padding_right=0 \
										width=20		\
			   --add item	   island.volume_bar popup.island \
			   --set island.volume_bar background.height=2		\
									  width=10					\
									  background.color=$TRANSPARENT_LABEL \
									  background.border_color=$TRANSPARENT_LABEL \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
									  background.corner_radius=23 \
									  background.padding_left=10 \
									  background.padding_right=10
	sketchybar --animate tanh 15 --set island.placeholder1 width=175 width=250
fi

sketchybar --animate sin 25 --set island popup.background.corner_radius=12 \
		   --animate sin 20 --set island popup.height=16

sleep 0.35
barWidth=$(bc -l <<< "$1/100*240")
barWidth=$( printf "%.0f" $barWidth )
sketchybar --animate tanh 15 --set island.volume_bar width=$barWidth

sketchybar --animate sin 15 --set island.volume_bar background.color=$DEFAULT_LABEL \
		   --animate sin 15 --set island.volume_bar background.border_color=$DEFAULT_LABEL \
		   --animate sin 15 --set island.volume_icon icon.color=$VOLUME_LOGO_COLOR
