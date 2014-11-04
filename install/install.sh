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


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# virtualenv global setup
easy_install -U pip
pip install virtualenv virtualenvwrapper

# bash environment global setup
cp -p /vagrant/install/bashrc /home/vagrant/.bashrc

# install our common Python packages in a temporary virtual env so that they'll get cached
su - vagrant -c "mkdir -p /home/vagrant/.pip_download_cache && \
    virtualenv /home/vagrant/yayforcaching && \
    PIP_DOWNLOAD_CACHE=/home/vagrant/.pip_download_cache /home/vagrant/yayforcaching/bin/pip install -r /vagrant/install/pip_requirements.txt && \
    rm -rf /home/vagrant/yayforcaching"

# ElasticSearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.deb
dpkg -i elasticsearch-1.3.2.deb
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
rm elasticsearch-1.3.2.deb

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
