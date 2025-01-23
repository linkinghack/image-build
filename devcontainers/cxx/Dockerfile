FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3

RUN apt update && apt install -y build-essential cmake perl  \
  && apt install -y gdb gdb-bpf \
  && apt install -y libclang-14-dev clang-14 clangd-14 libclang-cpp-dev clang-tools-14 clang-tidy-14 clang-format-14 clang-14-doc

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN apt-get update -y \
  &&  apt-get upgrade -y \
  && apt-get clean \
  && apt-get autoclean
USER devspace
