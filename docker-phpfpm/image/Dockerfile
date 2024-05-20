FROM php:7.3.29-fpm-alpine3.14
ENV PHPIZE_DEPS \
    coreutils \
    autoconf \
    dpkg-dev dpkg \
    file \
    g++ \
    gcc \
    libc-dev \
    make \
    pkgconf \
    re2c \
    libzip-dev

RUN set -xe; \
    apk add --no-cache --update --virtual .build-deps \
	  ${PHPIZE_DEPS} \
    icu-dev \
    oniguruma-dev \
    zlib-dev \
    libxml2-dev \
    imagemagick6-dev \
    libwebp-dev; \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1); \
    docker-php-ext-install -j${NPROC} \
    exif \
    intl \
    mysqli \
    mbstring \
    zip \
    soap \
    sockets \
 && pecl channel-update pecl.php.net \
 && pecl install imagick \
 && pecl install apcu \
 && docker-php-ext-enable imagick apcu \
 && pecl install redis \
 && docker-php-ext-enable redis.so \
 && echo -e 'file_uploads = On\n\
memory_limit = 256M\n\
upload_max_filesize = 250M\n\
post_max_size = 250M\n\
max_execution_time = 600\n\
SMTP = mail'\
>> /usr/local/etc/php/conf.d/docker-php-uploads.ini \
 && runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
&& apk add --no-cache --virtual .php-rundeps $runDeps \
&& apk del .build-deps \
&& apk add --no-cache --update \
    mysql-client \
    #Supervisor
    supervisor \
&& rm -rf /tmp/* /var/cache/apk/*  ~/.pearrc


COPY --chown=root:root ./supervisord.conf /etc/supervisord.conf
COPY --chown=root:root ./www.conf /usr/local/etc/php-fpm.d/www.conf

RUN apk update && apk add fcgi

CMD /usr/bin/supervisord -c /etc/supervisord.conf

HEALTHCHECK --interval=10s --timeout=5s \
    CMD \
    SCRIPT_NAME=/ping \
    SCRIPT_FILENAME=/ping \
    REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1
