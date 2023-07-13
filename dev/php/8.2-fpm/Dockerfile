FROM kishlin/base-kishlin-php:8.2-fpm

VOLUME /srv/cache

ENV COMPOSER_ALLOW_SUPERUSER true
ENV COMPOSER_CACHE_DIR /srv/cache/composer/cache
ENV COMPOSER_DISABLE_XDEBUG_WARN 1
ENV COMPOSER_HOME /srv/cache/composer
ENV COMPOSER_MEMORY_LIMIT -1
ENV COMPOSER_VERSION 2.5.8
ENV XDEBUG_VERSION 3.2.1

RUN pecl channel-update pecl.php.net \
    && pecl install xdebug-${XDEBUG_VERSION} \
    && docker-php-ext-enable xdebug \
    && curl -sS http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
    && chmod -R 777 /srv/cache \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& cd - \
	&& apt update && apt upgrade -y && apt install -y parallel

# Copy config
COPY ./config/system/ /docker/
ADD config/php/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini
ADD config/php/custom-php-fpm.conf /usr/local/etc/php-fpm.d/zz-custom-php.conf

ENTRYPOINT ["/bin/bash", "/docker/entrypoint.sh"]
CMD ["php-fpm"]
