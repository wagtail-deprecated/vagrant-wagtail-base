#!/bin/bash

# we need jesse-backports for Java 8, required for Elasticsearch 5
echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list

# Update APT database
apt-get update -y

# Useful tools
apt-get install -y vim git curl gettext build-essential

# Dependencies for PIL
apt-get install -y libjpeg-dev libtiff-dev zlib1g-dev libfreetype6-dev liblcms2-dev

# Redis
apt-get install -y redis-server

# PostgreSQL 9.6
cat << EOF > /etc/apt/sources.list.d/pgdg.list
deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main
EOF
cat /vagrant/install/apt-key-postgresql.asc | sudo apt-key add -
apt-get update -y
apt-get install -y postgresql-9.6 libpq-dev

# Java for Elasticsearch
apt install -y -t jessie-backports openjdk-8-jre-headless ca-certificates-java

# Python 3.6
apt-get install -y libssl-dev libncurses-dev liblzma-dev libgdbm-dev libsqlite3-dev libbz2-dev tk-dev libreadline6-dev
curl https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz | tar xvz
cd Python-3.6.1
./configure --enable-optimizations
make
make install
cd ..
rm -rf Python-3.6.1

# Python tools
# We need virtualenv >13.0.0 in order to get pip 7 to automatically install
apt-get install -y python3-pip fabric python3-sphinx python3-six
pip3 install virtualenv


# Create vagrant pgsql superuser
su - postgres -c "createuser -s vagrant"


# Elasticsearch
echo "Downloading ElasticSearch..."
wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.deb
dpkg -i elasticsearch-5.4.0.deb
# reduce JVM heap size from 2g to 512m
sed -i 's/^\(-Xm[sx]\)2g$/\1512m/g' /etc/elasticsearch/jvm.options

systemctl enable elasticsearch
systemctl start elasticsearch
rm elasticsearch-5.4.0.deb


# Remove some large packages that we don't need
apt-get remove -y libllvm3.5
apt-get autoremove -y

# Cleanup
apt-get clean

echo "Zeroing free space to improve compression..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
