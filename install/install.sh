#!/bin/bash

# Install APT requirements
apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext

# Python development
apt-get install -y build-essential python python-dev python-setuptools

# Dependencies for PIL
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# OpenCV
apt-get install -y python-opencv python-numpy

# Redis
apt-get install -y redis-server

# PostgresSQL
apt-get install -y postgresql libpq-dev

# Java for Elasticsearch
apt-get install -y openjdk-7-jre-headless

# Python 3.4
apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz
tar -xvf Python-3.4.3.tgz
cd Python-3.4.3
./configure
make
make install
cd ..


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# PIP and Virtualenv for Python 2 (these are bundled with Python 3)
easy_install-2.7 -U pip
pip2.7 install virtualenv


# Install Fabric and Sphinx
pip2.7 install Fabric==1.10.1 Sphinx==1.2.3


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb
dpkg -i elasticsearch-1.4.4.deb
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
rm elasticsearch-1.4.4.deb


# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
