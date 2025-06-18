#!/bin/bash
set -e

# Get the ID of the running container (filter out the header and get the first match)
container_id=$(docker ps -q)

# Check if a container ID was found
if [ -n "$container_id" ]; then
    echo "Stopping and removing container $container_id..."
    docker rm -f "$container_id"
else
    echo "No running containers found."
fi
