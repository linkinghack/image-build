FROM lscr.io/linuxserver/code-server:4.96.4-ls250 as vscode

# FROM lscr.io/linuxserver/code-server:4.4.0-ls125
FROM linkinghack/devenv-cxx14-ubuntu:2501-1

# For CangjieENV update notice
# COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt

ARG BASE_ENV_HOME=/home/devspace

USER root
# Copy CodeServer binaries
COPY --from=vscode /app/code-server /usr/local/code-server
RUN mkdir -p /usr/local/share/vscode/extensions \
  && chmod -R 777 /usr/local/share/vscode

USER devspace
CMD [ "/usr/local/code-server/bin/code-server", \
    "--bind-addr", "0.0.0.0:8443", \
    "--user-data-dir", "/home/devspace/.vscode/data", \
    "--extensions-dir", "/usr/local/share/vscode/extensions", \
    "--auth",  "none", \
    "--disable-telemetry", \
    "--disable-getting-started-override" ]
EXPOSE 8443
