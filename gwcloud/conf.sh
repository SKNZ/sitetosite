#!/bin/sh

set -o xtrace

echo "PREPING"
cd /etc/ipsec.d/
mkdir p12
ipsec pki --gen --type rsa --size 4096 --outform der > private/root.der
chmod 600 private/root.der

echo "GEN. ROOT CA"
ipsec pki \
        --self \
        --ca \
        --lifetime 3650  \
        --in private/root.der  \
        --type rsa  \
        --dn "C=FI, O=NETSEC1, CN=rootca"  \
        --outform der > cacerts/root.der \

ipsec pki --print --in cacerts/root.der

echo "GEN. GWCLOUD KEY"
ipsec pki --gen --type rsa --size 4096 --outform der > private/gwcloud.der
chmod 600 private/gwcloud.der

IP=$(ip route get 1 | awk '{print $NF;exit}')
echo "GEN. GWCLOUD CERT (IP $IP)"
ipsec pki --pub \
          --in private/gwcloud.der \
          --type rsa | ipsec pki --issue --lifetime 730  \
                --cacert cacerts/root.der \
                --cakey private/root.der  \
                --dn "C=FI, O=NETSEC1, CN=gwcloud"  \
                --san gwcloud \
                --san @gwcloud \
                --san $IP \
                --san @$IP \
                --flag serverAuth \
                --flag ikeIntermediate \
                --outform pem > certs/gwcloud.pem
ipsec pki --print --in certs/gwcloud.pem

echo "GEN. GWIOT KEY"
ipsec pki --gen --type rsa --size 4096 --outform der > private/gwiot.der
chmod 600 private/gwiot.der

echo "GEN. GWIOT CERT (IP $IP)"
ipsec pki --pub \
          --in private/gwiot.der \
          --type rsa | ipsec pki --issue --lifetime 730  \
                --cacert cacerts/root.der \
                --cakey private/root.der  \
                --dn "C=FI, O=NETSEC1, CN=gwiot"  \
                --san gwiot \
                --san @gwiot \
                --flag serverAuth \
                --flag ikeIntermediate \
                --outform pem > certs/gwiot.pem
ipsec pki --print --in certs/gwiot.pem

echo "REG. GWCLOUD CERT"
echo ": RSA gwcloud.der" >> /etc/ipsec.secrets
echo ": PSK lolyolo" >> /etc/ipsec.secrets

echo "IPSEC CONF"
cp /app/ipsec.conf /etc/ipsec.conf
cp /app/strongswan.conf /etc/
