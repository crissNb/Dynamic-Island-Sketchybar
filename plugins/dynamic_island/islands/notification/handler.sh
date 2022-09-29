#!/usr/bin/env sh

NOTIFICATION_DATABASE="/private/var/folders/fp/..."
# CHANGE THIS LINE ^^^^^^^^^^^^^

cache="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications"
changed="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications_changed"
lastLine="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications_last"
lastNotifCount="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications_count_last"

# fetch notifications
python3 $HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/FetchNotifications.py $NOTIFICATION_DATABASE $cache $lastLine

changed () {
	if cmp -s "$lastLine" "$changed"; then
		return 1
	else
		return 0
	fi
}

# determine current notification count
curNotifCount="$(wc -l $cache | awk '{ print $1 }')"

if changed $cache; then
	# check if there is a new notification
	if [ "$curNotifCount" -gt $(cat $lastNotifCount) ]; then
		# new notification present
		# format:  Time[0] 	Shown[1]	Bundle[2] 	 AppPath[3]	UUID[4]	Title[5]	SubTitle[6]	Message[7]
		notif=$(cat $lastLine)

		# format notif
		IFS=';'
		read -ra strarr <<< "$notif"

		source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/notification_island.sh" ${strarr[5]} ${strarr[6]} ${strarr[7]} ${strarr[2]}
		# copy last line to changed
		printf $curNotifCount > "$lastNotifCount"
		cp $lastLine $changed

		sleep 3

		source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/reset.sh"
	else
		cp $lastLine $changed
		printf $curNotifCount > "$lastNotifCount"
	fi
fi
