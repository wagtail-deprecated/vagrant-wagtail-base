#!/bin/bash

# to build wagtail-base-v1.2.0.box:
vagrant destroy
vagrant up
vagrant halt
rm -f wagtail-base-v1.2.0.box
vagrant package --output wagtail-base-v1.2.0.box

# to install locally:
# vagrant box add wagtail-base-v1.2.0 wagtail-base-v1.2.0.box
