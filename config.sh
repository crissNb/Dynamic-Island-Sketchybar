#!/usr/bin/env sh

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/colors.sh" # Loads all defined colors
source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/icons.sh" # Loads all defined icons

FONT=${FONT:="SF Pro"} # Needs to have Regular, Bold, Semibold, Heavy and Black variants
SPACE_CLICK_SCRIPT=${SPACE_CLICK_SCRIPT:="yabai -m space --focus \$SID 2>/dev/null"} # The script that is run for clicking on space components

PADDINGS=${PADDINGS:=3} # All paddings use this value (icon, label, background)
CORNER_RADIUS=${CORNER_RADIUS:=0}

POPUP_BORDER_WIDTH=${POPUP_BORDER_WIDTH:=2}
POPUP_CORNER_RADIUS=${POPUP_CORNER_RADIUS:=11}

SHADOW=${SHADOW:=on}

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
                     margin=10                                         \
                     blur_radius=30                                    \
                     notch_width=0                                     \
                                                                       \
           --default updates=when_shown                                \
                     icon.font="$FONT:Bold:14.0"                       \
                     icon.color=$ICON_COLOR                            \
                     icon.padding_left=$PADDINGS                       \
                     icon.padding_right=$PADDINGS                      \
                     label.font="$FONT:Semibold:13.0"                  \
                     label.color=$LABEL_COLOR                          \
                     label.padding_left=$PADDINGS                      \
                     label.padding_right=$PADDINGS                     \
                     background.padding_right=$PADDINGS                \
                     background.padding_left=$PADDINGS                 \
                     popup.background.corner_radius=11                 \
                     popup.background.border_color=$POPUP_BORDER_COLOR \
                     popup.background.color=$POPUP_BACKGROUND_COLOR    \
                     popup.background.shadow.drawing=$SHADOW
                     # popup.background.border_width=2                   \
