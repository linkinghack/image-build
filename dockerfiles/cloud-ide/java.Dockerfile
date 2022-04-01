FROM codercom/code-server:4.2.0
ARG TARGETPLATFORM

COPY ./product.json /usr/lib/code-server/lib/vscode/product.json
COPY ./lang_specific_confs/maven.settings.xml /home/coder/.m2/settings.xml


USER root
## install dev tools for Java development
RUN sudo apt update \
  && sudo apt install curl vim wget unzip net-tools -y \
  && if [ ${TARGETPLATFORM}} == "linux/amd64" ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jdk_x64_linux_hotspot_8u322b06.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u322-b06/OpenJDK8U-jdk_aarch64_linux_hotspot_8u322b06.tar.gz; fi \
  && curl -sSL -o java8.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java8.tar.gz \
  && rm -f java8.tar.gz \
  && echo "PATH=$PATH:/usr/local/jdk8u322-b06/bin" >> /home/coder/.bashrc \
  && if [ ${TARGETPLATFORM}} == "linux/amd64" ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14.1%2B1/OpenJDK11U-jdk_x64_linux_hotspot_11.0.14.1_1.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.14.1%2B1/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.14.1_1.tar.gz; fi \
  && curl -sSL -o java11.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java11.tar.gz \
  && rm -f java11.tar.gz \
  && if [ ${TARGETPLATFORM}} == "linux/amd64" ]; then export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18%2B36/OpenJDK18U-jdk_x64_linux_hotspot_18_36.tar.gz; else export DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18%2B36/OpenJDK18U-jdk_aarch64_linux_hotspot_18_36.tar.gz; fi \
  && curl -sSL -o java18.tar.gz ${DOWNLOAD_URL} \
  && tar -C /usr/local -zxf java18.tar.gz \
  && rm -f java18.tar.gz \
  && curl -sSL -o maven.tar.gz https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz \
  && tar -C /usr/local -zxf ./maven.tar.gz \
  && rm -f maven.tar.gz \
  && echo "PATH=$PATH:/usr/local/apache-maven-3.8.5/bin" >> /home/coder/.bashrc \
  && curl -sSL -o gradle.zip https://gradle.org/next-steps/?version=7.4.2&format=all \
  && unzip -d /usr/local gradle.zip \
  && rm -f gradle.zip \
  && echo "PATH=$PATH:/usr/local/gradle-7.4.2/bin" >> /home/coder/.bashrc

USER coder

## configure jenv
RUN git clone https://github.com/jenv/jenv.git ~/.jenv \
  && echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile \
  && echo 'eval "$(jenv init -)"' >> ~/.bash_profile \
  && jenv add /usr/local/jdk8u322-b06 \
  && jenv add /usr/local/jdk-11.0.14.1+1 \
  && jenv add /usr/local/jdk-18+36

ENV JAVA_HOME=/usr/local/jdk8u322-b06
ENV MAVEN_HOME=/usr/local/apache-maven-3.8.5
ENV GRADLE_HOME=/usr/local/gradle-7.4.2