#!/usr/bin/env sh

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/general.sh"

SPACE_CLICK_SCRIPT=${SPACE_CLICK_SCRIPT:="yabai -m space --focus \$SID 2>/dev/null"} # The script that is run for clicking on space components

PADDINGS=${PADDINGS:=3}
CORNER_RADIUS=${CORNER_RADIUS:=0}

POPUP_BORDER_WIDTH=${POPUP_BORDER_WIDTH:=2}
POPUP_CORNER_RADIUS=${POPUP_CORNER_RADIUS:=11}

# Setting up the general bar appearance and default values
sketchybar --bar     height=32                                         \
                     color=$TRANSPARENT                                \
                     shadow=$SHADOW                                    \
                     position=top                                      \
                     sticky=on                                         \
                     padding_right=$((10 - $PADDINGS))                 \
                     padding_left=18                                   \
                     corner_radius=0                                   \
                     y_offset=0                                        \
                     margin=0                                          \
                     blur_radius=30                                    \
                     notch_width=0                                     \
           --default updates=when_shown                                \
                     icon.font="$FONT:Bold:14.0"                       \
                     icon.color=$WHITE                                 \
                     icon.padding_left=$PADDINGS                       \
                     icon.padding_right=$PADDINGS                      \
                     label.font="$FONT:Semibold:13.0"                  \
                     label.color=$WHITE                                \
                     label.padding_left=$PADDINGS                      \
                     label.padding_right=$PADDINGS                     \
                     background.padding_right=$PADDINGS                \
                     background.padding_left=$PADDINGS                 \
                     popup.background.corner_radius=11                 \
                     popup.background.shadow.drawing=$SHADOW		   \
                     popup.background.border_width=2                   \
