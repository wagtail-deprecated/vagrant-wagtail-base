#!/bin/bash

# to build wagtail-stretch64-v1.0.0.box:
vagrant destroy
vagrant up
vagrant halt
rm -f wagtail-stretch64-v1.0.0.box
vagrant package --output wagtail-stretch64-v1.0.0.box

# to install locally:
# vagrant box add wagtail-stretch64-v1.0.0 wagtail-stretch64-v1.0.0.box
