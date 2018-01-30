#!/usr/bin/env bash

DOCKERIMG=${DOCKERIMG:-dsvetlyakov/webex}
#PULSE_PATH=`netstat -xnlp 2>/dev/null| grep \`ps aux| grep pulseaudio | grep -v grep | awk '{print $2;}'\` | grep user | awk '{print $10;}'`
PULSE_PATH="/run/user/$(id -u)/pulse/native"

echo $PULSE_PATH

xhost +local:webex-$(id -un)

docker run --rm \
	--hostname=webex-$(id -un) \
        --privileged \
        --name webex \
	--group-add $(getent group audio | cut -d: -f3) \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
	--device /dev/snd \
	-e PULSE_SERVER=unix:$PULSE_PATH \
	-v $PULSE_PATH:$PULSE_PATH \
	-v /dev/shm:/dev/shm \
        dsvetlyakov/webex $*
