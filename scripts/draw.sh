#!/usr/bin/env sh
queuedList="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/data/queued"
active="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/data/active"
override="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/data/override"

# $1 - priority settings. 0 for default, 1 to override
if [[ $1 == 0 ]]; then
	if [[ $(cat $active) == 1 ]]; then
		exit 0
	fi
else
	sed -i.bak '2d' $queuedList
fi

# read valid entry
validEntry=$(head -n 1 $queuedList)

# check if valid entry is null
if [ ! -n "$validEntry" ]
then
	exit 0
fi

IFS=';'
read -ra strarr <<< "$validEntry"
unset IFS

# read values
duration=${strarr[1]}
command=${strarr[2]}
exitCmd=${strarr[3]}
exitDur=${strarr[4]}

# set active to true
printf "1" > "$active"

# show island
bash $command $1

# time until island starts disappearing
sleep $duration

if [[ $(cat $override) > 0 ]] && [[ $1 < $(cat $override) ]]
then
	exit 0
fi

# start animating out the island
bash $exitCmd

# time until island is completely disappeared
sleep $exitDur

if [[ $(cat $override) > 0 ]] && [[ $1 < $(cat $override) ]]
then
	exit 0
fi

printf "0" > "$active"
printf "0" > "$override"

# unqueue
sed -i.bak '1d' $queuedList

# process next queue
bash "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/draw.sh" 0
