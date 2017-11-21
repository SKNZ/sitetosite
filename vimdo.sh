#!/bin/bash

sudo iptables-restore --test cloudgw/fw
if [[ $? -eq 0 ]]; then
    docker-compose build cloudgw
    docker kill sitetosite_bgw_1 sitetosite_agw_1 sitetosite_cloudgw_1 sitetosite_aiot_1 sitetosite_biot_1
    docker-compose up -d agw bgw cloudgw 
    sleep 3
    docker-compose up aiot
    docker-compose up biot
    docker exec -it sitetosite_cloudgw_1 sh -c 'iptables-save | tail -n +24'
fi
