#!/usr/bin/env sh

############ MODULES ############
# NOTIFICATIONS
bash "$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/handler.sh"

# VOLUME
# bash "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/handler.sh"
##################################

# draw dynamic island automatically to pop the queue:
bash "$HOME/.config/sketchybar/plugins/dynamic_island/draw.sh" 0
