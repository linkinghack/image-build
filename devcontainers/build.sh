#!/bin/bash
set -x
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

IMAGE_NAME="linkinghack/devcontainer-base:bullseye-2308-2"
BUILD_DIR="./base-image/debian"

/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin/devcontainer build \
    --platform linux/arm64,linux/amd64 \
    --image-name $IMAGE_NAME \
    --workspace-folder $BUILD_DIR \
    --config $BUILD_DIR/devcontainer.json \
    --push
