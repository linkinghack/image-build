FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN chmod -R 777 /usr/local/share/nvm \
    &&  apt-get update -y \
    &&  apt-get upgrade -y \
    && apt-get clean \
    && apt-get autoclean \
    && mkdir -p /usr/local/go \
    && mkdir -p /usr/local/gopath \
    && chmod -R 777 /usr/local/go && chmod -R 777 /usr/local/gopath

# ENV PATH=$PATH:/usr/local/go/bin:/usr/local/gopath/bin
# ENV GOPATH=/usr/local/gopath
# ENV GOROOT=/usr/local/go
USER devspace
