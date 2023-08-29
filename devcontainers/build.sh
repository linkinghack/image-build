#!/bin/bash
set -x
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

## General
IMAGE_NAME="linkinghack/devenv-python-base:bullseye-2308-1"
BUILD_DIR="./python"

/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin/devcontainer build \
    --platform linux/amd64 \
    --image-name $IMAGE_NAME \
    --workspace-folder $BUILD_DIR \
    --config $BUILD_DIR/devcontainer.json \
    --push

# # Python with CUDA (amd64 only)
# docker build -t $IMAGE_NAME -f $BULID_DIR/Dockerfile $BUILD_DIR
# docker push $IMAGE_NAME

## NodeJS
# cd nodejs; bash build-image.sh
