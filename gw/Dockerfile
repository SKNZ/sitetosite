FROM alpine:edge

RUN apk add --update strongswan vim iptables
# RUN apk add --update iputils net-tools

ADD . /app
WORKDIR /app

RUN ./setup.sh

CMD ./startup.sh
