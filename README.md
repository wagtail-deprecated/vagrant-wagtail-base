# Vagrant box for Wagtail site development

A Vagrant box based on Debian Buster 10.3.0 64 bit, with the dependencies for developing Wagtail sites preinstalled.

## Usage

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``wagtail/buster64``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init wagtail/buster64
```

## What's inside

 - Python 3.8.2 with virtualenv, pip, poetry, and Fabric 2
 - NodeJS 12.16 with npm and nvm
 - PostgreSQL 11.7 with libpq-dev and contrib
 - Redis 5.0.3
 - Elasticsearch 5.6.8
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python 3, PostgreSQL and some image libraries (libjpeg, zlib, etc)

### Elasticsearch

While Elasticsearch is installed, it is not enabled by default. To enable it, add the following into the Vagrant provision script of your project:

```
systemctl enable elasticsearch
systemctl start elasticsearch
```

## Build instructions

To generate the .box file, run either:

```
./build.sh virtualbox
```

or 

```
./build.sh libvirt
```

Based on which provider you are using.

Then, to install locally:

```
vagrant box add wagtail/buster64 wagtail-buster64-v1.1.0.box
```
