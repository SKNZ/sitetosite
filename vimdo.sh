#!/bin/bash

sudo iptables-restore --test cloudgw/fw
if [[ $? -eq 0 ]]; then
    docker kill sitetosite_agw_1 sitetosite_cloudgw_1 sitetosite_aiot_1
    docker-compose up -d agw cloudgw 
    docker exec -it sitetosite_cloudgw_1 iptables-save
    docker-compose up aiot &
    docker-compose up biot &
    wait
fi
