#!/usr/bin/env bash

edition="$1"
host="$2"
port="$3"
bootFlag="$4"

nginxFile="/opt/nginx/sbin/nginx"

# Determine the correct template and config files based on the edition
case "$edition" in
    bedrock)
        templateFile="/opt/nginx/stream.conf.d/minecraft-bedrock.template.conf"
        configFile="/opt/nginx/stream.conf.d/minecraft-bedrock.conf"
        ;;
    java)
        templateFile="/opt/nginx/stream.conf.d/minecraft-java.template.conf"
        configFile="/opt/nginx/stream.conf.d/minecraft-java.conf"
        ;;
    *)
        echo "Invalid edition specified: $edition"
        exit 1
        ;;
esac

# Copy the template and replace placeholders with actual values
yes | cp -fi "$templateFile" "$configFile" &> /dev/null
sed -i "s/<host_$edition>/$host/" "$configFile"
sed -i "s/<port_$edition>/$port/" "$configFile"

# Reload nginx only if not booting up
if [ -z "$bootFlag" ]; then
    $nginxFile -s reload
fi
