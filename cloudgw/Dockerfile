FROM alpine:latest

RUN apk add --update strongswan vim iptables

ADD . /app
WORKDIR /app

RUN ./setup.sh

CMD ./startup.sh
