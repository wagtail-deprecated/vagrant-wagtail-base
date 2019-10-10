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
echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list
cat /vagrant/install/ACCC4CF8.asc | apt-key add
apt-get update -y
apt-get install -y postgresql-11 postgresql-client-11 postgresql-contrib-11 libpq-dev

# Java for Elasticsearch
apt install -y openjdk-8-jre-headless ca-certificates-java

# Remove Python 3.5 (shipped with debian)
apt-get remove -y python3

# Python
export PYTHON_VERSION=3.7.4
apt-get install -y libffi-dev libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
curl https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz | tar xvz
cd Python-$PYTHON_VERSION
./configure --enable-optimizations
make
make install
cd ..
rm -rf Python-$PYTHON_VERSION
apt-get remove -y libffi-dev libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev


# Install poetry and Fabric
pip3 install poetry Fabric


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

rm elasticsearch-5.6.8.deb


# Remove packages that we don't need
apt-get autoremove -y

# Remove Python tests pycache (only used for testing Python itself. Saves 29.5MB)
rm -rf /usr/local/lib/python3.7/test/__pycache__

# Cleanup
apt-get clean
rm /var/lib/apt/lists/*

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
