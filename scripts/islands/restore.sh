#!/usr/bin/env/bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"

dynamic-island-sketchybar --animate tanh 20 --bar height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
    --animate sin 25 --bar corner_radius="$P_DYNAMIC_ISLAND_CORNER_RADIUS" \
    --animate tanh 25 --bar margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT)) margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH))

dynamic-island-sketchybar --animate tanh 20 --bar height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH))
