FROM kishlin/base-kishlin-mongo:4.2-bionic

RUN echo "rs.initiate({_id:\"local-mongo-atlas-rs0\", members: [{_id: 1, host: \"mongo-atlas:27017\"}]})"  > /docker-entrypoint-initdb.d/replica-init.js

CMD ["mongod", "--replSet", "local-mongo-atlas-rs0", "--smallfiles"]
