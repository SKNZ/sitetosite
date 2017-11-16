FROM ubuntu:16.04

ADD . /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y strongswan openssl inetutils-ping net-tools nano strongswan-plugin-gmp
RUN ./conf.sh

CMD ./startup.sh
