#!/bin/bash
## Copyright LINKINGHACK. All rights reserved.
## Licensed under the MIT license.

## Usage :  <major version> <full version> <whether link as latest> <target user home>
### installNode.sh 19 v19.4.0 true devspace

set -ex

MAJOR_VERSION=${1:-"latest"}
NODE_VERSION=${2:-"latest"}

CURRENT_CPU_ARCH=$(uname -m)
LINK_AS_LATEST=${3:-"false"}

USER_NAME=${4:-"devspace"}

TARGET_PLATFORM="x64"
if [ "$CURRENT_CPU_ARCH" = "x86_64" ]; then
  TARGET_PLATFORM="x64";
elif ["$CURRENT_CPU_ARCH" = "aarch64" ]; then
  TARGET_PLATFORM="arm64"
fi

NODE_ORG_BASE_URL="https://nodejs.org/dist"

DOWNLOAD_URL="$NODE_ORG_BASE_URL/$NODE_VERSION/node-$NODE_VERSION-linux-$TARGET_PLATFORM.tar.gz"

DIR_NAME="node-$NODE_VERSION-linux-$TARGET_PLATFORM"
FILE_NAME="$DIR_NAME.tar.gz"

## Download node binaries and install
wget $DOWNLOAD_URL

mkdir -p /opt/nodejs
tar xf ./$FILE_NAME -C /opt/nodejs
ln /opt/nodejs/$DIR_NAME /opt/nodejs/$MAJOR_VERSION

if [ "$LINK_AS_LATEST" = "true" ]; then
  TARGET_HOME="/home/$USER_NAME"
  mkdir -p $TARGET_HOME/nodejs
  ln /opt/nodejs/$DIR_NAME $TARGET_HOME/nodejs/current
  ln /opt/nodejs/lts /opt/nodejs/$MAJOR_VERSION
fi
