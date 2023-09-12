#!/usr/bin/env bash

title=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:16.0"
	label.y_offset=-6
	background.height=0
	background.padding_left=12
	background.padding_right=0
	drawing=off
)

subtitle=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	background.height=0
	background.padding_left=0
	background.padding_right=0
	width=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Italic:12.0"
	label.y_offset=-24
	drawing=off
)

body=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	background.padding_left=0
	background.height=0
	background.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:14.0"
	label.y_offset=-43
	label.width="$P_DYNAMIC_ISLAND_NOTIFICATION_MAX_ALLOWED_BODY"
	width=0
	drawing=off
)

logo=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	background.padding_left=20
	background.padding_right=12
	background.image.scale=0.8
	background.height=0
	y_offset=-10
	width=0
	drawing=off
)

dynamic-island-sketchybar --add item island.notification_title popup.island \
	--set island.notification_title "${title[@]}" \
	--add item island.notification_subtitle popup.island \
	--set island.notification_subtitle "${subtitle[@]}" \
	--add item island.notification_body popup.island \
	--set island.notification_body "${body[@]}" \
	--add item island.notification_logo popup.island \
	--set island.notification_logo "${logo[@]}"
