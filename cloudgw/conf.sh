#!/bin/sh

set -o xtrace

echo "PREPING"
cd /etc/ipsec.d/

echo "REG. GWCLOUD CERT"
cp -R /app/pki/private/* /etc/ipsec.d/private/
cp -R /app/pki/certs/* /etc/ipsec.d/certs/
cp -R /app/pki/cacerts/* /etc/ipsec.d/cacerts/
echo ": RSA $(cd /app/pki/private/ && ls)" >> /etc/ipsec.secrets

echo "IPSEC CONF"
cp /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf
cp /app/ipsec.conf /etc/ipsec.conf
