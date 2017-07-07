#!/bin/bash

# If not root, run again with sudo
if (($EUID != 0))
then
  sudo "$0" "$@"
  exit
fi

apt-get update

for package in vim-gtk python3 exuberant-ctags tree python-pip \
    python-virtualenv curl
do
    apt-get install -y $package
done

# install python packages
pip install virtualenvwrapper
