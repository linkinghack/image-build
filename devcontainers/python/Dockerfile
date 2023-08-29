FROM linkinghack/devcontainer-base:bullseye-2308-2

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN chmod -R 777 /usr/local/share/nvm \
    && echo 'alias anaconda="source ~/.conda.rc"' >> /etc/bash.bashrc
USER devspace

COPY conda.rc /home/devspace/.conda.rc
COPY install_conda.sh install.sh
RUN bash install.sh