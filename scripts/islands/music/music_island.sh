#!/usr/bin/env sh
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/music.sh"
ARTWORK_LOCATION="$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/artwork.jpg"

# fetch music info
TITLE=$(osascript -e "tell application \"$MUSIC_SOURCE\" to get name of current track")
ARTIST=$(osascript -e "tell application \"$MUSIC_SOURCE\" to get artist of current track")

if [[ $MUSIC_SOURCE == "Music" ]]; then
	osascript "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/islands/music/get_artwork.scpt"
elif [[ $MUSIC_SOURCE == "Spotify" ]]; then
	COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
	curl -s --max-time 25 "$COVER" -o "$ARTWORK_LOCATION"
else
	exit 0
fi

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
									    background.image="$ARTWORK_LOCATION" \
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
		   --set island.music_placeholder width=$INFO_EXPAND_WIDTH \
		   											 background.height=$DEFAULT_HEIGHT \
													 background.color=$TRANSPARENT \
													 background.border_color=$TRANSPARENT \
													 background.corner_radius=$DEFAULT_CORNER_RADIUS \
													 background.padding_left=0 \
													 background.padding_right=0 \
													 background.y_offset=0 \
													 background.shadow.drawing=off \
		   --set island		popup.drawing=true \
						    background.drawing=false \
   						    popup.horizontal=on

sketchybar --animate sin 20 --set island.music_placeholder width=$INFO_SQUISH_WIDTH width=$INFO_MAX_EXPAND_SQUISH_WIDTH width=$INFO_MAX_EXPAND_WIDTH\
		   --animate sin 35 --set island popup.height=$INFO_MAX_EXPAND_HEIGHT popup.height=$INFO_EXPAND_HEIGHT \
		   --animate sin 35 --set island popup.background.corner_radius=$INFO_CORNER_RAD

sleep 0.45
sketchybar --animate sin 25 --set island.music_title label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.music_artist label.color=$DEFAULT_LABEL \
		   --animate sin 25 --set island.music_artwork background.color=$TRANSPARENT_LABEL
