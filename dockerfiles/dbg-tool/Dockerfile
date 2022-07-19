FROM bitnami/kubectl:latest as kubectl

FROM golang as heyBuilder
WORKDIR /code
RUN  git clone https://github.com/rakyll/hey.git \
  && cd hey \
  && go build -o ./bin/hey
# COPY ./hey .
# ENV GOPROXY https://goproxy.cn
# RUN go build -o ./bin/hey

FROM ubuntu
RUN apt update \
  && apt install git vim wget curl iputils-ping net-tools telnet netcat nano python2 python3 netcat -y

COPY --from=heyBuilder /code/bin/hey /usr/local/bin/hey
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
RUN chmod 755 /usr/local/bin/hey

ENTRYPOINT [ "tail", "-f", "/dev/null" ]