FROM ubuntu:jammy
RUN sudo apt update \
    && sudo apt upgrade -y \
    && sudo apt install git nano vim gcc gdb g++ cmake curl wget netcat telnet make net-tools unzip zsh -y