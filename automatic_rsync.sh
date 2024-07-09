#!/bin/bash

# Define remote Pis (replace with your Pis' hostnames or IP addresses)
REMOTE_PIS=(
    "pi@192.168.0.2"
    "pi@192.168.0.4"
    "pi@192.168.0.5"
)

# Directory to monitor
MONITOR_DIR="/home/pi"

# Watch for close_write events in the monitored directory, excluding hidden files and automatic_rsync.sh
inotifywait -m -e close_write --exclude '^\./(\..*|automatic_rsync.sh)' --format '%w%f' "$MONITOR_DIR" |
while read -r FILE
do
    echo "File $FILE was modified. Syncing changes..."
    for PI in "${REMOTE_PIS[@]}"
    do
        rsync -avz --delete --exclude='^\./(\..*|automatic_rsync.sh)' "$MONITOR_DIR/" "$PI:$MONITOR_DIR/"
    done
    echo "Sync complete."
done
