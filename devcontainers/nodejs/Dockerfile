FROM linkinghack/devcontainer-base:bullseye-2308-2

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN nvm install v16.20.2 \
    && nvm install v14.21.3 \
    && nvm install v12.22.12

USER devspace

RUN npm i -g typescript
