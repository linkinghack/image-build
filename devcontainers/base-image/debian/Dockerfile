# FROM buildpack-deps:noble-curl
FROM ubuntu:jammy

RUN apt update && apt upgrade -y \
    && apt install vim dnsutils telnet perl net-tools netcat-traditional nano wget curl tmux  -y \
    && apt clean
