#!/bin/sh

# cp /certs/gwiot.pem /etc/ipsec.d/certs/
# cp /certs/gwiot.der /etc/ipsec.d/private/

IP=$(ip route get 1 | awk '{print $NF;exit}')

echo "net.ipv4.ip_forward = 1" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" |  tee -a /etc/sysctl.conf

# for ISAKMP (handling of security associations)
iptables -A INPUT -p udp --dport 500 --j ACCEPT
# for NAT-T (handling of IPsec between natted devices)
iptables -A INPUT -p udp --dport 4500 --j ACCEPT
# for ESP payload (the encrypted data packets)
iptables -A INPUT -p esp -j ACCEPT
# for the routing of packets on the server
iptables -t nat -A POSTROUTING -j SNAT --to-source $IP -o eth+
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -m policy --dir out --pol ipsec -j ACCEPT

for vpn in /proc/sys/net/ipv4/conf/*; do
    echo 0 > $vpn/accept_redirects
    echo 0 > $vpn/send_redirects
done

sysctl -p

ipsec start --nofork &

echo "OK"
sleep 2

ipsec up net

ip route add 10.2.0.2 dev eth0
ip route add 10.2.0.0/16 via 10.2.0.2 dev eth0

# fg
bash
