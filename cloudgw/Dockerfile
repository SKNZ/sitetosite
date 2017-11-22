FROM alpine:edge

RUN apk add --update strongswan vim iptables zsh

ADD . /app
WORKDIR /app

RUN ./setup.sh

CMD ./startup.sh
