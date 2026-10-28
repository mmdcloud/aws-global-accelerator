#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
echo "Hello from ${region}" > /var/www/html/index.html

