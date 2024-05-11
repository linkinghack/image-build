FROM linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
ENV NVM_DIR=/usr/local/share/nvm
RUN chmod -R 777 /usr/local/share/nvm \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install lts/iron \
    && nvm install lts/hydrogen \
    && nvm install lts/gallium \
    && nvm install lts/fermium \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    && apt-get clean \
    && apt-get autoclean

RUN npm i -g typescript
USER devspace

