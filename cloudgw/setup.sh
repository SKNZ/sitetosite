#!/bin/sh

set -o xtrace

cd /etc/ipsec.d/

cp -Rv /app/pki/private/* /etc/ipsec.d/private/
cp -Rv /app/pki/certs/* /etc/ipsec.d/certs/
cp -Rv /app/pki/cacerts/* /etc/ipsec.d/cacerts/
echo ": RSA $(cd /app/pki/private/ && ls)" >> /etc/ipsec.secrets

cp -v /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf
cp -v /app/ipsec.conf /etc/ipsec.conf
cp -v /app/ipsec_cipher.conf /etc/ipsec.d/
