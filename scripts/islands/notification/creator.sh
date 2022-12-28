#!/usr/bin/env sh

sketchybar --add item	  island.notification_title popup.island \
		   --set island.notification_title	  width=0 			\
		   						  label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  label.font="$P_DYNAMIC_ISLAND_FONT:Bold:16.0" \
								  label.y_offset=-6 \
								  background.height=0 \
								  background.padding_left=12 \
								  background.padding_right=0 \
								  drawing=off \
		   --add item	  island.notification_subtitle popup.island \
		   --set island.notification_subtitle  label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.height=0 \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  width=0 \
								  label.font="$P_DYNAMIC_ISLAND_FONT:Italic:12.0" \
								  label.y_offset=-24 \
								  drawing=off \
		   --add item	  island.notification_body popup.island \
		   --set island.notification_body	  label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.padding_left=0 \
								  background.height=0 \
								  background.padding_right=0 \
								  label.font="$P_DYNAMIC_ISLAND_FONT:Semibold:14.0" \
								  label.y_offset=-43 \
								  label.width=$P_DYNAMIC_ISLAND_NOTIFICATION_MAX_ALLOWED_BODY \
								  width=0 \
								  drawing=off \
		   --add item     island.notification_expanding popup.island	\
		   --set island.notification_expanding width=$P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_WIDTH			\
		   						  background.height=0 \
								  background.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.border_color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
								  background.corner_radius=$P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  drawing=off \
		   --add item	  island.notification_logo popup.island \
		   --set island.notification_logo background.color=$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN \
							 background.padding_left=20 \
							 background.padding_right=62 \
							 background.image.scale=0.8 \
							 background.height=0 \
							 y_offset=-10 \
							 width=0 \
							 drawing=off
