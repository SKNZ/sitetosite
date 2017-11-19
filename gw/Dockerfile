FROM alpine:latest

RUN apk add --update strongswan vim
# RUN apk add --update iputils net-tools

ADD . /app
WORKDIR /app

CMD ./startup.sh
