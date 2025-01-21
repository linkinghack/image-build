#!/bin/bash

set -xeu

USERNAME=${USERNAME:-"devspace"}

pip3 install jupyterlab

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
sudo $HOME/miniconda.sh -b -p /usr/local/miniconda3

echo "Installation of miniconda completed"

# clear installation file
rm -f $HOME/miniconda.sh

sudo -u $USERNAME /usr/local/miniconda3/bin/conda init zsh
sudo -u $USERNAME /usr/local/miniconda3/bin/conda init bash

__conda_setup="$('/usr/local/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

## config conda env location
conda config --add envs_dirs /usr/local/miniconda3/envs
sudo -u $USERNAME /usr/local/miniconda3/bin/conda config --add envs_dirs /usr/local/miniconda3/envs
## install more python versions
conda create -n py38 -q -y  python=3.8
conda create -n py311 -q -y  python=3.11
conda create -n py312 -q -y  python=3.12
