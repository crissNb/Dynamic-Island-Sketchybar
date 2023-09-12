#!/usr/bin/env bash

icon=(
	icon="$ICON"
	icon.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	icon.y_offset=2
	padding_left=10
	padding_right=0
	width=0
	drawing=off
)

bar=(
	background.height=2
	background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	background.border_color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	background.y_offset=0
	background.shadow.drawing=off
	drawing=off
    y_offset=-19
    padding_left=10
)

#create brightness items
dynamic-island-sketchybar --add item island.brightness_icon left \
	--set island.brightness_icon "${icon[@]}" \
	--add item island.brightness_bar left \
	--set island.brightness_bar "${bar[@]}"
