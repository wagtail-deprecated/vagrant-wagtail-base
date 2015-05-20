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

# Dependencies for Python
apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev


# Python 2.7
curl https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz | tar xvz
cd Python-2.7.9
./configure
make
make install
cd ..
rm -rf Python-2.7.9

python2 -m ensurepip

pip2.7 install virtualenv wheel
su - vagrant -c "pip2.7 wheel psycopg2==2.6"
su - vagrant -c "pip2.7 wheel libsass==0.7.0"
su - vagrant -c "pip2.7 wheel libsass==0.8.2"
su - vagrant -c "pip2.7 wheel Pillow==2.8.1"


# Python 3.4
curl https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tgz | tar xvz
cd Python-3.4.3
./configure
make
make install
cd ..
rm -rf Python-3.4.3

pip3.4 install wheel
su - vagrant -c "pip3.4 wheel psycopg2==2.6"
su - vagrant -c "pip3.4 wheel libsass==0.7.0"
su - vagrant -c "pip3.4 wheel libsass==0.8.2"
su - vagrant -c "pip3.4 wheel Pillow==2.8.1"


# Tell PIP where to find wheel files
echo "export PIP_FIND_LINKS=/home/vagrant/wheelhouse" >> /home/vagrant/.bashrc


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Install Fabric and Sphinx
pip2.7 install Fabric==1.10.1 Sphinx==1.2.3


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.deb
dpkg -i elasticsearch-1.4.4.deb
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
rm elasticsearch-1.4.4.deb


# Remove some large packages that we don't need
apt-get remove -y juju juju-core
apt-get remove -y libllvm3.4
apt-get autoremove -y

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
