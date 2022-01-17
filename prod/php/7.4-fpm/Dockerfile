FROM php:7.4-fpm

VOLUME /srv/cache

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        unzip gettext-base openssh-client wget git jq make cmake libssl-dev libssl-doc \
        libxml2-dev zlib1g-dev libmagickwand-dev libcurl3-dev sudo libpq-dev libbz2-dev \
        libgeoip-dev libevent-dev libsodium-dev libtidy-dev libxslt1-dev libzip-dev \
        libc-client-dev librabbitmq-dev libkrb5-dev libkrb5-dev libpng-dev libjpeg-dev \
        libonig-dev \
    && pecl install redis \
    && pecl install mongodb \
    && docker-php-ext-configure gd \
       --enable-gd \
       --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        calendar \
        exif \
        ftp \
        gd \
        gettext \
        iconv \
        intl \
        mbstring \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        shmop \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        tidy \
        xsl \
        zip \
    && docker-php-ext-enable \
            mongodb \
            opcache \
            redis \
    && pecl install igbinary \
    && pecl install event \
    && pecl install propro \
    && pecl install raphf \
    && docker-php-ext-enable \
            igbinary \
            propro \
            raphf \
            event \
    && pecl install libsodium \
    && pecl install pecl_http \
    && pecl install amqp \
    && pecl install imagick \
    && pecl install geoip-1.1.1 \
    && docker-php-ext-enable sodium \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-enable http \
    && docker-php-ext-enable amqp \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable geoip \
    && apt-get clean \
    && pecl clear-cache \
    && mkdir /nginx \
    && rm -rf /var/lib/apt/lists/* \
    && cd -

# Copy config
COPY ./config/system /docker/
ADD config/php/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini
ADD config/php/custom-php-fpm.conf /usr/local/etc/php-fpm.d/zz-custom-php.conf

ENTRYPOINT ["/bin/bash", "/docker/entrypoint.sh"]
CMD ["php-fpm"]
