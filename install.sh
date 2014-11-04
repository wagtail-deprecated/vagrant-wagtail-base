#!/bin/bash

# Script to set up dependencies for Django on Vagrant.

PGSQL_VERSION=9.3

# Need to fix locale so that Postgres creates databases in UTF-8
cp -p /vagrant_data/etc-bash.bashrc /etc/bash.bashrc
locale-gen en_GB.UTF-8
dpkg-reconfigure locales

export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext

# Python dev packages
apt-get install -y build-essential python python-dev python-setuptools

# Python 3.4
apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
wget https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tgz
tar -xvf Python-3.4.1.tgz
cd Python-3.4.1
./configure
make
make install
cd ..
rm Python-3.4.1.tgz
rm -rf Python-3.4.1

# Dependencies for image processing with Pillow (drop-in replacement for PIL)
# supporting: jpeg, tiff, png, freetype, littlecms
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Dependencies for OpenCV image feature detection
apt-get install -y python-opencv python-numpy

# Redis
apt-get install -y redis-server


# Postgresql
if ! command -v psql; then
    apt-get install -y postgresql-$PGSQL_VERSION libpq-dev postgresql-client-common
    cp /vagrant_data/pg_hba.conf /etc/postgresql/$PGSQL_VERSION/main/
    /etc/init.d/postgresql reload
fi

# virtualenv global setup
if ! command -v pip; then
    easy_install -U pip
fi
if [[ ! -f /usr/local/bin/virtualenv ]]; then
    pip install virtualenv virtualenvwrapper
fi

# bash environment global setup
cp -p /vagrant_data/bashrc /home/vagrant/.bashrc

# Build virtual environments
su - vagrant -c "virtualenv /home/vagrant/.virtualenvs/python2 && /home/vagrant/.virtualenvs/python2/bin/pip install -r /vagrant_data/common_requirements.txt"
su - vagrant -c "pyvenv /home/vagrant/.virtualenvs/python3 && /home/vagrant/.virtualenvs/python3/bin/pip install -r /vagrant_data/common_requirements.txt"

# ElasticSearch
if ! command -v /usr/share/elasticsearch/bin/elasticsearch; then
    apt-get install -y openjdk-7-jre-headless
    echo "Downloading ElasticSearch..."
    wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.deb
    dpkg -i elasticsearch-1.3.2.deb
    update-rc.d elasticsearch defaults 95 10
    service elasticsearch start
    rm elasticsearch-1.3.2.deb
fi

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
