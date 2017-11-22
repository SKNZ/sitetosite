FROM alpine:latest

RUN apk add --update curl zsh
ADD . /app
WORKDIR /app

CMD ./startup.sh
