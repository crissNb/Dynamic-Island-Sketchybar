#!/usr/bin/env/bash

power_text=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	label.y_offset=-17
	label.align=right
	padding_left=0
	padding_right=10
	drawing=off
)

power_icon=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	y_offset=-17
	drawing=off
)

dynamic-island-sketchybar --add item island.power_text right \
	--set island.power_text "${power_text[@]}" \
	--add item island.power_icon left \
	--set island.power_icon "${power_icon[@]}"
