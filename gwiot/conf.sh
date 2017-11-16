#!/bin/sh

set -o xtrace

echo "REG. GWIOT CERT"
# echo ": RSA gwiot.der" >> /etc/ipsec.secrets
echo ": PSK lolyolo" >> /etc/ipsec.secrets

echo "IPSEC CONF"
cp /app/ipsec.conf /etc/ipsec.conf
cp /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf
# cp /app/strongswan.conf /etc/strongswan.conf
