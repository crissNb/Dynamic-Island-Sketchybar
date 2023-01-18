#!/usr/bin/env sh

# music island
sketchybar --add item		island.music_artwork	 popup.island \
		   --set island.music_artwork	background.color=$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN \
										background.padding_left=20 \
										background.padding_right=3 \
										background.image.scale=0.08 \
										y_offset=-15 \
										drawing=off \
										width=50 \
		   --add item		island.music_title	popup.island \
		   --set island.music_title		width=0		\
										label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
										label.padding_left=0	\
										label.padding_right=0	\
										label.font="$P_DYNAMIC_ISLAND_FONT:Bold:16.0"	\
										label.y_offset=-20	\
										background.padding_left=0	\
										background.padding_right=0	\
										label.width=550 \
										drawing=off \
		   --add item		island.music_artist	popup.island \
		   --set island.music_artist	width=0		\
										label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT	\
										label.padding_left=0 \
										label.padding_right=0 \
										background.padding_left=0 \
										background.padding_right=0 \
										label.width=550 \
										label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:14.0" \
										label.y_offset=-40 \
										drawing=off \
		   --add item		island.music_placeholder popup.island \
		   --set island.music_placeholder width=$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH \
													 background.height=$P_DYNAMIC_ISLAND_MUSIC_INFO_DEFAULT_HEIGHT \
													 background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
													 background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
													 background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
													 background.padding_left=0 \
													 background.padding_right=0 \
													 background.y_offset=0 \
													 background.shadow.drawing=off \
													 drawing=off

# pause island
sketchybar --add item	island.resume_text popup.island \
		   --set island.resume_text	label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
									label.padding_right=0 	\
									label.font="$P_DYNAMIC_ISLAND_FONT:Bold:11.0" \
									label.y_offset=-20		\
									background.padding_left=0 \
									background.padding_right=0 \
									width=30			\
									drawing=off \
		   --add item island.resume_bar popup.island \
		   --set island.resume_bar width=$P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_WIDTH \
								   background.height=$P_DYNAMIC_ISLAND_MUSIC_RESUME_DEFAULT_HEIGHT \
								   background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								   background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								   background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
								   background.padding_left=0 \
								   background.padding_right=0 \
								   background.y_offset=0 \
								   background.shadow.drawing=off \
								   drawing=off
