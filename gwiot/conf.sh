#!/bin/sh

set -o xtrace

echo "REG. GWIOT CERT"
cp -R /app/pki/private/* /etc/ipsec.d/private/
cp -R /app/pki/certs/* /etc/ipsec.d/certs/
cp -R /app/pki/cacerts/* /etc/ipsec.d/cacerts/
echo ": RSA gwiotKey.der" >> /etc/ipsec.secrets
# echo ": PSK lolyolo" >> /etc/ipsec.secrets

echo "IPSEC CONF"
cp /app/ipsec.conf /etc/ipsec.conf
cp /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf
# cp /app/strongswan.conf /etc/strongswan.conf
