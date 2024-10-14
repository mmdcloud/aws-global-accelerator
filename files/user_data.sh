#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
echo "Hello from ${region}" > /var/www/html/index.html
