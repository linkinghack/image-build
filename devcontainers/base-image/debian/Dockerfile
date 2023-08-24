FROM buildpack-deps:bullseye-curl

RUN apt update && apt upgrade -y \
    && apt install vim dnsutils telnet -y \
    && apt clean