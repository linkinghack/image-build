#!/bin/bash
set -x
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

## General 

## 1. Build IDE base image (including node )
IMAGE_NAME="linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1"
BUILD_DIR="./base-image/debian"

# ## 2. Build Java developing environment
# IMAGE_NAME="linkinghack/devenv-java:bullseye-2308-1"
# BUILD_DIR="./java"

# ## 3. Build Golang developing environment
# IMAGE_NAME="linkinghack/devenv-golang:bullseye-2308-1"
# BUILD_DIR="./golang"

# ## 4. Build dotnet dev env
# IMAGE_NAME="linkinghack/devenv-python-base:bullseye-2308-1"
# BUILD_DIR="./dotnet"


/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin/devcontainer build \
    --platform linux/arm64,linux/amd64 \
    --image-name $IMAGE_NAME \
    --workspace-folder $BUILD_DIR \
    --config $BUILD_DIR/devcontainer.json \
    --push

# # Python with CUDA (amd64 only)
# docker build -t $IMAGE_NAME -f $BULID_DIR/Dockerfile $BUILD_DIR
# docker push $IMAGE_NAME

## NodeJS
# cd nodejs; bash build-image.sh
