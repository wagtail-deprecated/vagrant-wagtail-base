# Vagrant box for Wagtail site development

A Vagrant box based on Debian Stretch 9.8.0 64 bit, with the dependencies for developing Wagtail sites preinstalled.

## Usage

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``torchbox/wagtail-stretch64``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init torchbox/wagtail-stretch64
```

## What's inside

 - Python 3.7.3 with virtualenv and pip
 - PostgreSQL 11.2 with libpq-dev and contrib
 - Redis 3.2.6
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
vagrant box add wagtail-stretch64-v2.0.0 wagtail-stretch64-v2.0.0.box
```
