#!/usr/bin/env sh
volume="$INFO"
bash "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/queue_island.sh" \
   "volume;" \
   "1;$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/volume/volume_island.sh $volume|;$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/volume/reset.sh;0.8"
