FROM golang as procbuild
WORKDIR /code
RUN git clone https://github.com/jpillora/webproc.git \
   && cd webproc \
   && go build -o webproc .

FROM ubuntu
# webproc release settings
# fetch dnsmasq and webproc binary
COPY --from=procbuild /code/webproc/webproc /usr/bin/webproc
RUN apk update \
	&& apk --no-cache add dnsmasq \
	&& chmod +x /usr/bin/webproc
#configure dnsmasq
RUN mkdir -p /etc/default/
RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf
#run!
ENTRYPOINT ["webproc","--config","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon"]
