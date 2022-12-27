#!/usr/bin/env sh
source "$HOME/.config/sketchybar/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_WIDTH-$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_BRIGHTNESS_MAX_EXPAND_WIDTH+$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT+($P_DYNAMIC_ISLAND_SQUISH_AMOUNT/2)))

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
	100) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	9[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	8[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	7[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	6[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	5[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	4[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH;;
	3[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW;;
	2[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW;;
	1[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW;;
	[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW;;
	*) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW
esac

if [[ $override == "0" ]]; then
	sketchybar --set island.brightness_placeholder1 drawing=on \
			   --set island.brightness_placeholder2 drawing=on \
			   --set island.brightness_placeholder3 drawing=on \
			   --set island.brightness_icon drawing=on \
			   							icon="$ICON" \
			   --set island.brightness_bar drawing=on \
			   --set island	popup.drawing=true \
			   				background.drawing=false \
							popup.horizontal=off \
							popup.height=$P_DYNAMIC_ISLAND_BRIGHTNESS_DEFAULT_HEIGHT
fi

if [[ $override == "0" ]]; then
	sketchybar --animate sin 15 --set island.brightness_placeholder1 width=$SQUISH_WIDTH width=$MAX_EXPAND_SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_BRIGHTNESS_MAX_EXPAND_WIDTH \
			   --animate sin 20 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_BRIGHTNESS_CORNER_RAD \
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT
else
	sketchybar --animate sin 15 --set island.brightness_placeholder1 width=$MAX_EXPAND_SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_BRIGHTNESS_MAX_EXPAND_WIDTH \
			   --animate sin 20 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_BRIGHTNESS_CORNER_RAD \
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT
fi

barWidth=$(bc -l <<< "$brightness/100*240")
barWidth=$( printf "%.0f" $barWidth )
sketchybar --animate tanh 15 --set island.brightness_bar width=$barWidth

sketchybar --animate sin 10 --set island.brightness_bar background.color=$P_DYNAMIC_ISLAND_COLOR_WHITE \
		   --animate sin 10 --set island.brightness_bar background.border_color=$P_DYNAMIC_ISLAND_COLOR_WHITE \
		   --animate sin 10 --set island.brightness_icon icon.color=$P_DYNAMIC_ISLAND_COLOR_WHITE

sleep 0.8

sketchybar --animate tanh 20 --set island.brightness_icon icon.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
		   --animate tanh 20 --set island.brightness_bar background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT

sleep 0.2

sketchybar --set island.brightness_bar width=10

sketchybar --animate tanh 20 --set island popup.height=$P_DYNAMIC_ISLAND_BRIGHTNESS_DEFAULT_HEIGHT \
		   --animate tanh 20 --set island.brightness_placeholder1 width=$SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_WIDTH \
		   --animate sin 25 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS

sleep 0.5

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/brightness/reset.sh"
