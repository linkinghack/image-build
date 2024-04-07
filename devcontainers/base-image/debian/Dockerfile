FROM buildpack-deps:jammy-curl

RUN apt update && apt upgrade -y \
    && apt install vim dnsutils telnet perl -y \
    && apt clean
