#!/bin/bash

# For generating/running a Dockerfile image based on Python 2
# Note: Python 2 is no longer officially supported and this Docker image will
# probably stop working eventually...

#from: https://unix.stackexchange.com/a/129401
while getopts ":d:p:" opt; do
  case $opt in
    d) duration="$OPTARG"
    ;;
    p) p_out="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

OW_OUT_DIR=/home/ow/shared
HOST_OUT_DIR=$PWD

xhost +

if [ -z "$duration" ]
then #duration is not set, don't use it
    DURATION_PART=""
else #Duration is set, use it.
    DURATION_PART="-e DURATION=$duration"
fi

docker run -d \
--name openworm2 \
--device=/dev/dri:/dev/dri \
-e DISPLAY=$DISPLAY \
$DURATION_PART \
-e OW_OUT_DIR=$OW_OUT_DIR \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
--privileged \
-v $HOST_OUT_DIR:$OW_OUT_DIR:rw \
openworm/openworm:0.9.2_py2 \
bash -c "DISPLAY=:44 python master_openworm.py"

docker logs -f openworm2
