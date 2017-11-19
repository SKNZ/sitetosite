#!/bin/bash

set -o xtrace

mkdir -p pki
cd pki

ipsec pki --gen --type ed25519 caKey.der

ipsec pki --self --in caKey.der \
    --dn "C=FI, O=netsecvpn, CN=rootca" --ca > caCert.der

function mkgw {
    gw="$1gw"
    ipsec pki --gen --type ed25519 > "${gw}Key.der"

    ipsec pki --pub --in "${gw}Key.der" | ipsec pki --issue \
        --cacert caCert.der \
        --cakey caKey.der \
        --dn "C=FI, O=netsecvpn, CN=$gw" --san $gw > "${gw}Cert.der"

    mkdir -p "../$gw/pki/"{private,certs,cacerts}
    cp "${gw}Key.der" "../${gw}/pki/private"
    cp "${gw}Cert.der" "../${gw}/pki/certs"
    cp "cloudgwCert.der" "../${gw}/pki/certs"
    cp caCert.der ../${gw}/pki/cacerts
}

mkgw "cloud"
mkgw "a"


