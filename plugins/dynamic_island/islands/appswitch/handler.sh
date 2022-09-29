#!/usr/bin/env sh

case "$SENDER" in
  "front_app_switched") source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/appswitch_island.sh" $INFO
  ;;
esac
