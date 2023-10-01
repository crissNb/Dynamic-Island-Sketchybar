#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_NOTIFICATION_MAX_EXPAND_WIDTH))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# 1 - override
# 2 - title
# 3 - subtitle
# 4 - message - message1
# 5 - app bundle identifier
override="${strarr[0]}"
title="${strarr[1]}"
subtitle="${strarr[2]}"
message="${strarr[3]}"
appId="${strarr[4]%% *}"

logo=(
	drawing=on
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	background.image="app.$appId"
	width=50
)

# Enable
dynamic-island-sketchybar --set island.notification_title drawing=on \
	label="$title" \
	--set island.notification_subtitle drawing=on \
	label="$subtitle" \
	--set island.notification_body drawing=on \
	label="$message" \
	--set island.notification_logo "${logo[@]}" \

target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$EXPAND_SIZE" \
	--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT" \
	--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_NOTIFICATION_CORNER_RAD"

sleep 0.45
dynamic-island-sketchybar --animate sin 20 --set island.notification_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 20 --set island.notification_subtitle label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 20 --set island.notification_body label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 20 --set island.notification_logo background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 2.25

dynamic-island-sketchybar --animate tanh 20 --set island.notification_title label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 20 --set island.notification_subtitle label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 20 --set island.notification_body label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 20 --set island.notification_logo background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"

sleep 0.15

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"

sleep 0.7

source "$DYNAMIC_ISLAND_DIR/scripts/islands/notification/reset.sh"
