#!/usr/bin/env bash
listener=(
	script="$DYNAMIC_ISLAND_DIR/process.sh"
	width=0
)

dynamic-island-sketchybar --add item di_helper_listener center \
	--add event di_helper_listener_event \
	--subscribe di_helper_listener di_helper_listener_event \
	--set di_helper_listener "${listener[@]}"
