#!/bin/bash

set -o xtrace

for i in $(seq 1 4); do 
    echo "Testing $i"
    SRV=$(dig +short sitetosite_server_$i)

    echo "Got $i $? $SRV"
    if [[ $SRV ]]; then
        sed -ie "s/#srv/server $SRV:8080;\n#srv/" /etc/nginx/nginx.conf; 
    fi
done

nginx
