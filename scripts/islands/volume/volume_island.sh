#!/usr/bin/env bash
source "$HOME/.config/dis-userconfig/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_VOLUME_EXPAND_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT / 2)))

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
	island=(
		popup.drawing=true
		background.drawing=false
		popup.horizontal=off
		popup.height="$P_DYNAMIC_ISLAND_VOLUME_DEFAULT_HEIGHT"
	)

	# enable
	dynamic-island-sketchybar --set island.volume_placeholder1 drawing=on \
		--set island.volume_placeholder2 drawing=on \
		--set island.volume_placeholder3 drawing=on \
		--set island.volume_icon drawing=on \
		icon="$ICON" \
		--set island.volume_bar drawing=on \
		--set island "${island[@]}"
fi

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --animate sin 15 --set island.volume_placeholder1 width="$SQUISH_WIDTH" width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH" \
		--animate sin 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD" \
		--animate sin 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT"
else
	dynamic-island-sketchybar --animate sin 15 --set island.volume_placeholder1 width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH" \
		--animate sin 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD" \
		--animate sin 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT"
fi

barWidth=$(bc -l <<<"$volume/100*240")
barWidth=$(printf "%.0f" "$barWidth")
dynamic-island-sketchybar --animate tanh 15 --set island.volume_bar width="$barWidth"

dynamic-island-sketchybar --animate sin 10 --set island.volume_bar background.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.volume_bar background.border_color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 10 --set island.volume_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 20 --set island.volume_icon icon.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 20 --set island.volume_bar background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.2

dynamic-island-sketchybar --set island.volume_bar width=10

dynamic-island-sketchybar --animate tanh 20 --set island popup.height="$P_DYNAMIC_ISLAND_VOLUME_DEFAULT_HEIGHT" \
	--animate tanh 20 --set island.volume_placeholder1 width=$SQUISH_WIDTH width="$P_DYNAMIC_ISLAND_VOLUME_EXPAND_WIDTH" \
	--animate sin 25 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS"

sleep 0.5
source "$DYNAMIC_ISLAND_DIR/scripts/islands/volume/reset.sh"
