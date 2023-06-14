#!/usr/bin/env bash
source "$HOME/.config/dis-userconfig/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_BATTERY_EXPAND_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_BATTERY_MAX_EXPAND_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - connection type
override="${strarr[0]}"
power_source="${strarr[1]}"
icon=$P_DYNAMIC_ISLAND_ICON_BATTERY_ONBATTERY

if [ "$power_source" == "AC" ]; then
	icon=$P_DYNAMIC_ISLAND_ICON_BATTERY_CONNECTEDAC
fi

if [[ $override == "0" ]]; then
	island=(
		popup.drawing=true
		background.drawing=false
		popup.horizontal=on
		popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT"
	)

	dynamic-island-sketchybar --set island.power_text drawing=on \
		--set island.power_background drawing=on \
		--set island.power_icon drawing=on \
		--set island "${island[@]}"
fi

dynamic-island-sketchybar --set island.power_icon label="$icon" \
	--set island.power_text label="$power_source"

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --animate tanh 15 --set island.power_background width="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_WIDTH" width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_BATTERY_MAX_EXPAND_WIDTH" \
		--animate tanh 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_BATTERY_CORNER_RAD"
else
	dynamic-island-sketchybar --animate tanh 15 --set island.power_background width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_WIDTH" \
		--animate tanh 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_BATTERY_CORNER_RAD"
fi

sleep 0.2

dynamic-island-sketchybar --animate sin 15 --set island.power_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 15 --set island.power_icon label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.power_text label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.power_icon label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

dynamic-island-sketchybar --animate tanh 20 --set island popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
	--animate sin 25 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS" \
	--animate tanh 15 --set island.power_background width="$SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_WIDTH"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/power/reset.sh"
