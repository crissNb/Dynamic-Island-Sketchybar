#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT / 2)))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_BRIGHTNESS_MAX_EXPAND_WIDTH))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - front app name
override="${strarr[0]}"
brightness="${strarr[1]}"

# calculate brightness logo
case $brightness in
100) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
9[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
8[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
7[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
6[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
5[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
4[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_HIGH ;;
3[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW ;;
2[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW ;;
1[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW ;;
[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW ;;
*) ICON=$P_DYNAMIC_ISLAND_ICON_BRIGHTNESS_LOW ;;
esac

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --set island.brightness_icon drawing=on icon="$ICON" \
		--set island.brightness_bar drawing=on
fi

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

    dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_BRIGHTNESS_CORNER_RAD" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT"
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_BRIGHTNESS_CORNER_RAD" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_BRIGHTNESS_EXPAND_HEIGHT"
fi

# subtract 20, because we're using padding value of 10.
barWidth=$(bc -l <<<"$brightness/100*$(($P_DYNAMIC_ISLAND_BRIGHTNESS_MAX_EXPAND_WIDTH * 2 - 20))")
barWidth=$(printf "%.0f" "$barWidth")
dynamic-island-sketchybar --animate tanh 15 --set island.brightness_bar width="$barWidth"

dynamic-island-sketchybar --animate sin 10 --set island.brightness_bar background.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.brightness_bar background.border_color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.brightness_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.brightness_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.brightness_bar background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

dynamic-island-sketchybar --animate tanh 5 --set island.brightness_bar width=0

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/brightness/reset.sh"
