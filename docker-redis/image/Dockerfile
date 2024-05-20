FROM redis:latest

RUN mkdir -p /usr/local/etc/redis
COPY redis.conf /usr/local/etc/redis/redis.conf


CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]

HEALTHCHECK --interval=10s --timeout=5s \
  CMD redis-cli ping || exit 1
