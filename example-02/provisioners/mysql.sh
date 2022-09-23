#!/bin/bash -eux

# Set root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password passwd'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password passwd'

# Install MySQL Server
sudo apt-get update
sudo apt-get install -y mysql-server-5.7