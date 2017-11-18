FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y strongswan openssl inetutils-ping net-tools vim

ADD . /app
WORKDIR /app

RUN ./conf.sh

CMD ./startup.sh
