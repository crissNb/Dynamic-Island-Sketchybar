#!/usr/bin/env/bash
PREVIOUS_ISLAND_CACHE="$HOME/.config/dynamic-island-sketchybar/scripts/islands/previous_island"

dynamic-island-sketchybar --animate tanh 10 --bar height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
    --animate sin 10 --bar corner_radius="$P_DYNAMIC_ISLAND_CORNER_RADIUS"

TARGET_WIDTH="$P_DYNAMIC_ISLAND_DEFAULT_WIDTH"

while IFS= read -r line
do
    echo "$line"
  if [[ $line == "music" ]]; then
    if [[ $TARGET_WIDTH -lt $P_DYNAMIC_ISLAND_MUSIC_IDLE_EXPAND_WIDTH ]]; then
        TARGET_WIDTH="$P_DYNAMIC_ISLAND_MUSIC_IDLE_EXPAND_WIDTH"
    fi
  fi
done < "$PREVIOUS_ISLAND_CACHE"

dynamic-island-sketchybar --animate tanh 10 --bar margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $TARGET_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT)) margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $TARGET_WIDTH))

sleep 0.2

# Restore elements
while IFS= read -r line
do
    echo "$line"
  if [[ $line == "music" ]]; then
      dynamic-island-sketchybar --set island.music_visualizer drawing=on \
                                --set island.small_artwork drawing=on

      dynamic-island-sketchybar --animate tanh 10 --set island.music_visualizer label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
          --animate tanh 10 --set island.small_artwork background.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT"
  fi
done < "$PREVIOUS_ISLAND_CACHE"
