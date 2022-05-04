#!/bin/bash

# Run VPN server based on the configuration we did before, on the first container
docker run -v $PWD/vpn_files:/etc/openvpn -d -p 2998:1194/udp --net yuvals_app_bridge --name container1_vpnserver  --cap-add=NET_ADMIN kylemanna/openvpn

# Create second container in the same network we created.
docker run -d --net yuvals_app_bridge -p 1001:80 --name container2 nginx
