#!/usr/bin/env bash

USER_CONFIG="$HOME/.config/sketchybar/userconfig.sh"
test -f "$USER_CONFIG" && source "$USER_CONFIG"

sketchy_bar=(
	height=32
	color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	shadow=off
	position=top
	sticky=on
	padding_right=$((10 - "$P_DYNAMIC_ISLAND_PADDINGS"))
	topmost="${P_DYNAMIC_ISLAND_TOPMOST:=off}"
	padding_left=18
	corner_radius=9
	y_offset=0
	margin=10
	blur_radius=30
	notch_width=0
)

sketchy_default=(
	updates=when_shown
	icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	icon.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
	icon.padding_left="$P_DYNAMIC_ISLAND_PADDINGS"
	icon.padding_right="$P_DYNAMIC_ISLAND_PADDINGS"
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:13.0"
	label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE"
	label.padding_left="$P_DYNAMIC_ISLAND_PADDINGS"
	label.padding_right="$P_DYNAMIC_ISLAND_PADDINGS"
	background.padding_right="$P_DYNAMIC_ISLAND_PADDINGS"
	background.padding_left="$P_DYNAMIC_ISLAND_PADDINGS"
	popup.background.corner_radius=11
	popup.background.shadow.drawing=off
	popup.background.border_width=2
	popup.horizontal=on
)

# Setting up the general bar appearance and default values
sketchybar --bar "${sketchy_bar[@]}" \
	--default "${sketchy_default[@]}"
