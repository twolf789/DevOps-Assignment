#!/bin/bash

# Install Docker
sudo apt install curl
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Adding the user to the 'docker' group in order to avoid writing 'sudo' in the beginning of each docker command
if [[ $# -eq 1 ]]; then
  sudo usermod -aG docker $1
else
  echo "Sorry, but you didn't provide your username as a positional argument. Docker had been installed, but your user wasn't added to the docker group."
