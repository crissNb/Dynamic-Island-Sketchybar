#!/bin/bash
DYNAMIC_ISLAND_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

# run helper program
ISLANDHELPER=git.crissnb.islandhelper
killall islandhelper
cd "$DYNAMIC_ISLAND_DIR"/helper/ && make
"$DYNAMIC_ISLAND_DIR"/helper/islandhelper "$ISLANDHELPER" &
