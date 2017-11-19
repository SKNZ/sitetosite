#!/bin/sh

set -o xtrace

PK="$(ls /app/pki/private/*.der)"
cp $PK /etc/ipsec.d/private/
cp -Rv /app/pki/certs/* /etc/ipsec.d/certs/
cp -Rv /app/pki/cacerts/* /etc/ipsec.d/cacerts/
echo ": RSA $(basename $PK)" >> /etc/ipsec.secrets

cp -v /app/ipsec_client.conf /etc/ipsec.d/
cp -v /app/ipsec_cipher.conf /etc/ipsec.d/
cp -v /app/charon-logging.conf /etc/strongswan.d/charon-logging.conf

