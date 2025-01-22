FROM lscr.io/linuxserver/code-server:4.96.4-ls250 as vscode

# FROM lscr.io/linuxserver/code-server:4.4.0-ls125
FROM linkinghack/devenv-python-ubuntu:bullseye-2405-1

ARG BASE_ENV_HOME=/home/devspace
ARG S6_OVERLAY_VERSION=3.2.0.2

USER root
# Copy CodeServer binaries
COPY --from=vscode /app/code-server /usr/local/code-server


RUN chmod -R 777 ${BASE_ENV_HOME}/.vscode \
    && usermod -aG docker devspace \
    && apt update \
    && apt install xz-utils -y \
    && apt autoclean -y \
    && pip install jupyterlab

# install s6-overlay
ARG ARCH=$(uname -m)
RUN curl -L -o /tmp/s6-overlay-noarch.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && curl -L -o /tmp/s6-overlay-${ARCH}.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${ARCH}.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-${ARCH}.tar.xz

USER devspace
ENTRYPOINT [ "/init" ]

EXPOSE 8888
EXPOSE 8443
