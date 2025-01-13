FROM fedora:42

RUN dnf update -y \
    && dnf install -y vim bind-utils telnet perl net-tools nc nano wget curl tmux \
    && dnf install -y ca-certificates \
    curl \
    gnupg \
    net-tools \
    wget \
    && dnf clean all