#!/usr/bin/env sh

sketchybar --add item	  island.notification_title popup.island \
		   --set island.notification_title	  width=0 			\
		   						  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  label="$title" \
								  label.font="$FONT:Bold:16.0" \
								  label.y_offset=12 \
								  background.height=0 \
								  background.padding_left=12 \
								  background.padding_right=0 \
								  drawing=off \
		   --add item	  island.notification_subtitle popup.island \
		   --set island.notification_subtitle  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  width=0 \
								  label="$subtitle" \
								  label.font="$FONT:Italic:14.0" \
								  label.y_offset=-7 \
								  drawing=off \
		   --add item	  island.notification_body popup.island \
		   --set island.notification_body	  label.color=$TRANSPARENT_LABEL \
								  label.padding_left=0 \
								  label.padding_right=0 \
								  background.padding_left=0 \
								  background.height=0 \
								  background.padding_right=0 \
								  label.font="$FONT:Semibold:14.0" \
								  label="$message" \
								  label.y_offset=-40 \
								  label.width=$MAX_ALLOWED_BODY \
								  width=0 \
								  drawing=off \
		   --add item     island.notification_expanding popup.island	\
		   --set island.notification_expanding width=$EXPAND_WIDTH			\
		   						  background.height=0 \
								  background.color=$TRANSPARENT \
								  background.border_color=$TRANSPARENT \
								  background.corner_radius=$DEFAULT_CORNER_RADIUS \
								  background.padding_left=0 \
								  background.padding_right=0 \
								  background.y_offset=0 \
								  background.shadow.drawing=off \
								  drawing=off \
		   --add item	  island.notification_logo popup.island \
		   --set island.notification_logo background.color=$ICON_HIDDEN \
							 background.padding_left=20 \
							 background.padding_right=62 \
							 background.image.scale=0.9 \
							 background.image="app.$appId" \
							 background.height=0 \
							 y_offset=-10 \
							 width=0 \
							 drawing=off
