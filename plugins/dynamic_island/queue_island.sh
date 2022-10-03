#!/usr/bin/env sh
queuedList="$HOME/.config/sketchybar/plugins/dynamic_island/data/queued"
override="$HOME/.config/sketchybar/plugins/dynamic_island/data/override"

# $1 - type
# $2 - duration
# $3 - command
# $4 - exit command
# $5 - exit duration
entry="$1;$2;$3;$4;$5"

validEntry=$(head -n 1 $queuedList)

if [ -n "$validEntry" ]
then
	IFS=';'
	read -ra strarr <<< "$validEntry"
	unset IFS

	if [[ ${strarr[0]} == $1 ]]
	then
		# add to queuedList
		ex -sc "1i|$entry" -cx "$queuedList"

		# override
		overrideVal=$(cat $override)
		priority="$((overrideVal + 1))"
		printf $priority > "$override"
		source "$HOME/.config/sketchybar/plugins/dynamic_island/draw.sh" $priority
		exit 0
	fi
fi


echo $entry >> $queuedList
source "$HOME/.config/sketchybar/plugins/dynamic_island/draw.sh" 0
