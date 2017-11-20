#!/bin/sh

if [[ "$(ifconfig eth0 | grep 10.0.)" ]]; then
    ETH_INTERNET="eth0"
    ETH_LAN="eth1"
else
    ETH_INTERNET="eth1"
    ETH_LAN="eth0"
fi

sed "s/eth_internet/$ETH_INTERNET/g; s/eth_lan/$ETH_LAN/g" fw | iptables-restore 

