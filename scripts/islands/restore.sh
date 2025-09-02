#!/usr/bin/env/bash
PREVIOUS_ISLAND_CACHE="$DYNAMIC_ISLAND_DIR/scripts/islands/previous_island"

# Ensure cache file exists
if [[ ! -f "$PREVIOUS_ISLAND_CACHE" ]]; then
    touch "$PREVIOUS_ISLAND_CACHE"
fi

dynamic-island-sketchybar --animate tanh 10 --bar height="$P_DYNAMIC_ISLAND_DEFAULT_HEIGHT" \
    --animate sin 10 --bar corner_radius="$P_DYNAMIC_ISLAND_CORNER_RADIUS" 2>/dev/null || {
    echo "Warning: Failed to animate bar during restore" >&2
}

TARGET_WIDTH="$P_DYNAMIC_ISLAND_DEFAULT_WIDTH"

while IFS= read -r line
do
  if [[ $line == "music" ]]; then
    if [[ $TARGET_WIDTH -lt $P_DYNAMIC_ISLAND_MUSIC_IDLE_EXPAND_WIDTH ]]; then
        TARGET_WIDTH="$P_DYNAMIC_ISLAND_MUSIC_IDLE_EXPAND_WIDTH"
    fi
  fi
done < "$PREVIOUS_ISLAND_CACHE"

dynamic-island-sketchybar --animate tanh 10 --bar margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $TARGET_WIDTH + $P_DYNAMIC_ISLAND_SQUISH_AMOUNT)) margin=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $TARGET_WIDTH)) 2>/dev/null || {
    echo "Warning: Failed to animate bar margin during restore" >&2
}

sleep 0.2

# Restore elements
while IFS= read -r line
do
    echo "$line"
  if [[ $line == "music" ]]; then
      dynamic-island-sketchybar --set island.music_visualizer drawing=on \
                                --set island.small_artwork drawing=on 2>/dev/null || {
          echo "Warning: Failed to show music island elements during restore" >&2
      }

      dynamic-island-sketchybar --animate tanh 10 --set island.music_visualizer label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
          --animate tanh 10 --set island.small_artwork background.image.scale=1 2>/dev/null || {
          echo "Warning: Failed to animate music island elements during restore" >&2
      }
  fi
done < "$PREVIOUS_ISLAND_CACHE"
