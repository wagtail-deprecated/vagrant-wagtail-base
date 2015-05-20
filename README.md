Vagrant box for Wagtail site development
========================================

A Vagrant box based on Ubuntu trusty32, with the dependencies for developing Wagtail sites preinstalled.

Usage
-----

This box is available on Vagrant cloud (aka Atlas) so can be used by just setting your base box to ``torchbox/wagtail``.

To create a new Vagrantfile that uses this box, run the following:

```
vagrant init torchbox/wagtail
```

What's inside
-------------

 - Python 2.7.9 with virtualenv and pip
 - Python 3.4.3 with pip (use bundled pyvenv for virtual environments)
 - PostgreSQL 9.3.6
 - Redis 2.8.4
 - Elasticsearch 1.4.4
 - Vim, Git, GCC (with C++ support)
 - Development headers for Python (2 and 3), PostgreSQL and some image libraries (libjpeg, zlib, etc)
 - Prebuilt wheels for Pillow 2.8.1, psycopg2 2.6 and libsass 0.7.0 for both python versions (and pip configured to use them)


Build instructions
------------------

To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-base-v1.2.0 wagtail-base-v1.2.0.box
