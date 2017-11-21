#!/bin/sh

if [[ "$(ifconfig eth0 | grep 10.0.)" ]]; then
    ETH_INTERNET="eth0"
    ETH_LAN="eth1"
else
    ETH_INTERNET="eth1"
    ETH_LAN="eth0"
fi

NET_LAN="10.$(hostname -i | sed 's/ /\n/g' | grep -v 10.0. | cut -d'.' -f 2).0.0"

echo "ETH_INTERET is $ETH_INTERNET"
echo "ETH_LAN is $ETH_LAN"
echo "NET_LAN is $NET_LAN"

sed "s/eth_internet/$ETH_INTERNET/g; s/eth_lan/$ETH_LAN/g; s/net_lan/$NET_LAN/g" fw | iptables-restore 

