FROM linkinghack/devcontainer-base:bullseye-2308-1

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN sed -i 's|[ -t 1 ] && [[ "${TERM_PROGRAM}" = "vscode" || "${TERM_PROGRAM}" = "codespaces" ]]|[ -t 1 ]|g' 
USER devspace