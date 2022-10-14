#!/usr/bin/env sh

source "$HOME/.config/sketchybar/plugins/Dynamic-Island-Sketchybar/scripts/configs/general.sh"

DYNAMIC_ISLAND_ENV_VARS=""
vars=(
P_DYNAMIC_ISLAND_FONT
P_DYNAMIC_ISLAND_ICON_HIDDEN
P_DYNAMIC_ISLAND_DEFAULT_LABEL
P_DYNAMIC_ISLAND_TRANSPARENT_LABEL
P_DYNAMIC_ISLAND_MAX_HEIGHT
P_DYNAMIC_ISLAND_DEFAULT_HEIGHT
P_DYNAMIC_ISLAND_DEFAULT_WIDTH
P_DYNAMIC_ISLAND_DEFAULT_CORNER_RADIUS
P_DYNAMIC_ISLAND_SQUISH_AMOUNT
P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_WIDTH
P_DYNAMIC_ISLAND_APPSWITCH_MAX_EXPAND_WIDTH
P_DYNAMIC_ISLAND_APPSWITCH_EXPAND_HEIGHT
P_DYNAMIC_ISLAND_APPSWITCH_CORNER_RAD
P_DYNAMIC_ISLAND_APPSWITCH_ICON_SIZE
P_DYNAMIC_ISLAND_ICON_VOLUME_MAX
P_DYNAMIC_ISLAND_ICON_VOLUME_MED
P_DYNAMIC_ISLAND_ICON_VOLUME_LOW
P_DYNAMIC_ISLAND_ICON_VOLUME_MUTED
P_DYNAMIC_ISLAND_VOLUME_EXPAND_WIDTH
P_DYNAMIC_ISLAND_VOLUME_MAX_EXPAND_WIDTH
P_DYNAMIC_ISLAND_VOLUME_DEFAULT_HEIGHT
P_DYNAMIC_ISLAND_VOLUME_EXPAND_HEIGHT
P_DYNAMIC_ISLAND_VOLUME_CORNER_RAD
P_DYNAMIC_ISLAND_VOLUME_NORMAL_ICON_COLOR
P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH
P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_WIDTH
P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT
P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD
P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_WIDTH
P_DYNAMIC_ISLAND_MUSIC_RESUME_MAX_EXPAND_WIDTH
P_DYNAMIC_ISLAND_MUSIC_RESUME_EXPAND_HEIGHT
P_DYNAMIC_ISLAND_MUSIC_RESUME_CORNER_RAD
P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_WIDTH
P_DYNAMIC_ISLAND_NOTIFICATION_MAX_EXPAND_WIDTH
P_DYNAMIC_ISLAND_NOTIFICATION_EXPAND_HEIGHT
P_DYNAMIC_ISLAND_NOTIFICATION_CORNER_RAD
P_DYNAMIC_ISLAND_NOTIFICATION_MAX_ALLOWED_BODY
)
for var in ${vars[*]}; do
     DYNAMIC_ISLAND_ENV_VARS="$DYNAMIC_ISLAND_ENV_VARS $var=${!var}"
done

FONT=${P_DYNAMIC_ISLAND_FONT:="SF Pro"} # Needs to have Regular, Bold, Semibold, Heavy and Black variants
SPACE_CLICK_SCRIPT=${P_DYNAMIC_ISLAND_SPACE_CLICK_SCRIPT:="yabai -m space --focus \$SID 2>/dev/null"} # The script that is run for clicking on space components

PADDINGS=${P_DYNAMIC_ISLAND_PADDINGS:=3}
CORNER_RADIUS=${P_DYNAMIC_ISLAND_CORNER_RADIUS:=0}

POPUP_BORDER_WIDTH=${P_DYNAMIC_ISLAND_POPUP_BORDER_WIDTH:=2}
POPUP_CORNER_RADIUS=${P_DYNAMIC_ISLAND_POPUP_CORNER_RADIUS:=11}

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
