FROM linkinghack/devenv-base-ubuntu-withnode:focal-250124-1

RUN apt update && apt install -y build-essential cmake perl  \
  && apt install -y gdb \
  && apt install -y gcc-7 g++-7 libgcc-7-dev libstdc++-7-dev \
  && apt install -y cmake make clang-7 libclang-7-dev clang-tools-7 clang-tidy-7 clang-format-7 clangd-8 libclang-cpp10-dev libclang-cpp10 \
  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN apt-get update -y \
  &&  apt-get upgrade -y \
  && apt-get clean \
  && apt-get autoclean
USER devspace
