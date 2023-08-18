#!/bin/bash

wget https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz

sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-v18.17.1-linux-x64.tar.xz -C /usr/local/lib/nodejs 

# Update PATH var
export PATH=/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin:$PATH

. ~/.profile

## install devcontainer
sudo npm install -g @devcontainers/cli