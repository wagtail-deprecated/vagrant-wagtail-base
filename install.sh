#!/bin/bash

# Script to set up dependencies for Django on Vagrant.

PGSQL_VERSION=9.1

# Need to fix locale so that Postgres creates databases in UTF-8
cp -p /vagrant_data/etc-bash.bashrc /etc/bash.bashrc
locale-gen en_GB.UTF-8
dpkg-reconfigure locales

export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

apt-get update -y

# Useful tools
apt-get install -y vim git curl build-essential

# Python
apt-get install -y libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
wget https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tgz
tar -xvf Python-3.4.1.tgz
cd Python-3.4.1
./configure
make
make install
cd ..

# Dependencies for image processing with Pillow (drop-in replacement for PIL)
# supporting: jpeg, tiff, png, freetype, littlecms
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Redis
apt-get install -y redis-server

# Use YAML for test fixtures
apt-get install -y libyaml-dev

# Dependencies for lxml (for HTML whitelisting)
apt-get install -y libxml2-dev libxslt-dev


# Postgresql
if ! command -v psql; then
    apt-get install -y postgresql-$PGSQL_VERSION libpq-dev postgresql-client-common
    cp /vagrant_data/pg_hba.conf /etc/postgresql/$PGSQL_VERSION/main/
    /etc/init.d/postgresql reload
fi

# bash environment global setup
cp -p /vagrant_data/bashrc /home/vagrant/.bashrc

# install our common Python packages in a temporary virtual env so that they'll get cached
if [[ ! -e /home/vagrant/.pip_download_cache ]]; then
    su - vagrant -c "mkdir -p /home/vagrant/.pip_download_cache && \
        pyvenv /home/vagrant/yayforcaching && \
        PIP_DOWNLOAD_CACHE=/home/vagrant/.pip_download_cache /home/vagrant/yayforcaching/bin/pip install -r /vagrant_data/common_requirements.txt && \
        rm -rf /home/vagrant/yayforcaching"
fi

# ElasticSearch
if ! command -v /usr/share/elasticsearch/bin/elasticsearch; then
    apt-get install -y openjdk-7-jre-headless
    echo "Downloading ElasticSearch..."
    wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
    dpkg -i elasticsearch-1.2.1.deb
    update-rc.d elasticsearch defaults 95 10
    service elasticsearch start
fi
