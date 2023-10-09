#!/bin/bash

set -xeu
docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASSWORD

# build eosio-cdt.181 base image
# docker build -t linkinghack/eos-cdt-1.8.1-base:ubuntu18.04 -f ./dockerfiles/eos-cdt.181.base.Dockerfile ./context;
# docker push linkinghack/eos-cdt-1.8.1-base:ubuntu18.04;

# build cloud ide images
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/go-code-server:go1.18-code4.4.0-v1.3 -f ./dockerfiles/cloud-ide/go.Dockerfile ./dockerfiles/cloud-ide --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/java-code-server:java8-11-18-code4.4.0-v1.3 -f ./dockerfiles/cloud-ide/java.Dockerfile ./dockerfiles/cloud-ide --push;

# build VSO base image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/dev-base:bullseye-230116 -f ./dockerfiles/dev-base/Dockerfile ./dockerfiles/dev-base --push;

# build IDE Base image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/ide-base:full-230116 -f ./dockerfiles/base-img/dev-base.Dockerfile ./dockerfiles/base-img --push;

# build IDE full-featured image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/cloud-ide:full-230224 -f ./dockerfiles/cloud-ide/all.Dockerfile ./dockerfiles/cloud-ide --push;

# build dbg-tool
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/dbg-tool:v1.4 -f ./dockerfiles/dbg-tool/Dockerfile ./dockerfiles/dbg-tool --push;

# build webproc-dnsmasq
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/webproc-dnsmasq:v1.0 -f ./dockerfiles/dnsmasq/Dockerfile ./dockerfiles/dnsmasq --push;


# build enhanced base image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/dev-container:220726 -f ./dockerfiles/base-img/dev-base.Dockerfile ./dockerfiles/base-img/ --push;
# docker build -t linkinghack/dev-container:220726 -f ./dockerfiles/base-img/dev-base.Dockerfile ./dockerfiles/base-img/;
# docker push linkinghack/dev-container:220726;

# build VM base image for Virtink VM for ClusterAPI clusters
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs:k125-4 -f ./dockerfiles/vm/vm-rootfs-k1.25/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.25 --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-ubuntu:k124-0-2310-1 -f ./dockerfiles/vm/vm-rootfs-k1.24.0/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.24.0 --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-cdi:k125-12 -f ./dockerfiles/vm/cdi.Dockerfile ./dockerfiles/vm --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-ubuntu:k125-12-2310-1 -f ./dockerfiles/vm/vm-rootfs-k1.25/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.25 --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-ubuntu:k126-2-2310-1 -f ./dockerfiles/vm/vm-rootfs-k1.26.2/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.26.2 --push;
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs:k125-12 -f ./dockerfiles/vm/vm-rootfs-k1.25/Dockerfile ./dockerfiles/vm/vm-rootfs-k1.25 --push;
docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs-fedora38:k127-4-2310-1 -f ./dockerfiles/vm/vm-rootfs-k1.27.4/fedora.Dockerfile ./dockerfiles/vm/vm-rootfs-k1.27.4 --push;
# docker build -t linkinghack/vm-rootfs-fedora38:k127-4-amd64 -f ./dockerfiles/vm/vm-rootfs-k1.27.4/fedora.Dockerfile ./dockerfiles/vm/vm-rootfs-k1.27.4;
# docker push linkinghack/vm-rootfs-fedora38:k127-4-amd64

# build 1.24.0 CDI rootfs image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/vm-rootfs:k124-0-cdi -f ./dockerfiles/vm/vm-cdi-rootfs-1.24.0/Dockerfile ./dockerfiles/vm/vm-cdi-rootfs-1.24.0 --push;

# Build Python base images
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/python:3.10-transformer -f ./dockerfiles/lang-base/python/transformer/Dockerfile ./dockerfiles/lang-base/python/transformer --push;

# Build istio bookinfo example
# git clone git@github.com:istio/istio.git
# cd istio
# export TAG=230710
# export HUB=docker.io/linkinghack
# docker buildx bake -f ./samples/bookinfo/src/docker-bake.hcl --set "*.platform=linux/amd64,linux/arm64" --push --provenance=false

# Build prometheus-adapter
# git clone git@github.com:kubernetes-sigs/prometheus-adapter.git
# cd prometheus-adapter
# git checkout v0.10.0
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/prometheus-adapter:v0.10.0 --build-arg GO_VERSION=1.18.9 . --push

# build NicTool image
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/nictool:221123 -f ./dockerfiles/nictool/Dockerfile ./dockerfiles/nictool --push;

# build bind9-webmin
# docker buildx build --platform linux/arm64,linux/amd64 -t linkinghack/bin9-webmin:230305 -f ./dockerfiles/bind9-webmin/Dockerfile ./dockerfiles/bind9-webmin --push;

