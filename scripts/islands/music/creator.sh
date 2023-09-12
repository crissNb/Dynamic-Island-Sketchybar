#!/usr/bin/env bash

artwork=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	background.padding_left=20
	background.padding_right=3
	background.image.scale=0.08
	y_offset=-15
	drawing=off
	width=50
)

title=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:16.0"
	label.y_offset=-20
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
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:14.0"
	label.y_offset=-40
	drawing=off
)

resume_text=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:11.0"
	label.y_offset=-20
	background.padding_left=0
	background.padding_right=0
	width=30
	drawing=off
)

# music island
dynamic-island-sketchybar --add item island.music_artwork \
	--set island.music_artwork "${artwork[@]}" \
	--add item island.music_title \
	--set island.music_title "${title[@]}" \
	--add item island.music_artist \
	--set island.music_artist "${artist[@]}" \

# pause island
dynamic-island-sketchybar --add item island.resume_text \
	--set island.resume_text "${resume_text[@]}" \
	--add item island.resume_bar \
