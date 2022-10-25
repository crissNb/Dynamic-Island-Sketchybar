#!/usr/bin/env sh
case "$SENDER" in
  "front_app_switched")
	  sketchybar --trigger dynamic_island_queue INFO="appswitch" ISLAND_ARGS="$INFO"
  ;;
esac
