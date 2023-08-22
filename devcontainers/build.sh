#!/bin/bash
set -xeu
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

export IMAEG_NAME="linkinghack/devcontainer-base:bullseye-2308-1"
export BUILD_DIR="./base-image/debian"

/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin/devcontainer build \
    --workspace-folder ${BUILD_DIR} \
    --config ${BUILD_DIR}/devcontainer.json \
    --image-name ${IMAGE_NAME} \
    --platform linux/arm64,linux/amd64 \
    --push
