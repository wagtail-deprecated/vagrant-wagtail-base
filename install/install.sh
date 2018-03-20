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

# Python 3.6
apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
curl https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz | tar xvz
cd Python-3.6.1
./configure --enable-optimizations
make
make install
cd ..
rm -rf Python-3.6.1


# Fabric (doesn't support Python 3 so installing into system's Python 2)
apt-get install -y fabric


# We need virtualenv >13.0.0 in order to get pip 7 to automatically install
pip3 install virtualenv


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Elasticsearch
echo "Downloading Elasticsearch..."
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.3.deb
dpkg -i elasticsearch-5.3.3.deb
# reduce JVM heap size from 2g to 512m
sed -i 's/^\(-Xm[sx]\)2g$/\1512m/g' /etc/elasticsearch/jvm.options

systemctl enable elasticsearch
systemctl start elasticsearch
rm elasticsearch-5.3.3.deb


# Remove packages that we don't need
apt-get autoremove -y

# Remove Python tests pycache (only used for testing Python itself. Saves 29.5MB)
rm -rf /usr/local/lib/python3.6/test/__pycache__

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
