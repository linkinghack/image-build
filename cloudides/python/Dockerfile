FROM lscr.io/linuxserver/code-server:4.96.4-ls250 as vscode

# FROM lscr.io/linuxserver/code-server:4.4.0-ls125
FROM linkinghack/devenv-python-ubuntu:bullseye-2405-1

ARG BASE_ENV_HOME=/home/devspace
ARG S6_OVERLAY_VERSION=3.2.0.2

USER root
# Copy CodeServer binaries
COPY --from=vscode /app/code-server /usr/local/code-server

RUN apt update \
    && apt install xz-utils -y \
    && apt autoclean -y \
    && pip install jupyterlab

USER devspace
