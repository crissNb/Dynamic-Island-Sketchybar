#!/usr/bin/env/bash
if [[ $P_DYNAMIC_ISLAND_MUSIC_ENABLED == 1 ]]; then
    dynamic-island-sketchybar --animate tanh 10 --set island.small_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_ICON_HIDDEN" \
        --animate tanh 10 --set island.music_visualizer label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
fi

sleep 0.2

if [[ $P_DYNAMIC_ISLAND_MUSIC_ENABLED == 1 ]]; then
    dynamic-island-sketchybar --set island.music_visualizer drawing=off \
        --set island.small_artwork drawing=off
fi
