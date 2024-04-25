#!/bin/bash
set -x
wget https://nodejs.org/dist/v18.17.1/node-v18.17.1-linux-x64.tar.xz

sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-v18.17.1-linux-x64.tar.xz -C /usr/local/lib/nodejs 

# Update PATH var
export PATH=/usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin:$PATH

source ~/.profile

sudo chmod -R 777 /usr/local/lib/nodejs/node-v18.17.1-linux-x64

## install devcontainer
npm install -g @devcontainers/cli

ls -alh /usr/local/lib/nodejs/node-v18.17.1-linux-x64/bin
