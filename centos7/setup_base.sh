#!/bin/bash

# Install base parts of the OS (command line utilities, editors, etc.) that
# aren't included in the minimal CentOS 7 installation.
yum -y groups install base core

# SWC software that we'll install from the CentOS repos
# (other stuff will be through Anaconda)
yum -y install git make

