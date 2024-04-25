FROM linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
ENV NVM_DIR=/usr/local/share/nvm
RUN chmod -R 777 /usr/local/share/nvm \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install v16.20.2 \
    && nvm install v14.21.3 \
    && nvm install v12.22.12

RUN npm i -g typescript
USER devspace

