FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt
RUN chmod -R 777 /usr/local/share/nvm \
    && echo 'alias anaconda="source ~/.conda.rc"' >> /etc/bash.bashrc \
    && echo 'anaconda' >> /etc/bash.bashrc

USER root
ENV USERNAME=devspace
COPY install_conda.sh install.sh
RUN bash install.sh && rm install.sh

# 确保所有用户的环境变量中包含 Conda 的路径
COPY conda.sh /etc/profile.d/conda.sh
USER devspace
