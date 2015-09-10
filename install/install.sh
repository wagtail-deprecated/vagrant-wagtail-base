#!/bin/bash

# Update APT database
apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext build-essential

# Dependencies for PIL
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Redis
apt-get install -y redis-server

# PostgreSQL
apt-get install -y postgresql libpq-dev

# Java for Elasticsearch
apt-get install -y openjdk-7-jre-headless

# Python 2.7
apt-get install -y python python-dev python-pip python-virtualenv python-wheel

# Python 3.4
apt-get install -y python3 python3-dev python3-pip python3-virtualenv python3-wheel


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.deb
dpkg -i elasticsearch-1.7.1.deb
systemctl enable elasticsearch
systemctl start elasticsearch
rm elasticsearch-1.7.1.deb


# Remove some large packages that we don't need
apt-get remove -y libllvm3.4
apt-get autoremove -y

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
