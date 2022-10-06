#!/usr/bin/env sh

case "$SENDER" in
  "front_app_switched") bash "$HOME/.config/sketchybar/plugins/dynamic_island/queue_island.sh"  \
	  "appswitch;" \
	  "1;" \
	  "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/appswitch_island.sh $INFO;" \
	  "$HOME/.config/sketchybar/plugins/dynamic_island/islands/appswitch/reset.sh;" \
	  "0.6" \
  ;;
esac
