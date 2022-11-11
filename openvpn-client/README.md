# OpenVPN client

## Quick Start
Add --net=container:openvpn-client to any container you want to pass through the vpn.
If the container has a webui add the ports to the openvpn-client container. 
Avoid passing port used for OpenVPN connections.
### Docker Compose
```
version: '3'
services:
    openvpn-client:
        restart: unless-stopped
        container_name: openvpn-client
        image: tetricz/openvpn-client
        volumes:
         - </your/directory>:/openvpn
        environment:
         - PROTO="udp"
         - PORT="1194"
         - LAN_NETWORK="192.168.1.0/24"
         - docker_GATEWAY="172.17.0.1"
         - docker_SUBNET="172.17.0.0/16"
         - VPN_USER=""
         - VPN_PASS=""
        cap_add:
         - NET_ADMIN
```
### Docker Run
```
docker run -dit --cap-add=NET_ADMIN -e VPN_PASS="password" -e VPN_USER="username" -v </your/directory>:/openvpn --name openvpn-client tetricz/openvpn-client
```
