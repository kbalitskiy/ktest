#!/usr/bin/env bash

DOCKERIMG=${DOCKERIMG:-dsvetlyakov/webex}

xhost +local:webex-$(id -un)

docker run --rm \
	--hostname=webex-$(id -un) \
        --privileged \
        --name webex \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /dev/snd:/dev/snd \
	-v $(pwd)/asound_home.conf:/etc/asound.conf \
        dsvetlyakov/webex $*
