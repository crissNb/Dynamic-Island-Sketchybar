#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/brightness.sh"
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/icons.sh"

args=$*
IFS='|'
read -ra strarr <<< "$args"
unset IFS

# $1 - override
# $2 - front app name
override="${strarr[0]}"
brightness="${strarr[1]}"

# calculate brightness logo
case $brightness in
	100) ICON=$BRIGHTNESS_HIGH;;
	9[0-9]) ICON=$BRIGHTNESS_HIGH;;
	8[0-9]) ICON=$BRIGHTNESS_HIGH;;
	7[0-9]) ICON=$BRIGHTNESS_HIGH;;
	6[0-9]) ICON=$BRIGHTNESS_HIGH;;
	5[0-9]) ICON=$BRIGHTNESS_HIGH;;
	4[0-9]) ICON=$BRIGHTNESS_HIGH;;
	3[0-9]) ICON=$BRIGHTNESS_LOW;;
	2[0-9]) ICON=$BRIGHTNESS_LOW;;
	1[0-9]) ICON=$BRIGHTNESS_LOW;;
	[0-9]) ICON=$BRIGHTNESS_LOW;;
	*) ICON=$BRIGHTNESS_LOW
esac

if [[ $override == "0" ]]; then
	#create brightness items
	sketchybar --set island	   popup.drawing=true \
							   popup.horizontal=off \
							   background.drawing=false \
							   popup.height=$DEFAULT_HEIGHT \
			   --add item     island.placeholder1 popup.island	\
			   --set island.placeholder1 width=192			\
									  background.height=2 \
									  background.color=$TRANSPARENT \
									  background.border_color=$TRANSPARENT \
									  background.corner_radius=$DEFAULT_CORNER_RADIUS \
									  background.padding_left=5 \
									  background.padding_right=6 \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
			   --add item     island.placeholder2 popup.island	\
			   --set island.placeholder2 width=10			\
									  background.height=2 \
									  background.color=$TRANSPARENT \
									  background.border_color=$TRANSPARENT \
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
			   --add item	   island.brightness_icon popup.island \
			   --set island.brightness_icon icon="$ICON"			\
										icon.color=$TRANSPARENT_LABEL \
										icon.font="$FONT:Bold:14.0" \
										icon.y_offset=2 \
										icon.padding_left=10 \
										icon.padding_right=0 \
										width=20		\
			   --add item	   island.brightness_bar popup.island \
			   --set island.brightness_bar background.height=2		\
									  width=10					\
									  background.color=$TRANSPARENT_LABEL \
									  background.border_color=$TRANSPARENT_LABEL \
									  background.y_offset=0 \
									  background.shadow.drawing=off \
									  background.padding_left=10 \
									  background.padding_right=10
fi

if [[ $override == "0" ]]; then
	sketchybar --animate sin 15 --set island.placeholder1 width=$SQUISH_WIDTH width=$MAX_EXPAND_SQUISH_WIDTH width=$MAX_EXPAND_WIDTH \
			   --animate sin 20 --set island popup.background.corner_radius=$CORNER_RAD \
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$EXPAND_HEIGHT
else
	sketchybar --animate sin 15 --set island.placeholder1 width=$MAX_EXPAND_SQUISH_WIDTH width=$MAX_EXPAND_WIDTH \
			   --animate sin 20 --set island popup.background.corner_radius=$CORNER_RAD \
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$EXPAND_HEIGHT
fi

barWidth=$(bc -l <<< "$brightness/100*240")
barWidth=$( printf "%.0f" $barWidth )
sketchybar --animate tanh 15 --set island.brightness_bar width=$barWidth

sketchybar --animate sin 10 --set island.brightness_bar background.color=$DEFAULT_LABEL \
		   --animate sin 10 --set island.brightness_bar background.border_color=$DEFAULT_LABEL \
		   --animate sin 10 --set island.brightness_icon icon.color=$NORMAL_ICON_COLOR

sleep 0.8

sketchybar --animate tanh 20 --set island.brightness_icon icon.color=$TRANSPARENT_LABEL \
		   --animate tanh 20 --set island.brightness_bar background.color=$TRANSPARENT_LABEL

sleep 0.2

sketchybar --set island.brightness_bar width=10

sketchybar --animate tanh 20 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate tanh 20 --set island.placeholder1 width=$SQUISH_WIDTH width=$EXPAND_WIDTH \
		   --animate sin 25 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS

sleep 0.5

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/brightness/reset.sh"
