#!/bin/bash

# to build wagtail-base-v0.3.box:
vagrant destroy
vagrant up
vagrant halt
rm -f wagtail-base-v0.3.box
vagrant package --output wagtail-base-v0.3.box

# to install locally:
# vagrant box add wagtail-base-v0.3 wagtail-base-v0.3.box
