FROM ubuntu:jammy

RUN apt update && apt install software-properties-common -y \
  && add-apt-repository ppa:cncf-buildpacks/pack-cli \
  && apt update \
  && apt-get install pack-cli vim git net-tools curl wget -y

# Install Docker
COPY ./install_docker.sh /tmp/install_docker.sh
RUN chmod +x /tmp/install_docker.sh && /tmp/install_docker.sh