FROM ghcr.io/linuxserver/code-server:4.9.1-ls146 as coderserver

FROM linkinghack/ide-base:full-230116

# Copy CodeServer binaries
COPY --from=coderserver /app/code-server /usr/local/code-server

ENV PATH="${PATH}:/home/devspace/.dotnet/current"

VOLUME [ "/ide", "/usr/local/code-server/.vscode" ]
USER devspace
CMD [ "/usr/local/code-server/bin/code-server", \
    "--bind-addr", "0.0.0.0:8443", \
    "--user-data-dir", "/ide/userdata", \
    "--extensions-dir", "/ide/extensions", \
    "--auth",  "none", \
    "--disable-telemetry", \
    "--disable-getting-started-override" ]
EXPOSE 8443
