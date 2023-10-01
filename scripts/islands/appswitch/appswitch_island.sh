#!/usr/bin/env bash
source "$DYNAMIC_ISLAND_DIR/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT / 2)))

args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - front app name
override="${strarr[0]}"
appName="${strarr[1]}"
BUNDLENAME=$(osascript -e "id of app \"$appName\"")

if [[ $override == "0" ]]; then
	dynamic-island-sketchybar --set island.appname drawing=on \
		--set island.applogo drawing=on
fi

dynamic-island-sketchybar --set island.appname label="$appName"

# determine expand width based on the character length
char_length=${#appName}
expand_size=$(bc -l <<<"$P_DYNAMIC_ISLAND_APPSWITCH_MAX_EXPAND_WIDTH+$char_length*7")
expand_squish=$(($expand_size + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

expand_size_margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $expand_size))
expand_squish_margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $expand_squish))


if [[ $override == "0" ]]; then

    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

	dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$expand_squish_margin" margin="$expand_size_margin" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD"
else
	dynamic-island-sketchybar --animate tanh 10 --bar margin="$expand_squish_margin" margin="$expand_size_margin" \
		--animate tanh 10 --bar height="$MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD"
fi

sleep 0.1

dynamic-island-sketchybar --animate sin 15 --set island.appname label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 15 --set island.applogo background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.8

dynamic-island-sketchybar --animate tanh 15 --set island.appname label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.applogo background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"

sleep 0.1

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"
sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/reset.sh"
