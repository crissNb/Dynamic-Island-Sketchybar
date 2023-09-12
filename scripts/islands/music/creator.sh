#!/usr/bin/env bash

artwork=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	padding_left=20
	padding_right=0
	background.image.scale=0.08
	y_offset=0
	drawing=off
	width=50
)

title=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	y_offset=0
	background.padding_left=0
	background.padding_right=0
	label.width=550
	drawing=off
)

artist=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	background.padding_left=0
	background.padding_right=0
	label.width=550
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:12.0"
	label.y_offset=-20
	drawing=off
)

resume_text=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:12.0"
	padding_left=0
	padding_right=10
	width=30
	drawing=off
)

# music island
dynamic-island-sketchybar --add item island.music_artwork left \
	--set island.music_artwork "${artwork[@]}" \
	--add item island.music_title center \
	--set island.music_title "${title[@]}" \
	--add item island.music_artist center \
	--set island.music_artist "${artist[@]}" \

# pause island
dynamic-island-sketchybar --add item island.resume_text right \
	--set island.resume_text "${resume_text[@]}"
