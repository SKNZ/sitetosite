#!/bin/sh

route del default
route add default gw ${GWNAME}
D="http://10.1.0.$(hostname -i | cut -d '.' -f 2)"
if [[ "$IOT_SERVER" ]]; then
    D="$IOT_SERVER"
fi

curl -Gvs -m 1 "$D" --data-urlencode "time='$(date)'"
if [[ "$IOT_SERVER2" ]]; then
    curl -Gvs -m 1 "$IOT_SERVER2" --data-urlencode "time='$(date)'"
fi

# sh
