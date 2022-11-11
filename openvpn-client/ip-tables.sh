#!/bin/bash
iptables --flush
iptables --delete-chain
iptables -t nat --flush
iptables -t nat --delete-chain
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
ip6tables --flush
ip6tables --delete-chain
ip6tables -t nat --flush
ip6tables -t nat --delete-chain
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT DROP

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -o tun0 -p icmp -j ACCEPT

iptables -A INPUT -s "${LAN_NETWORK}" -j ACCEPT
iptables -A INPUT -s "${LAN_NETWORK}" -d "${docker_SUBNET}" -j ACCEPT
iptables -A INPUT -s "${docker_SUBNET}" -d "${docker_SUBNET}" -j ACCEPT
iptables -A OUTPUT -d "${LAN_NETWORK}" -j ACCEPT
iptables -A OUTPUT -d "${LAN_NETWORK}" -s "${docker_SUBNET}" -j ACCEPT
iptables -A OUTPUT -d "${docker_SUBNET}" -s "${docker_SUBNET}" -j ACCEPT

iptables -A OUTPUT -p "${PROTO}" -m "${PROTO}" --dport "${PORT}" -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT

ip route add "${LAN_NETWORK}" via "${docker_GATEWAY}" dev eth0