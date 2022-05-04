# DevOps-Assignment

Prerequisites:
  1. Please run the script "docker_install.sh", *enter your username as a positional argument* (Execute the script as root, on Debian Linux machine).
  2. Next, run the "environment.sh" - it will create the network that will be used as the OpenVPN site and also as the containers network. It also creates all the
     configuration the VPN server need.
  3. Last thing you need to do before you create anacron job for the main_script.sh - run the "forwarding.sh" script to create the iptables rules.

Use "main_script.sh" in anacron, to make it run upon startup of the Ubuntu machine. Setup the anachron job:
  

  

Why I chose this network settings:
  - Custom bridge driver reason:
  - Subnet reason: 

Traffic route explanation:
  

Three reasons for this build:
  1.
  2.
  3.
  
