FROM golang as heyBuilder
WORKDIR /code
RUN  git clone https://github.com/rakyll/hey.git \
  && cd hey \
  && go build -o ./bin/hey
# COPY ./hey .
# ENV GOPROXY https://goproxy.cn
# RUN go build -o ./bin/hey

# FROM bitnami/kubectl:latest as kubectl
# COPY --from=heyBuilder /code/bin/hey /usr/local/bin/hey

FROM ubuntu
RUN apt update \
  && apt install git vim wget curl openssh-client iputils-ping net-tools telnet netcat nano python2 python3 netcat -y

COPY --from=heyBuilder /usr/local/bin/hey /usr/local/bin/hey
COPY --from=bitnami/kubectl:latest /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
RUN chmod 755 /usr/local/bin/hey \
   && chmod 755 /usr/local/bin/kubectl


ENTRYPOINT [ "tail", "-f", "/dev/null" ]