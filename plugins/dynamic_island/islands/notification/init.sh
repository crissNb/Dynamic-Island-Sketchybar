#!/usr/bin/env sh

NOTIFICATION_DATABASE="/private/var/folders/..."
# CHANGE THIS LINE ^^^^^^^^^^^^^

lastLine="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications_last"
cache="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/data/notifications"

# run python script to check for notifications
NotificationCheckScript="$HOME/.config/sketchybar/plugins/dynamic_island/islands/notification/FetchNotifications.py"
pkill -f $NotificationCheckScript
python3 $NotificationCheckScript $NOTIFICATION_DATABASE $cache $lastLine &
