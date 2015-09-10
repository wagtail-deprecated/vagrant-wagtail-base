#!/bin/bash

# to build wagtail-jessie64-v1.0.0.box:
vagrant destroy
vagrant up
vagrant halt
rm -f wagtail-jessie64-v1.0.0.box
vagrant package --output wagtail-jessie64-v1.0.0.box

# to install locally:
# vagrant box add wagtail-jessie64-v1.0.0 wagtail-jessie64-v1.0.0.box
