#!/bin/bash

# If not root, run again with sudo
if (($EUID != 0))
then
  sudo "$0" "$@"
  exit
fi

read -p 'Warning, settings for linux Mint rafaela. Continue?' yn
case $yn in
    [Yy]* ) 
        cp official-package-repositories.list /etc/apt/sources.list.d/;;
    * ) 
        exit;;
esac
