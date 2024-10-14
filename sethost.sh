#!/usr/bin/env bash

# Container and script paths
container="proxy"
script="/opt/set_host.sh"

# Check if all required arguments are provided
if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
  echo "Error: Missing arguments."
  echo "Usage: $0 [edition] [host] [port]"
  exit 1
fi

edition="$1"
host="$2"
port="$3"

# Execute the set_host.sh script inside the container
docker-compose exec $container bash $script "$edition" "$host" "$port"

# Check the exit status of the previous command
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to execute the script inside the container."
  exit 1
fi

echo "Script executed successfully inside the container."
