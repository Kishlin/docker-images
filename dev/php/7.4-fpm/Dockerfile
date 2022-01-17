FROM kishlin/base-kishlin-php:7.4-fpm

VOLUME /srv/cache

ENV COMPOSER_ALLOW_SUPERUSER true
ENV COMPOSER_CACHE_DIR /srv/cache/composer/cache
ENV COMPOSER_DISABLE_XDEBUG_WARN 1
ENV COMPOSER_HOME /srv/cache/composer
ENV COMPOSER_MEMORY_LIMIT -1
ENV COMPOSER_VERSION 1.9.2

RUN pecl channel-update pecl.php.net \
    && pecl install xdebug-2.9.6 \
    && docker-php-ext-enable xdebug \
    && curl -sS http://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
	&& COMPOSER_HOME=/srv/cache/composer composer -q global require "hirak/prestissimo:^0.3" \
	&& chmod -R 777 /srv/cache \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& cd - \
	&& curl -so /usr/local/bin/security-checker https://get.sensiolabs.org/security-checker.phar \
	&& chmod +x /usr/local/bin/security-checker \
	&& apt update && apt upgrade -y && apt install -y parallel

# Copy config
COPY ./config/system/ /docker/
ADD config/php/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini
ADD config/php/custom-php-fpm.conf /usr/local/etc/php-fpm.d/zz-custom-php.conf

ENTRYPOINT ["/bin/bash", "/docker/entrypoint.sh"]
CMD ["php-fpm"]
