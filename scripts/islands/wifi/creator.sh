#!/usr/bin/env/sh
dynamic-island-sketchybar --add item island.wifi_ssid right \
		   --set island.wifi_ssid		width=0 \
										label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
										label.font="$P_DYNAMIC_ISLAND_FONT:Bold:12.0" \
										label.y_offset=-5 \
										label.align=right \
										padding_left=0 \
										padding_right=10 \
										drawing=off \
		   --add item island.wifi_icon 	left \
		   --set island.wifi_icon 		label.color=$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT \
									    label.font="$P_DYNAMIC_ISLAND_FONT:Bold:12.0" \
										y_offset=-5 \
                                        padding_right=10 \
										drawing=off
