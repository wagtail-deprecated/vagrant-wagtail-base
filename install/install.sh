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
apt-get install -y python python-dev

# Python 3.4
apt-get install -y python3 python3-dev

# Python tools
# We need virtualenv >13.0.0 in order to get pip 7 to automatically install
apt-get install -y python3-pip fabric python-sphinx
pip3 install virtualenv


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Prebuild wheelfiles for Pillow, psycopg2 and libsass
# pip 7 automatically builds wheelfiles and caches them in ~/.cache/pip allowing faster initial provisions for projects
su - vagrant -c "virtualenv --python=python2 /home/vagrant/venv2"
su - vagrant -c "virtualenv --python=python3 /home/vagrant/venv3"
su - vagrant -c "/home/vagrant/venv2/bin/pip install psycopg2==2.6.1 libsass==0.8.3 pillow==2.9.0"
su - vagrant -c "/home/vagrant/venv3/bin/pip install psycopg2==2.6.1 libsass==0.8.3 pillow==2.9.0"
su - vagrant -c "rm -rf /home/vagrant/venv2"
su - vagrant -c "rm -rf /home/vagrant/venv3"


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
