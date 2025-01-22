#!/bin/bash

set -x

docker buildx build \
    -t linkinghack/devenv-nodejs-ubuntu:2501-1 \
    --platform linux/arm64,linux/amd64 \
    . --push
