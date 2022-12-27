#!/usr/bin/env sh
source "$HOME/.config/sketchybar/userconfig.sh"

SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_WIDTH-$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_SQUISH_WIDTH=$(($P_DYNAMIC_ISLAND_NOTIFICATION_MAX_EXPAND_WIDTH+$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))
MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT+$P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

args=$*
IFS='|'
read -ra strarr <<< "$args"
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

# Enable
sketchybar --set island.notification_title drawing=on \
		   --set island.notification_subtitle drawing=on \
		   --set island.notification_body drawing=on \
		   --set island.notification_logo drawing=on \
		   --set island.notification_expanding drawing=on \
		   --set island      popup.drawing=true \
							 background.drawing=false \
							 popup.horizontal=on \
							 popup.height=$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT

sketchybar --animate sin 20 --set island.notification_expanding width=$SQUISH_WIDTH width=$MAX_EXPAND_SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_NOTIFICATION_MAX_EXPAND_WIDTH \
		   --animate sin 35 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_NOTIFICATION_CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.notification_title label.color=$P_DYNAMIC_ISLAND_COLOR_WHITE \
		   --animate sin 25 --set island.notification_subtitle label.color=$P_DYNAMIC_ISLAND_COLOR_WHITE \
		   --animate sin 25 --set island.notification_body label.color=$P_DYNAMIC_ISLAND_COLOR_WHITE \
		   --animate sin 25 --set island.notification_logo background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT

sleep 2

sketchybar --animate tanh 25 --set island.notification_title label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
		   --animate tanh 25 --set island.notification_subtitle label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
		   --animate tanh 25 --set island.notification_body label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
		   --animate tanh 25 --set island.notification_logo background.color=$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN

sleep 0.15

sketchybar --animate tanh 20 --set island popup.height=$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT \
		   --animate tanh 25 --set island popup.background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
		   --animate tanh 15 --set island.notification_expanding width=$SQUISH_WIDTH width=$P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_WIDTH

sleep 0.7

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/reset.sh"
