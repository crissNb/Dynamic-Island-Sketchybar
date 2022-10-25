#!/usr/bin/env sh

# $1 status

# run python script to check for notifications
NotificationCheckScript="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/FetchNotifications.py"

pkill -f $NotificationCheckScript

if [[ $1 == 0 ]]; then
	exit 0
fi

NOTIFICATION_DATABASE="$(lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print $NF }' | grep 'db2/db$' | xargs dirname)/db"

 python3 $NotificationCheckScript $NOTIFICATION_DATABASE &
