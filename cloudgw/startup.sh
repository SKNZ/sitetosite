#!/bin/sh

IP=$(hostname -i | sed 's/ /\n/g' | grep -v 10.0)
echo "MY INTERNET IP IS $IP"

echo "net.ipv4.ip_forward = 1" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.rp_filter = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" |  tee -a /etc/sysctl.conf
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" |  tee -a /etc/sysctl.conf


# for ISAKMP (handling of security associations)
# iptables -A INPUT -p udp --dport 500 --j ACCEPT
# for NAT-T (handling of IPsec between natted devices)
# iptables -A INPUT -p udp --dport 4500 --j ACCEPT
# for ESP payload (the encrypted data packets)
# iptables -A INPUT -p esp -j ACCEPT

# for the routing of packets on the server
# iptables -t nat -A POSTROUTING -j SNAT --to-source $IP -o eth+

for vpn in /proc/sys/net/ipv4/conf/*; do
    echo 0 > $vpn/accept_redirects
    echo 0 > $vpn/send_redirects
done

sysctl -p

./ipt.sh
rm /var/run/starter.charon.pid
rm /var/run/charon.pid
rm l.log
ipsec start --nofork

# ipsec start
# ./ipt.sh
