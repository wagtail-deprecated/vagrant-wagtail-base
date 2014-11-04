#!/bin/bash

apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext

# Python dev packages
apt-get install -y build-essential python python-dev python-setuptools

# Dependencies for image processing with Pillow (drop-in replacement for PIL)
# supporting: jpeg, tiff, png, freetype, littlecms
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Dependencies for OpenCV image feature detection
apt-get install -y python-opencv python-numpy

# Redis
apt-get install -y redis-server

# Postgresql
apt-get install -y postgresql libpq-dev


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# virtualenv global setup
if ! command -v pip; then
    easy_install -U pip
fi
if [[ ! -f /usr/local/bin/virtualenv ]]; then
    pip install virtualenv virtualenvwrapper
fi

# bash environment global setup
cp -p /vagrant_data/bashrc /home/vagrant/.bashrc

# install our common Python packages in a temporary virtual env so that they'll get cached
if [[ ! -e /home/vagrant/.pip_download_cache ]]; then
    su - vagrant -c "mkdir -p /home/vagrant/.pip_download_cache && \
        virtualenv /home/vagrant/yayforcaching && \
        PIP_DOWNLOAD_CACHE=/home/vagrant/.pip_download_cache /home/vagrant/yayforcaching/bin/pip install -r /vagrant_data/common_requirements.txt && \
        rm -rf /home/vagrant/yayforcaching"
fi

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
