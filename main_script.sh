#!/bin/bash

# Pull the OpenVPN image from Docker Hub
docker image pull kylemanna/openvpn:latest

# Create dir to store persistent data (i.e keys)
mkdir /vpn_files

# Create network for the containers. This network will also be used as vpn site.
docker network create --driver=bridge --subnet=192.168.5.0/24 yuvals_app_bridge

# Generating the conf using ... and storing it in the dir we created.
docker run -v $PWD/vpn_files:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://192.168.5.0:2998


# Create network for the containers
docker network create --driver=bridge --subnet=192.168.5.0/24 yuvals_app_bridge
