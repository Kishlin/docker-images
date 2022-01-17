FROM kishlin/base-kishlin-node:8.15-alpine

VOLUME /srv/cache

RUN npm config set unsafe-perm true \
  && npm i -g yarn \
  && npm i gulp@~3.9.1 \
  && npm i -g gulp@~3.9.1

COPY ./config/system/ /docker/

ENTRYPOINT ["/bin/sh", "/docker/entrypoint.sh"]
