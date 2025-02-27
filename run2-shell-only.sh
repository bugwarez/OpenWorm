#!/bin/bash

# For generating/running a Dockerfile image based on Python 2
# Note: Python 2 is no longer officially supported and this Docker image will
# probably stop working eventually...

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

xhost +

docker run -ti \
  --name openworm2 \
  --device=/dev/dri:/dev/dri \
  -e DISPLAY=$DISPLAY \
  -e OW_OUT_DIR=$OW_OUT_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  --privileged \
  -v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
  openworm/openworm:0.9.2 \
  bash
