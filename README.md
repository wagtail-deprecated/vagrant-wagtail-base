Vagrant box for Wagtail site development
========================================

A Vagrant box based on Debian Stretch 9.4.0 64 bit, with the dependencies for developing Wagtail sites preinstalled.

Usage
-----

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``torchbox/wagtail-stretch64``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init torchbox/wagtail-stretch64
```

What's inside
-------------

 - Python 3.5.3 with virtualenv and pip
 - PostgreSQL 9.6.8 with libpq-dev and contrib
 - Redis 3.2.6
 - Elasticsearch 5.6.8
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python 3, PostgreSQL and some image libraries (libjpeg, zlib, etc)

Build instructions
------------------

To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-stretch64-v1.0.0 wagtail-stretch64-v1.0.0.box
