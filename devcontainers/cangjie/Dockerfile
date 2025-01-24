FROM docker.io/linkinghack/cj-sdk:0.53.13 AS sdk
# FROM docker.io/linkinghack/openssl-prebuild:3.4.0 AS openssl

FROM linkinghack/devenv-base-ubuntu-withnode:jammy-250113-3

COPY --from=sdk /usr/local/cangjie/cangjie /usr/local/cangjie

COPY first-run-notice.txt  /usr/local/etc/vscode-dev-containers/first-run-notice.txt

USER root
# install latest openssl
# RUN curl -sSL https://github.com/openssl/openssl/releases/download/openssl-3.4.0/openssl-3.4.0.tar.gz -o openssl-3.4.0.tar.gz \
#   && tar -xvf openssl-3.4.0.tar.gz \
#   && cd openssl-3.4.0 \
#   && ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib \
#   && make \
#   && make install \
#   && cd .. \
#   && rm -rf openssl-3.4.0 openssl-3.4.0.tar.gz
# install cangjie SDK dependencies
RUN  apt-get update -y \
    && apt-get install binutils libc-dev libc++-dev libgcc-9-dev  build-essential perl libperl-dev libssl-dev libssl3 -y \
    && apt-get clean \
    && apt-get autoclean

# RUN --mount=type=bind,from=openssl,source=/usr/local/openssl-3.4.0,dst=/sdk/openssl \
#     cd /sdk/openssl \
#     && make install \
#     && ls -alh /usr/local/openssl-3.4.0

# install conan, openssl
RUN  echo "export LIBRARY_PATH=/usr/local/openssl-3.4.0/lib:$LIBRARY_PATH" >> /etc/profile \
  && echo "<prefix>/lib" >> /etc/ld.so.conf \
  && ldconfig

COPY envsetup.sh /etc/profile.d/envsetup.sh

USER devspace
# ARG hw_arch=$(arch)
# ENV CANGJIE_HOME=/usr/local/cangjie
# ENV PATH=${CANGJIE_HOME}/bin:${CANGJIE_HOME}/tools/bin:$PATH:${HOME}/.cjpm/bin
# ENV LD_LIBRARY_PATH=${CANGJIE_HOME}/runtime/lib/linux_${hw_arch}_llvm:${CANGJIE_HOME}/tools/lib:${LD_LIBRARY_PATH}
