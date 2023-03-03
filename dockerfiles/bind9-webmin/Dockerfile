FROM ubuntu/bind9
COPY setup-repo.sh /setup-repo.sh
RUN apt update -y \
  && bash /setup-repo.sh \
  && apt install webmin -y

COPY ./entrypoint.sh /entrypoint.sh
#  Create a temperory container with ubuntu image
# and use passwd root to generate a shadow/passwd file
COPY ./shadow /etc/shadow
COPY ./passwd /etc/passwd
COPY ./config /etc/webmin/config
ENTRYPOINT ["/entrypoint.sh"]
