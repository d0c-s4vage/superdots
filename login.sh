#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THIS_PROG="$0"

cd "$DIR"

docker build -t d0c-s4vage/nixspace .

docker run \
    --rm \
    -it \
    -v /etc/localtime:/etc/localtime:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v user-data-${USER}:/home/user \
    -v /dev:/dev \
    --net host \
    --name "${USER}-login" \
    d0c-s4vage/nixspace:latest
