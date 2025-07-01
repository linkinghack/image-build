FROM linkinghack/devenv-base-ubuntu-withnode:focal-250124-1

RUN apt update && apt install software-properties-common -y \
  && add-apt-repository ppa:cncf-buildpacks/pack-cli \
  && apt update \
  && apt-get install pack-cli vim git net-tools curl wget -y
