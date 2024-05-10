FROM linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN chmod -R 777 /usr/local/share/nvm \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove
USER devspace
