FROM golang as heyBuilder
WORKDIR /code
RUN  git clone https://github.com/rakyll/hey.git \
  && cd hey \
  && go build -o ./bin/hey

FROM ubuntu
RUN apt update \
  && apt install git vim wget curl iputils-ping net-tools nano python2 python3 -y

COPY --from=heyBuilder /code/hey/bin/hey /usr/local/bin/hey
RUN chmod 755 /usr/local/bin/hey

ENTRYPOINT [ "tail", "-f", "/dev/null" ]