#!/bin/bash
# 获取脚本所在目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
XAUTH=/tmp/.docker.xauth
docker run -it \
  --gpus all \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev/input:/dev/input" \
  -v "/run/udev:/run/udev" \
  -v "$SCRIPT_DIR/../:/root/code/ocs2_ws" \
  -v "$HOME/.raisim/:/root/.raisim/" \
  --privileged \
  --security-opt seccomp=unconfined \
  --network host \
  --name ocs2-ws \
ocs2-ws
