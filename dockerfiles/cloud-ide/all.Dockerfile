FROM ghcr.io/linuxserver/code-server:4.9.1-ls146 as coderserver

FROM linkinghack/ide-base:full-230116

# Copy CodeServer binaries
COPY --from=codeserver /app/code-server /usr/local/code-server

USER devspace
CMD [ "/usr/local/code-server/bin/code-server", "--bind-addr", "0.0.0.0:8443", "--user-data-dir", "/home/devspace/ide/data", "--extensions-dir", "/home/devspace/ide/extensions", "--disable-telemetry", "--auth",  "none"]
EXPOSE 8443

