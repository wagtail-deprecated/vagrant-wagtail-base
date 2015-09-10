Vagrant box for Wagtail site development
========================================

A Vagrant box based on Debian Jessie 8.1.0 64 bit, with the dependencies for developing Wagtail sites preinstalled.

Usage
-----

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``torchbox/wagtail-jessie64``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init torchbox/wagtail
```

What's inside
-------------

 - Python 2.7.9 with virtualenv and pip
 - Python 3.4.2 with virtualenv and pip
 - PostgreSQL 9.4.4
 - Redis 2.8.17
 - Elasticsearch 1.7.1
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python (2 and 3), PostgreSQL and some image libraries (libjpeg, zlib, etc)
 - Prebuilt wheel files for libsass (0.8.2), pillow (2.9.0) and psycopg2 (2.6.1). To use them, just pip install


Build instructions
------------------

To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-jessie64-v1.0.0 wagtail-jessie64-v1.0.0.box
