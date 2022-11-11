# Maintainer https://github.com/Tetricz
ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION}

ENV PORT="1194" \
    LAN_NETWORK="192.168.1.0/24" \
    VPN_USER="" \
    VPN_PASS="" \
    PROTO="udp" \
    docker_GATEWAY="172.17.0.1" \
    docker_SUBNET="172.17.0.0/16"

ADD ./update-resolv-conf /etc/openvpn/
ADD ./tun.sh /home/
ADD ./ip-tables.sh /home/
ADD ./entrypoint.sh /
RUN apk --no-cache add bash curl iptables ip6tables openresolv openrc jq openvpn \
 && chmod +x ./entrypoint.sh /home/* /etc/openvpn/* \
 && mkdir -p /openvpn

HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
             CMD curl -LSs 'https://api.ipify.org'

ENTRYPOINT [ "./entrypoint.sh" ]