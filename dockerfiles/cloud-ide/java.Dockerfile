FROM docker AS docker-cli

FROM lscr.io/linuxserver/code-server:4.4.0-ls125
ARG TARGETPLATFORM

COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker
COPY product.json /usr/lib/code-server/lib/vscode/product.json
COPY lang_specific_confs/maven.settings.xml /config/.m2/settings.xml
COPY lang_specific_confs/maven.settings.xml /root/.m2/settings.xml


USER root
## install dev tools for Java development
RUN sudo apt update \
  && sudo apt upgrade -y \
  && sudo apt install curl vim wget unzip nano zsh -y

RUN  if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u332-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u332b09.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u332-b09/OpenJDK8U-jdk_aarch64_linux_hotspot_8u332b09.tar.gz; fi \
  && curl -sSL -o java8.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java8.tar.gz \
  && rm -f java8.tar.gz \
  && if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.15%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.15_10.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.15%2B10/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.15_10.tar.gz; fi \
  && curl -sSL -o java11.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java11.tar.gz \
  && export PATH=$PATH:/usr/local/jdk-11.0.15+10/bin \
  && rm -f java11.tar.gz \
  && if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.1%2B10/OpenJDK18U-jdk_x64_linux_hotspot_18.0.1_10.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18.0.1%2B10/OpenJDK18U-jdk_aarch64_linux_hotspot_18.0.1_10.tar.gz; fi \
  && curl -sSL -o java18.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java18.tar.gz \
  && rm -f java18.tar.gz \
  && curl -sSL -o maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz \
  && tar -C /usr/local -zxf ./maven.tar.gz \
  && rm -f maven.tar.gz \
  && export PATH=$PATH:/usr/local/apache-maven-3.8.5/bin \
  && curl -sSL -o gradle.zip https://services.gradle.org/distributions/gradle-7.4.2-all.zip \
  && unzip -d /usr/local ./gradle.zip \
  && rm -f gradle.zip \
  && export PATH=$PATH:/usr/local/gradle-7.4.2/bin \
  && echo "export PATH=$PATH" >> /etc/profile

## configure jenv
RUN git clone https://github.com/jenv/jenv.git /config/.jenv \
  && echo 'export PATH=$HOME/.jenv/bin:$PATH' >> /config/.bash_profile \
  && echo 'eval "$(jenv init -)"' >> /config/.bash_profile \
  && echo 'export PATH=$HOME/.jenv/bin:$PATH' >> /root/.bash_profile \
  && echo 'eval "$(jenv init -)"' >> /root/.bash_profile
#   && export PATH="$HOME/.jenv/bin:$PATH" \
#   && jenv add /usr/local/jdk8u322-b06 \
#   && jenv add /usr/local/jdk-11.0.15+10 \
#   && jenv add /usr/local/jdk-18+36
RUN chmod -R 755 /config/.jenv

ENV JAVA_HOME=/usr/local/jdk-11.0.15+10
ENV MAVEN_HOME=/usr/local/apache-maven-3.8.5
ENV GRADLE_HOME=/usr/local/gradle-7.4.2
# ENV PATH="$PATH:${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${GRADLE_HOME}/bin"
USER root
