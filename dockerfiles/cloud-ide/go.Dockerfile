FROM codercom/code-server:4.2.0
COPY ./product.json /usr/lib/code-server/lib/vscode/product.json

ARG TARGETPLATFORM

USER root
## install dev tools for Go development
RUN sudo apt update \
    && sudo apt upgrade -y \
    && sudo apt install vim gcc gdb g++ curl wget make net-tools -y

## install go compiler
RUN if [ "${TARGETPLATFORM}" == "linux/amd64" ]; then export DOWNLOAD_URL=https://go.dev/dl/go1.18.linux-amd64.tar.gz; else export DOWNLOAD_URL=https://go.dev/dl/go1.18.linux-arm64.tar.gz; fi \
  && curl -sSL -o go.tar.gz ${DOWNLOAD_URL} \
  &&  tar -C /usr/local -xzf go.tar.gz \
  && rm -f go.tar.gz \
  &&  echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile

USER coder