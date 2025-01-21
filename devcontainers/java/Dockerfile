FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3
ENV SDKMAN_DIR /usr/local/sdkman

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN  apt-get update -y \
    &&  apt-get upgrade -y \
    && apt-get clean \
    && apt-get autoclean
USER devspace
