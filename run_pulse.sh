#!/usr/bin/env bash

DOCKERIMG=${DOCKERIMG:-dsvetlyakov/webex}

xhost +local:webex-$(id -un)

docker run --rm \
	--hostname=webex-$(id -un) \
        --privileged \
        --name webex \
	--group-add $(getent group audio | cut -d: -f3) \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
	--device /dev/snd \
	-e PULSE_SERVER=unix:/run/user/1000/pulse/native \
	-v /run/user/1000/pulse/native:/run/user/1000/pulse/native \
        dsvetlyakov/webex $*
