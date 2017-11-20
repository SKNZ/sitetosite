FROM alpine:latest

RUN apk add --update curl 
ADD . /app
WORKDIR /app

CMD ./startup.sh
