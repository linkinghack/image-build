FROM linkinghack/devcontainer-base:bullseye-2308-2

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
ENV NVM_DIR=/usr/local/share/nvm
RUN chmod -R 755 /usr/local/share/nvm \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install v16.20.2 \
    && nvm install v14.21.3 \
    && nvm install v12.22.12

RUN npm i -g typescript
USER devspace

