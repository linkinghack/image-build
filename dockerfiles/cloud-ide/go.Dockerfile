FROM docker AS docker-cli

FROM linkinghack/code-server:4.2.0-ls117
COPY product.json /usr/lib/code-server/lib/vscode/product.json
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker

ARG TARGETPLATFORM

USER root
## install dev tools for Go development
# RUN sudo apt update \
#     && sudo apt upgrade -y \
#     && sudo apt install vim gcc gdb g++ curl wget make net-tools unzip -y

## install go compiler
RUN if [ "${TARGETPLATFORM}" = 'linux/amd64' ];  \
    then export DOWNLOAD_URL=https://go.dev/dl/go1.18.linux-amd64.tar.gz; \
    curl -sSL -o go-amd.tar.gz ${DOWNLOAD_URL}; \
    tar -C /usr/local -xzf go-amd.tar.gz; \
    rm -f go-amd.tar.gz; \
  else export DOWNLOAD_URL=https://go.dev/dl/go1.18.linux-arm64.tar.gz;\
    curl -sSL -o go-arm.tar.gz ${DOWNLOAD_URL}; \
    tar -C /usr/local -xzf go-arm.tar.gz; \
    rm -f go-arm.tar.gz; \
  fi \
  &&  echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile

## install tools
RUN go install -v github.com/cweill/gotests/gotests@latest \
  && go install -v github.com/ramya-rao-a/go-outline@latest \ 
  && go install -v github.com/ramya-rao-a/go-outline@latest \ 
  && go install -v github.com/fatih/gomodifytags@latest \ 
  && go install -v github.com/josharian/impl@latest \ 
  && go install -v github.com/haya14busa/goplay/cmd/goplay@latest \
  && go install -v github.com/go-delve/delve/cmd/dlv@latest \
  && go install -v honnef.co/go/tools/cmd/staticcheck@latest \
  && go install -v golang.org/x/tools/gopls@latest 
  
## create user
ENV PUID=1001
ENV PGID=1001
RUN useradd -m -u 1001 panzhou-user \
  && chown panzhou-user:panzhou-user /app \
  && chown panzhou-user:panzhou-user /config \
  && chown panzhou-user:panzhou-user /defaults

# USER panzhou-user
