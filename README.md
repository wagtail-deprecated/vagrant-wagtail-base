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

 - Python 3.6.1 with virtualenv and pip
 - PostgreSQL 9.6.3
 - Redis 2.8.17
 - Elasticsearch 5.4.0
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python 3, PostgreSQL and some image libraries (libjpeg, zlib, etc)

Changes from v1
---------------

 - Debian updated to 8.7.0 (previously 8.2.0)
 - Python 3 updated to 3.6.1 (previously 3.4.2)
 - Removed Python 2 support
 - Removed prebuilt wheel files (they get outdated quickly and weren't saving much time)
 - Updated PostgreSQL to 9.6.3 (previously 9.4.4)
 - Updated Elasticsearch to 5.4.0 (previously 1.7.1)

Build instructions
------------------

To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-jessie64-v2.0.0 wagtail-jessie64-v2.0.0.box
