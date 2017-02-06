Vagrant box for Wagtail site development
========================================

A Vagrant box based on Debian Jessie 8.7.0 64 bit, with the dependencies for developing Wagtail sites preinstalled.

Usage
-----

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``torchbox/wagtail-jessie64``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init torchbox/wagtail
```

What's inside
-------------

 - Python 3.4.2 with virtualenv and pip
 - PostgreSQL 9.6.1
 - Redis 2.8.17
 - Elasticsearch 1.7.1
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python 3, PostgreSQL and some image libraries (libjpeg, zlib, etc)
 - Prebuilt wheel files for libsass (0.8.3), pillow (2.9.0) and psycopg2 (2.6.2). To use them, just pip install

Changes from v1
---------------

 - Debian updated to 8.7.0 (previously 8.2.0)
 - Removed Python 2 support
 - Updated PostgreSQL to 9.6.1 (previously 9.4.4)
 - Updated bundled psycopg2 to 2.6.2 (previously 2.6.1)

Build instructions
------------------

To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-jessie64-v1.0.0 wagtail-jessie64-v1.0.0.box
