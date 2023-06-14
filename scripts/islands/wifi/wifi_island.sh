#!/usr/bin/env bash
source "$HOME/.config/dis-userconfig/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_WIFI_EXPAND_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_WIFI_MAX_EXPAND_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_WIFI_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - ssid
override="${strarr[0]}"
ssid="${strarr[1]}"
icon=$P_DYNAMIC_ISLAND_ICON_WIFI_CONNECTED

if [ -z "$ssid" ]; then
	icon=$P_DYNAMIC_ISLAND_ICON_WIFI_DISCONNECTED
	ssid="Disconnected"
fi

if [[ $override == "0" ]]; then
	island=(
		popup.drawing=true
		background.drawing=false
		popup.horizontal=on
		popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT"
	)
	dynamic-island-sketchybar --set island.wifi_ssid drawing=on \
		--set island.wifi_background drawing=on \
		--set island.wifi_icon drawing=on \
		--set island "${island[@]}"
fi

dynamic-island-sketchybar --set island.wifi_icon label="$icon" \
	--set island.wifi_ssid label="$ssid"

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --animate tanh 15 --set island.wifi_background width="$P_DYNAMIC_ISLAND_WIFI_EXPAND_WIDTH" width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_WIFI_MAX_EXPAND_WIDTH" \
		--animate tanh 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_WIFI_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_WIFI_CORNER_RAD"
else
	dynamic-island-sketchybar --animate tanh 15 --set island.wifi_background width="$MAX_EXPAND_SQUISH_WIDTH" width="$P_DYNAMIC_ISLAND_WIFI_EXPAND_WIDTH" \
		--animate tanh 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height="$P_DYNAMIC_ISLAND_WIFI_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_WIFI_CORNER_RAD"
fi

sleep 0.2

dynamic-island-sketchybar --animate sin 15 --set island.wifi_ssid label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 15 --set island.wifi_icon label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.wifi_ssid label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.wifi_icon label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.1

dynamic-island-sketchybar --animate tanh 20 --set island popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
	--animate sin 25 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS" \
	--animate tanh 15 --set island.wifi_background width=$SQUISH_WIDTH width="$P_DYNAMIC_ISLAND_WIFI_EXPAND_WIDTH"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/wifi/reset.sh"
