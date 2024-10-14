# Minecraft NGINX Reverse Proxy

This project is based on [tekn0irs](https://github.com/tekn0ir) [nginx-stream](https://github.com/tekn0ir/nginx-stream).


## Requirements
- A webserver with a static IP address supporting Docker


## Setup

This image is available at [Docker Hub](https://hub.docker.com/r/vollborn/minecraft-nginx-reverse-proxy).

### Using docker run
You can run it by using the following command:
```shell
docker run -d \
  -p 25565:25565 \
  -p 19132:19132/udp \
  -e BEDROCK_HOST=192.168.1.1 \
  -e BEDROCK_PORT=19132 \
  -e JAVA_HOST=192.168.1.2 \
  -e JAVA_PORT=25565 \
  vollborn/minecraft-nginx-reverse-proxy
```

### Using docker compose
You can also use docker-compose.
Example docker-compose.yml:
```yml
version: "3.8"

services:
  proxy:
    image: vollborn/minecraft-nginx-reverse-proxy
    restart: unless-stopped
    ports:
      - "${LOCAL_PORT_JAVA:-25565}:25565"   # Java Edition
      - "${LOCAL_PORT_BEDROCK:-19132}:19132/udp"  # Bedrock Edition
    environment:
      INITIAL_HOST: <host>
      INITIAL_PORT: <port>
      # TZ: "Europe/Berlin"
```

Here we go.
<br>You should be up and running!


## Development Setup
Enter the cloned directory.
```shell
cd minecraft-nginx-reverse-proxy
```

Then you need to copy the .env.example file. For that, run:
```shell
cp .env.example .env
```

Run docker-compose build to build the container.
```shell
docker-compose build
```


### Starting the development container

You can start the container by executing this command:
```shell
docker-compose up -d
```

To change the host IP address or port without restarting the container, you can to execute the following command:

```shell
# Windows
sethost <ip> <port>

# Linux
bash ./sethost.sh <ip> <port>
```

Examples:
```shell
# Windows
sethost bedrock 192.168.178.99 19132
sethost java 192.168.178.99 25565

# Linux
bash ./sethost.sh java 192.168.178.99 25565
bash ./sethost.sh bedrock 192.168.178.99 19132

```
