FROM alpine:latest

RUN apk add --update curl 

CMD route del default; \
    route add default gw ${GWNAME}; \
    curl -Gvs "$IOT_SERVER" --data-urlencode "time='$(date)'"; \
    # sh
