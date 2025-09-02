#!/usr/bin/env/bash
if [[ $P_DYNAMIC_ISLAND_MUSIC_ENABLED == 1 ]]; then
    dynamic-island-sketchybar --animate tanh 10 --set island.small_artwork background.image.scale=0 \
        --animate tanh 10 --set island.music_visualizer label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" 2>/dev/null || {
        echo "Warning: Failed to animate music island elements during clear" >&2
    }
fi

sleep 0.2

if [[ $P_DYNAMIC_ISLAND_MUSIC_ENABLED == 1 ]]; then
    dynamic-island-sketchybar --set island.music_visualizer drawing=off \
        --set island.small_artwork drawing=off 2>/dev/null || {
        echo "Warning: Failed to hide music island elements during clear" >&2
    }
fi
