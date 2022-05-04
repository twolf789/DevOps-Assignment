#!/bin/bash

# Enabling forwarding for the host network (Our custom network that we created has forwading enabled by default)
echo '1' | sudo tee /proc/sys/net/ipv4/conf/ens33/forwarding

# All host network inbound traffic on port TCP 80 will be forwarded to the nginx container
iptables -t nat -A PREROUTING -p tcp -i ens33 --dport 80 -j DNAT --to-destination 192.168.5.3:1001
iptables -A FORWARD -p tcp -d 192.168.5.3 --dport 1001 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# All host network inbound traffic on port UDP 1194 will be forwarded to the OpenVPN container
iptables -t nat -A PREROUTING -p udp -i ens33 --dport 1194 -j DNAT --to-destination 192.168.5.2:2998
iptables -A FORWARD -p udp -d 192.168.5.2 --dport 2998 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
