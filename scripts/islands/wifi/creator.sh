#!/usr/bin/env/sh
dynamic-island-sketchybar --add item island.wifi_ssid right \
		   --set island.wifi_ssid		width=0 \
										label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
										label.padding_left=0 \
										label.padding_right=0 \
										label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0" \
										label.y_offset=-17 \
										label.align=right \
										background.padding_left=5 \
										background.padding_right=0 \
										drawing=off \
		   --add item island.wifi_icon 	left \
		   --set island.wifi_icon 		label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
									    label.font="$P_DYNAMIC_ISLAND_FONT:Bold:14.0" \
										y_offset=-17 \
										drawing=off
