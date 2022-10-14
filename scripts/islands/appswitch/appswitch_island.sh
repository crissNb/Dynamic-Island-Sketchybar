#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/appswitch.sh"

args=$*
IFS='|'
read -ra strarr <<< "$args"
unset IFS

# $1 - front app name
# $2 - override
appName="${strarr[0]}"
override="${strarr[1]}"
BUNDLENAME=$(osascript -e "id of app \"$appName\"")

if [[ $override == " 0" ]]; then
	sketchybar --add item island.appname popup.island \
			   --set island.appname		width=0 \
										label.color=$TRANSPARENT_LABEL \
										label.padding_left=0 \
										label.padding_right=0 \
										label.font="$FONT:Bold:14.0" \
										label.y_offset=-17 \
										label.align=right \
										background.padding_left=5 \
										background.padding_right=0 \
			   --add item island.appbackground popup.island \
			   --set island.appbackground width=$EXPAND_WIDTH \
									   background.height=$DEFAULT_HEIGHT \
									   background.color=$TRANSPARENT \
									   background.border_color=$TRANSPARENT \
									   background.corner_radius=$DEFAULT_CORNER_RADIUS \
									   background.padding_left=0 \
									   background.padding_right=0 \
									   background.y_offset=0 \
									   background.shadow.drawing=off \
			   --add item island.applogo popup.island \
			   --set island.applogo background.color=$ICON_HIDDEN \
								 background.padding_left=20 \
								 background.padding_right=5 \
								 background.image.scale=$ICON_SIZE \
								 y_offset=-16 \
			   --set island		popup.drawing=true \
								background.drawing=false \
								popup.horizontal=on
fi

sketchybar --set island.appname		label="$appName" \
		   --set island.applogo 	background.image="app.$BUNDLENAME"

if [[ $override == " 0" ]]; then
	sketchybar --animate sin 15 --set island.appbackground width=$SQUISH_WIDTH width=$MAX_EXPAND_SQUISH_WIDTH width=$MAX_EXPAND_WIDTH\
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$EXPAND_HEIGHT \
			   --animate sin 20 --set island popup.background.corner_radius=$CORNER_RAD
else
	sketchybar --animate sin 15 --set island.appbackground width=$MAX_EXPAND_SQUISH_WIDTH width=$MAX_EXPAND_WIDTH\
			   --animate sin 20 --set island popup.height=$MAX_EXPAND_HEIGHT popup.height=$EXPAND_HEIGHT \
			   --animate sin 20 --set island popup.background.corner_radius=$CORNER_RAD
fi

sleep 0.2

sketchybar --animate sin 15 --set island.appname label.color=$DEFAULT_LABEL \
		   --animate sin 15 --set island.applogo background.color=$TRANSPARENT_LABEL
