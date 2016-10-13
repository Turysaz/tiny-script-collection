#!/bin/bash

# update package list
sudo apt-get update

# repair...
sudo apt-get check
sudo apt-get install -f
sudo apt-get autoremove

# install updates
sudo apt-get upgrade
