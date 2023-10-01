#!/usr/bin/env bash
ARTWORK_LOCATION="$DYNAMIC_ISLAND_DIR/scripts/islands/music/artwork.jpg"

artwork=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	padding_left=5
	padding_right=0
	background.image.scale=0.12
	y_offset=0
	drawing=off
	width=50
	background.image="$ARTWORK_LOCATION"
)

title=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0"
	y_offset=-10
	padding_left=-80
	padding_right=0
	label.width=550
	drawing=off
)

artist=(
	width=0
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_left=0
	label.padding_right=0
	padding_left=-80
	padding_right=0
	label.width=550
	label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:12.0"
	label.y_offset=-30
	drawing=off
)

resume_text=(
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
	label.padding_right=0
	label.font="$P_DYNAMIC_ISLAND_FONT:Bold:12.0"
	padding_left=0
	padding_right=10
	width=30
    y_offset=-5
	drawing=off
)

visualizer=(
    drawing=off
    update_freq=0
    y_offset=-10
    label.font="$P_DYNAMIC_ISLAND_FONT:Bold:10.0"
    script="$DYNAMIC_ISLAND_DIR/scripts/islands/music/cava.sh"
	label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
)

small_artwork=(
	background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN"
	padding_left=10
	padding_right=0
	background.image.scale=0.04
	y_offset=-5
	drawing=off
	width=50
	background.image="$ARTWORK_LOCATION"
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

# idle island
dynamic-island-sketchybar --add item island.music_visualizer right \
    --set island.music_visualizer "${visualizer[@]}" \
    --add item island.small_artwork left \
    --set island.small_artwork "${small_artwork[@]}"
