#!/bin/bash

# to build wagtail-buster64-v1.1.0.box:
vagrant destroy
vagrant up --provider $1
vagrant halt
rm -f wagtail-buster64-v1.1.0.box
vagrant package --output wagtail-buster64-v1.1.0.box

# to install locally:
# vagrant box add wagtail-buster64-v1.1.0 wagtail-buster64-v1.1.0.box
