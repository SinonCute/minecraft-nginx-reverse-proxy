@echo off

:: Set the container name and script path
set container=proxy
set script=/opt/set_host.sh

:: Check if the required arguments are provided
if "%1"=="" (
    echo Error: Bedrock or Java edition not specified.
    echo Usage: set_host.bat [edition] [host] [port]
    exit /b 1
)

if "%2"=="" (
    echo Error: Host not specified.
    echo Usage: set_host.bat [edition] [host] [port]
    exit /b 1
)

if "%3"=="" (
    echo Error: Port not specified.
    echo Usage: set_host.bat [edition] [host] [port]
    exit /b 1
)

:: Execute the set_host.sh script in the Docker container with arguments
docker-compose exec %container% bash %script% %1 %2 %3

:: Check the exit status of the last command
if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to execute the script inside the container.
    exit /b 1
)

echo Script executed successfully inside the container.
