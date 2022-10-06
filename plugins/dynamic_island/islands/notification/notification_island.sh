#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/notification_island_settings.sh"

args=$*
IFS='|'
read -ra strarr <<< "$args"
unset IFS

# 0 - title
# 1 - subtitle
# 2 - message - message1
# 3 - app bundle identifier
title=${strarr[0]}
subtitle=${strarr[1]}
message=${strarr[2]}
appId=${strarr[3]%% *}

# create notification items
sketchybar --add item	  island.title popup.island \
		   --set island.title	  width=0 			\
		   						  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  label="$title" \
								  label.font="$FONT:Bold:16.0" \
								  label.y_offset=12 \
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
								  background.padding_right=0 \
								  label.font="$FONT:Semibold:14.0" \
								  label="$message" \
								  label.y_offset=-40 \
								  label.width=$MAX_ALLOWED_BODY \
								  width=50 \
		   --add item     island.expanding popup.island	\
		   --set island.expanding width=$EXPAND_SIZE			\
		   						  background.height=$DEFAULT_HEIGHT \
								  background.color=$PITCH_BLACK \
								  background.border_color=$PITCH_BLACK \
								  background.corner_radius=$DEFAULT_CORNER_RADIUS \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
		   --add item	  island.logo popup.island \
		   --set island.logo background.color=$ICON_HIDDEN \
							 background.padding_left=20 \
							 background.padding_right=12 \
							 background.image.scale=0.9 \
							 background.image="app.$appId" \
							 y_offset=-10 \
		   --set island      popup.drawing=true \
							 background.drawing=false \
							 popup.horizontal=on

sketchybar --animate sin 20 --set island.expanding width=$SQUISH_SIZE width=$MAX_EXPAND_SQUISH_SIZE width=$MAX_EXPAND_SIZE\
		   --animate sin 35 --set island popup.height=145 popup.height=140 \
		   --animate sin 35 --set island popup.background.corner_radius=42

sleep 0.45
sketchybar --animate sin 25 --set island.title label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.subtitle label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.body label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.logo background.color=$TRANSPARENT_LABEL
