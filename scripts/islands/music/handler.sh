#!/usr/bin/env bash

# Debug logging function
debug_log() {
    if [[ "${P_DYNAMIC_ISLAND_MUSIC_DEBUG:-0}" == "1" ]]; then
        echo "[MUSIC_DEBUG] $*" >&2
    fi
}

debug_log "Handler called with INFO: $INFO"

# Validate that INFO is provided and is valid JSON
if [[ -z "$INFO" ]]; then
    debug_log "No INFO provided, exiting"
    exit 0
fi

# Safely extract music information with error handling
TITLE=$(echo "$INFO" | jq -r '.title // "Unknown Title"' 2>/dev/null)
ARTIST=$(echo "$INFO" | jq -r '.artist // "Unknown Artist"' 2>/dev/null)
STATE=$(echo "$INFO" | jq -r '.state // "unknown"' 2>/dev/null)

debug_log "Raw extracted values - Title: '$TITLE', Artist: '$ARTIST', State: '$STATE'"

# Validate extracted data (jq returns empty string on parse error)
if [[ -z "$TITLE" || "$TITLE" == "null" ]]; then
    TITLE="Unknown Title"
    debug_log "Title was empty or null, using fallback"
fi

if [[ -z "$ARTIST" || "$ARTIST" == "null" ]]; then
    ARTIST="Unknown Artist"
    debug_log "Artist was empty or null, using fallback"
fi

if [[ -z "$STATE" || "$STATE" == "null" ]]; then
    STATE="unknown"
    debug_log "State was empty or null, using fallback"
fi

debug_log "Final values - Title: '$TITLE', Artist: '$ARTIST', State: '$STATE'"

# Only trigger if we have valid state information
if [[ "$STATE" != "unknown" ]]; then
    debug_log "Triggering dynamic island queue with valid state"
    dynamic-island-sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS="$TITLE|$ARTIST|$STATE"
else
    debug_log "State is unknown, not triggering dynamic island"
fi
