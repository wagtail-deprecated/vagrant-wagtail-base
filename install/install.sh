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
apt install -y openjdk-8-jre-headless ca-certificates-java

# Python tools
apt-get install -y python3-dev python3-pip python3-setuptools

# Fabric (doesn't support Python 3 so installing into system's Python 2)
apt-get install -y fabric


# We need virtualenv >13.0.0 in order to get pip 7 to automatically install
pip3 install virtualenv


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Elasticsearch
echo "Downloading Elasticsearch..."
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.8.deb
dpkg -i elasticsearch-5.6.8.deb
# reduce JVM heap size from 2g to 512m
sed -i 's/^\(-Xm[sx]\)2g$/\1512m/g' /etc/elasticsearch/jvm.options

systemctl enable elasticsearch
systemctl start elasticsearch
rm elasticsearch-5.6.8.deb


# Remove packages that we don't need
apt-get autoremove -y

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
