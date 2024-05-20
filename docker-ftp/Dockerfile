FROM centos:centos7

RUN yum -y install openssl vsftpd && rm -rf /var/cache/yum/*

COPY vsftp.conf /etc/vsftp/vsftp.conf
COPY start.sh /

RUN chmod +x /start.sh
RUN mkdir -p /var/www/html
RUN chown -R daemon:daemon /var/www/html/

ENTRYPOINT ["/start.sh"]
