CURR_DIR=$(
	cd "$(dirname "${BASH_SOURCE[0]}")" || exit
	pwd -P
)

CONF_FILE="$CURR_DIR/cava.conf"

# Function to cleanup on exit
cleanup() {
    if [[ "${P_DYNAMIC_ISLAND_MUSIC_DEBUG:-0}" == "1" ]]; then
        echo "[CAVA_DEBUG] Cleaning up cava process..." >&2
    fi
    
    # Kill any existing cava processes started by this script
    pkill -f "cava -p $CONF_FILE" 2>/dev/null
    
    # Kill any child processes
    jobs -p | xargs -r kill 2>/dev/null
    
    exit 0
}

# Set up signal handlers
trap cleanup EXIT TERM INT

# Function to check if cava is available
check_cava() {
    # Debug logging for cava
    if [[ "${P_DYNAMIC_ISLAND_MUSIC_DEBUG:-0}" == "1" ]]; then
        echo "[CAVA_DEBUG] Checking cava availability..." >&2
    fi
    
    if ! command -v cava &> /dev/null; then
        echo "Warning: cava not found, music visualizer disabled" >&2
        return 1
    fi
    
    # Check if the config file exists
    if [[ ! -f "$CONF_FILE" ]]; then
        echo "Warning: cava config file not found at $CONF_FILE" >&2
        return 1
    fi
    
    # Check if Background Music is available (or any audio input)
    # Try a quick test run of cava
    if ! timeout 2s cava -p "$CONF_FILE" >/dev/null 2>&1; then
        echo "Warning: cava cannot access audio input, check Background Music or audio setup" >&2
        return 1
    fi
    
    if [[ "${P_DYNAMIC_ISLAND_MUSIC_DEBUG:-0}" == "1" ]]; then
        echo "[CAVA_DEBUG] Cava is available and working" >&2
    fi
    
    return 0
}

# Main loop with error handling
main_loop() {
    local retry_count=0
    local max_retries=3
    
    while true; do
        if ! check_cava; then
            sleep 30  # Wait longer if cava is not available
            continue
        fi
        
        # Start cava with error handling
        if cava -p "$CONF_FILE" 2>/dev/null | sed -u 's/ //g; s/0/▁/g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g; s/8/█/g' | while read -r line; do
            if [[ -n "$NAME" && -n "$line" ]]; then
                dynamic-island-sketchybar --set "$NAME" label="$line" 2>/dev/null
            fi
        done; then
            retry_count=0
        else
            retry_count=$((retry_count + 1))
            echo "Cava failed (attempt $retry_count/$max_retries)" >&2
            
            if [[ $retry_count -ge $max_retries ]]; then
                echo "Max retries reached, disabling visualizer for this session" >&2
                sleep 300  # Sleep for 5 minutes before retrying
                retry_count=0
            else
                sleep $((retry_count * 2))  # Exponential backoff
            fi
        fi
    done
}

# Run main loop
main_loop
