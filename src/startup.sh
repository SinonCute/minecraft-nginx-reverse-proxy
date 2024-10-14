#!/usr/bin/env bash

# Function to configure the server
configure_server() {
  local edition="$1"
  local host="$2"
  local port="$3"

  local template="/opt/minecraft_${edition}.template.conf"
  local config="/opt/nginx/stream.conf.d/minecraft_${edition}.conf"

  # Check if the template exists
  if [[ ! -f "$template" ]]; then
    echo "Error: Template $template not found."
    exit 1
  fi

  # Replace placeholders in the template with provided values (without adding quotes)
  sed "s|<host>|${host}|g; s|<port>|${port}|g" "$template" > "$config"
  echo "Configured $edition server at $host:$port."
}

# Function to replace placeholders in nginx.conf
replace_in_nginx_conf() {
  local nginx_conf="/opt/nginx/conf/nginx.conf"

  # Check if nginx.conf exists
  if [[ ! -f "$nginx_conf" ]]; then
    echo "Error: nginx.conf not found. Exiting."
    exit 1
  fi

  # Replace placeholders without adding quotes
  sed -i "s|<host_java>|${JAVA_HOST}|g" "$nginx_conf"
  sed -i "s|<port_java>|${JAVA_PORT}|g" "$nginx_conf"
  sed -i "s|<host_bedrock>|${BEDROCK_HOST}|g" "$nginx_conf"
  sed -i "s|<port_bedrock>|${BEDROCK_PORT}|g" "$nginx_conf"
  echo "nginx.conf placeholders replaced."

  # Print the updated nginx.conf for verification
  echo "Updated nginx.conf content:"
  cat "$nginx_conf"
}

# Configure Bedrock server if variables are set
if [[ -n "${BEDROCK_HOST}" && -n "${BEDROCK_PORT}" ]]; then
  echo "Setting Bedrock host and port..."
  configure_server "bedrock" "${BEDROCK_HOST}" "${BEDROCK_PORT}"
fi

# Configure Java server if variables are set
if [[ -n "${JAVA_HOST}" && -n "${JAVA_PORT}" ]]; then
  echo "Setting Java host and port..."
  configure_server "java" "${JAVA_HOST}" "${JAVA_PORT}"
fi

# Replace placeholders in nginx.conf
replace_in_nginx_conf

# Start NGINX
echo "Starting nginx..."
/opt/nginx/sbin/nginx -g 'daemon off;'
