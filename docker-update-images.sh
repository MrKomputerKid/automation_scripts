#!/bin/bash

# List of directories containing Docker Compose files
compose_dirs=(
    "/home/cwessel/mc-server"
    "/home/cwessel/docker-bitlbee"
    "/home/cwessel/chowdown"
    "/home/cwessel/matterbridge"
    "/home/cwessel/qbittorrent"
)

# Iterate through each directory
for dir in "${compose_dirs[@]}"
do
    echo "Updating containers in $dir"
    cd "$dir" || continue  # Change directory or skip if not found

    # Stop and remove existing containers
    docker compose down

    # Pull the latest images
    docker compose pull

    # Recreate and start the containers
    docker compose up -d
done
