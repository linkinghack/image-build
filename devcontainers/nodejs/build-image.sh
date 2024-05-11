#!/bin/bash

set -x

docker buildx build \
    -t linkinghack/devenv-nodejs:bullseye-2405-1 \
    --platform linux/arm64,linux/amd64 \
    . --push
