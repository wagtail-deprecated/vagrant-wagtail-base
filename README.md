vagrant-wagtail-base
====================

A Vagrant box based on Ubuntu trusty32, with the dependencies for developing Wagtail
sites preinstalled.

The Wagtail demo site https://github.com/torchbox/wagtaildemo includes an install
script that will bring up a working site from a vanilla trusty32 base box, but using
vagrant-wagtail-base instead will skip some of the time-consuming initial setup.

Build instructions
------------------
To generate the .box file for vagrant you need to have packer installed and run the following command:

    packer build -only=virtualbox-iso wagtail.json

To install locally:

    vagrant box add wagtail-base-v0.3 wagtail-base-v0.3-virtualbox.box

You also have a second Option to generate VMWare boxes via:

    packer build -only=vmware-iso wagtail.json

And add them locally:

    vagrant box add wagtail-base-v0.3 wagtail-base-v0.3-vmware.box


Build instructions (Legacy)
---------------------------
To generate the .box file:

    ./build.sh

To install locally:

    vagrant box add wagtail-base-v0.3 wagtail-base-v0.3.box
