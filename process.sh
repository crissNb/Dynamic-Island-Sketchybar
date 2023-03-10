#!/usr/bin/env bash
# provided "arguments":
# $IDENTIFIER - identifier of the dynamic island element
# $OVERRIDE - whether or not to override the existing dynamic island element
# $ARGS - necessary arguments to activate the dynamic island element
export DYNAMIC_ISLAND_DIR
DYNAMIC_ISLAND_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

ISLAND_DIR="$DYNAMIC_ISLAND_DIR/scripts/islands"

case $IDENTIFIER in
"appswitch")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/appswitch/appswitch_island.sh"
	fi
	# arg: app name
	bash "$ISLAND_DIR/appswitch/appswitch_island.sh" "$OVERRIDE|$ARGS"
	;;
"volume")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/volume/volume_island.sh"
	fi
	# arg: volume amt
	bash "$ISLAND_DIR/volume/volume_island.sh" "$OVERRIDE|$ARGS"
	;;
"brightness")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/brightness/brightness_island.sh"
	fi
	# arg: volume amt
	bash "$ISLAND_DIR/brightness/brightness_island.sh" "$OVERRIDE|$ARGS"
	;;
"pause")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/music/pause_island.sh"
	fi
	# arg: pause status
	bash "$ISLAND_DIR/music/pause_island.sh" "$OVERRIDE|$ARGS"
	;;
"wifi")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/wifi/wifi_island.sh"
	fi
	# arg: wifi details
	bash "$ISLAND_DIR/wifi/wifi_island.sh" "$OVERRIDE|$ARGS"
	;;
"power")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/power/power_island.sh"
	fi
	# arg: connection type
	bash "$ISLAND_DIR/power/power_island.sh" "$OVERRIDE|$ARGS"
	;;
"music")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/music/music_island.sh"
	fi
	# arg: none
	bash "$ISLAND_DIR/music/music_island.sh" "$OVERRIDE"
	;;
"notifications")
	if [[ $OVERRIDE == 1 ]]; then
		pkill -f "$ISLAND_DIR/notification/notification_island.sh"
	fi
	# args: notification details
	bash "$ISLAND_DIR/notification/notification_island.sh" "$OVERRIDE|$ARGS"
	;;
esac
