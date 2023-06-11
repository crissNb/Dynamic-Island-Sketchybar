#!/usr/bin/env bash
source "$HOME/.config/dis-userconfig/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

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
	island=(
		popup.drawing=true
		background.drawing=false
		popup.horizontal=on
		popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT"
	)

	sketchybar --set island.appname drawing=on \
		--set island.appbackground drawing=on \
		--set island.applogo drawing=on \
		--set island "${island[@]}"
fi

sketchybar --set island.appname label="$appName" \
	--set island.applogo background.image="app.$BUNDLENAME"

# determine expand width based on the character length
charLength=${#appName}
expandSize=$(bc -l <<<"$P_DYNAMIC_ISLAND_APPSWITCH_MAX_EXPAND_WIDTH+$charLength*15")
expand_squish=$(($expandSize + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

if [[ $override == "0" ]]; then
	sketchybar --animate tanh 15 --set island.appbackground width="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_WIDTH" width="$expand_squish" width="$expandSize" \
		--animate tanh 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD"
else
	sketchybar --animate tanh 15 --set island.appbackground width="$expand_squish" width="$expandSize" \
		--animate tanh 20 --set island popup.height="$MAX_EXPAND_HEIGHT" popup.height="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT" \
		--animate tanh 20 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD"
fi

sleep 0.2

sketchybar --animate sin 15 --set island.appname label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate sin 15 --set island.applogo background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"

sleep 0.8

sketchybar --animate tanh 15 --set island.appname label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.applogo background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"

sleep 0.1

sketchybar --animate tanh 20 --set island popup.height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
	--animate sin 25 --set island popup.background.corner_radius="$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS" \
	--animate tanh 15 --set island.appbackground width=$SQUISH_WIDTH width="$P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_WIDTH"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/appswitch/reset.sh"
