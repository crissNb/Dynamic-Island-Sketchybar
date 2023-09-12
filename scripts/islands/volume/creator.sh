#!/usr/bin/env bash

volume_icon=(
	icon.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	icon.y_offset=2
	padding_left=10
    padding_right=0
	width=0
	drawing=off
)

volume_bar=(
	background.height=2
	background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	background.border_color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	background.y_offset=0
	background.shadow.drawing=off
	drawing=off
    y_offset=-19
    padding_left=10
)

dynamic-island-sketchybar --add item island.volume_icon left \
	--set island.volume_icon "${volume_icon[@]}" \
	--add item island.volume_bar left \
	--set island.volume_bar "${volume_bar[@]}"
