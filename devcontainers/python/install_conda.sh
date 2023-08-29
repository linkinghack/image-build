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

__conda_setup="$('/home/devspace/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

## install more python versions
conda create -n py27 -q -y  python=2.7
conda create -n py38 -q -y  python=3.8
conda create -n py311 -q -y  python=3.11
