# FROM buildpack-deps:noble-curl
# FROM ubuntu:jammy
FROM ubuntu:focal

RUN apt update && apt upgrade -y \
    && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt install vim dnsutils iputils-ping telnet perl net-tools netcat-traditional nano wget curl tmux  -y \
    && apt clean
