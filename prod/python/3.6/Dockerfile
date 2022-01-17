FROM python:3.6

RUN apt update && apt install python3-dev default-libmysqlclient-dev -y \
    && pip3 install --upgrade pip \
    && pip3 install mysqlclient s3fs \
    && pip3 install rx==1.6.1 \
    && pip3 install PrettyTable
