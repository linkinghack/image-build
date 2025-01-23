FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3

RUN apt update && apt install -y build-essential cmake perl  \
  && apt install -y gdb gdb-bpf \
  && apt install -y gcc-7 g++-7 libgcc-7-dev libstdc++-7-dev \
  && apt install -y cmake make clang-7 clangd-7 libclang-7-dev libclang-cpp7-dev clang-tools-7 clang-tidy-7 clang-format-7 clang-7-doc \
  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN apt-get update -y \
  &&  apt-get upgrade -y \
  && apt-get clean \
  && apt-get autoclean
USER devspace
