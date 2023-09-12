#!/usr/bin/env/bash

appname=(
	width=10
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:12.0"
	label.y_offset=-5
	label.align=right
	padding_left=0
	padding_right=10
	drawing=off
)

applogo=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	padding_left=20
	padding_right=5
	background.image.scale="$P_DYNAMIC_ISLAND_APPSWITCH_ICON_SIZE"
	y_offset=-16
	drawing=off
)

dynamic-island-sketchybar --add item island.appname right \
	--set island.appname "${appname[@]}" \
	--add item island.applogo left \
	--set island.applogo "${applogo[@]}"
