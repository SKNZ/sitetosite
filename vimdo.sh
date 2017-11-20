#!/bin/bash

sudo iptables-restore --test gw/fw
if [[ $? -eq 0 ]]; then
    docker build -t gw gw/
    docker-compose build agw
    docker kill sitetosite_agw_1 sitetosite_cloudgw_1 sitetosite_aiot_1 sitetosite_biot_1
    docker-compose up -d agw cloudgw 
    docker-compose up aiot &
    docker-compose up biot &
    wait
    docker exec -it sitetosite_agw_1 iptables-save
    wait
fi
