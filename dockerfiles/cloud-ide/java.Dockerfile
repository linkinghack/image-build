FROM docker AS docker-cli

FROM linkinghack/code-server:4.2.0-ls117
ARG TARGETPLATFORM

COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker
COPY product.json /usr/lib/code-server/lib/vscode/product.json
COPY lang_specific_confs/maven.settings.xml /config/.m2/settings.xml


USER root
## install dev tools for Java development
RUN sudo apt update \
  && apt upgrade -y \
  && sudo apt install curl vim wget unzip -y

RUN  if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jdk_x64_linux_hotspot_8u322b06.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jdk_aarch64_linux_hotspot_8u322b06.tar.gz; fi \
  && curl -sSL -o java8.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java8.tar.gz \
  && rm -f java8.tar.gz \
  && echo "export PATH=$PATH:/usr/local/jdk8u322-b06/bin" >> /config/.bashrc \
  && if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14.1%2B1/OpenJDK11U-jdk_x64_linux_hotspot_11.0.14.1_1.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14.1%2B1/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.14.1_1.tar.gz; fi \
  && curl -sSL -o java11.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java11.tar.gz \
  && rm -f java11.tar.gz \
  && if [ "${TARGETPLATFORM}" = 'linux/amd64' ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18%2B36/OpenJDK18U-jdk_x64_linux_hotspot_18_36.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18%2B36/OpenJDK18U-jdk_aarch64_linux_hotspot_18_36.tar.gz; fi \
  && curl -sSL -o java18.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java18.tar.gz \
  && rm -f java18.tar.gz \
  && curl -sSL -o maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz \
  && tar -C /usr/local -zxf ./maven.tar.gz \
  && rm -f maven.tar.gz \
  && echo "export PATH=$PATH:/usr/local/apache-maven-3.8.5/bin" >> /config/.bashrc \
  && curl -sSL -o gradle.zip https://services.gradle.org/distributions/gradle-7.4.2-all.zip \
  && unzip -d /usr/local ./gradle.zip \
  && rm -f gradle.zip \
  && echo "export PATH=$PATH:/usr/local/gradle-7.4.2/bin" >> /config/.bashrc

# create user
ENV PUID=1001
ENV PGID=1001
RUN useradd -m -u 1001 panzhou-user \
  && chown panzhou-user:panzhou-user /app \
  && chown panzhou-user:panzhou-user /config \
  && chown panzhou-user:panzhou-user /defaults

# USER panzhou-user

USER 1001
## configure jenv
RUN git clone https://github.com/jenv/jenv.git /config/.jenv \
  && echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> /config/.bash_profile \
  && echo 'eval "$(jenv init -)"' >> /config/.bash_profile
#   && export PATH="$HOME/.jenv/bin:$PATH" \
#   && jenv add /usr/local/jdk8u322-b06 \
#   && jenv add /usr/local/jdk-11.0.14.1+1 \
#   && jenv add /usr/local/jdk-18+36

ENV JAVA_HOME=/usr/local/jdk8u322-b06
ENV MAVEN_HOME=/usr/local/apache-maven-3.8.5
ENV GRADLE_HOME=/usr/local/gradle-7.4.2
USER root