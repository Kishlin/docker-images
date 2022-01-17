FROM kishlin/base-kishlin-mongo:4.0-xenial

RUN echo "rs.initiate({_id:\"local-mongo-rs0\", members: [{_id: 1, host: \"mongo:27017\"}]})"  > /docker-entrypoint-initdb.d/replica-init.js

CMD ["mongod", "--replSet", "local-mongo-rs0", "--smallfiles"]