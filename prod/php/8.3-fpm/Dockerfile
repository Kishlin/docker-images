FROM php:8.3-fpm

VOLUME /srv/cache

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        vim unzip gettext-base openssh-client wget git jq make cmake libssl-dev libssl-doc \
        libxml2-dev zlib1g-dev libmagickwand-dev libcurl3-dev sudo libpq-dev libbz2-dev \
        libtidy-dev libxslt1-dev libzip-dev libc-client-dev librabbitmq-dev libkrb5-dev \
        libkrb5-dev libpng-dev libjpeg-dev libonig-dev \
    && pecl install redis \
    && pecl install mongodb \
    && docker-php-ext-configure gd \
       --enable-gd \
       --with-jpeg

RUN docker-php-ext-install -j$(nproc) \
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
        zip

RUN docker-php-ext-enable \
            mongodb \
            opcache \
            redis

RUN pecl install igbinary

RUN pecl install raphf

RUN docker-php-ext-enable \
            igbinary \
            raphf

RUN pecl install pecl_http \
    && mkdir -p /usr/src/php/ext/amqp \
    && curl -fsSL https://pecl.php.net/get/amqp | tar xvz -C "/usr/src/php/ext/amqp" --strip 1 \
    && docker-php-ext-install amqp

RUN apt-get -y install gcc autoconf libc-dev pkg-config
RUN apt-get -y install libmagickwand-dev

RUN curl -L -o /tmp/imagick.tar.gz https://github.com/Imagick/imagick/archive/7088edc353f53c4bc644573a79cdcd67a726ae16.tar.gz \
    && tar --strip-components=1 -xf /tmp/imagick.tar.gz \
    && phpize \
    && ./configure

RUN make \
    && make install \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    && rm -rf /tmp/*

RUN PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-enable http

RUN docker-php-ext-enable amqp

RUN docker-php-ext-enable imagick

RUN apt-get clean

RUN mkdir /nginx \
    && rm -rf /var/lib/apt/lists/* \
    && cd -

# Copy config
COPY ./config/system /docker/
ADD config/php/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini
ADD config/php/custom-php-fpm.conf /usr/local/etc/php-fpm.d/zz-custom-php.conf

ENTRYPOINT ["/bin/bash", "/docker/entrypoint.sh"]

CMD ["php-fpm"]
