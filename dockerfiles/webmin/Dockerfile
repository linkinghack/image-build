FROM linkinghack/bind9-webmin:221208

RUN echo "service named start; \n\
service webmin start \n\
sleep 36500d"\
  >> /entrypoint.sh

ENTRYPOINT [ "sh", "/entrypoint.sh" ]
# /usr/bin/perl /usr/share/webmin/miniserv.pl /etc/webmin/miniserv.conf
# /usr/sbin/named -u bind

EXPOSE 53
EXPOSE 953
EXPOSE 10000