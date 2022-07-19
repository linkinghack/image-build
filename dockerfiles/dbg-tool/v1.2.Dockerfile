FROM bitnami/kubectl:latest as kubectl

FROM linkinghack/dbg-tool:v1
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
RUN chmod a+x /usr/local/bin/kubectl