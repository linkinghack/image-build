#!/bin/bash
set -x
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD
docker login ghcr.io -u linkinghack -p $GITHUB_TOKEN

## Init NodeJS env
chmod a+x ./init_nodejs.sh
./init_nodejs.sh
. ~/.profile

## General

## 1. Build IDE base image (including node )
# IMAGE_NAME="linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3"
# BUILD_DIR="./base-image/debian"

# IMAGE_NAME="linkinghack/devenv-base-fedora42-withnode:250113-1"
# BUILD_DIR="./base-image/fedora"

# ## 2. Build Java developing environment
# IMAGE_NAME="linkinghack/devenv-java-ubuntu:2501-1"
# BUILD_DIR="./java"

# ## 3. Build Golang developing environment
# IMAGE_NAME="linkinghack/devenv-golang-ubuntu:2501-1"
# BUILD_DIR="./golang"

# ## 4. Build dotnet dev env
# IMAGE_NAME="linkinghack/devenv-python-base:bullseye-2308-1"
# BUILD_DIR="./dotnet"

## 5. Build CXX dev env
# IMAGE_NAME="linkinghack/devenv-cxx14-ubuntu:2501-1"
# BUILD_DIR="./cxx"

# IMAGE_NAME="linkinghack/devenv-cxx7-ubuntu:2501-1"
# BUILD_DIR="./cxx/gcc7"

## 6. Build Python dev env
# IMAGE_NAME="linkinghack/devenv-python-ubuntu:2501-1"
# BUILD_DIR="./python"

## 7. Build All in One dev env
# IMAGE_NAME="linkinghack/devenv-allinone-ubuntu:2501-1"
# BUILD_DIR="./all-in-one"

## 8. Build cangjie dev env
IMAGE_NAME="linkinghack/devenv-cangjie-ubuntu:2501-1"
BUILD_DIR="./cangjie"

## X. Build NodeJS dev env
# cd ./nodejs; bash build-image.sh


#### General build command
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
cd nodejs; bash build-image.sh
