FROM buildpack-deps:jammy-curl

RUN apt update && apt upgrade -y \
    && apt install vim dnsutils telnet perl net-tools netcat nano -y \
    && apt clean
