#!/usr/bin/env/bash

appname=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	label.y_offset=-17
	label.align=right
	background.padding_left=5
	background.padding_right=0
	drawing=off
)

applogo=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	background.padding_left=20
	background.padding_right=5
	background.image.scale="$P_DYNAMIC_ISLAND_APPSWITCH_ICON_SIZE"
	y_offset=-16
	drawing=off
)

dynamic-island-sketchybar --add item island.appname right \
	--set island.appname "${appname[@]}" \
	--add item island.applogo popup.island left \
	--set island.applogo "${applogo[@]}"
