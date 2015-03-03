#!/bin/bash

# to build wagtail-base-v1.1.box:
vagrant destroy
vagrant up
vagrant halt
rm -f wagtail-base-v1.1.box
vagrant package --output wagtail-base-v1.1.box

# to install locally:
# vagrant box add wagtail-base-v1.1 wagtail-base-v1.1.box
