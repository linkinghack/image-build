FROM ubuntu:jammy
RUN  apt update \
    &&  apt upgrade -y \
    &&  apt install git nano vim gcc gdb g++ cmake curl wget netcat telnet make net-tools unzip zsh -y