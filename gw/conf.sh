#!/bin/sh

set -o xtrace

echo "REG. GWIOT CERT"
PK="$(ls /app/pki/private/*.der)"
cp $PK /etc/ipsec.d/private/
cp -Rv /app/pki/certs/* /etc/ipsec.d/certs/
cp -Rv /app/pki/cacerts/* /etc/ipsec.d/cacerts/
echo ": RSA $(basename $PK)" >> /etc/ipsec.secrets

echo "IPSEC CONF"
cp /app/ipsec.conf /etc/ipsec.conf
cp /app/ipsec_client.conf /etc/ipsec.d/
cp /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf

