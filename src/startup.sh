#!/usr/bin/env bash

# Check for required environment variables for Bedrock and Java editions
if [[ -n ${BEDROCK_HOST} ]] && [[ -n ${BEDROCK_PORT} ]]; then
    echo "Setting Bedrock host and port..."
    bash /opt/set_host.sh "bedrock" "${BEDROCK_HOST}" "${BEDROCK_PORT}" true
fi

if [[ -n ${JAVA_HOST} ]] && [[ -n ${JAVA_PORT} ]]; then
    echo "Setting Java host and port..."
    bash /opt/set_host.sh "java" "${JAVA_HOST}" "${JAVA_PORT}" true
fi

echo "Starting nginx..."

/opt/nginx/sbin/nginx -g 'daemon off;'
