FROM debian:buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends sendmail net-tools && \
    rm -rf /var/lib/apt/lists/*

ENV HOSTNAME mydomain.com
ENV SUBNET=""

ADD entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 25

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD netstat -l | grep smtp
