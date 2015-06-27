#!/bin/bash

if (($EUID != 0))
then
  sudo "$0" "$@"
  exit
fi

apt-get update

for package in vim-gtk python3
do
    apt-get install -y $package
done
