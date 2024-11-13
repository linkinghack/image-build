FROM buildpack-deps:noble-curl

RUN apt update && apt upgrade -y \
    && apt install vim dnsutils telnet perl net-tools netcat nano wget curl netcat tmux  -y \
    && apt clean
