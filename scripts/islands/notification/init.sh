#!/usr/bin/env sh

NOTIFICATION_DATABASE="$(lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print $NF }' | grep 'db2/db$' | xargs dirname)/db"

# run python script to check for notifications
NotificationCheckScript="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/notification/FetchNotifications.py"

pkill -f $NotificationCheckScript
python3 $NotificationCheckScript $NOTIFICATION_DATABASE &
