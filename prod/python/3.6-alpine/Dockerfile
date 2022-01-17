FROM python:3.6-alpine

# In alpine version : default-libmysqlclient-dev package is replaced with mariadb-dev
RUN apk update && apk add python3-dev mariadb-dev build-base \
    && pip3 install --upgrade pip \
    && pip3 install mysqlclient s3fs \
    && pip3 install rx==1.6.1 \
    && pip3 install PrettyTable
