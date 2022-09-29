#!/usr/bin/env sh
source "$HOME/.config/sketchybar/dynamic_island_settings.sh"
source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/music_island_settings.sh"

cache="$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/data/cache"

PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")

if [[ $(cat $cache) == 0 ]]; then
	# add
	sketchybar --add item	island.resume_text popup.island \
			   --set island.resume_text	label.color=$TRANSPARENT_LABEL \
			   							label.padding_left=235 	\
										label.padding_right=0 	\
										label="Resumed"	\
										label.font="$FONT:Bold:11.0" \
										label.y_offset=-20		\
										background.padding_left=0 \
										background.padding_right=0 \
										width=30			\
			   --add item island.resume_bar popup.island \
			   --set island.resume_bar width=$RESUME_EXPAND_SIZE \
									   background.height=$DEFAULT_HEIGHT \
									   background.color=$PITCH_BLACK \
									   background.border_color=$PITCH_BLACK \
									   background.corner_radius=$DEFAULT_CORNER_RADIUS \
									   background.padding_left=0 \
									   background.padding_right=0 \
									   background.y_offset=0 \
									   background.shadow.drawing=off \
			   --set island		popup.drawing=true \
								background.drawing=false \
								popup.horizontal=on


	# animate
	sketchybar --animate sin 20 --set island.resume_bar width=$RESUME_SQUISH_SIZE width=$MAX_RESUME_EXPAND_SQUISH_SIZE width=$MAX_RESUME_EXPAND_SIZE\
			   --animate sin 35 --set island popup.height=$RESUME_HEIGHT_SQUISH popup.height=$RESUME_HEIGHT \
			   --animate sin 35 --set island popup.background.corner_radius=$RESUME_CORNER_RADIUS

	sleep 0.45
	sketchybar --animate sin 25 --set island.resume_text label.color=$DEFAULT_LABEL

	sleep 3

	source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/reset-resume.sh"

	printf 1 > "$cache"
	exit 0
fi

if [[ $PLAYER_STATE == "paused" ]]; then
	# add
	sketchybar --add item	island.resume_text popup.island \
			   --set island.resume_text	label.color=$TRANSPARENT_LABEL \
			   							label.padding_left=0 	\
										label.padding_right=0 	\
										label="Paused"	\
										label.font="$FONT:Bold:11.0" \
										label.y_offset=-20		\
										background.padding_left=0 \
										background.padding_right=0 \
										width=30			\
			   --add item island.resume_bar popup.island \
			   --set island.resume_bar width=$RESUME_EXPAND_SIZE \
									   background.height=$DEFAULT_HEIGHT \
									   background.color=$PITCH_BLACK \
									   background.border_color=$PITCH_BLACK \
									   background.corner_radius=$DEFAULT_CORNER_RADIUS \
									   background.padding_left=0 \
									   background.padding_right=0 \
									   background.y_offset=0 \
									   background.shadow.drawing=off \
			   --set island		popup.drawing=true \
								background.drawing=false \
								popup.horizontal=on


	# animate
	sketchybar --animate sin 20 --set island.resume_bar width=$RESUME_SQUISH_SIZE width=$MAX_RESUME_EXPAND_SQUISH_SIZE width=$MAX_RESUME_EXPAND_SIZE\
			   --animate sin 35 --set island popup.height=$RESUME_HEIGHT_SQUISH popup.height=$RESUME_HEIGHT \
			   --animate sin 35 --set island popup.background.corner_radius=$RESUME_CORNER_RADIUS

	sleep 0.45
	sketchybar --animate sin 25 --set island.resume_text label.color=$DEFAULT_LABEL

	sleep 3

	source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/reset-resume.sh"

	printf 0 > "$cache"
	exit 0
fi

# fetch music info
TITLE=$(osascript -e 'tell application "Music" to get name of current track')
ARTIST=$(osascript -e 'tell application "Music" to get artist of current track')
osascript "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/get_artwork.scpt"
if [[ ${#TITLE} -gt 25 ]]; then
  TITLE=$(printf "$(echo $TITLE | cut -c 1-25)…")
fi

if [[ ${#ARTIST} -gt 25 ]]; then
  ARTIST=$(printf "$(echo $ARTIST | cut -c 1-25)…")
fi
sketchybar --add item		island.music_artwork	 popup.island \
		   --set island.music_artwork	background.color=$ICON_HIDDEN \
   									    background.padding_left=20 \
									    background.padding_right=3 \
									    background.image="$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/artwork.jpg" \
									    background.image.scale=0.1 \
									    y_offset=-15 \
		   --add item		island.music_title	popup.island \
		   --set island.music_title		width=0		\
		   								label.color=$TRANSPARENT_LABEL \
										label.padding_left=0	\
										label.padding_right=0	\
										label="$TITLE"	\
										label.font="$FONT:Bold:16.0"	\
										label.y_offset=-20	\
										background.padding_left=0	\
										background.padding_right=0	\
										label.width=550 \
		   --add item		island.music_artist	popup.island \
		   --set island.music_artist	width=0		\
		   								label.color=$TRANSPARENT_LABEL	\
										label.padding_left=0 \
										label.padding_right=0 \
										background.padding_left=0 \
										background.padding_right=0 \
										label.width=550 \
										label="$ARTIST"	\
										label.font="$FONT:Semibold:14.0" \
										label.y_offset=-40 \
		   --add item		island.music_placeholder popup.island \
		   --set island.music_placeholder width=$EXPAND_SIZE \
		   											 background.height=$DEFAULT_HEIGHT \
													 background.color=$PITCH_BLACK \
													 background.border_color=$PITCH_BLACK \
													 background.corner_radius=$DEFAULT_CORNER_RADIUS \
													 background.padding_left=0 \
													 background.padding_right=0 \
													 background.y_offset=0 \
													 background.shadow.drawing=off \
		   --set island		popup.drawing=true \
						    background.drawing=false \
   						    popup.horizontal=on

sketchybar --animate sin 20 --set island.music_placeholder width=$SQUISH_SIZE width=$MAX_EXPAND_SQUISH_SIZE width=$MAX_EXPAND_SIZE\
		   --animate sin 35 --set island popup.height=$MUSIC_INFO_HEIGHT_SQUISH popup.height=$MUSIC_INFO_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=34

sleep 0.45
sketchybar --animate sin 25 --set island.music_title label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.music_artist label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.music_artwork background.color=$TRANSPARENT_LABEL

sleep 3

source "$HOME/.config/sketchybar/plugins/dynamic_island/islands/music/reset.sh"
