FROM linkinghack/devenv-base-ubuntu-withnode:jammy-2404-1

RUN apt update && apt install build-essential cmake perl  \
  && apt install -y gdb gdb-bpf \
  && apt install libclang-14-dev clang-14 clangd-14 libclang-cpp-dev clang-tools-14 clang-tidy-14 clang-format-14 clang-14-doc

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN chmod -R 777 /usr/local/share/nvm
USER devspace
