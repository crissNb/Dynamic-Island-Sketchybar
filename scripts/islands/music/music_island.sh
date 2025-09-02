#!/usr/bin/env bash
source "$HOME/.config/dynamic-island-sketchybar/userconfig.sh"
source "$DYNAMIC_ISLAND_DIR/scripts/islands/clear.sh"

# Debug logging function
debug_log() {
    if [[ "${P_DYNAMIC_ISLAND_MUSIC_DEBUG:-0}" == "1" ]]; then
        echo "[MUSIC_DEBUG] $*" >&2
    fi
}

debug_log "Music island script started with args: $*"

# Validate configuration values
validate_config() {
    local errors=0
    
    # Check if required variables are set and are numeric where needed
    if [[ -z "$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" ]] || ! [[ "$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT is not set or not numeric, using default" >&2
        P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT=100
        errors=1
    fi
    
    if [[ -z "$P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH" ]] || ! [[ "$P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH is not set or not numeric, using default" >&2
        P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH=170
        errors=1
    fi
    
    if [[ -z "$P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION" ]] || ! [[ "$P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION is not set or not numeric, using default" >&2
        P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION=1512
        errors=1
    fi
    
    if [[ -z "$P_DYNAMIC_ISLAND_SQUISH_AMOUNT" ]] || ! [[ "$P_DYNAMIC_ISLAND_SQUISH_AMOUNT" =~ ^[0-9]+$ ]]; then
        echo "Warning: P_DYNAMIC_ISLAND_SQUISH_AMOUNT is not set or not numeric, using default" >&2
        P_DYNAMIC_ISLAND_SQUISH_AMOUNT=6
        errors=1
    fi
    
    return $errors
}

# Validate configuration before proceeding
validate_config

INFO_MAX_EXPAND_HEIGHT=$(($P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT + ($P_DYNAMIC_ISLAND_SQUISH_AMOUNT) / 2))
INFO_EXPAND_SIZE=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_MUSIC_INFO_MAX_EXPAND_WIDTH))

# $1 - override
args=$*
IFS='|'
read -ra strarr <<<"$args"
unset IFS

# $1 - override
# $2 - artist
# $3 - title
override="${strarr[0]}"
# fetch music info
ARTIST="${strarr[1]}"
TITLE="${strarr[2]}"
STATE="${strarr[3]}"

debug_log "Parsed arguments - Override: $override, Artist: '$ARTIST', Title: '$TITLE', State: '$STATE'"

PREVIOUS_ISLAND_CACHE="$DYNAMIC_ISLAND_DIR/scripts/islands/previous_island"

# Validate state and handle edge cases
if [[ -z "$STATE" || "$STATE" == "null" ]]; then
    # If state is unknown, exit gracefully
    exit 0
fi

if [[ $STATE == "playing" ]]; then
  if ! grep -Fxq "music" "$PREVIOUS_ISLAND_CACHE"; then
      echo "music" >> "$PREVIOUS_ISLAND_CACHE"
  fi

  if grep -Fxq "paused" "$PREVIOUS_ISLAND_CACHE"; then
      source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/pause_island.sh" "$override|1"
      exit
  fi
elif [[ $STATE == "paused" || $STATE == "stopped" ]]; then
  source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/pause_island.sh" "$override|0"
  exit
else
  # Unknown state, exit gracefully
  exit 0
fi

# Validate that we have meaningful content to display
if [[ "$TITLE" == "Unknown Title" && "$ARTIST" == "Unknown Artist" ]]; then
    # No useful information to display
    exit 0
fi

# Smart text truncation that respects word boundaries when possible
truncate_text() {
    local text="$1"
    local max_len="$2"
    
    # Return original if within limit
    if [[ ${#text} -le $max_len ]]; then
        echo "$text"
        return
    fi
    
    # Try to truncate at word boundary
    local truncated=$(echo "$text" | cut -c 1-$((max_len-3)))
    local last_space=$(echo "$truncated" | sed 's/.*\(.\)/\1/')
    
    # If we can find a word boundary near the end, use it
    if [[ "$truncated" =~ [[:space:]] ]]; then
        truncated=$(echo "$truncated" | sed 's/[[:space:]][^[:space:]]*$//')
        echo "${truncated}..."
    else
        # Fall back to character truncation
        echo "$(echo "$text" | cut -c 1-$((max_len-3)))..."
    fi
}

# Sanitize and truncate text fields
TITLE=$(echo "$TITLE" | sed 's/[^[:print:]]//g')  # Remove non-printable characters
ARTIST=$(echo "$ARTIST" | sed 's/[^[:print:]]//g')

TITLE=$(truncate_text "$TITLE" 25)
ARTIST=$(truncate_text "$ARTIST" 25)

# Set labels before attempting to display
dynamic-island-sketchybar --set island.music_artist label="$ARTIST" \
	--set island.music_title label="$TITLE" 2>/dev/null || {
		echo "Error: Failed to set music labels" >&2
		exit 1
	}

# Attempt to show elements with artwork validation
if [[ $override == "0" ]]; then
	# Try to enable artwork, but don't fail if it doesn't work
	dynamic-island-sketchybar --set island.music_artwork drawing=on \
		--set island.music_title drawing=on \
		--set island.music_artist drawing=on \
        --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
        --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
		--set island "${island[@]}" 2>/dev/null || {
			echo "Warning: Failed to configure music island elements, continuing without artwork" >&2
			# Fallback: just show title and artist without artwork
			dynamic-island-sketchybar --set island.music_title drawing=on \
				--set island.music_artist drawing=on \
				--set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
				--set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
				--set island "${island[@]}" 2>/dev/null
		}
	
	# Try to enable artwork separately (may not be available)
	dynamic-island-sketchybar --set island.music_artwork background.image.drawing=on 2>/dev/null || {
		echo "Warning: Music artwork not available or failed to display" >&2
	}
fi

if [[ $override == "0" ]]; then
    target_width=$(($P_DYNAMIC_ISLAND_MONITOR_HORIZONTAL_RESOLUTION / 2 - $P_DYNAMIC_ISLAND_DEFAULT_WIDTH - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))

    dynamic-island-sketchybar --animate tanh 8 --bar margin="$target_width" margin="$(($INFO_EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$INFO_EXPAND_SIZE" \
		--animate tanh 10 --bar height="$INFO_MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD" 2>/dev/null || {
			echo "Warning: Animation failed, continuing without animation" >&2
		}
else
    dynamic-island-sketchybar --animate tanh 8 --bar margin="$(($INFO_EXPAND_SIZE - $P_DYNAMIC_ISLAND_SQUISH_AMOUNT))" margin="$INFO_EXPAND_SIZE" \
		--animate tanh 10 --bar height="$INFO_MAX_EXPAND_HEIGHT" height="$P_DYNAMIC_ISLAND_MUSIC_INFO_EXPAND_HEIGHT" \
		--animate tanh 10 --bar corner_radius="$P_DYNAMIC_ISLAND_MUSIC_INFO_CORNER_RAD" 2>/dev/null || {
			echo "Warning: Animation failed, continuing without animation" >&2
		}
fi

sleep 0.15
dynamic-island-sketchybar --animate tanh 15 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 15 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_WHITE" \
	--animate tanh 15 --set island.music_artwork background.image.drawing=on 2>/dev/null

sleep 1.7

dynamic-island-sketchybar --animate tanh 15 --set island.music_title label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artist label.color="$P_DYNAMIC_ISLAND_COLOR_TRANSPARENT" \
	--animate tanh 15 --set island.music_artwork background.image.drawing=off 2>/dev/null

sleep 0.2

source "$DYNAMIC_ISLAND_DIR/scripts/islands/restore.sh"

sleep 0.4

source "$DYNAMIC_ISLAND_DIR/scripts/islands/music/reset.sh"
