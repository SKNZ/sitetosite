#!/bin/bash

set -o xtrace

mkdir -p pki
cd pki

ipsec pki --gen > caKey.der

ipsec pki --self --in caKey.der --dn "C=CH, O=strongSwan, CN=strongSwan CA" --ca > caCert.der

ipsec pki --gen > gwcloudKey.der

ipsec pki --pub --in gwcloudKey.der | ipsec pki --issue --cacert caCert.der --cakey caKey.der \
                                                 --dn "C=CH, O=strongSwan, CN=gwcloud" --san gwcloud > gwcloudCert.der

ipsec pki --gen > gwiotKey.der

ipsec pki --pub --in gwiotKey.der | ipsec pki --issue --cacert caCert.der --cakey caKey.der \
                                                 --dn "C=CH, O=strongSwan, CN=gwiot" --san gwiot > gwiotCert.der

mkdir -p ../gwiot/pki/{private,certs,cacerts}
cp gwiotKey.der ../gwiot/pki/private
cp gwiotCert.der ../gwiot/pki/certs
cp caCert.der ../gwiot/pki/cacerts

mkdir -p ../gwcloud/pki/{private,certs,cacerts}
cp gwcloudKey.der ../gwcloud/pki/private
cp gwcloudCert.der ../gwcloud/pki/certs
cp caCert.der ../gwcloud/pki/cacerts

