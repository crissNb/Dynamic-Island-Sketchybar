#!/usr/bin/env bash

# Validate that INFO is provided and is valid JSON
if [[ -z "$INFO" ]]; then
    exit 0
fi

# Safely extract music information with error handling
TITLE=$(echo "$INFO" | jq -r '.title // "Unknown Title"' 2>/dev/null)
ARTIST=$(echo "$INFO" | jq -r '.artist // "Unknown Artist"' 2>/dev/null)
STATE=$(echo "$INFO" | jq -r '.state // "unknown"' 2>/dev/null)

# Validate extracted data (jq returns empty string on parse error)
if [[ -z "$TITLE" || "$TITLE" == "null" ]]; then
    TITLE="Unknown Title"
fi

if [[ -z "$ARTIST" || "$ARTIST" == "null" ]]; then
    ARTIST="Unknown Artist"
fi

if [[ -z "$STATE" || "$STATE" == "null" ]]; then
    STATE="unknown"
fi

# Only trigger if we have valid state information
if [[ "$STATE" != "unknown" ]]; then
    dynamic-island-sketchybar --trigger dynamic_island_queue INFO="music" ISLAND_ARGS="$TITLE|$ARTIST|$STATE"
fi
