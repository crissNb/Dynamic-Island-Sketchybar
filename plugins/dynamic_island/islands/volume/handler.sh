#!/usr/bin/env sh

cache="$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/data/cache"

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

# line 1: volume level; line 2: isDISPLAYING
IFS=';'
read -ra strarr <<< "$(cat $cache)"
LASTVOL=${strarr[0]}
DISPLAYING=${strarr[1]}
unset IFS
changed () {
	if [[ $VOLUME == $LASTVOL ]]; then
		return 1
	else
		return 0
	fi
}

if changed; then
	if [[ $MUTED != "false" ]]; then
		bash "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/volume_island.sh" $VOLUME 1 $DISPLAYING
	else
		bash "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/volume_island.sh" $VOLUME 0 $DISPLAYING
	fi

	if (( $DISPLAYING >= 1 )); then
		DISPLAYING=$((DISPLAYING+1))
	elif (( $DISPLAYING == 0 )); then
		DISPLAYING=1
	fi

	cache_data="${VOLUME};${DISPLAYING}"
	printf $cache_data > "$cache"

	sleep 1

	IFS=';'
	read -ra strarr <<< "$(cat $cache)"
	lastVol=${strarr[0]}
	DISPLAYING=${strarr[1]}
	unset IFS

	if (( $DISPLAYING > 1 )); then
		DISPLAYING=$((DISPLAYING-1))
		cache_data="${VOLUME};${DISPLAYING}"
		printf $cache_data > "$cache"
		exit 0
	fi

	source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/volume/reset.sh"

	DISPLAYING=0
	cache_data="${VOLUME};${DISPLAYING}"
	printf $cache_data > "$cache"
fi
