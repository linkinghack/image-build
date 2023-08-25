#!/bin/bash
set -x
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

## Golang
IMAGE_NAME="linkinghack/devenv-golang:bullseye-2308-1"
BUILD_DIR="./golang"

# /usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin/devcontainer build \
#     --platform linux/arm64,linux/amd64 \
#     --image-name $IMAGE_NAME \
#     --workspace-folder $BUILD_DIR \
#     --config $BUILD_DIR/devcontainer.json \
#     --push


## NodeJS
cd nodejs; bash build-image.sh
