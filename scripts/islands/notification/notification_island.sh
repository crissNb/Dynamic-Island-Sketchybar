#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/notifications.sh"

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

# create notification items
sketchybar --add item	  island.title popup.island \
		   --set island.title	  width=0 			\
		   						  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  label="$title" \
								  label.font="$FONT:Bold:16.0" \
								  label.y_offset=12 \
								  background.height=0 \
								  background.padding_left=12 \
								  background.padding_right=0 \
		   --add item	  island.subtitle popup.island \
		   --set island.subtitle  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  width=0 \
								  label="$subtitle" \
								  label.font="$FONT:Italic:14.0" \
								  label.y_offset=-7 \
		   --add item	  island.body popup.island \
		   --set island.body	  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.padding_left=0 \
								  background.height=0 \
								  background.padding_right=0 \
								  label.font="$FONT:Semibold:14.0" \
								  label="$message" \
								  label.y_offset=-40 \
								  label.width=$MAX_ALLOWED_BODY \
								  width=0 \
		   --add item     island.expanding popup.island	\
		   --set island.expanding width=$EXPAND_WIDTH			\
		   						  background.height=0 \
								  background.color=$TRANSPARENT \
								  background.border_color=$TRANSPARENT \
								  background.corner_radius=$DEFAULT_CORNER_RADIUS \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
		   --add item	  island.logo popup.island \
		   --set island.logo background.color=$ICON_HIDDEN \
							 background.padding_left=20 \
							 background.padding_right=62 \
							 background.image.scale=0.9 \
							 background.image="app.$appId" \
							 background.height=0 \
							 y_offset=-10 \
							 width=0 \
		   --set island      popup.drawing=true \
							 background.drawing=false \
							 popup.horizontal=on

sketchybar --animate sin 20 --set island.expanding width=$SQUISH_WIDTH width=$MAX_EXPAND_SQUISH_WIDTH width=$MAX_EXPAND_WIDTH \
		   --animate sin 35 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.title label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.subtitle label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.body label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.logo background.color=$TRANSPARENT_LABEL

sleep 2

sketchybar --animate tanh 25 --set island.title label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.subtitle label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.body label.color=$TRANSPARENT_LABEL \
		   --animate tanh 25 --set island.logo background.color=$ICON_HIDDEN

sleep 0.15

sketchybar --animate tanh 20 --set island popup.height=$DEFAULT_HEIGHT \
		   --animate tanh 25 --set island popup.background.corner_radius=$DEFAULT_CORNER_RADIUS \
		   --animate tanh 15 --set island.expanding width=$SQUISH_WIDTH width=$EXPAND_WIDTH

sleep 0.7

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/reset.sh"
