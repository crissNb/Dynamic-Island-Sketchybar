#!/usr/bin/env sh
volume="$INFO"
bash "$HOME/.config/sketchybar/plugins/dynamic_island/queue_island.sh" \
   "volume;" \
   "1;$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/volume_island.sh $volume|;$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/reset.sh;0.8"
