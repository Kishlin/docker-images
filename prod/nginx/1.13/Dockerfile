FROM nginx:1.13-alpine

# Default value, can be overridden
ENV PHP_ADDRESS "php"
ENV TZ "Europe/Paris"
ENV SERVER_NAME "php-docker.pierrelouislegrand.com"

COPY ./config /tmp
RUN mv /tmp/site.conf /etc/nginx/conf.d/default.conf \
 && mv /tmp/entrypoint.sh /root/entrypoint.sh \
 && mv /tmp/certs /etc/nginx/certs \
 && apk add --no-cache tzdata

STOPSIGNAL SIGTERM

ENTRYPOINT ["/bin/sh","/root/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
