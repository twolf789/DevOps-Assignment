# DevOps-Assignment

Prerequisites:
(Execute the scripts as root, on Debian Linux machine).
  1. Please run the script "docker_install.sh".
  2. Next, run the "environment.sh" - it will create the network that will be used as the OpenVPN site and also as the containers network. It also creates all the
     configuration the VPN server need.
  3. Last thing you need to do before you create anacron job for the main_script.sh - run the "forward_traffic.sh" script to create the iptables rules.


To make the "main_script.sh" run upon startup of the Ubuntu machine, put the script in "/etc/init.d/" directory and make it executable by running "chmod +x /etc/init.d/main_script.sh".
  

Why I chose these network settings:
  - Custom network with bridge driver: I chose to use a bridge network defined by me, named 'yuvals_app_bridge' because all containers without a --network specified, are
    attached to the default bridge network. This can be a risk, as unrelated stacks/services/containers are then able to communicate. By doing so, I created a scoped
    network in which only both containers attached to 'yuvals_app_bridge' network are able to communicate.
  - Subnet reason: I configured 'yuvals_app_bridge' network to use 192.168.5.0/29. This way the containers ip addresses attached to this network will be less predictable 
    and this subnet can contain very small amount of devices.

Traffic route explanation:
  I decided to route inbound traffic to ens33 (host network) to the containers attached to 'yuvals_app_bridge' network based on their destination port using forward
  rules and DNAT in IPTABLES. All host network inbound traffic on port TCP 80 will be forwarded to the nginx container, and all host network inbound traffic on port UDP
  1194 will be forwarded to the OpenVPN container.

Conclusion- three reasons for this solution:
  1. In this build we can control what traffic will get to the containers. Based on their uses we can know what will be the destination ports and then forward the
  traffic to the relevant container.
  2. The containers are isolated in a different private network, which provides maximum security. I exposed only the needed ports, the host ports that were exposed are
  very random to make it less predictable.
  3. The images used to build the containers sourced at Docker Hub (most realible source), The tags I used are the latest (which contains the minimum amount of security
  risks), and from verified accounts.
  
