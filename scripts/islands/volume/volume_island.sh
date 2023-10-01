#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT / 2)))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - volume
override="${strarr[0]}"
volume="${strarr[1]}"

# calculate volume logo
case $volume in
100) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MAX ;;
9[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MAX ;;
8[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MAX ;;
7[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MAX ;;
6[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MED ;;
5[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MED ;;
4[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MED ;;
3[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_LOW ;;
2[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_LOW ;;
1[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_LOW ;;
[0-9]) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MUTED ;;
*) ICON=$P_DYNAMIC_ISLAND_ICON_VOLUME_MUTED ;;
esac

if [[ $override == "0" ]]; then
	# enable
	dynamic-island-sketchybar --set island.volume_icon drawing=on \
		icon="$ICON" \
		--set island.volume_bar drawing=on
fi

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

    dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT"
else
    dynamic-island-sketchybar --animate tanh 10 --bar margin="$(($EXPAND_SIZE + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT"
fi

sleep 0.1

# subtract 20, because we're using padding value of 10.
barWidth=$(bc -l <<<"$volume/100*$(($P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH * 2 - 20))")
barWidth=$(printf "%.0f" "$barWidth")
dynamic-island-sketchybar --animate tanh 15 --set island.volume_bar width="$barWidth"

dynamic-island-sketchybar --animate sin 10 --set island.volume_bar background.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.volume_bar background.border_color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.volume_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.volume_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.volume_bar background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

dynamic-island-sketchybar --animate tanh 5 --set island.volume_bar width=0

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/volume/reset.sh"
