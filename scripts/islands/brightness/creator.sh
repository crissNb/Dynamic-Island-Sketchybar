#!/usr/bin/env sh

#create brightness items
sketchybar --set island popup.height=$P_DYNAMIC_ISLAND_BRIGHTNESS_DEFAULT_HEIGHT \
		   --add item     island.brightness_placeholder1 popup.island	\
		   --set island.brightness_placeholder1 width=192			\
								  background.height=2 \
								  background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
								  background.padding_left=5 \
								  background.padding_right=6 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  drawing=off \
		   --add item     island.brightness_placeholder2 popup.island	\
		   --set island.brightness_placeholder2 width=10			\
								  background.height=2 \
								  background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
								  background.padding_left=5 \
								  background.padding_right=6 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  drawing=off \
		   --add item     island.brightness_placeholder3 popup.island	\
		   --set island.brightness_placeholder3 width=10			\
								  background.height=1 \
								  background.color=$P_DYNAMIC_ISLAND_COLOR_BLACK \
								  background.border_color=$P_DYNAMIC_ISLAND_COLOR_BLACK \
								  background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
								  background.padding_left=5 \
								  background.padding_right=5 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  drawing=off \
		   --add item	   island.brightness_icon popup.island \
		   --set island.brightness_icon icon="$ICON"			\
									icon.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
									icon.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0" \
									icon.y_offset=2 \
									icon.padding_left=10 \
									icon.padding_right=0 \
									width=20		\
									drawing=off \
		   --add item	   island.brightness_bar popup.island \
		   --set island.brightness_bar background.height=2		\
								  width=10					\
								  background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  background.padding_left=10 \
								  background.padding_right=10 \
								  drawing=off
