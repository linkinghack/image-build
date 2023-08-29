#!/bin/bash

set -xeu

pip3 install jupyterlab


# mkdir -p ~/miniconda3

architecture="$(uname -m)"
if [ "${architecture}" = "x86_64" ]; then
    echo "(!) Architecture $architecture unsupported"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh

elif [ "${architecture}" = "aarch64" ]; then
    echo "(!) Architecture $architecture unsupported"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O $HOME/miniconda.sh
fi

## start install
chmod +x $HOME/miniconda.sh;
$HOME/miniconda.sh -b

echo "Installation of miniconda completed"

source /etc/bash.bashrc

## install more python versions
conda create -n py27 -q -y  python=2.7
conda create -n py38 -q -y  python=3.8
conda create -n py311 -q -y  python=3.11
