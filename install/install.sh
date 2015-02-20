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
wget https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz
tar -xvf Python-3.4.2.tgz
cd Python-3.4.2
./configure
make
make install
cd ..


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# PIP and Virtualenv
easy_install -U pip
pip install virtualenv


# Copy bashrc
cp -p /vagrant/install/bashrc /home/vagrant/.bashrc


# Create virtualenv and install Wagtail requirements
su - vagrant -c "virtualenv /home/vagrant/venv"
su - vagrant -c "/home/vagrant/venv/bin/pip install -r /vagrant/install/requirements.txt"


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.deb
dpkg -i elasticsearch-1.3.4.deb
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
rm elasticsearch-1.3.4.deb


# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
