#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
echo "Hello from $1" > /var/www/html/index.html
