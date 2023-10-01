#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_BATTERY_MAX_EXPAND_WIDTH))

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
	dynamic-island-sketchybar --set island.power_text drawing=on \
		--set island.power_icon drawing=on
fi

dynamic-island-sketchybar --set island.power_icon label="$icon" \
	--set island.power_text label="$power_source"

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

    dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_BATTERY_CORNER_RAD"
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_BATTERY_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_BATTERY_CORNER_RAD"
fi

sleep 0.1

dynamic-island-sketchybar --animate sin 15 --set island.power_text label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 15 --set island.power_icon label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.power_text label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.power_icon label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/power/reset.sh"
