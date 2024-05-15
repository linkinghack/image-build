FROM linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt

RUN apt update && apt install -y build-essential cmake perl  \
  && apt install -y gdb gdb-bpf \
  && pipx install --include-deps ansible

RUN chmod -R 777 /usr/local/share/nvm \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    && apt-get clean \
    && apt-get autoclean
USER devspace
