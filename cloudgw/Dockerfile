FROM alpine:latest

RUN apk add --update strongswan vim

ADD . /app
WORKDIR /app

RUN ./setup.sh

CMD ./startup.sh
