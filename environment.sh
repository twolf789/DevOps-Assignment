#!/bin/bash

# Pull the OpenVPN image from Docker Hub
docker image pull kylemanna/openvpn:latest

# Create dir to store persistent data (i.e keys)
mkdir /vpn_files

# Create network with bridge driver and custom subnet for the containers. This network will also be used as vpn site. (Explanation on the README file)
docker network create --driver=bridge --subnet=192.168.5.0/29 yuvals_app_bridge

# Generating the configuration files, and storing them in the dir we created (using bind mount). Also stating our custom bridge network.
docker run -v $PWD/vpn_files:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://192.168.5.0:2998

# Generating CA certificate and we will have a private key belong to the PKI.
docker run -v $PWD/vpn_files:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

# Create a user that will be used to login to this OpenVPN server.
docker run -v $PWD/vpn_files:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full yuval COMPLEXPASSWORD11

# Create a profile file that has all the connection information included in it
docker run -v $PWD/vpn_files:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient yuval > yuval.ovpn
