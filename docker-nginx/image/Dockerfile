FROM nginx:stable-alpine

RUN apk add --update --no-cache \
    ca-certificates \
    bash \
    bc \
    wget \
    socat \
    openssl \
    coreutils \
 && rm -rf /tmp/* /var/cache/apk/* \
 && mkdir /etc/nginx/xtra \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

COPY --chown=root:root templates /etc/nginx/templates
COPY --chown=root:root nginx.conf /etc/nginx/

HEALTHCHECK --interval=10s --timeout=5s \
  CMD curl -f http://localhost/ || exit 1
